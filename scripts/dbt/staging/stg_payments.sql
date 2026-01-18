select
    nullif(trim(transaction_id), '') as transaction_id,
    nullif(trim(order_id), '') as order_id,
    nullif(trim(customer_id), '') as customer_id,
    payment_date,
    nullif(trim(payment_provider), '') as payment_provider,
    nullif(trim(payment_method), '') as payment_method,
    nullif(trim(card_type), '') as card_type,
    card_last4,
    amount,
    nullif(trim(currency), '') as currency,
    transaction_fee,
    nullif(trim(payment_status), '') as payment_status,
    nullif(trim(failure_reason), '') as failure_reason,
    attempt_number,
    nullif(trim(authorization_code), '') as authorization_code,
    gateway_response_code,
    nullif(trim(metadata), '') as metadata,
    created_at,
    updated_at,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_payment_gateway_log') }}
where transaction_id is not null
