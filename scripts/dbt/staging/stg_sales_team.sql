select
    nullif(trim(employee_id), '') as employee_id,
    nullif(trim(employee_name), '') as employee_name,
    lower(trim(nullif(email, ''))) as email,
    nullif(trim(department), '') as department,
    nullif(trim(territory), '') as territory,
    territory_start_date,
    territory_end_date,
    hire_date,
    termination_date,
    nullif(trim(employee_status), '') as employee_status,
    nullif(trim(manager_id), '') as manager_id,
    commission_rate,
    quota,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_sales_team_roster') }}
where employee_id is not null
