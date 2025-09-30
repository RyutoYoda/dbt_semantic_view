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

{#
  Override Snowflake relation comment behavior to support SEMANTIC VIEW.
  dbt's SnowflakeRelationType does not include this custom type, so
  we detect the materialization via model.config and emit the correct DDL.
#}

{% macro snowflake__alter_relation_comment(relation, relation_comment) -%}
    {%- set is_semantic_view = (model is defined) and (model.config is defined) and (model.config.materialized == 'semantic_view') -%}

    {%- if relation.is_dynamic_table -%}
        {%- set relation_type = 'dynamic table' -%}
    {%- elif is_semantic_view -%}
        {%- set relation_type = 'semantic view' -%}
    {%- else -%}
        {%- set relation_type = relation.type | replace('_', ' ') -%}
    {%- endif -%}

    {%- if relation.is_iceberg_format and not is_semantic_view -%}
        alter iceberg table {{ relation.render() }} set comment = $${{ relation_comment | replace('$', '[$]') }}$$;
    {%- else -%}
        comment on {{ relation_type }} {{ relation.render() }} IS $${{ relation_comment | replace('$', '[$]') }}$$;
    {%- endif -%}
{% endmacro %}


