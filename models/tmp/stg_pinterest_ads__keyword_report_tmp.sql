ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=fivetran_utils.enabled_vars(['ad_reporting__pinterest_ads_enabled','pinterest__using_keywords'])) }}

{{
    fivetran_utils.union_data(
        table_identifier='stg_pinterest_ads__keyword_report', 
        database_variable='pinterest_database', 
        schema_variable='pinterest_schema', 
        default_database=target.database,
        default_schema='pinterest',
        default_variable='stg_pinterest_ads__keyword_report_source',
        union_schema_variable='pinterest_union_schemas',
        union_database_variable='pinterest_union_databases'
    )
}}