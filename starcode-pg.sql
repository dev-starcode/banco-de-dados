-- Criar schema
CREATE SCHEMA IF NOT EXISTS tenant01;

-- Usar o schema
SET search_path TO tenant01;

-- Tabelas
CREATE TABLE brands (
    brand_id UUID PRIMARY KEY,
    name VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE categories (
    category_id UUID PRIMARY KEY,
    name VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE suppliers (
    supplier_id UUID PRIMARY KEY,
    cod INT,
    name VARCHAR(45),
    document VARCHAR(45),
    email VARCHAR(45),
    phone VARCHAR(12),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id UUID PRIMARY KEY,
    name VARCHAR(255),
    image TEXT,
    brand_id UUID REFERENCES brands(brand_id),
    category_id UUID REFERENCES categories(category_id),
    supplier_id UUID REFERENCES suppliers(supplier_id),
    quantity INT,
    quantity_min INT,
    price_cost DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    validate_date DATE,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_price_history (
    product_price_history_id UUID PRIMARY KEY,
    product_id UUID REFERENCES products(product_id),
    type VARCHAR(20),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stock_movements (
    stock_movement_id UUID PRIMARY KEY,
    product_id UUID REFERENCES products(product_id),
    quantity_changed INT,
    movement_type INT,
    date_moviment TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(30)
);

CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    name VARCHAR(255),
    tenant VARCHAR(45),
    email VARCHAR(100),
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clients (
    client_id UUID PRIMARY KEY,
    cod VARCHAR(9),
    name VARCHAR(255),
    image VARCHAR(255),
    document VARCHAR(20),
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales (
    sale_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id),
    client_id UUID REFERENCES clients(client_id),
    cashier_id UUID,
    parcial_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    total DECIMAL(10,2),
    status VARCHAR(20),
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sale_products (
    sale_product_id UUID PRIMARY KEY,
    sale_id UUID REFERENCES sales(sale_id),
    product_id UUID REFERENCES products(product_id),
    product_name VARCHAR(45),
    price_coust DECIMAL(10,2),
    price_sale DECIMAL(10,2),
    quantity INT,
    total_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cashier (
    cashier_id UUID PRIMARY KEY,
    opening_amount DECIMAL(10,2),
    status VARCHAR(20),
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_opened_id UUID REFERENCES users(user_id),
    user_closed_id UUID REFERENCES users(user_id),
    total_sales INT,
    closing_amount DECIMAL(10,2)
);

CREATE TABLE cashier_moviments (
    cashier_moviment_id UUID PRIMARY KEY,
    cashier_id UUID REFERENCES cashier(cashier_id),
    user_id UUID REFERENCES users(user_id),
    type VARCHAR(10),
    amount DECIMAL(10,2),
    reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shopping (
    shopping_id UUID PRIMARY KEY,
    supplier_id UUID REFERENCES suppliers(supplier_id),
    product_id UUID REFERENCES products(product_id),
    price_cost DECIMAL(10,2),
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE enterprises (
    enterprise_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id),
    logo VARCHAR(255),
    document VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    address_id UUID PRIMARY KEY,
    entity_id UUID,
    street VARCHAR(45),
    number INT,
    city VARCHAR(45),
    state VARCHAR(45),
    country VARCHAR(45),
    postal_code VARCHAR(15),
    complement VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE enterprise_users (
    enterprise_user_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id),
    enterprise_id UUID REFERENCES enterprises(enterprise_id),
    role VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE permissions (
    permission_id UUID PRIMARY KEY,
    type VARCHAR(45),
    description VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_permissions (
    user_permission_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(user_id),
    permission_id UUID REFERENCES permissions(permission_id),
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE account_categories (
    account_categories_id UUID PRIMARY KEY,
    name VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods (
    payment_methods_id UUID PRIMARY KEY,
    name VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounts_payables (
    accounts_payable_id UUID PRIMARY KEY,
    description TEXT,
    amount DECIMAL(10,2),
    due_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    account_categories_id UUID REFERENCES account_categories(account_categories_id),
    payment_methods_id UUID REFERENCES payment_methods(payment_methods_id),
    supplier_id UUID REFERENCES suppliers(supplier_id)
);

CREATE TABLE accounts_receivables (
    accounts_receivable UUID PRIMARY KEY,
    description TEXT,
    amount DECIMAL(10,2),
    due_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    received_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    client_id UUID REFERENCES clients(client_id),
    account_categories_id UUID REFERENCES account_categories(account_categories_id),
    payment_methods_id UUID REFERENCES payment_methods(payment_methods_id)
);
