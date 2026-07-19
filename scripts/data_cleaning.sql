SELECT
    -- Keep original transaction ID and rename using snake_case
    Transaction_ID AS transaction_id,

    -- Replace missing, 'Unknown', and 'Error' item names with a standardized value
    CASE
        WHEN Item IS NULL
             OR LOWER(TRIM(Item)) IN ('unknown', 'error')
        THEN 'Unknown'
        ELSE TRIM(Item)
    END AS item,

    -- Calculate missing quantity using Total_Spent ÷ Price_Per_Unit
    CASE
        WHEN Quantity IS NULL
        THEN Total_Spent / Price_Per_Unit
        ELSE Quantity
    END AS quantity,

    -- Calculate missing unit price using Total_Spent ÷ Quantity
    CASE
        WHEN Price_Per_Unit IS NULL
        THEN Total_Spent / Quantity
        ELSE Price_Per_Unit
    END AS price_per_unit,

    -- Calculate missing total amount using Quantity × Price_Per_Unit
    CASE
        WHEN Total_Spent IS NULL
        THEN Quantity * Price_Per_Unit
        ELSE Total_Spent
    END AS total_spent,

    -- Standardize payment method values and replace invalid entries
    CASE
        WHEN Payment_Method IS NULL
             OR LOWER(TRIM(Payment_Method)) IN ('error', 'unknown')
        THEN 'Unknown'
        ELSE TRIM(Payment_Method)
    END AS payment_method,

    -- Standardize location values and replace missing or invalid entries
    CASE
        WHEN Location IS NULL
             OR LOWER(TRIM(Location)) IN ('error', 'unknown')
        THEN 'Unknown'
        ELSE TRIM(Location)
    END AS location,

    -- Rename transaction date column
    Transaction_Date AS transaction_date

FROM dirty_cafe_sales;
