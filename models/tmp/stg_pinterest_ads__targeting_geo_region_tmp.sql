{{ config(
    enabled=fivetran_utils.enabled_vars([
        'ad_reporting__pinterest_ads_enabled',
        'pinterest_ads_pin_promotion_targeting_report_enabled',
        'pinterest_ads_targeting_geo_region_enabled'])
) }}

{{
    fivetran_utils.union_data(
        table_identifier='targeting_geo_region', 
        database_variable='pinterest_database', 
        schema_variable='pinterest_schema', 
        default_database=target.database,
        default_schema='pinterest_ads',
        default_variable='targeting_geo_region',
        union_schema_variable='pinterest_ads_union_schemas',
        union_database_variable='pinterest_ads_union_databases'
    )
}}

