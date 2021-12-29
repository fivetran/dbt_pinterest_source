{% macro get_campaign_history_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "created_time", "datatype": dbt_utils.type_timestamp(), "alias": "created_timestamp"},
    {"name": "id", "datatype": dbt_utils.type_string(), "alias": "campaign_id"},
    {"name": "name", "datatype": dbt_utils.type_string()},
    {"name": "status", "datatype": dbt_utils.type_string()},
    {"name": "advertiser_id", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}
