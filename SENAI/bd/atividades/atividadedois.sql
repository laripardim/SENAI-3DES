create database funcionarios;
use funcionarios;

Create table Funcionarios(
    Cod_Func numeric(4) not null,
    Nome_Func varchar(50) not null,
    Sexo char(1) not null,
    Cidade varchar(30),
    Estado varchar(2),
    constraint pk_func_1 primary key(Cod_Func)
);

Create table Departamentos(
    Cod_Depto numeric(4) not null,
    Nome_Depto varchar(50) not null,
    constraint pk_dep_1 primary key(Cod_Depto)
);

Create table Produtos(
    Cod_Produto numeric(4) not null,
    Nome_produto varchar(50) not null,
    constraint pk_prod_1 primary key(Cod_Produto)
);

Create table Solicitacao(
    Num_Sol numeric(4) not null,
    Data_sol date null,
    Cod_Depto numeric(4) not null,
    Cod_Func numeric(4) not null,
    constraint pk_sol_1 primary key(Num_Sol),
    constraint fk_sol_dep_1 Foreign Key(Cod_Depto) references Departamentos(Cod_Depto),
    constraint fk_sol_fun_1 Foreign Key(Cod_Func) references Funcionarios(Cod_Func)
);

Create table ItensSolicitacao(
    Num_Sol numeric(4) not null,
    Cod_Produto numeric(4) not null,
    Qtde numeric(4) not null,
    Valor numeric(12,2) not null,
    constraint pk_itens_sol primary key(Num_Sol, cod_produto),
    constraint fk_itens_sol_1 foreign Key(Num_Sol) references Solicitacao(Num_Sol),
    constraint fk_itens_prod_1 Foreign Key(Cod_Produto) references Produtos(Cod_Produto)
);

show tables;

insert into Departamentos values
(1000,"Vendas"),
(2000,"Compras"),
(2001,"Recursos Humanos");
insert into Funcionarios values
(100,"Jose Pedro","M","Sumare","SP"),
(150,"Ana Pereira","F","Nova Odessa","SP"),
(200,"Maria da Silva","F","Londrina","PR"),
(300,"Joao Antonio","M","Campinas","SP");
insert into Produtos values
(125,"Parafuso"),
(135,"Arruela"),
(145,"Difusor"),
(155,"Paralama");
insert into Solicitacao values
(1000,"2018/12/01",1000,100),
(1001,"2018/03/13",2001,200),
(1005,"2018/02/10",2001,150),
(1010,"2019/02/22",2000,100),
(1020,"2019/03/23",1000,200),
(1040,"2019/03/24",2001,300);
insert into ItensSolicitacao values
(1000,125,2,4.36),
(1000,145,1,85),
(1001,135,3,2.12),
(1001,155,2,522),
(1010,145,2,170),
(1010,135,2,1.06),
(1020,125,1,2.18),
(1020,145,2,170),
(1040,155,3,783),
(1005,125,1,50),
(1005,145,3,54.5);

-- 2

select num_sol from itenssolicitacao where valor = (select max(valor) from itenssolicitacao);
select
f.nome_func,
i.num_sol, (i.qtde * i.valor) as total
from funcionarios f 
inner join solicitacao s 
on f.cod_func = s.cod_func
inner join itenssolicitacao i 
on s.num_sol = i.num_sol
where valor = (select max(valor) from itenssolicitacao);

-- 3
select d.nome_Depto
from departamentos d
inner join solicitacao s
on d.cod_depto = s.cod_depto
inner join itenssolicitacao i
on s.num_sol = i.num_sol
where cod_produto = 125 and 145;


-- 4
-- select nome_produto from produtos where (select data_sol from solicitacao where data_sol = 02);
select
p.nome_produto
from produtos p
inner join itenssolicitacao i
on p.cod_produto = i.cod_produto
inner join solicitacao s
on s.num_sol = i.num_sol
where data_sol = "2018-02-10";