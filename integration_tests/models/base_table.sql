{{ config(materialized='table') }}

select *
from {{ ref('my_seed') }}


