--CREATING DDL Scripts for Bronze Tables

-- =====================================================
-- 1. AD SPEND DAILY TABLE
-- =====================================================

IF OBJECT_ID('Bronze.ad_spend', 'U') IS NOT NULL
	DROP TABLE Bronze.ad_spend
GO

CREATE TABLE Bronze.ad_spend (
    spend_date DATE,
    channel VARCHAR(100),
    campaign_name VARCHAR(50),
    campaign_id VARCHAR(50),
    impressions INTEGER,
    clicks INTEGER,
    cost DECIMAL(10,2),
    currency VARCHAR(50),
    ad_platform VARCHAR(50),
    target_audience VARCHAR(50),
    ad_type VARCHAR(50),
    region VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME,
);
GO

-- =====================================================
-- 2. CRM SALES TABLE
-- =====================================================
IF OBJECT_ID('Bronze.crm_sales', 'U') IS NOT NULL
	DROP TABLE Bronze.crm_sales
GO

CREATE TABLE Bronze.crm_sales (
    sale_id VARCHAR(100),
    customer_id VARCHAR(100),
    sale_date DATE,
    ingestion_date DATE,
    order_total DECIMAL(10,2),
    payment_method VARCHAR(100),
    order_status VARCHAR(50),
    customer_email VARCHAR(50),
    billing_country VARCHAR(50),
    channel VARCHAR(50),
    referring_source VARCHAR(50),
    discount_applied DECIMAL(10,2),
    customer_type VARCHAR(50),
    crm_notes VARCHAR(50),
);
GO

-- =====================================================
-- 3. CUSTOMER MASTER TABLE
-- =====================================================
IF OBJECT_ID('Bronze.customer_details', 'U') IS NOT NULL
	DROP TABLE Bronze.customer_details
GO

CREATE TABLE Bronze.customer_details (
    customer_id VARCHAR(100),
    country VARCHAR(50),
    created_date DATE,
    last_updated DATE,
    customer_status VARCHAR(100),
    customer_type VARCHAR(100),
    email_verified VARCHAR(100),
    phone_verified VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code INTEGER,
    marketing_opt_in VARCHAR(100),
    preferred_language VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(200),
    address_line1 VARCHAR(200),
    address_line2 VARCHAR(200), 
);
GO

-- =====================================================
-- 4. ECOMMERCE ORDERS TABLE
-- =====================================================
IF OBJECT_ID('Bronze.ecommerce_orders_raw', 'U') IS NOT NULL
	DROP TABLE Bronze.ecommerce_orders_raw
GO

CREATE TABLE Bronze.ecommerce_orders_raw (
    event_source VARCHAR(100),
    transaction_id VARCHAR(100),
    order_id VARCHAR(100),
    customer_id VARCHAR(100),
    order_date DATETIME,
    created_at DATETIME,
    updated_at DATETIME,
    order_status VARCHAR(100),
    payment_status VARCHAR(100),
    product_id VARCHAR(100),
    product_name VARCHAR(500),
    quantity INTEGER,
    gross_price DECIMAL(10,2),
    tax_included VARCHAR(50),
    tax_amount DECIMAL(10,2),
    shipping_fee DECIMAL(10,2),
    currency_code VARCHAR(100),
    promo_code VARCHAR(100),
    discount_amount DECIMAL(10,2),
    order_source VARCHAR(100),
    customer_ip NVARCHAR(200),
);
GO

-- =====================================================
-- 5. INVENTORY MASTER TABLE
-- =====================================================
IF OBJECT_ID('Bronze.product_inventory', 'U') IS NOT NULL
	DROP TABLE Bronze.product_inventory
GO

CREATE TABLE Bronze.product_inventory (
    product_id VARCHAR(100),
    product_name VARCHAR(255),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    brand VARCHAR(100),
    sku VARCHAR(100),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    stock_quantity INTEGER,
    reorder_level INTEGER,
    warehouse_location VARCHAR(100),
    status VARCHAR(100),
    weight NVARCHAR(100),
    dimensions NVARCHAR(100),
    created_date DATETIME,
    last_updated DATETIME,
    is_hazardous VARCHAR(100),
);
GO

-- =====================================================
-- 6. PAYMENT GATEWAY LOG TABLE
-- =====================================================
IF OBJECT_ID('Bronze.payment_gateway_logs', 'U') IS NOT NULL
	DROP TABLE Bronze.payment_gateway_logs
GO

CREATE TABLE Bronze.payment_gateway_logs (
    transaction_id VARCHAR(100),
    order_id VARCHAR(100),
    customer_id VARCHAR(100),
    payment_date DATETIME,
    payment_provider VARCHAR(50),
    payment_method VARCHAR(50),
    card_type VARCHAR(50),
    card_last4 INTEGER,
    amount DECIMAL(10,2),
    currency VARCHAR(10),
    transaction_fee DECIMAL(10,2),
    payment_status VARCHAR(50),
    failure_reason VARCHAR(100),
    attempt_number INTEGER,
    authorization_code NVARCHAR(200),
    gateway_response VARCHAR(500),
    metadata NVARCHAR(500),
    created_at VARCHAR(500),
    updated_at VARCHAR(500),
);

-- =====================================================
-- 7. PROMO CAMPAIGNS TABLE
-- =====================================================
IF OBJECT_ID('Bronze.promotional_campaigns', 'U') IS NOT NULL
	DROP TABLE Bronze.promotional_campaigns
GO

CREATE TABLE Bronze.promotional_campaigns (
    campaign_id VARCHAR(100),
    campaign_name VARCHAR(255),
    campaign_type VARCHAR(255),
    promo_code VARCHAR(200),
    discount_percent DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    discount_rules VARCHAR(500),
    start_date DATE,
    end_date DATE,
    min_order_amount INTEGER,
    max_uses_per_customer INTEGER,
    total_uses INTEGER,
    budget INTEGER,
    actual_spend DECIMAL(10,2),
    target_segment VARCHAR(100),
    campaign_channel VARCHAR(200),
    created_by VARCHAR(150),
    created_at DATE,
    updated_at DATE,
);
GO

-- =====================================================
-- 8. RETURNS LOG TABLE
-- =====================================================
IF OBJECT_ID('Bronze.customer_returns', 'U') IS NOT NULL
	DROP TABLE Bronze.customer_returns
GO

CREATE TABLE Bronze.customer_returns (
    return_id VARCHAR(100),
    order_id VARCHAR(100),
    transaction_id VARCHAR(100),
    customer_id VARCHAR(100),
    product_id VARCHAR(100),
    return_date DATE,
    process_date DATE,
    return_reason VARCHAR(500),
    return_status VARCHAR(50),
    quantity_returned INTEGER,
    original_amount DECIMAL(10,2),
    refund_amount DECIMAL(10,2),
    refund_method VARCHAR(100),
    refund_processed VARCHAR(100),
    restocking_fee DECIMAL(10,2),
    notes VARCHAR(500),
);
GO

-- =====================================================
-- 9. SALES TEAM ROSTER TABLE
-- =====================================================
IF OBJECT_ID('Bronze.sales_team', 'U') IS NOT NULL
	DROP TABLE Bronze.sales_team
GO

CREATE TABLE Bronze.sales_team (
    employee_id VARCHAR(100),
    employee_name VARCHAR(200),
    email VARCHAR(255),
    department VARCHAR(100),
    territory VARCHAR(100),
    territory_start_date DATE,
    territory_end_date DATE,
    hire_date DATE,
    termination_date DATE,
    employee_status VARCHAR(100),
    manager_id VARCHAR(100),
    commission_rate DECIMAL(10,3),
    quota INTEGER,
);
GO

-- =====================================================
-- 10. SHIPMENT TRACKING TABLE
-- =====================================================
IF OBJECT_ID('Bronze.shipment_tracking', 'U') IS NOT NULL
	DROP TABLE Bronze.shipment_tracking
GO

CREATE TABLE Bronze.shipment_tracking (
    shipment_id VARCHAR(100),
    order_id VARCHAR(100),
    customer_id VARCHAR(100),
    carrier VARCHAR(100),
    carrier_service VARCHAR(100),
    tracking_number VARCHAR(100),
    ship_date DATE,
    estimated_delivery_date DATE,
    actual_delivery_date DATE,
    shipment_status VARCHAR(50),
    warehouse VARCHAR(100),
    shipping_cost DECIMAL(10,2),
    weight_lbs DECIMAL(10,2),
    package_count INTEGER,
    signature_required VARCHAR(100),
    delivery_notes VARCHAR(500),
);
GO

-- =====================================================
-- 11. SUPPORT TICKETS TABLE
-- =====================================================
IF OBJECT_ID('Bronze.customer_support_tickets', 'U') IS NOT NULL
	DROP TABLE Bronze.customer_support_tickets
GO

CREATE TABLE Bronze.customer_support_tickets (
    ticket_id VARCHAR(100),
    customer_id VARCHAR(100),
    order_id VARCHAR(100),
    ticket_date DATETIME,
    category VARCHAR(100),
    priority VARCHAR(50),
    status VARCHAR(50),
    subject VARCHAR(100),
    description VARCHAR(5000),
    assigned_to VARCHAR(100),
    agent_timezone VARCHAR(100),
    resolved_date DATETIME,
    response_time_hours DECIMAL(10,2),
    satisfaction_score INTEGER,
    satisfaction_comment VARCHAR(5000),
    channel VARCHAR(100),
    tags VARCHAR(1000),
    created_at DATE,
    updated_at DATE,
);
GO

-- =====================================================
-- 12. WEB SESSIONS TABLE
-- =====================================================
IF OBJECT_ID('Bronze.web_sessions', 'U') IS NOT NULL
	DROP TABLE Bronze.web_sessions
GO

CREATE TABLE Bronze.web_sessions (
    session_id VARCHAR(100),
    session_token VARCHAR(500),
    customer_id VARCHAR(100),
    session_start DATETIME,
    session_end DATETIME,
    page_views INTEGER,
    time_on_site_seconds INTEGER,
    device_type VARCHAR(50),
    browser VARCHAR(50),
    operating_system VARCHAR(100),
    traffic_source VARCHAR(100),
    utm_campaign VARCHAR(100),
    utm_medium VARCHAR(100),
    utm_source VARCHAR(100),
    landing_page VARCHAR(200),
    exit_page VARCHAR(100),
    converted VARCHAR(100),
    order_id VARCHAR(200),
    ip_address VARCHAR(100),
    country VARCHAR(100),
    logged_at DATE,
);
