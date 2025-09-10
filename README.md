## Package for Semantic View materialization
This dbt package to support of Snowflake Semantic View as a new materialization in DBT. 

It introduces the necessary macros and integration tests to enable creating, dropping, and renaming semantic views in dbt.

Importing the package allows users to create and materialize semantic views directly from DBT, refer to them in other model definitions. Additionally, it support the use of semantic views as part of DBT models for creating materialized tables.

### Installation
```
packages:
  - package: Snowflake-Labs/dbt_semantic_view
```

### Usage
- Use Semantic View materialization `{{ config(materialized='semantic_view')}}`
```
{{ config(materialized='semantic_view')}}
TABLES(
  {{ source('<source_name>', '<table_name_1>') }},
  {{ ref('<table_or_view>') }},
  ...
)
[ RELATIONSHIPS ( relationshipDef [ , ... ] ) ]
[ FACTS ( semanticExpression [ , ... ] ) ]
[ DIMENSIONS ( semanticExpression [ , ... ] ) ]
[ METRICS ( semanticExpression [ , ... ] ) ]
[ COMMENT = '<comment_about_semantic_view>' ]
[ COPY GRANTS ]
```

- Refer to semantic view model in other DBT model `{{ ref('<semantic_view>') }}`
```
{{ config(materialized='table') }}
select * from semantic_view(
  {{ ref('<semantic_view>') }} 
  [
    {
METRICS <metric> [ , ... ] |
FACTS <fact_expr>  [ , ... ]
    }
  ]
  [ DIMENSIONS <dimension_expr>  [ , ... ] ]
  [ WHERE <predicate> ]
)
```

### Integration Tests
First, set the following environment variables:
```
export SNOWFLAKE_TEST_ACCOUNT=
export SNOWFLAKE_TEST_USER=
export SNOWFLAKE_TEST_ROLE=
export SNOWFLAKE_TEST_WAREHOUSE=
export SNOWFLAKE_TEST_DATABASE=
export SNOWFLAKE_TEST_SCHEMA=
export SNOWFLAKE_TEST_PRIVATE_KEY_PATH=
export SNOWFLAKE_TEST_PRIVATE_KEY_PASSPHRASE=
```
Then, run integration tests:
```
cd integration_tests/
dbt deps --target snowflake
dbt build --target snowflake
```

### Docs for package
See [Link to Github Pages](https://snowflake-labs.github.io/dbt-snowflake-semantic-view )


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
