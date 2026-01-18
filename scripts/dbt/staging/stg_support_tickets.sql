select
    nullif(trim(ticket_id), '') as ticket_id,
    nullif(trim(customer_id), '') as customer_id,
    nullif(trim(order_id), '') as order_id,
    ticket_date,
    nullif(trim(category), '') as category,
    nullif(trim(priority), '') as priority,
    nullif(trim(status), '') as status,
    nullif(trim(subject), '') as subject,
    nullif(trim(assigned_to), '') as assigned_to,
    description,
    nullif(trim(agent_timezone), '') as agent_timezone,
    resolved_date,
    response_time_hours,
    satisfaction_score,
    nullif(trim(channel), '') as channel,
    nullif(trim(tags), '') as tags,
    created_at,
    updated_at,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_support_tickets') }}
where ticket_id is not null
