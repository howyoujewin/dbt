{{ config(materialized='view') }}

select
    Store as store_id,
    Dept as department_id,
    TO_DATE(date, 'YYYY-MM-DD') as date_day, 
    Weekly_Sales as weekly_sales,
    IsHoliday as is_holiday,
    current_timestamp() as insert_date
from {{ source('walmart_raw', 'raw_department_sales') }}