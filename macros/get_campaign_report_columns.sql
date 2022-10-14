{% macro get_campaign_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "advertiser_id", "datatype": dbt.type_string()},
    {"name": "campaign_id", "datatype": dbt.type_string()},
    {"name": "campaign_name", "datatype": dbt.type_string()},
    {"name": "campaign_status", "datatype": dbt.type_string()},
    {"name": "clickthrough_1", "datatype": dbt.type_int()},
    {"name": "clickthrough_2", "datatype": dbt.type_int()},
    {"name": "date", "datatype": dbt.type_timestamp()},
    {"name": "impression_1", "datatype": dbt.type_int()},
    {"name": "impression_2", "datatype": dbt.type_int()},
    {"name": "spend_in_micro_dollar", "datatype": dbt.type_int()}
] %}

{{ fivetran_utils.add_pass_through_columns(columns, var('pinterest__campaign_report_passthrough_metrics')) }}

{{ return(columns) }}

{% endmacro %}
