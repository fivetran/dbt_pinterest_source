with base as (

    select *
    from {{ var('ad_group_history') }}

), fields as (

    select
        id as ad_group_id,
        campaign_id,
        created_time as created_timestamp,
        name,
        status,
        start_time as start_timestamp,
        end_time as end_timestamp,
        _fivetran_synced
    from base

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['ad_group_id','_fivetran_synced'] )}} as version_id
    from fields

)

select *
from surrogate_key