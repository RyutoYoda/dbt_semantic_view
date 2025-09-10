-- Copyright 2025 Snowflake Inc. 
-- SPDX-License-Identifier: Apache-2.0
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

{% macro snowflake__get_create_semantic_view_sql(relation, sql) -%}
{#-
--  Produce DDL that creates a semantic view
--
--  Args:
--  - relation: Union[SnowflakeRelation, str]
--      - SnowflakeRelation - required for relation.render()
--      - str - is already the rendered relation name
--  - sql: str - the code defining the model
--  Returns:
--      A valid DDL statement which will result in a new semantic view.
-#}

  create or replace semantic view {{ relation }}
  {{ sql }}

{%- endmacro %}


{% macro snowflake__create_or_replace_semantic_view() %}
  {%- set identifier = model['alias'] -%}

  {%- set old_relation = adapter.get_relation(database=database, schema=schema, identifier=identifier) -%}
  {%- set exists_as_view = (old_relation is not none and old_relation.is_view) -%}
  {%- set copy_grants = config.get('copy_grants', default=false) -%}

  {%- set target_relation = api.Relation.create(
      identifier=identifier, schema=schema, database=database,
      type='view') -%}
  {% set grant_config = config.get('grants') %}

  {%- if copy_grants -%}
    {#- Normalize SQL and append COPY GRANTS if not already present (case-insensitive) -#}
    {%- set _sql_norm = sql | trim -%}
    {%- set _sql_norm = _sql_norm[:-1] if _sql_norm[-1:] == ';' else _sql_norm -%}
    {%- set _sql_norm = _sql_norm | trim -%}
    {%- set _ends = (_sql_norm | lower)[-11:] -%}
    {%- if _ends != 'copy grants' -%}
      {%- set sql = sql ~ '\nCOPY GRANTS' -%}
    {%- endif -%}
  {%- endif -%}

  {{ run_hooks(pre_hooks) }}

  -- build model
  {% call statement('main') -%}
    {{ dbt_semantic_view.snowflake__get_create_semantic_view_sql(target_relation, sql) }}
  {%- endcall %}

  {{ run_hooks(post_hooks) }}

  {{ return({'relations': [target_relation]}) }}

{% endmacro %}