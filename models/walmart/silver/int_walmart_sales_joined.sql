{{ config(materialized='table') }}

with sales as (
    select * from {{ ref('stg_walmart_department') }}
),

features as (
    select * from {{ ref('stg_walmart_features') }}
),

stores as (
    select * from {{ ref('stg_walmart_stores') }}
)

select
    -- Primary Key
    md5(cast(coalesce(cast(s.store_id as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(s.department_id as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(s.date_day as string), '_dbt_utils_surrogate_key_null_') as string)) as sales_pk,
    
    -- Dimensional Keys
    s.store_id,
    s.department_id,
    s.date_day,

    -- Core Metrics
    s.weekly_sales,
    st.store_size,
    
    -- Compliance / Context Flags
    s.is_holiday,

    -- Climate & Economic Factors
    f.temperature,
    f.fuel_price,
    f.cpi,
    f.unemployment,

    -- Markdown Metrics
    f.markdown_1,
    f.markdown_2,
    f.markdown_3,
    f.markdown_4,
    f.markdown_5,

    -- Metadata Tracking
    current_timestamp() as transformed_at

from sales s
left join stores st 
    on s.store_id = st.store_id
left join features f 
    on s.store_id = f.store_id 
    and s.date_day = f.date_day