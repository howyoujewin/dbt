{{
    config
    (
        materialized = 'view'
    )

}}

select * from {{ ref('customers') }}
where country = 'USA'