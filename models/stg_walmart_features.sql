{{ config(materialized='view') }}

select
    Store as store_id,
    to_date(Date, 'MM/DD/YYYY') as date_day, -- Converts string date to a proper Snowflake DATE data type
    Temperature as temperature,
    Fuel_Price as fuel_price,
    MarkDown1::float as markdown_1, -- Directly casting to float since 'NA' is already NULL
    MarkDown2::float as markdown_2,
    MarkDown3::float as markdown_3,
    MarkDown4::float as markdown_4,
    MarkDown5::float as markdown_5,
    CPI as cpi,
    Unemployment as unemployment,
    IsHoliday as is_holiday,
    current_timestamp() as insert_date
from {{ source('walmart_raw', 'raw_walmart_features') }}