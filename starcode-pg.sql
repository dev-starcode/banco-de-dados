-- Criar schema
CREATE SCHEMA IF NOT EXISTS tenant;

-- Usar o schema
SET search_path TO tenant;

-- Tabelas
CREATE TABLE brands (
    brand_id  VARCHAR(36) PRIMARY KEY,
    name VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE categories (
    category_id  VARCHAR(36) PRIMARY KEY,
    name VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE suppliers (
    supplier_id  VARCHAR(36) PRIMARY KEY,
    cod INT,
    name VARCHAR(45),
    document VARCHAR(45),
    email VARCHAR(45),
    phone VARCHAR(12),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id  VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255),
    image TEXT,
    brand_id  VARCHAR(36) REFERENCES brands(brand_id),
    category_id  VARCHAR(36) REFERENCES categories(category_id),
    supplier_id  VARCHAR(36) REFERENCES suppliers(supplier_id),
    quantity INT,
    quantity_min INT,
    price_cost DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    validate_date DATE,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_price_history (
    product_price_history_id  VARCHAR(36) PRIMARY KEY,
    product_id  VARCHAR(36) REFERENCES products(product_id),
    type VARCHAR(20),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE stock_movements (
    stock_movement_id  VARCHAR(36) PRIMARY KEY,
    product_id  VARCHAR(36) REFERENCES products(product_id),
    quantity_changed INT,
    movement_type INT,
    date_movement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(30)
);

CREATE TABLE users (
    user_id  VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255),
    tenant VARCHAR(45),
    email VARCHAR(100),
    password VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clients (
    client_id  VARCHAR(36) PRIMARY KEY,
    cod VARCHAR(9),
    name VARCHAR(255),
    image VARCHAR(255),
    document VARCHAR(20),
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sales (
    sale_id  VARCHAR(36) PRIMARY KEY,
    user_id  VARCHAR(36) REFERENCES users(user_id),
    client_id  VARCHAR(36) REFERENCES clients(client_id),
    cashier_id  VARCHAR(36),
    partial_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    total DECIMAL(10,2),
    status VARCHAR(20),
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products_sale (
    product_sale_id  VARCHAR(36) PRIMARY KEY,
    sale_id  VARCHAR(36) REFERENCES sales(sale_id),
    product_id  VARCHAR(36) REFERENCES products(product_id),
    product_name VARCHAR(255),
    price_cost DECIMAL(10,2),
    price_sale DECIMAL(10,2),
    quantity INT,
    total_price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cashier (
    cashier_id VARCHAR(36) PRIMARY KEY,
    opening_amount DECIMAL(10,2),
    status VARCHAR(20),
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_opened_id  VARCHAR(36) REFERENCES users(user_id),
    user_closed_id  VARCHAR(36) REFERENCES users(user_id),
    total_sales INT,
    closing_amount DECIMAL(10,2)
);

CREATE TABLE cashier_movements (
    cashier_movement_id  VARCHAR(36) PRIMARY KEY,
    cashier_id  VARCHAR(36) REFERENCES cashier(cashier_id),
    user_id  VARCHAR(36) REFERENCES users(user_id),
    type VARCHAR(10),
    amount DECIMAL(10,2),
    reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE shopping (
    shopping_id  VARCHAR(36) PRIMARY KEY,
    supplier_id  VARCHAR(36) REFERENCES suppliers(supplier_id),
    product_id  VARCHAR(36) REFERENCES products(product_id),
    price_cost DECIMAL(10,2),
    quantity INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE enterprises (
    enterprise_id  VARCHAR(36) PRIMARY KEY,
    user_id  VARCHAR(36) REFERENCES users(user_id),
    logo VARCHAR(255),
    document VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE addresses (
    address_id  VARCHAR(36) PRIMARY KEY,
    entity_id  VARCHAR(36),
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
    enterprise_user_id  VARCHAR(36) PRIMARY KEY,
    user_id  VARCHAR(36) REFERENCES users(user_id),
    enterprise_id  VARCHAR(36) REFERENCES enterprises(enterprise_id),
    role VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE permissions (
    permission_id  VARCHAR(36) PRIMARY KEY,
    type VARCHAR(45),
    description VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_permissions (
    user_permission_id  VARCHAR(36) PRIMARY KEY,
    user_id  VARCHAR(36) REFERENCES users(user_id),
    permission_id  VARCHAR(36) REFERENCES permissions(permission_id),
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE account_categories (
    account_categories_id  VARCHAR(36) PRIMARY KEY,
    name VARCHAR(45),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_methods (
    payment_methods_id  VARCHAR(36) PRIMARY KEY,
    name VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE accounts_payables (
    accounts_payable_id  VARCHAR(36) PRIMARY KEY,
    description TEXT,
    amount DECIMAL(10,2),
    due_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    account_categories_id  VARCHAR(36) REFERENCES account_categories(account_categories_id),
    payment_methods_id  VARCHAR(36) REFERENCES payment_methods(payment_methods_id),
    supplier_id  VARCHAR(36) REFERENCES suppliers(supplier_id)
);

CREATE TABLE accounts_receivables (
    accounts_receivable  VARCHAR(36) PRIMARY KEY,
    description TEXT,
    amount DECIMAL(10,2),
    due_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    received_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    client_id  VARCHAR(36) REFERENCES clients(client_id),
    account_categories_id  VARCHAR(36) REFERENCES account_categories(account_categories_id),
    payment_methods_id  VARCHAR(36) REFERENCES payment_methods(payment_methods_id)
);
