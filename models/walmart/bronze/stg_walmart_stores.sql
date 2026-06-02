{{ config(materialized='view') }}

select
    Store as store_id,
    Type as store_type,
    Size as store_size,
    current_timestamp() as insert_date,
    current_timestamp() as update_date
from PC_DBT_DB.BRONZE_WALMART.RAW_STORE_DIM_LND