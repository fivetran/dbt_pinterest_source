{% macro get_advertiser_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "owner_user_id", "datatype": dbt_utils.type_string()},
    {"name": "created_time", "datatype": dbt_utils.type_timestamp(), "alias": "created_timestamp"},
    {"name": "updated_time", "datatype": dbt_utils.type_timestamp(), "alias": "updated_timestamp"},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "advertiser_id"},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "test_account", "datatype": "boolean"},
    {"name": "currency", "datatype": dbt_utils.type_string()},
    {"name": "country", "datatype": dbt_utils.type_string()},
    {"name": "is_one_tap", "datatype": "boolean"}
] %}

{{ return(columns) }}

{% endmacro %}
