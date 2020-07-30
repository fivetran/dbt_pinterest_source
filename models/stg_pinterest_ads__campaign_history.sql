with base as (

    select *
    from {{ var('campaign_history') }}

), fields as (

    select
        id as campaign_id,
        created_time as created_timestamp,
        name,
        status,
        _fivetran_synced
    from base

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['campaign_id','_fivetran_synced'] )}} as version_id
    from fields

)

select *
from surrogate_key