-- DESAFIO UM!

-- Mostra todos os clientes
select * from clientes;

-- Busca por nome os clientes "like"
select cliente_id from clientes where nome like "Cesar Augusto Pascali Rago";

-- Buscando todos os telefones 
select * from telefones

-- Buscando todos os telefones do cliente "Cesar Augusto..."
select * from telefones where cliente_id = (select cliente_id from clientes where nome = "Cesar Augusto Pascali Rago");

-- Quantos os telefones do cliente "Cesar Augusto..."
select count(telefone) from telefones
where cliente_id = (select cliente_id from clientes where nome = "Cesar Augusto Pascali Rago");

-- Deletar os quatro telefones e acrescentar um novo
delete from telefones where cliente_id = 12;
insert into Telefones(cliente_id, Telefone)values(12, "19991865503")

-- Criar uma view que mostre os clientes e telefones juntos, coloque o nome de "vw_clientes"
-- Join tem a mesma função da virgula (preferivel nao usar), precisa de um parametro (on)
create view vw_clientes as
select c.cliente_id, c.nome, t.telefone from clientes c
inner join telefones t on c.cliente_id = t.cliente_id

-- (Leve) Acrescentar cliente
insert into Clientes(nome, logradouro, numero, complemento, bairro, referencia) values("Joaquim Inácio Silva","Rua Itapira",504,"Chacara","Roseira de Cima","Pedra grande branca no portão");
insert into Telefones(cliente_id, Telefone) values(LAST_INSERT_ID(),"19989995511");
select * from vw_clientes where nome like "Joaquim %";
-- Que pediu
select * from vw_clientes where nome like "Joaquim %";
select * from pedidos order by pedido_id desc limit 1;
-- Inserir pedido (duas pizzas Baiana e uma de Atum)
insert into Itens_Pedido(pedido_id, pizza_id, quantidade, valor) values("27","6","2","32.13"), ("27","5","1","32.29");

-- (Pesada) Acrescentar cliente
insert into Clientes(nome, logradouro, numero, complemento, bairro, referencia) values("Joaquim Inácio Silva","Rua Itapira",504,"Chacara","Roseira de Cima","Pedra grande branca no portão");
-- "LAST_INSERT_ID()" é uma função do sql
insert into Telefones(cliente_id, Telefone) values(LAST_INSERT_ID(),"19989995511");
select * from vw_clientes where nome like "Joaquim %";

-- Que pediu
insert into Pedidos(cliente_id, data, hora) values(LAST_INSERT_ID(),curdate(),curtime());
select * from pedidos order by pedido_id desc limit 1;

-- Inserir pedido (duas pizzas Baiana e uma de Atum)
insert into Itens_Pedido(pedido_id, pizza_id, quantidade, valor)
values
(LAST_INSERT_ID(),(select pizza_id from pizzas where nome = "Baiana"),"2",(select valor from pizzas where nome = "Baiana"),
(LAST_INSERT_ID(),(select pizza_id from pizzas where nome = "Atum"),"1",(select valor from pizzas where nome = "Atum"));



-- DESAFIO DOIS!

-- Ultimo pedido do cliente Cesar Augusto e qual o valor do pedido
select pedido_id from pedidos where cliente_id = 12;
select * from pedidos where cliente_id = (select cliente_id from clientes where nome = "Cesar Augusto Pascali Rago") order by pedido_id desc limit 1;
-- Ou
select * from pedidos where cliente_id = 12 order by pedido_id desc limit 1;
-- Ou
select * from pedidos where cliente_id = (select cliente_id from clientes where nome = "Cesar Augusto Pascali Rago") order by data desc limit 1;
select quantidade from Itens_Pedido where pedido_id = 22;
-- Quantidade de Pizzas e quantidade de sabores diferentes
select sum(quantidade) from Itens_Pedido where pedido_id = 22;
select count(pizza_id) from Itens_Pedido where pedido_id = 22;
-- Criar view mostrando o nome em ordem de pedido_id e coloque o nome de "vw_pedidos"
create view vw_itens as
select i.pedido_id, i.pizza_id, p.nome, i.quantidade, i.valor from itens_pedido i
inner join pizzas p on p.pizza_id = i.pizza_id order by i.pedido_id;

-- Criar uma view da tabela itens_pedido com o subtotal
create view vw_itens_sub as select *, (quantidade * valor) as subtotal from itens_pedido;
select * from vw_itens_sub;

