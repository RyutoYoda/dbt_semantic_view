{{ config(materialized='test') }}

-- Assert COPY GRANTS is present in DDL when specified in SQL
select 'COPY GRANTS missing for SEMANTIC_VIEW_WITH_COPY_GRANTS' as error_message
where position(
  'copy grants' in lower(get_ddl('SEMANTIC_VIEW', '{{ ref('semantic_view_with_copy_grants') }}'))
) = 0


