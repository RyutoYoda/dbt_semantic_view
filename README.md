## dbt-snowflake-semantic-view dbt package
This dbt package provides support for Snowflake Semantic View as materialization.

### Usage
```
{{config(materialized='semantic view')}}
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
