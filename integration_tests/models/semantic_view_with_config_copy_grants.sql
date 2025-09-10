{{ config(materialized='semantic_view') }}
TABLES(t1 AS {{ ref('base_table') }})
DIMENSIONS(t1.count as value)
METRICS(t1.total_rows AS SUM(t1.value))