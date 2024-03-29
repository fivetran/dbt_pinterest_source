{% macro pinterest_ads_extract_url_parameter(field, url_parameter) -%}

{{ return(adapter.dispatch('pinterest_ads_extract_url_parameter', 'pinterest_source') (field, url_parameter)) }}

{% endmacro %}


{% macro default__pinterest_ads_extract_url_parameter(field, url_parameter) -%}

{{ dbt_utils.get_url_parameter(field, url_parameter) }}

{%- endmacro %}


{% macro spark__pinterest_ads_extract_url_parameter(field, url_parameter) -%}

{%- set formatted_url_parameter = "'" + url_parameter + "=([^&]+)'" -%}
nullif(regexp_extract({{ field }}, {{ formatted_url_parameter }}, 1), '')

{%- endmacro %}