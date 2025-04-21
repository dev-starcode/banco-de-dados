INSERT INTO tenant.users (user_id, name, tenant, email, password) VALUES
('73a213fe-61cc-4935-be15-fcad1280d07e', 'nando', 'bar do nando', 'nando@store.com', 'password');

INSERT INTO tenant.enterprises (enterprise_id, user_id, logo, document) VALUES 
('24338b5f-47e6-447b-9243-afe1982ba169', '73a213fe-61cc-4935-be15-fcad1280d07e', '', '00000000000');

INSERT INTO tenant.enterprise_users(enterprise_user_id, user_id, enterprise_id, role) VALUES 
('dc33e84a-c8a4-4365-b30a-edb9cecf1bc4', '73a213fe-61cc-4935-be15-fcad1280d07e', '24338b5f-47e6-447b-9243-afe1982ba169', 'owner');

INSERT INTO tenant.permissions(permission_id, type, description) VALUES 
('d3cb971a-4277-4a2d-a019-db360474a419', 'admin', 'Administrador');

INSERT INTO tenant.user_permissions(user_permission_id, user_id, permission_id) VALUES
('1d020ae2-0cbe-4c0d-bd6f-f9934e828031', '73a213fe-61cc-4935-be15-fcad1280d07e', 'd3cb971a-4277-4a2d-a019-db360474a419');

INSERT INTO tenant.clients (client_id, name, email, document) VALUES
('3184ec2a-673e-4a46-8311-3cde22341012', 'John Doe', 'john@example.com', '11122233344'),
('8c84e797-f701-4000-b8c4-1ed8baba06eb', 'Jane Smith', 'jane@example.com', '55566677788');

INSERT INTO tenant.brands (brand_id, name, description) VALUES
('fa28ac11-b88c-4f56-bdb8-93ca42725a48', 'Apple', 'Consumer electronics'),
('9d254619-4579-4b80-9632-4b7069294acf',	'tio jorge','marca tio jorge'),
('a10748c8-1226-443e-8532-c30de85b7469',	'coca cola','marca coca cola');

INSERT INTO tenant.categories (category_id, name, description) VALUES
('8d032fa7-f3b4-41f3-80d9-27d958defe70', 'Eletrônico', 'Dispositivos Eletrônico'),
('87dd6f5d-5f9b-486f-8e5f-2576f7c01488', 'Alimentos', 'Alimentos');

INSERT INTO tenant.suppliers (supplier_id, name, email, phone) VALUES
('07afce7a-0085-4ad5-9473-a80482d53c93', 'Mix Mateus.', 'mixmateus@supplier.com', '123456789'),
('e55952d1-03d5-4e0c-af59-40c31662d8be', 'Tech Supplier Inc.', 'tech@supplier.com', '123456789'),
('5924216c-155a-4560-9467-6b1dca645a34', 'Fashion Supplier Co.', 'fashion@supplier.com', '987654321');

INSERT INTO tenant.products (product_id, name, image, brand_id, category_id, supplier_id, quantity, quantity_min, price_cost, selling_price, validate_date, status) VALUES
('4e89b0ee-6be0-4000-b094-44edee80a804', 'Arroz tio Jorge', '', '9d254619-4579-4b80-9632-4b7069294acf', '87dd6f5d-5f9b-486f-8e5f-2576f7c01488', '07afce7a-0085-4ad5-9473-a80482d53c93', 100, 10, 4.5, 6, '2025-07-05', 'active'),
('7ddce0ef-c91d-43bb-9bb3-74e8051e934b', 'Feijão Tio Jorge', '', '9d254619-4579-4b80-9632-4b7069294acf', '87dd6f5d-5f9b-486f-8e5f-2576f7c01488', '07afce7a-0085-4ad5-9473-a80482d53c93', 80, 15, 5, 7.0, '2025-07-05', 'active'),
('6cff992a-3b93-4638-bc73-75bc530e95d4', 'Lanterna', '', 'fa28ac11-b88c-4f56-bdb8-93ca42725a48', '8d032fa7-f3b4-41f3-80d9-27d958defe70', 'e55952d1-03d5-4e0c-af59-40c31662d8be', 10, 2, 12, 20, null, 'active'); 

INSERT INTO tenant.stock_movements (stock_movement_id, product_id, quantity_changed, reason) VALUES
('fe9c0f78-5552-41d4-9bad-d90b27941b2e', '4e89b0ee-6be0-4000-b094-44edee80a804', 50, 'in'),
('4e849404-8e52-4092-9c73-6683d6103c91', '7ddce0ef-c91d-43bb-9bb3-74e8051e934b', 40, 'out');

INSERT INTO tenant.shopping(shopping_id, supplier_id, product_id, price_cost, quantity) VALUES
('2e01751e-890f-4b72-88fe-6f4c33f128a7', '07afce7a-0085-4ad5-9473-a80482d53c93', '4e89b0ee-6be0-4000-b094-44edee80a804', 4.5, 100),
('84e92a37-1ef2-49db-befa-8184dbaa6c30', '07afce7a-0085-4ad5-9473-a80482d53c93', '7ddce0ef-c91d-43bb-9bb3-74e8051e934b', 5, 80);

INSERT INTO tenant.cashier(cashier_id, opening_amount, status, opened_at, closed_at, user_opened_id, user_closed_id, total_sales, closing_amount) VALUES
('5d8bf2c3-bf74-4f49-ab49-fbf97efb3981', 100, 'closed', '2025-04-03 07:30:05.923341', '2025-04-03 18:30:45.923341', '73a213fe-61cc-4935-be15-fcad1280d07e', '73a213fe-61cc-4935-be15-fcad1280d07e', 2, 435),
('ee549196-b863-44cc-8857-8045463e93af', 100, 'opened', '2025-04-05 07:30:05.923341', null, '73a213fe-61cc-4935-be15-fcad1280d07e', null, 0, null);

INSERT INTO tenant.cashier_movements(cashier_movement_id, cashier_id, user_id, type, amount, reason) VALUES 
('2bd46586-1143-4900-8d58-5e02e610b24c', '5d8bf2c3-bf74-4f49-ab49-fbf97efb3981', '73a213fe-61cc-4935-be15-fcad1280d07e', 'in', 130.00, 'venda realizada'),
('14a7bac4-d179-48ce-9267-2025be34895a', '5d8bf2c3-bf74-4f49-ab49-fbf97efb3981', '73a213fe-61cc-4935-be15-fcad1280d07e', 'in', 300.00, 'venda realizada'),
('eb5f4ebc-4ae2-4553-a99c-f2355d2e0b1e', '5d8bf2c3-bf74-4f49-ab49-fbf97efb3981', '73a213fe-61cc-4935-be15-fcad1280d07e', 'out', 100.00, 'conta de internet paga'),
('f8a16f40-bc72-42d2-816d-3275f42d50ba', 'ee549196-b863-44cc-8857-8045463e93af', '73a213fe-61cc-4935-be15-fcad1280d07e', 'in', 100.00, 'venda realizada');

INSERT INTO tenant.sales(sale_id, user_id, client_id, cashier_id, partial_price, discount, total, status, sale_date) VALUES 
('88ec98aa-512b-4496-a5f3-d1c910b2c51d', '73a213fe-61cc-4935-be15-fcad1280d07e', null, '5d8bf2c3-bf74-4f49-ab49-fbf97efb3981', 135, 0, 130, 'paid', '2025-04-03 08:30:05.923341'),
('816ce30c-5a96-4151-894d-8e176985df83', '73a213fe-61cc-4935-be15-fcad1280d07e', '3184ec2a-673e-4a46-8311-3cde22341012', 'ee549196-b863-44cc-8857-8045463e93af', 100,  0, 100, 'paid', null);

INSERT INTO tenant.products_sale(product_sale_id, sale_id, product_id, product_name, price_cost, price_sale, quantity, total_price) VALUES 
('131e25a5-56ad-42bd-95fc-f5f6ecd29ab5', '88ec98aa-512b-4496-a5f3-d1c910b2c51d', '6cff992a-3b93-4638-bc73-75bc530e95d4', 'Lanterna', 12, 20, 5, 100),
('158fd012-3a14-41f7-8811-f1f1c11f7cce', '88ec98aa-512b-4496-a5f3-d1c910b2c51d', '7ddce0ef-c91d-43bb-9bb3-74e8051e934b', 'Feijão',  5, 7, 5, 35),
('50baeea6-f496-4309-ac6b-520af6d1e669', '816ce30c-5a96-4151-894d-8e176985df83', '6cff992a-3b93-4638-bc73-75bc530e95d4', 'Lanterna',  12, 20, 5, 100);

INSERT INTO tenant.addresses(address_id, entity_id, street, number, city, state, country, postal_code, complement) VALUES
('5c34a08e-2f85-4707-815f-e5a3890bdc92', 'e55952d1-03d5-4e0c-af59-40c31662d8be', 'Rua do Carmo', 500, 'Santa Inês', 'MA', 'Brasil', '65300-000', 'Sem Complemento'),
('06e20c79-4bc7-442c-ac4f-09540cccd2a1', '07afce7a-0085-4ad5-9473-a80482d53c93', 'Rua do Oswaldo Cruz', 325, 'Santa Inês', 'MA', 'Brasil', '65300-000', 'Sem Complemento'),
('5924216c-155a-4560-9467-6b1dca645a34', '07afce7a-0085-4ad5-9473-a80482d53c93', 'Rua do Alagoas', 448, 'Santa Inês', 'MA', 'Brasil', '65301-012', 'Sem Complemento'),
('7d9a2008-df42-43c5-923f-89827d650d24', '73a213fe-61cc-4935-be15-fcad1280d07e', 'Rua 21 de abril', 222, 'Santa Inês', 'MA', 'Brasil', '65300-000', 'Sem Complemento');
