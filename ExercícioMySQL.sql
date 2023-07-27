create database hotel;
use hotel;

create table Cliente(
		id int auto_increment primary key,
        nome varchar(50),
        telef int,
        localidade varchar(50));

create table Reserva(
		id int auto_increment primary key,
        cliente int,
        foreign key(cliente) references Cliente(id),
        data_inicio datetime,
        data_fim datetime);
        
create table LinhaReserva(
		quarto int,
        foreign key(quarto) references Quarto(id),
        reserva int,
        foreign key(reserva) references Reserva(id),
        primary key(quarto,reserva));
        
create table Quarto(
		id int auto_increment primary key,
        preco decimal(18,2),
        piso int,
        foreign key(piso) references Piso(piso),
        tipo varchar(50),
        foreign key(tipo) references Tipo2(tipo));
        
create table Piso(
		piso int primary key
        );

create table Tipo2(
		tipo varchar(50) primary key
        );

insert into Cliente(nome, telef, localidade) values
		('Maria','912345678','Vale de Cambra'),
        ('Anibal','918765432','Porto'),
        ('Manuel','931245678','Aveiro'),
        ('Francisco','932165487','S. João da Madeira');

insert into Piso(piso) values
		(1), (2), (3), (4), (5);
        
insert into Tipo2(tipo) values
			('Quarto Individual'),('Quarto Casal'),('Suíte Presidencial'),('Master'),('Duplex');
            
insert into Quarto(preco,piso,tipo) values 
			('50.00','4','Quarto Casal'), 
            ('100.00','2','Master'),
            ('120.00','5','Suíte Presidencial');
            
insert into Quarto(preco, piso, tipo) values 
			('45.00','3','Quarto Individual');
            
insert into Reserva(cliente, data_inicio, data_fim) values
			('3','2023-03-02 22:00:00','2023-03-03 13:30:00'),
            ('7','2023-04-01 14:00:00','2023-04-03 15:00:00'),
            ('1','2023-04-02 14:00:00','2023-04-03 12:00:00'),
            ('2','2023-03-05 12:30:00','2023-03-07 13:00:00');

insert into Reserva(cliente, data_inicio, data_fim) values
			('7','2023-02-14 16:00:00','2023-02-15 12:00:00');

insert into LinhaReserva(quarto, reserva) values 
			('1','2'),
            ('2','4'),
            ('3','1');
            
select * from Cliente;
select * from Piso;
select * from Quarto;
select * from Reserva;
select * from Tipo2;
select * from LinhaReserva;

 #1. quais os clientes do Porto?
select nome from Cliente where localidade = 'Porto';

#2. quais os quartos tipo "Master"?
select id, tipo from Quarto where tipo = 'Master'; 

#3. quantos quartos tem o 5º Piso?
select id, tipo from Quarto where piso = 5; 

#4. quais os quartos que nunca foram reservados? 
select id, tipo from Quarto where
				id NOT IN (select quarto from LinhaReserva);

#5. qual o cliente que tem mais reservas?
select count(r.id), c.nome from Reserva r, Cliente c where 
				c.id = r.cliente
                group by c.nome order by count(r.id) desc
                limit 1;

#6. qual o quarto mais caro?
select preco, tipo from Quarto order by preco desc; 
            
        
