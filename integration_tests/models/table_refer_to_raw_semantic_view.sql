{{ config(materialized='table') }}

select * from semantic_view({{ source('seed_sources', 'raw_semantic_view') }} metrics total_rows)


