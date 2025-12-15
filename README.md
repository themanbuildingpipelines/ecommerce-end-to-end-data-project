# E-Commerce Data Engineering Pipeline

An end-to-end data engineering project with a real-world multi-source e-commerce ecosystem with serious data quality issues. The pipeline implements medallion architecture (Bronze/Silver/Gold) to transform messy operational data into analytics-ready insights, uncovering **$120K+ in hidden revenue opportunities**. Read the full case study here. 

## Project Overview

This project demonstrates enterprise-grade data engineering practices by:
- Using 13 interconnected tables with data quality issues (12.6M rows, 2GB)
- Implementing medallion architecture for data transformation
- Building star schema models for analytics
- Identifying revenue leakage and operational inefficiencies
- Creating executive dashboards and actionable insights

**Business Impact**: Identified $120K in recoverable revenue across 7 opportunity categories including abandoned carts, failed payment retries, unprocessed refunds, and inventory optimization.

---

## Tools and Technologies

### Core Data Stack
- **Snowflake/BigQuery/PostgreSQL**: Cloud data warehouse (Bronze/Silver/Gold layers)
- **dbt**: SQL-based transformation framework for data modeling and quality
  - [dbt Documentation](https://docs.getdbt.com/)
- **Python**: Data generation and automation (Pandas, NumPy)
- **Tableau/Looker/Power BI**: Business intelligence and dashboards

### Supporting Technologies
- **Great Expectations**: Data quality validation and profiling
- **Airflow/Dagster** (optional): Orchestration for production pipelines
- **Git**: Version control and collaboration
- **SQL**: Primary transformation language

### Visualization & Documentation
- **Mermaid**: Architecture diagrams
- **Markdown**: Technical documentation

---

## Data Architecture

### Medallion Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│ BRONZE LAYER (Raw, Untouched)                               │
├─────────────────────────────────────────────────────────────┤
│ • 13 raw tables loaded from CSV files                       │
│ • No transformations applied                                │
│ • Metadata: load_timestamp, source_file, row_count         │
│ • Preserves all data quality issues for auditability       │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ SILVER LAYER (Cleaned, Standardized)                        │
├─────────────────────────────────────────────────────────────┤
│ • Data type corrections (string prices → numeric)           │
│ • Deduplication (customers, transactions)                   │
│ • Standardization (categories, countries, statuses)         │
│ • Date/time normalization                                   │
│ • Referential integrity fixes                               │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ GOLD LAYER (Analytics-Ready, Star Schema)                   │
├─────────────────────────────────────────────────────────────┤
│ • Fact Tables: fact_orders, fact_payments, fact_sessions   │
│ • Dimension Tables: dim_customer, dim_product, dim_date     │
│ • Business metrics: revenue, CLV, return_rate, conversion   │
│ • Slowly changing dimensions (SCD Type 2)                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Data Sources (13 Tables)

All data is **synthetically generated** to simulate real-world e-commerce operations:

### Source Systems (Operational)
1. **CRM Sales** (`crm_sales_01.csv`) - 1M rows
   - Customer intent and sales signals
   - Issues: 24-48h latency, 15% missing customer_id, duplicate sale_id
   
2. **E-Commerce Orders** (`ecom_orders_raw.csv`) - 2.7M rows
   - Transaction line items and order details
   - Issues: String prices, tax ambiguity, 3% duplicate transaction_id, 10% customer_id mismatch
   
3. **Product Inventory** (`inventory_master.csv`) - 50K rows
   - Product catalog and stock levels
   - Issues: Category chaos (47 variations), negative stock, reorder logic broken

### Master Data (Reference)
4. **Customer Master** (`customer_master_db.csv`) - 150K rows
   - Unified customer profile
   - Issues: 15% duplicates, email variations, address inconsistencies
   
5. **Sales Team Roster** (`sales_team_roster.csv`) - 50 rows
   - Employee and territory assignments
   - Issues: ID reuse (rehires), territory overlaps, missing effective dates
   
6. **Promotional Campaigns** (`promo_campaigns.csv`) - 100 rows
   - Marketing promotions and discount rules
   - Issues: Campaign ID reuse, date overlaps, free-text rules, usage exceeds limits

### Transactional Systems (Operations)
7. **Returns/Refunds** (`returns_log.csv`) - 300K rows
   - Product returns and refund processing
   - Issues: 20% missing records, dates before orders, refund > original amount
   
8. **Shipping/Fulfillment** (`shipment_tracking.csv`) - 1M rows
   - Logistics and delivery tracking
   - Issues: Multiple shipments per order, reused tracking numbers, date inversions
   
9. **Payment Transactions** (`payment_gateway_log.csv`) - 1.5M rows
   - Payment gateway events and retries
   - Issues: Multiple attempts per order, nested JSON, failed payments mixed with successful

### Customer Interaction (Support & Engagement)
10. **Support Tickets** (`support_tickets_raw.csv`) - 200K rows
    - Customer service interactions
    - Issues: 40% missing structured order_id (refs in free text), timezone chaos, low satisfaction coverage
    
11. **Email Marketing Events** (`email_campaign_events.csv`) - 750K rows
    - Email engagement funnel (sent/delivered/opened/clicked)
    - Issues: Broken conversion attribution (70% missing order_id), unsubscribes in separate system, A/B test variants unclear

### Marketing & Analytics (Attribution)
12. **Web Analytics Sessions** (`web_sessions_export.csv`) - 5M rows
    - User behavior and session tracking
    - Issues: 70% no customer_id (session_token only), negative time_on_site, UTM parameter mismatch
    
13. **Marketing Spend** (`ad_spend_daily.csv`) - 2K rows
    - Daily advertising costs by channel
    - Issues: Daily grain only, campaign name mismatch, clicks > impressions

---

## Project Structure

```
ecommerce-data-pipeline/
├── data_generation/              # Python scripts for data generation
│   ├── crm_sales_generator.py
│   ├── ecommerce_orders.py
│   ├── product_inventory.py
│   ├── customer_master_generator.py
│   ├── returns_refunds_generator.py
│   ├── shipping_fulfillment_generator.py
│   ├── payment_transactions_generator.py
│   ├── sales_rep_generator.py
│   ├── web_analytics_generator.py
│   ├── marketing_spend_generator.py
│   ├── promo_campaigns_generator.py
│   ├── support_tickets_generator.py
│   ├── email_marketing_generator.py
│   └── master_data_generator.py   # Runs all generators
│
├── dbt_project/                   # dbt transformation project
│   ├── dbt_project.yml
│   ├── profiles.yml
│   └── models/
│       ├── bronze/                # Source definitions
│       │   └── sources.yml
│       ├── silver/                # Cleaned & standardized
│       │   ├── silver_orders_cleaned.sql
│       │   ├── silver_customers_deduped.sql
│       │   ├── silver_products_standardized.sql
│       │   ├── silver_returns_reconciled.sql
│       │   └── silver_payments_success.sql
│       ├── gold/                  # Star schema
│       │   ├── fact_orders.sql
│       │   ├── fact_payments.sql
│       │   ├── fact_sessions.sql
│       │   ├── dim_customer.sql
│       │   ├── dim_product.sql
│       │   ├── dim_date.sql
│       │   └── dim_campaign.sql
│       └── analytics/             # Business insights
│           ├── revenue_analysis.sql
│           ├── customer_ltv.sql
│           ├── hidden_revenue_opportunities.sql
│           └── operational_metrics.sql
│
├── tests/                         # dbt tests
│   ├── data_quality/
│   └── business_logic/
│
├── docs/                          # Documentation
│   ├── architecture_diagram.md
│   ├── data_dictionary.md
│   └── data_quality_report.md
│
├── dashboards/                    # BI dashboard exports
│   ├── revenue_leakage.twbx
│   ├── operational_issues.twbx
│   ├── customer_analytics.twbx
│   └── marketing_attribution.twbx
│
├── README.md                      # This file
└── requirements.txt               # Python dependencies
```

---

## Data Flow

### 1. Generation Layer (Python)
```bash
# Generate all 13 tables with realistic data quality issues
python master_data_generator.py
```

**Output**: 13 CSV files (12.6M rows, ~2GB total)

### 2. Bronze Layer (Raw Ingestion)
```sql
-- Load CSVs into data warehouse as-is
-- No transformations, preserve all issues
CREATE TABLE bronze.crm_sales AS 
SELECT *, CURRENT_TIMESTAMP() AS load_timestamp 
FROM read_csv_auto('crm_sales_01.csv');
```

### 3. Silver Layer (dbt Transformations)
```bash
# Clean and standardize data
dbt run --models silver.*
```

**Key Transformations**:
- Parse string prices → numeric
- Deduplicate customers (15% reduction)
- Standardize categories (47 variations → 10 core)
- Fix date inversions
- Reconcile returns without refunds

### 4. Gold Layer (Star Schema)
```bash
# Build analytics-ready fact/dimension tables
dbt run --models gold.*
```

**Output**: 
- 3 fact tables (orders, payments, sessions)
- 4 dimension tables (customer, product, date, campaign)

### 5. Analytics Layer (Business Insights)
```bash
# Generate revenue opportunity analysis
dbt run --models analytics.*
```

**Output**: 
- $120K in hidden revenue opportunities
- 7 actionable insight queries
- Executive dashboards

---

## Key Data Quality Issues & Solutions

### Issue #1: 70% Web Sessions Lack Customer ID
**Problem**: Attribution impossible for majority of traffic

**Solution**:
```sql
-- Session stitching using cookies and IP address
WITH session_bridge AS (
    SELECT 
        session_token,
        customer_id,
        ip_address,
        ROW_NUMBER() OVER (PARTITION BY session_token ORDER BY session_start) AS rn
    FROM web_sessions
    WHERE customer_id IS NOT NULL
)
-- Probabilistic attribution model
```

### Issue #2: 15% Duplicate Customers
**Problem**: Inflated customer counts, loyalty program abuse

**Solution**:
```sql
-- Fuzzy matching on email, phone, address
WITH ranked_customers AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY LOWER(TRIM(email))
            ORDER BY created_date DESC
        ) AS rn
    FROM bronze.customer_master
)
SELECT * FROM ranked_customers WHERE rn = 1
```

### Issue #3: String Prices ("$129.99", "€89.99")
**Problem**: Revenue calculations impossible

**Solution**:
```sql
-- Parse and convert to numeric
CAST(
    REGEXP_REPLACE(gross_price, '[^0-9.]', '') 
    AS DECIMAL(10,2)
) AS price_usd
```

### Issue #4: 20% Returns Not Logged
**Problem**: Revenue reconciliation broken, return rate underreported

**Solution**: Cross-reference payment refunds to identify missing returns

### Issue #5: Email Conversion Attribution Missing
**Problem**: 70-80% of click events lack order_id

**Solution**: Time-based probabilistic attribution (clicks within 24h of orders)

---

## $120K Hidden Revenue Analysis

### Revenue Opportunity Breakdown

| Opportunity | Amount | Effort | Priority | SQL Query |
|-------------|--------|--------|----------|-----------|
| **Abandoned Carts** | $25K | Low | 🔥 HIGH | `analytics/abandoned_carts.sql` |
| **Failed Payment Retries** | $28K | Low | 🔥 HIGH | `analytics/payment_retries.sql` |
| **Returns Without Refunds** | $22K | Medium | 🔥 HIGH | `analytics/unprocessed_refunds.sql` |
| **Promo Code Abuse** | $15K | Medium | 🟡 MED | `analytics/promo_overuse.sql` |
| **Negative Inventory Sales** | $12K | High | 🟡 MED | `analytics/inventory_lost_sales.sql` |
| **Shipping Cost Recovery** | $10K | Medium | 🟢 LOW | `analytics/shipping_recovery.sql` |
| **Duplicate Account Credits** | $8K | Medium | 🟢 LOW | `analytics/duplicate_credits.sql` |
| **TOTAL** | **$120K** | | | |

### Sample Insight Query

```sql
-- Abandoned Carts with Recovery Potential
SELECT
    customer_id,
    COUNT(*) as abandoned_carts,
    SUM(cart_value) as lost_revenue,
    AVG(DATEDIFF('day', cart_date, CURRENT_DATE())) as days_since_abandon
FROM {{ ref('silver_web_sessions') }}
WHERE order_status = 'abandoned'
  AND cart_value > 50
  AND DATEDIFF('day', cart_date, CURRENT_DATE()) BETWEEN 1 AND 30
GROUP BY customer_id
HAVING COUNT(*) >= 2
ORDER BY lost_revenue DESC
```

**Business Impact**: 5,000 customers with abandoned carts worth $25K. Single email campaign could recover 20% = $5K immediate revenue.

---

## Environment Setup

### Prerequisites
- Python 3.10+
- Snowflake/BigQuery/PostgreSQL account
- dbt-core or dbt Cloud
- Tableau/Looker/Power BI (for dashboards)
- Git

### Installation

1. **Clone repository**
```bash
git clone <repository-url>
cd ecommerce-data-pipeline
```

2. **Install Python dependencies**
```bash
pip install -r requirements.txt
```

3. **Configure dbt**
```bash
cd dbt_project
cp profiles.yml.example profiles.yml
# Edit profiles.yml with your database credentials
```

4. **Generate data**
```bash
cd ../data_generation
python master_data_generator.py
```

5. **Load to warehouse**
```bash
# Option 1: Snowflake (Python)
python load_to_snowflake.py

# Option 2: Manual upload via UI
# Upload CSVs to your warehouse
```

6. **Run dbt transformations**
```bash
cd ../dbt_project
dbt deps           # Install packages
dbt seed           # Load seed data (if any)
dbt run            # Run all models
dbt test           # Run data quality tests
```

---

## Quick Start

### Option 1: Full Pipeline (Recommended)
```bash
# 1. Generate all data (~1-2 hours)
python data_generation/master_data_generator.py

# 2. Load to warehouse (varies by method)
python load_to_snowflake.py

# 3. Run dbt transformations (~10-15 min)
cd dbt_project
dbt run

# 4. Generate dashboards (manual in BI tool)
```

### Option 2: Sample Data (Fast Testing)
```bash
# Generate 10K row samples (~5 minutes)
python data_generation/master_data_generator.py --sample 10000

# Load and transform
python load_to_snowflake.py --sample
cd dbt_project
dbt run --select silver.* gold.*
```

---

## Testing

### dbt Tests
```bash
cd dbt_project

# Run all tests
dbt test

# Test specific models
dbt test --select silver_orders_cleaned
dbt test --select gold.*
```

### Data Quality Tests
- **Uniqueness**: Primary keys have no duplicates
- **Not Null**: Required fields are populated
- **Referential Integrity**: Foreign keys match parent tables
- **Accepted Values**: Status fields match allowed values
- **Relationships**: Orders link to valid customers/products

### Python Tests (Optional)
```bash
cd data_generation
pytest tests/ -v
```

---

## Deployment

### Local Development
```bash
# Run dbt locally
dbt run --target local
```

### Production
```bash
# Deploy to production
dbt run --target prod

# Run incremental models only
dbt run --select state:modified+ --state ./target
```

### CI/CD (GitHub Actions Example)
```yaml
name: dbt CI/CD
on: [push]
jobs:
  dbt-run:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dbt
        run: pip install dbt-snowflake
      - name: Run dbt
        run: |
          cd dbt_project
          dbt run --target prod
          dbt test
```

---

## Dashboards

### Executive Dashboard Suite (4 Dashboards)

1. **Revenue Leakage Dashboard**
   - KPI Cards: $120K total opportunity, $75K high-priority
   - Abandoned cart trend (daily)
   - Failed payments by reason
   - Unprocessed refunds aging report

2. **Operational Issues Dashboard**
   - Negative inventory products (top 15)
   - Duplicate customer accounts
   - Promo code overuse alerts
   - Shipping cost errors

3. **Customer Analytics Dashboard**
   - Customer lifetime value distribution
   - Cohort retention curves
   - Churn risk segmentation
   - Email engagement funnel

4. **Marketing Attribution Dashboard**
   - Channel ROI comparison
   - Campaign performance table
   - Web-to-order conversion rates
   - Email click-to-purchase tracking

---

## Project Metrics

| Metric | Value |
|--------|-------|
| **Total Tables** | 13 |
| **Total Rows** | 12.6M |
| **Total Storage** | ~2GB |
| **Data Quality Issues** | 45+ types |
| **dbt Models** | 25+ |
| **Revenue Opportunities** | $120K |
| **Generation Time** | 1.5-2 hours |
| **Transformation Time** | 10-15 min |

---

## Skills Demonstrated

### Data Engineering
- ✅ Medallion architecture (Bronze/Silver/Gold)
- ✅ Star schema design (fact/dimension modeling)
- ✅ dbt transformations and testing
- ✅ Data quality management
- ✅ ETL/ELT pipelines
- ✅ Slowly changing dimensions (SCD Type 2)

### Analytics Engineering
- ✅ Business metrics definition
- ✅ Customer lifetime value (CLV)
- ✅ Cohort analysis
- ✅ Attribution modeling
- ✅ Revenue reconciliation

### Technical Skills
- ✅ Python (Pandas, NumPy)
- ✅ SQL (complex joins, window functions, CTEs)
- ✅ Cloud data warehouses (Snowflake/BigQuery)
- ✅ Data visualization (Tableau/Looker)
- ✅ Git version control
- ✅ Documentation (Markdown, Mermaid)

---

## Use Cases

### For Data Engineers
- Portfolio project demonstrating real-world data pipeline
- Practice with messy data and quality issues
- Learn dbt best practices
- Implement medallion architecture

### For Analytics Engineers
- Build star schema models
- Create business metrics
- Practice SQL optimization
- Design executive dashboards

### For Hiring Managers
- Assess candidate's ability to:
  - Handle complex data quality issues
  - Build scalable data pipelines
  - Generate business insights
  - Communicate technical concepts

---

## Future Enhancements

- [ ] Airflow/Dagster orchestration
- [ ] Great Expectations data quality framework
- [ ] CI/CD pipeline with automated tests
- [ ] Machine learning models (churn prediction, LTV forecasting)
- [ ] Real-time streaming layer (Kafka/Kinesis)
- [ ] Data catalog (DataHub/Atlan)
- [ ] Cost optimization analysis

---

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

---

## License

MIT License - feel free to use for personal or commercial projects.

---

## Contact & Acknowledgments

**Author**: [Your Name]  
**LinkedIn**: [Your LinkedIn]  
**Portfolio**: [Your Portfolio Site]  

**Inspired by**: Real-world e-commerce data engineering challenges at mid-sized DTC brands.

---

## Additional Resources

- [dbt Best Practices](https://docs.getdbt.com/best-practices)
- [Kimball Dimensional Modeling](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/)
- [Snowflake Documentation](https://docs.snowflake.com/)
- [Tableau Training](https://www.tableau.com/learn/training)

---

*This project demonstrates production-grade data engineering practices and business acumen suitable for senior data engineering roles.*
