{% macro create_base_table2() %}
  {% set sql %}
    create or replace table {{ target.database }}.{{ target.schema }}.BASE_TABLE2 as
    SELECT
        1 AS id,
        200 AS value
    UNION ALL
    SELECT
        2 AS id,
        300 AS value
    UNION ALL
    SELECT
        3 AS id,
        400 AS value;
  {% endset %}
  {% do run_query(sql) %}
{% endmacro %}

{% macro create_raw_semantic_view() %}
  {% set sql %}
    create or replace semantic view {{ target.database }}.{{ target.schema }}.RAW_SEMANTIC_VIEW
    tables (t1 as {{ target.database }}.{{ target.schema }}.BASE_TABLE2)
    dimensions (t1.count as value)
    metrics (t1.total_rows as sum(t1.value))
  {% endset %}
  {% do run_query(sql) %}
{% endmacro %}