select
    nullif(trim(return_id), '') as return_id,
    nullif(trim(order_id), '') as order_id,
    nullif(trim(transaction_id), '') as transaction_id,
    nullif(trim(customer_id), '') as customer_id,
    nullif(trim(product_id), '') as product_id,
    return_date,
    process_date,
    nullif(trim(return_reason), '') as return_reason,
    nullif(trim(return_status), '') as return_status,
    quantity_returned,
    original_amount,
    refund_amount,
    nullif(trim(refund_method), '') as refund_method,
    nullif(trim(refund_processed), '') as refund_processed,
    restocking_fee,
    nullif(trim(notes), '') as notes,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_returns_log') }}
where return_id is not null
