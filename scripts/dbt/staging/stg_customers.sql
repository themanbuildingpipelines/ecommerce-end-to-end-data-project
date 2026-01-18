select
    nullif(trim(customer_id), '') as customer_id,
    nullif(trim(country), '') as country,
    created_date,
    last_updated,
    nullif(trim(customer_status), '') as customer_status,
    nullif(trim(email_verified), '') as email_verified,
    nullif(trim(phone_verified), '') as phone_verified,
    nullif(trim(city), '') as city,
    nullif(trim(state), '') as state,
    postal_code,
    nullif(trim(marketing_opt_in), '') as marketing_opt_in,
    nullif(trim(preferred_language), '') as preferred_language,
    lower(trim(nullif(email, ''))) as email,
    nullif(trim(phone), '') as phone,
    nullif(trim(address_line1), '') as address_line1,
    nullif(trim(address_line2), '') as address_line2,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_customer_master') }}
where customer_id is not null
