delimiter //
create function moeda(v decimal(7,2)) returns text
Begin
return concat("R$", v);
end//
delimiter ;

select pedido_id, pizza_id, quantidade, moeda(valor) from itens_pedido;

1 {
delimiter //
create function desconto(v decimal(7,2)) returns text
Begin
declare x decimal(7,2);
set x = 10 / 100;
return concat("R$ ",v * x);
end//
delimiter ;

select pedido_id, pizza_id, quantidade, desconto(valor) from itens_pedido;
}

formula: m = c.(1+i) elevado a n
c=valor
taxa=1/100 1%
n=meses
i=taxa de juros

2{
delimiter //
create function juros(valor decimal(7,2), meses integer) returns decimal(7,2)
Begin
declare x decimal(7,2);
set x = 1 + 1/100
return concat("R$ ",v * x);
}

drop procedure if exists ver_preco;
delimiter //
create procedure ver_preco(id integer)
begin
    declare quantos int;
    select concat("O preco desta pizza é ", moeda(valor))
    from pizzas where pizza_id = id;
    set quantos = (select count(pizza_id) from pizzas where pizza_id = id); 
    if quantos = 0 then
       select "Pizza não encontrada";
    end if;
end//
delimiter ;
call ver_preco(12);

--crie um procedure que receba os dados a seguir: cliente_id, pizza_id e quantidade. gere um pedido e coloque esta pizza como item
drop procedure if exists gerar_pedido;

delimiter //
create procedure gerar_pedido(id integer)
begin
    declare quantos int;
    select concat("O pedido é ", cliente_id)
    from pedidos where pedido_id = id;
    set quantos = (select count(pedido_id) from pedidos where pedido_id = id);
    if quantos = 0 then
       select "Pedido não encontrado";
    end if;
    insert into pedidos values (default, (select cliente_id from clientes), curdate(), curtime(), null);
    insert into itens_pedido values ((select pedido_id from pedidos), (select pizza_id from pizzas), default, (select valor from pizzas));
end//
delimiter ;