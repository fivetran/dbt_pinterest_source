{% macro get_pin_promotion_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "ad_group_id", "datatype": dbt_utils.type_string()},
    {"name": "advertiser_id", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_string()},
    {"name": "clickthrough_1", "datatype": dbt_utils.type_numeric()},
    {"name": "clickthrough_2", "datatype": dbt_utils.type_numeric()},
    {"name": "date", "datatype": dbt_utils.type_timestamp()},
    {"name": "impression_1", "datatype": dbt_utils.type_numeric()},
    {"name": "impression_2", "datatype": dbt_utils.type_numeric()},
    {"name": "pin_promotion_id", "datatype": dbt_utils.type_string()},
    {"name": "spend_in_micro_dollar", "datatype": dbt_utils.type_numeric()}
] %}

{{ return(columns) }}

{% endmacro %}
