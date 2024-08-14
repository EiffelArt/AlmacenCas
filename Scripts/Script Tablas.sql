create database storage
Use storage

Create Table rol (
	idRol int primary key identity(1,1),
	nombre varchar(20),
)
Create Table usuarios (
	idUsuario int primary key identity(1,1),
	nombre varchar(100),
	correo varchar(50),
	contrasena varchar(25),
	idRol int not null,
	estatus int,
	CONSTRAINT fk_rolUser FOREIGN KEY (idRol) REFERENCES rol(idRol)
)
Create Table categoria(
	idCategoria int primary key identity(1,1),
	nombre varchar(60)
)
Create Table motivo (
	idMotivo int primary key identity(1,1),
	Descripcion varchar(120),
)
Create Table unidad (
	idUnidad int primary key identity(1,1),
	nombre varchar(255),
)
Create Table tipo_mov (
	idTipomov int primary key identity(1,1),
	Descripcion varchar(255),
)

Create Table producto (
	idProducto int primary key identity(1,1),
	nombre varchar(120),
	descripcion varchar(255),
	codigo varchar(60),
	foto varchar(255),
	cant_minima int,
	precio numeric(12, 3),
	existencia bigint,
	estatus char,
	fec_creacion datetime,
	user_creo int not null,
	unidad_med int not null,
	idCat int not null,
	CONSTRAINT fk_produser FOREIGN KEY (user_creo) REFERENCES usuarios(idUsuario),
	CONSTRAINT fk_produom FOREIGN KEY (unidad_med) REFERENCES unidad(idUnidad),
	CONSTRAINT fk_prodcat FOREIGN KEY (idCat) REFERENCES categoria(idCategoria)
)
create table movimiento(
	idMov bigint primary key identity(1,1),
	fec_mov datetime,
	cantidad int not null,
	user_mod int not null,
	idUsuPrestamo int not null, 
	idTipoMov int not null,
	idProducto int not null,
	idMotivo int not null,
	CONSTRAINT fk_movuserm FOREIGN KEY (user_mod) REFERENCES Usuarios(idUsuario),
	CONSTRAINT fk_movidupre FOREIGN KEY (idUsuPrestamo) REFERENCES Usuarios(idUsuario),
	CONSTRAINT fk_movtipmov FOREIGN KEY (idTipoMov) REFERENCES tipo_mov(idTipomov),
	CONSTRAINT fk_movprod FOREIGN KEY (idProducto) REFERENCES producto(idProducto),
	CONSTRAINT fk_movmot FOREIGN KEY (idMotivo) REFERENCES motivo(idMotivo)
)

