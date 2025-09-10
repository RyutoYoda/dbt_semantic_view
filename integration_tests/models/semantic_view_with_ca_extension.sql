{{ config(materialized='semantic_view') }}
TABLES(t1 AS {{ ref('base_table') }}, t2 as {{ source('seed_sources', 'base_table2') }})
DIMENSIONS(t1.count as value, t2.volume as value)
METRICS(t1.total_rows AS SUM(t1.count), t2.max_volume as max(t2.volume))
with extension (CA = '{"verified_queries":[{"name":"hi", "question": "hello"}]')