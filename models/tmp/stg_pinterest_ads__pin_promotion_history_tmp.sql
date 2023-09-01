{{ config(enabled=var('ad_reporting__pinterest_ads_enabled', True)) }}

{{
    fivetran_utils.union_data(
        table_identifier='stg_pinterest_ads__pin_promotion_history', 
        database_variable='pinterest_database', 
        schema_variable='pinterest_schema', 
        default_database=target.database,
        default_schema='pinterest',
        default_variable='stg_pinterest_ads__pin_promotion_history_source',
        union_schema_variable='pinterest_union_schemas',
        union_database_variable='pinterest_union_databases'
    )
}}