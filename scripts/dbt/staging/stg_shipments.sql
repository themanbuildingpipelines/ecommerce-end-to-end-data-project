select
    nullif(trim(shipment_id), '') as shipment_id,
    nullif(trim(order_id), '') as order_id,
    nullif(trim(carrier), '') as carrier,
    nullif(trim(carrier_service), '') as carrier_service,
    nullif(trim(tracking_number), '') as tracking_number,
    ship_date,
    estimated_delivery_date,
    actual_delivery_date,
    nullif(trim(shipment_status), '') as shipment_status,
    nullif(trim(warehouse), '') as warehouse,
    shipping_cost,
    weight_lbs,
    package_count,
    nullif(trim(signature_required), '') as signature_required,
    nullif(trim(delivery_notes), '') as delivery_notes,
    load_timestamp,
    source_file
from {{ source('bronze', 'bronze_shipment_tracking') }}
where shipment_id is not null
