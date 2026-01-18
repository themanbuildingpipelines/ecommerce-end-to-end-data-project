select
    nullif(trim(event_source), '') as event_source,
    nullif(trim(transaction_id), '') as transaction_id,
    nullif(trim(order_id), '') as order_id,
    nullif(trim(customer_id), '') as customer_id,

    order_date,
    created_at,
    updated_at,

    lower(trim(nullif(order_status, ''))) as order_status,
    lower(trim(nullif(payment_status, ''))) as payment_status,

    nullif(trim(product_id), '') as product_id,

    

    gross_price,
    nullif(trim(tax_included), '') as tax_included,
    try_to_decimal(nullif(trim(tax_amount), ''), 10, 2) as tax_amount,

    shipping_fee,
    nullif(trim(currency_code), '') as currency_code,
    nullif(trim(promo_code), '') as promo_code,
    try_to_decimal(nullif(trim(discount_amount), ''), 10, 2) as discount_amount,

    nullif(trim(order_source), '') as order_source,
    nullif(trim(customer_ip), '') as customer_ip,

    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_ecom_orders') }}
where order_id is not null
