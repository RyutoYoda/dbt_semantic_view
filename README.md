## Snowflake Semantic View dbt Package

Professional dbt macros and integration tests for building, dropping, and renaming Snowflake Semantic Views. This package lets you materialize Semantic Views via dbt and reference them from downstream models.

### At a glance
- **Materialization**: `semantic_view`
- **Warehouse**: Snowflake
- **dbt Compatibility**: dbt 1.x

### Quickstart
Follow these steps on macOS/Linux with Python 3 installed. No prior dbt installation is required.

1) Clone and enter the repo
```
git clone https://github.com/Snowflake-Labs/dbt-snowflake-semantic-view.git
cd dbt-snowflake-semantic-view
```

2) Create an isolated Python environment and install dependencies
```
python3 -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install dbt-snowflake
```

3) Configure Snowflake credentials (env vars)
Set the following environment variables for the integration profile. For username/password auth use `SNOWFLAKE_TEST_AUTHENTICATOR=snowflake`.
```
export SNOWFLAKE_TEST_ACCOUNT=<account>
export SNOWFLAKE_TEST_USER=<user>
export SNOWFLAKE_TEST_PASSWORD=<password>
export SNOWFLAKE_TEST_AUTHENTICATOR=<authenticator>   # e.g. snowflake | externalbrowser
export SNOWFLAKE_TEST_ROLE=<role>
export SNOWFLAKE_TEST_DATABASE=<database>
export SNOWFLAKE_TEST_WAREHOUSE=<warehouse>
export SNOWFLAKE_TEST_SCHEMA=<schema>
```

4) Run integration tests
```
cd integration_tests/
dbt deps --target snowflake
dbt build --target snowflake
```

### Usage in your dbt project
Add to `packages.yml`:
```
packages:
  - package: Snowflake-Labs/dbt_semantic_view
```

Create a model using the Semantic View materialization:
```
{{ config(materialized='semantic_view') }}
TABLES(
  {{ source('<source_name>', '<table_name>') }},
  {{ ref('<another_model>') }}
)
[ RELATIONSHIPS ( relationshipDef [ , ... ] ) ]
[ FACTS ( semanticExpression [ , ... ] ) ]
[ DIMENSIONS ( semanticExpression [ , ... ] ) ]
[ METRICS ( semanticExpression [ , ... ] ) ]
[ COMMENT = '<comment>' ]
[ COPY GRANTS ]
```

Reference a Semantic View from another model:
```
{{ config(materialized='table') }}
select *
from semantic_view(
  {{ ref('<semantic_view_model>') }}
  [ { METRICS <metric> | FACTS <fact_expr> } ]
  [ DIMENSIONS <dimension_expr> ]
  [ WHERE <predicate> ]
)
```

### Development
- Python 3.9+ recommended
- Use a venv: `python3 -m venv .venv && source .venv/bin/activate`
- Install tooling as needed: `pip install dbt-snowflake`

### Contributing
We welcome issues and PRs! Please:
- Open an issue to discuss significant changes
- Keep edits focused and include tests where possible
- Follow dbt and Python best practices

### License
Apache License 2.0. See `LICENSE` for details.