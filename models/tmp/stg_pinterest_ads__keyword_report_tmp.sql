{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__pinterest_ads_enabled','pinterest_ads__using_keywords'])) }}

{{
    fivetran_utils.union_data(
        table_identifier='keyword_report', 
        database_variable='pinterest_ads_database', 
        schema_variable='pinterest_ads_schema', 
        default_database=target.database,
        default_schema='pinterest_ads',
        default_variable='keyword_report_source',
        union_schema_variable='pinterest_ads_union_schemas',
        union_database_variable='pinterest_ads_union_databases'
    )
}}