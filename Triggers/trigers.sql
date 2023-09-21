create database funcoe_procedimentos;

use funcoes_procedimentos;

drop table produtos;

#gatilhos - Sempre esta atrelado a uma tabela
#ocorre quando uma operação de insert update ou delete é acionada;

create table produtos (
	id int primary key auto_increment,
    nome varchar(50),
    preco decimal(8,2),
    precoComDesconto decimal (8,2),
    quantidadeNoEstoque int not null default 0
);

create trigger calcularDesc before insert on produtos for each row set new.precoComDesconto = (new.preco*0.90);

#o new vem pois está sendo inserido um novo registro
#set é porque está sendo inserido um valor no mesmo registro que estou criando

insert produtos (nome,preco, quantidadeNoEstoque) values ("Livro",100.0,10);


select * from produtos;

create table venda (
	id int auto_increment primary key, 
    quantiade int,
    idproduto int,
    foreign key (idProduto) references produtos(id)
);

create trigger removerEstoque before insert on vendas for each row update produtos set produtos.quantidadeNoEstoque = produtos.quantidadeNoEstoque - new.quantidade 
where produto.id = new.idProduto;

insert vendas(quantidade, idProduto) values (5,2);

create trigger adicionarEstoque
before delete on venda
for each row 
update produtos
set produtos.quantidadeNoEstoque = produtos.quantidadeNoEstoque + old.quantidade where produtos.id = old.idProduto;

select * from produtos;
select * from venda;

create table usuarios (
	id int primary key auto_increment,
    nome varchar (50),
    idade int 
    
);

create table backup_usuarios(
id int primary key auto_increment,
    nome varchar (50),
    idade int, 
    dataExclusao timestamp
);

create trigger salvarUsuarioExcluido
before delete on usuarios
for each row 
insert backup_usuarios values (default, old.nome,old.idade,now());

insert usuarios values (default, "Tiago",19);

