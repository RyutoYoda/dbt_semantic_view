{{ config(materialized='test') }}

-- Compare result of a table that refers to the semantic view to calling the semantic view directly
with table_ref as (
  select * from {{ ref('table_refer_to_semantic_view') }}
), sv as (
  select * from semantic_view({{ ref('semantic_view_basic') }} metrics total_rows)
)
select 'table refer result does not match semantic view result' as error_message
from table_ref, sv
where table_ref.total_rows != sv.total_rows


