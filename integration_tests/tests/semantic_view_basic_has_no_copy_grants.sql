{{ config(materialized='test') }}

-- Assert COPY GRANTS is absent when not in SQL or yaml
select 'COPY GRANTS unexpectedly present for SEMANTIC_VIEW_BASIC' as error_message
where position(
  'copy grants' in lower(get_ddl('SEMANTIC_VIEW', '{{ ref('semantic_view_basic') }}'))
) > 0


