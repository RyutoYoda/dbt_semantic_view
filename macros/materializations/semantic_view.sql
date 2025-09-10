{% materialization semantic_view, adapter='snowflake' -%}

    {% set original_query_tag = set_query_tag() %}
    {% do snowflake_semantic_view.snowflake__create_or_replace_semantic_view() %}

    {% set target_relation = this.incorporate(type='view') %}

    -- COMMENT ON SEMANTIC VIEW support
    {% do persist_docs(target_relation, model, for_columns=false) %}

    {% do unset_query_tag(original_query_tag) %}

    {% do return({'relations': [target_relation]}) %}

{%- endmaterialization %}