select
    nullif(trim(sale_id), '') as sale_id,
    nullif(trim(customer_id), '') as customer_id,
    sale_date,
    ingestion_date,
    order_total,
    nullif(trim(payment_method), '') as payment_method,
    nullif(trim(order_status), '') as order_status,
    lower(trim(nullif(customer_email, ''))) as customer_email,
    nullif(trim(billing_country), '') as billing_country,
    nullif(trim(channel), '') as channel,
    nullif(trim(referring_source), '') as referring_source,
    discount_applied,
    nullif(trim(customer_type), '') as customer_type,
    nullif(trim(crm_notes), '') as crm_notes,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_crm_sales') }}
where sale_id is not null
