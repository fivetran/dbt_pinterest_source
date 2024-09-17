{{ config(enabled=var('ad_reporting__pinterest_ads_enabled', True)) }}

with base as (

    select *
    from {{ ref('stg_pinterest_ads__ad_group_history_tmp') }}
), 

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_pinterest_ads__ad_group_history_tmp')),
                staging_columns=get_ad_group_history_columns()
            )
        }}
    
        {{ fivetran_utils.source_relation(
            union_schema_variable='pinterest_ads_union_schemas', 
            union_database_variable='pinterest_ads_union_databases') 
        }}

    from base
),

final as (

    select
        source_relation,
        id as ad_group_id,
        name as ad_group_name,
        status as ad_group_status,
        ad_account_id as advertiser_id,
        _fivetran_synced,
        campaign_id,
        created_time as created_at,
        end_time,
        pacing_delivery_type,
        placement_group,
        start_time,
        summary_status,
        {{ pinterest_source.result_if_table_exists(
            table_ref=ref('stg_pinterest_ads__ad_group_history_tmp'), 
            result_statement='row_number() over (partition by id' ~ (', source_relation' if var('pinterest_ads_union_schemas', []) or var('pinterest_ads_union_databases', []) | length > 1) ~ ' order by _fivetran_synced desc)',
            if_empty=1
        )}} = 1 as is_most_recent_record

    from fields
)

select *
from final
