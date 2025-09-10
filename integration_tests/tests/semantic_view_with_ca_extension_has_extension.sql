{{ config(materialized='test') }}

-- Assert the CA extension is present with expected values via GET_DDL
select 'CA extension missing or values mismatch for SEMANTIC_VIEW_WITH_CA_EXTENSION' as error_message
where not (
  position('ca' in lower(get_ddl('SEMANTIC_VIEW', '{{ ref('semantic_view_with_ca_extension') }}'))) > 0
  and position('"verified_queries":[{"name":"hi", "question": "hello"}]' in lower(get_ddl('SEMANTIC_VIEW', '{{ ref('semantic_view_with_ca_extension') }}'))) > 0
)


