{{ config(enabled=var('ad_reporting__pinterest_ads_ads_enabled', True)) }}

{{
    fivetran_utils.union_data(
        table_identifier='pin_promotion_report', 
        database_variable='pinterest_ads_database', 
        schema_variable='pinterest_ads_schema', 
        default_database=target.database,
        default_schema='pinterest_ads',
        default_variable='pin_promotion_report_source',
        union_schema_variable='pinterest_ads_union_schemas',
        union_database_variable='pinterest_ads_union_databases'
    )
}}