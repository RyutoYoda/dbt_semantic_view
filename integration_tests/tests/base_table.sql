{{ config(materialized='test') }}

-- Passes when the seed has rows; fails if empty
select 'my_seed is empty' as error_message
where not exists (
  select 1 from {{ ref('my_seed') }}
)