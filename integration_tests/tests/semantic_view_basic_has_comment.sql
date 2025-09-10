{{ config(materialized='test') }}

-- Assert the semantic view's DDL contains the configured comment
select 'semantic view description missing' as error_message
where position('comment=''test semantic view''' in lower(get_ddl('SEMANTIC_VIEW', '{{ ref('semantic_view_basic') }}'))) = 0


