{{ config(materialized='test') }}

-- Compare sum(value) from BASE_TABLE to metric from semantic view
with base_sum as (
  select sum(value) as v from {{ ref('base_table') }}
), sv as (
  select * from semantic_view({{ ref('semantic_view_basic') }} metrics total_rows)
)
select 'semantic view metric does not match base_table sum' as error_message
from base_sum, sv
where base_sum.v != sv.total_rows