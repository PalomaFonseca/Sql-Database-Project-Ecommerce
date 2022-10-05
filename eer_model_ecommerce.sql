-- CREATING BD
CREATE DATABASE IF NOT EXISTS ecommerce_refinado;
USE ecommerce_refinado;

-- CREATING TABLES AND POPULATING

CREATE TABLE login(
	id_login int auto_increment not null,
    username varchar(20) not null,
    password_log varchar(20) not null,
    primary key(id_login),
    constraint uni_username unique(username)
);

INSERT INTO login(username, password_log) 
values
('paloma123','123456/'),
('rafael123','65436/8'),
('katarina123','456789'),
('zed123','336545/'),
('kalista123','658567/'),
('fizz123','325646/'),
('gangplank123','1456546');
            
CREATE TABLE person(
	id_person int not null auto_increment,
    id_plogin int not null,
    cpf char(11) not null,
    fname varchar(10) not null,
    minit char(3) not null,
    lname varchar(20) not null,
    phone varchar(20) not null,
    email varchar(20) not null,
    bdate date not null,
    address varchar(50),
    primary key(id_person),
    constraint uni_cpf unique(cpf),
    constraint fk_person_login foreign key(id_plogin) references login(id_login)
);

INSERT INTO person(id_plogin, cpf, fname, minit, lname, phone, email, bdate, address) 
values
(8,'11111111111','Gang','P','Plank','1123456789','gang@hotmail.com','20100205', 'Rua de lá,25'),
(7,'22222222222','Fizz','M','Fish','2223456789','fizz@hotmail.com','20110407', 'Rua daqui,755'),
(6,'33333333333','Twitch','L','Mouse','3323456789','twitch@hotmail.com','20090101', 'Rua solta,98'),
(5,'44444444444','Kalista','O','Sombras','4423456789','kalista@hotmail.com','20100205', 'Rua dos outros,1000');
                    

CREATE TABLE company(
	id_company int not null auto_increment,
    id_clogin int not null,
    cnpj char(14) not null,
    company_name varchar(60) not null,
    phone varchar(20) not null,
    address varchar(50) not null,
    email varchar(20) not null,
    primary key(id_company),
    constraint uni_cnpj unique(cnpj),
    constraint fk_company_login foreign key(id_clogin) references login(id_login)
);

INSERT INTO company(id_clogin, cnpj, company_name, phone, address, email) 
values
(4,'11111789456123','Zed comércio de Sombras','9978945123','Rua da avenidas, 55','zedcom@gmail.com'),
(3,'2222789456123','Katarina comércio de Laminas','9978945123','Rua da avenidas, 988','katcom@gmail.com'),
(2,'3333789456123','Rafael comércio de Perfusão','9976575123','Rua das pescas, 785','rafacom@gmail.com'),
(1,'4444789456123','Paloma comércio de Dados','9912345123','Rua dos bites, 4122','palomacom@gmail.com');


CREATE TABLE ourder(
	id_ourder int not null auto_increment,
    id_log_ourder int not null,
    ou_description varchar(255) not null,
    ou_date date not null,
    ou_status enum('Processing', 'Confirmed', 'Canceled') not null,
    delivery_value float not null,
    primary key(id_ourder),
    constraint fk_ourder_login foreign key(id_log_ourder) references login(id_login)
);

INSERT INTO ourder(id_log_ourder,ou_description,ou_date,ou_status,delivery_value) 
values
(1,'Computer,Mouse,Molinete','20220714','Confirmed',25.0),
(2,'Carpet,Table,Windlass','20220716','Confirmed',32.0),
(3,'Dog Collar,Food Plate,Teddy Bear','20220727','Confirmed',55.0),
(5,'Play Guinea Pig,Doll,Fork','20220801','Confirmed',14.0),
(6,'Mouse,Artifical Bait,SwitchBlade, Porcelain Dish','20220811','Confirmed',23.0),
(7,'Keyboard,Table,Light Fixture','20220926','Processing',32.0),
(1,'Keyborad,Windlass,Doll','20220927','Processing',18.0);

CREATE TABLE payment(
	id_payment int auto_increment not null,
    id_payourder int not null,
    pay_date date not null,
    valor float not null,
    pay_type enum('Credito', 'Boleto', 'Pix') not null,
    pay_status enum('Processing', 'Confirmed', 'Error') not null,
    primary key(id_payment),
    constraint fk_payment_order foreign key(id_payourder) references ourder(id_ourder)
);
Select  * from ourder;

INSERT INTO payment(id_payourder,pay_date,valor,pay_type,pay_status)
values
(1,'20220715',1430.0,'Credito','Confirmed'),
(2,'20220716',942.0,'Credito','Confirmed'),
(3,'20220727',179.0,'Boleto','Confirmed'),
(5,'20220802',243.0,'Boleto','Confirmed'),
(6,'20220811',0,'Credito','Error'),
(7,'20220927',657.0,'Pix','Processing'),
(1,'20220927',588.0,'Pix','Processing');


CREATE TABLE credit(
	id_credit int auto_increment not null,
	id_cred_pay int not null,
	cardholder varchar(50),
	due_date date,
	num int,
	primary key(id_credit),
	constraint fk_credit_pay foreign key(id_cred_pay) references payment(id_payment)
);


INSERT INTO credit(id_cred_pay,cardholder,due_date,num) 
values
(1,'Omaley Santos','20280402',2147483647),
(2,'Nunu Oliveira','20300301',1147483647),
(5,'Ivern Willup','20290210',1447483647);
                
CREATE TABLE pix(
	id_pix int auto_increment not null,
    id_pix_pay int not null,
    code_pix varchar(50),
    primary key(id_pix),
    constraint fk_pix_pay foreign key(id_pix_pay) references payment(id_payment)
);

INSERT INTO pix(id_pix_pay,code_pix) 
values
(6,'5465494984163416549796415341654165'),
(7,'5456416489403156310546534654564465');

CREATE TABLE ticket(
	id_ticket int auto_increment not null,
    id_tick_pay int not null,
    code_tick varchar(50),
    primary key(id_ticket),
    constraint fk_tick_pay foreign key(id_tick_pay) references payment(id_payment)
);

INSERT INTO ticket(id_tick_pay,code_tick) 
values  
(3,'54556s4d54df6564fd6f5'),
(4,'65f4g5h65645656456hh7');

CREATE TABLE delivery(
	id_delivery int auto_increment not null,
    id_delivery_our int not null,
    expected_date date not null,
    delivery_address varchar(45) not null,
    zip varchar(45) not null,
    del_status enum('In the carrier', 'Out for delivery', 'Delivered') not null,
    tracking_code varchar(50),
    primary key(id_delivery),
    constraint fk_delivery_our foreign key(id_delivery_our) references ourder(id_ourder)
);

INSERT INTO delivery(id_delivery_our,expected_date,delivery_address,zip,del_status,tracking_code) 
values
(1,20220730,'Rua Nossa Senhora, 326','43000-00','Delivered','56545665f56fsaaf56'),
(2,20220730,'Avenida dos Pássaros, 1213','57000-00','Delivered','978978s4a6fsaaf56'),
(3,20220810,'Travessa dos Peixes, 47','98000-00','Delivered','12154SA65f56fsaaf56'),
(4,20220815,'Rua Doces Azuis, 789','65000-00','Out for delivery','874654S56fsaaf56'),
(5,20220830,'Avenida dos Mamíferos, 4654','88000-00','Out for delivery','346565f56fsaaf56'),
(7,20221010,'Rua Bondosa, 246','21000-00','In the carrier','764165f56fsaaf56');

CREATE TABLE product(
	id_product int auto_increment not null,
    description_prod varchar(255) not null,
    category varchar(20) not null,
    product_value float not null,
    primary key(id_product)
);

INSERT INTO product(description_prod,category,product_value) 
values
('computer','games',1000.0),
('mouse','games',50.0),
('keyboard','games',100.0),
('light fixture','house',25.0),
('carpet','house',60.0),
('table','house',500.0),
('windlass','fishing',350.0),
('molinete','fishing',355.0),
('artificial bait','fishing',35.0),
('switchblade','fishing',90.0),
('knife','kitchen',2.0),
('porcelain dish','kitchen',45.0),
('fork','kitchen',10.0),
('dog collar','pets',25.0),
('food plate','pets',15.0),
('play guinea pig','pets',35.0),
('racing cart','childish',75.0),
('doll','childish',120.0),
('teddy bear','childish',40.0);

CREATE TABLE product_order(
	id_product_our int not null,
    id_ourder_prod int not null,
    quantity int not null,
    primary key(id_product_our,id_ourder_prod),
    constraint fk_product_our foreign key(id_product_our) references product(id_product),
    constraint fk_ourder_prod foreign key(id_ourder_prod) references ourder(id_ourder)
);

INSERT INTO product_order(id_product_our,id_ourder_prod,quantity) 
values 
(1,1,1),
(2,1,1),
(8,1,1),
(5,2,1),
(6,2,1),
(7,2,1),
(14,3,1),
(15,3,1),
(19,3,1),
(16,4,1),
(18,4,1),
(13,4,1),
(2,5,1),
(9,5,1),
(10,5,1),
(12,5,1),
(3,6,1),
(6,6,1),
(4,6,1),
(3,7,1),
(7,7,1),
(18,7,1);

CREATE TABLE seller(
	id_seller int auto_increment not null,
    complete_name varchar(50) not null,
    cnpj char(14) not null,
    primary key(id_seller),
    constraint uni_cnpj_seller unique(cnpj)
);

INSERT INTO seller(complete_name,cnpj) 
values
('Trade games ilimited','1234567897897'),
('Trade house ilimited','11111789456123'),
('Trade fishing ilimited','33334465456887'),
('Trade kitchen ilimited','74541359874984'),
('Trade pets ilimited','65845534645646'),
('Trade childish ilimited','86786797879879');

CREATE TABLE stock(
	id_seller_prod int not null,
    id_prod_seller int not null,
    quantity int not null,
    primary key(id_seller_prod,id_prod_seller),
    constraint fk_seller_prod foreign key(id_seller_prod) references seller(id_seller),
    constraint fk_prod_seller foreign key(id_prod_seller) references product(id_product)
);

INSERT INTO stock(id_seller_prod,id_prod_seller,quantity) 
values
(1,1,15),
(1,2,15),
(1,3,20),
(2,4,20),
(2,5,25),
(2,6,25),
(3,7,35),
(3,8,35),
(3,9,60),
(3,10,60),
(4,11,15),
(4,12,15),
(4,13,40),
(5,14,40),
(5,15,50),
(5,16,50),
(6,17,75),
(6,18,75),
(6,19,25);

CREATE TABLE supplier(
	id_supplier  int auto_increment not null,
    complete_name varchar(50) not null,
    cnpj char(14) not null,
    primary key(id_supplier),
    constraint uni_cnpj_supplier unique(cnpj)
);

INSERT INTO supplier(complete_name,cnpj) 
values
('Fishing and games company',1234789456121),
('House and kitchen company',5456455646788),
('Pets and childish company',9756456413153);
    
CREATE TABLE supplier_seller(
	id_supplier_seller int not null,
    id_seller_supplier int not null,
    primary key(id_supplier_seller,id_seller_supplier),
    constraint fk_supplier_seller foreign key(id_supplier_seller) references supplier(id_supplier),
    constraint fk_seller_supplier foreign key(id_seller_supplier) references seller(id_seller)
);

INSERT INTO supplier_seller(id_supplier_seller,id_seller_supplier) 
values
(1,1),
(2,2),
(1,3),
(2,4),
(3,5),
(3,6);
                            
-- QUESTIONS

-- 1º) Quantos pedidos o login "paloma123" já realizou:
Select * from ourder where id_log_ourder = 1;

-- 2º) Nome completo dos clientes físicos e seus respectivos CPFS:
Select concat(fname, ' ', minit, ' ', lname) as Name_person, cpf from person;

-- 3º) Lista de produtos e suas respectivas categorias ordenados pelo nome dos produtos de forma descendente;
Select description_prod as Products, category from product order by description_prod desc;

-- 4º) Lista de produtos e suas respectivas categorias ordenados pelo nome dos produtos de forma ascendente com limite de 5 instâncias;
Select description_prod as Products, category from product order by description_prod limit 5;

-- 5º) Nome completo dos clientes físicos e seus respectivos CPFS:
Select concat(fname, ' ', minit, ' ', lname) as Name_person, cpf from person;

#EM PROGRESSO
