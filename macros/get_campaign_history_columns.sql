{% macro get_campaign_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_time", "datatype": dbt.type_timestamp()},
    {"name": "default_ad_group_budget_in_micro_currency", "datatype": dbt.type_int()},
    {"name": "is_automated_campaign", "datatype": dbt.type_boolean()},
    {"name": "is_campaign_budget_optimization", "datatype": dbt.type_boolean()},
    {"name": "is_flexible_daily_budgets", "datatype": dbt.type_boolean()},
    {"name": "id", "datatype": dbt.type_string()},
    {"name": "ad_account_id", "datatype": dbt.type_string()},
    {"name": "name", "datatype": dbt.type_string()},
    {"name": "status", "datatype": dbt.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
