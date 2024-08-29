{% macro get_keyword_report_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "ad_group_id", "datatype": dbt.type_string()},
    {"name": "ad_group_name", "datatype": dbt.type_string()},
    {"name": "ad_group_status", "datatype": dbt.type_string()},
    {"name": "advertiser_id", "datatype": dbt.type_string()},
    {"name": "campaign_id", "datatype": dbt.type_string()},
    {"name": "clickthrough_1", "datatype": dbt.type_int()},
    {"name": "clickthrough_2", "datatype": dbt.type_int()},
    {"name": "date", "datatype": dbt.type_timestamp()},
    {"name": "impression_1", "datatype": dbt.type_int()},
    {"name": "impression_2", "datatype": dbt.type_int()},
    {"name": "keyword_id", "datatype": dbt.type_string()},
    {"name": "pin_promotion_id", "datatype": dbt.type_string()},
    {"name": "spend_in_micro_dollar", "datatype": dbt.type_int()},
    {"name": "total_conversions", "datatype": dbt.type_int()},
    {"name": "total_conversions_quantity", "datatype": dbt.type_int()},
    {"name": "total_conversions_value_in_micro_dollar", "datatype": dbt.type_int()}
] %}

{# Make backwards compatible in case users were bringing in conversion metrics via passthrough columns prior to us adding them by default #}
{{ pinterest_ads_fill_pass_through_columns(base_columns=columns, pass_through_fields=var('pinterest__keyword_report_passthrough_metrics'), except_fields=['total_conversions', "total_conversions_quantity", "total_conversions_value_in_micro_dollar"]) }}

{{ return(columns) }}

{% endmacro %}
