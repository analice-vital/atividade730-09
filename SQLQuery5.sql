if db_id('oficina_mecanica_db') is null
begin
    create database oficina_mecanica_db;
end

go

use oficina_mecanica_db;

go

create table clientes (
    id int identity(1,1) primary key,
    nome varchar(120) not null,
    cpf varchar(14) not null unique,
    telefone varchar(20) not null,
    email varchar(150) not null,
    endereco varchar(200) not null
);

create table veiculos (
    id int identity(1,1) primary key,
    cliente_id int not null,
    placa varchar(7) not null unique,
    marca varchar(50) not null,
    modelo varchar(50) not null,
    ano_fabricacao int not null,
    chassi varchar(17) not null unique,
    foreign key (cliente_id) references clientes(id)
);

create table mecanicos (
    id int identity(1,1) primary key,
    nome varchar(120) not null,
    cpf varchar(14) not null unique,
    telefone varchar(20) not null,
    email varchar(150) not null,
    data_contratacao date not null,
    funcao varchar(100) not null
);

create table ordens_servico (
    id int identity(1,1) primary key,
    veiculo_id int not null,
    mecanico_id int not null,
    data_abertura datetime not null,
    estimativa_entrega datetime not null,
    descricao varchar(300) not null,
    valor_total decimal(10,2) not null,
    status varchar(20) not null,
    foreign key (veiculo_id) references veiculos(id),
    foreign key (mecanico_id) references mecanicos(id)
);

insert into clientes
(nome, cpf, telefone, email, endereco)
values
('João da Silva', '123.456.789-00', '(14) 99876-1234', 'joao.silva@email.com', 'Botucatu'),
('Mariana de Oliveira', '987.654.321-00', '(14) 99123-4567', 'mariana.oliveira@email.com', 'Pardinho'),
('Carlos Menezes', '321.987.654-11', '(14) 99654-3210', 'carlos.mennezis@email.com', 'São Manuel'),
('Ana Beatriz de Souza', '456.789.123-22', '(14) 99444-8899', 'ana.souza@email.com', 'Botucatu');

select * from clientes;

insert into veiculos
(cliente_id, placa, marca, modelo, ano_fabricacao, chassi)
values
(1, 'ABC1A23', 'Fiat', 'Uno', 2015, '9BWZZZ377VT004251'),
(2, 'XYZ9Z99', 'Chevrolet', 'Onix', 2020, '9BG116GW04C400001'),
(3, 'JKL3D45', 'Toyota', 'Corolla', 2018, '8AJZZZ123J1234567'),
(4, 'QWE7E77', 'Honda', 'Fit', 2017, '93HGE8850EZ500123');

select * from veiculos;

insert into mecanicos
(nome, cpf, telefone, email, data_contratacao, funcao)
values
('Rafael dos Santos', '888.999.000-11', '(14) 99777-1234', 'rafael.santos@autotechnology.com', '2025-01-01', 'Mecânico Geral'),
('Luciana Fernandes', '777.888.999-22', '(14) 99666-4567', 'luciana.fernandes@autotechnology.com', '2025-06-15', 'Especialista em Freios'),
('Pedro Almeida', '666.777.888-33', '(14) 99555-7890', 'pedro.almeida@autotechnology.com', '2023-09-10', 'Eletricista Automotivo'),
('Carla Monteiro', '555.666.777-44', '(14) 99444-3210', 'carla.monteiro@autotechnology.com', '2024-06-01', 'Mecânica de Veículos Leves');

select * from mecanicos;

insert into ordens_servico
(veiculo_id, mecanico_id, data_abertura, estimativa_entrega, descricao, valor_total, status)
values
(1, 1, '2025-09-20 08:30:00', '2025-09-21 08:30:00', 'Troca de óleo e filtro', 150.00, 'Concluída'),
(2, 2, '2025-09-21 10:00:00', '2025-09-23 10:00:00', 'Substituição de pastilhas de freio dianteiras', 300.00, 'Em Andamento'),
(3, 3, '2025-09-22 14:15:00', '2025-09-23 08:00:00', 'Diagnóstico de falha no sistema elétrico', 120.00, 'Aberta'),
(4, 4, '2025-09-23 09:45:00', '2025-09-24 09:45:00', 'Alinhamento e balanceamento', 100.00, 'Cancelada');

select * from ordens_servico;

update veiculos
set modelo = 'Civic'
where placa = 'QWE7E77';

select * from veiculos;

update clientes
set email = 'carlos.menezes@email.com'
where cpf = '321.987.654-11';

select * from clientes;

delete from ordens_servico
where veiculo_id = 4;

select * from ordens_servico;