{{ config(materialized='test') }}

-- Compare result of a table that refers to the raw semantic view to calling it directly
with table_ref as (
  select * from {{ ref('table_refer_to_raw_semantic_view') }}
), sv as (
  select * from semantic_view({{ source('seed_sources', 'raw_semantic_view') }} metrics total_rows)
)
select 'table refer raw result does not match semantic view result' as error_message
from table_ref, sv
where table_ref.total_rows != sv.total_rows


