CREATE DATABASE IF NOT EXISTS nave_espacial_titanic
	DEFAULT CHARACTER SET utf8mb3
    COLLATE utf8mb3_spanish2_ci;
USE nave_espacial_titanic;
CREATE TABLE pasajero (
	id			INTEGER     AUTO_INCREMENT,
    nombre		VARCHAR(90) NOT NULL, 
    edad		INTEGER     NOT NULL,
    vip			BOOLEAN     NOT NULL,
    desaparecido	BOOLEAN	NOT NULL,
    n_p_destino	VARCHAR(20) NOT NULL,
    n_p_origen	VARCHAR(20) NOT NULL,
    num_cabina	INTEGER     NOT NULL,
    PRIMARY KEY (id),
    KEY (n_planeta),
    KEY (n_p_origen),
    CONSTRAINT planetas
        FOREIGN KEY(n_planeta, n_p_origen)
        REFERENCES planeta(nombre)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
CREATE TABLE planeta (
    nombre          VARCHAR(20) NOT NULL, 
    masa            INTEGER     NOT NULL,
    radio           INTEGER     NOT NULL,
    nombre_sist  	VARCHAR(20) NOT NULL,
    elemento_quimico		VARCHAR(20) 	NOT NULL,
    PRIMARY KEY (nombre),
    KEY (nombre_sist),
    CONSTRAINT sistemas
		FOREIGN KEY(nombre_sist)
        REFERENCES sistema(nombre)
		ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT compuestos
		FOREIGN KEY (compuesto)
        REFERENCES 	compuesto(nombre)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
CREATE TABLE satelite (
    nombre          VARCHAR(20) NOT NULL, 
    n_sistema  		VARCHAR(20) NOT NULL,
    n_planeta 		VARCHAR(20) NOT NULL,
    PRIMARY KEY (nombre),
    KEY (n_sistema),
    KEY (n_planeta),
	CONSTRAINT planeta
        FOREIGN KEY(n_planeta)
        REFERENCES planeta(nombre)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
    CONSTRAINT sistemas
        FOREIGN KEY(n_sistema)
        REFERENCES sistema(nombre)
        ON DELETE NO ACTION
        ON UPDATE CASCADE        
);
CREATE TABLE sistema (
    nombre          VARCHAR(20) UNIQUE NOT NULL,
	PRIMARY KEY (nombre)
);
CREATE TABLE elemento_quimico (
	nombre			VARCHAR(20) NOT NULL,
    simbolo			VARCHAR(3) NOT NULL,
    num_atomico		INTEGER NOT NULL,
	PRIMARY KEY (nombre)
);
CREATE TABLE cabina (
	numero			INTEGER NOT NULL,
    lado			VARCHAR(1) NOT NULL,
    letra_cubierta	VARCHAR(1) NOT NULL,
    numero_robot	INTEGER NOT NULL,
    PRIMARY KEY (numero, lado, letra_cubierta),
    KEY (letra_cubierta),
    CONSTRAINT cubierta
		FOREIGN KEY(letra_cubierta)
        REFERENCES cubierta(letra)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT robot
		FOREIGN KEY(numero_robot)
        REFERENCES robot(numero)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
CREATE TABLE cubierta(
	letra		VARCHAR(1) NOT NULL,
    clase		INTEGER NOT NULL,
    lado		VARCHAR(1) NOT NULL,
    PRIMARY KEY (letra)
);
CREATE TABLE robot(
	numero 		INTEGER AUTO_INCREMENT,
    diseño		VARCHAR(30),
    PRIMARY KEY (numero)
);
CREATE TABLE mecanico(
	id			INTEGER AUTO_INCREMENT,
    nombre		VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE reparacion(
	num_robot	INTEGER NOT NULL,
    id_m		INTEGER NOT NULL,
    fecha		DATETIME NOT NULL,
    KEY(num_robot, id_m, fecha),
    CONSTRAINT robot
		FOREIGN KEY(numero_robot)
        REFERENCES robot(numero)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT mecanico
		FOREIGN KEY(id_m)
        REFERENCES mecanico(id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
CREATE TABLE zona_entretenimiento(
	nombre		VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombre)
);
CREATE TABLE gasto(
	pasajero	INTEGER NOT NULL,
    n_entretenimiento	VARCHAR(30) NOT NULL,
    cantidad	INTEGER NOT NULL,
    KEY(id, n_entretenimiento),
    CONSTRAINT zona_entretenimiento
		FOREIGN KEY(n_entretenimiento)
        REFERENCES zona_entretenimiento(nombre)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT pasajero
		FOREIGN KEY(pasajero)
        REFERENCES pasajero(id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
CREATE TABLE personal_humano(
	id		INTEGER AUTO_INCREMENT,
    nombre	VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE gestion(
	id_persona	INTEGER NOT NULL,
    entretenimiento		VARCHAR(30) NOT NULL,
    CONSTRAINT zona_entretenimiento
		FOREIGN KEY(entretenimiento)
        REFERENCES zona_entretenimiento(nombre)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
	CONSTRAINT personal_humano
		FOREIGN KEY(id_persona)
        REFERENCES personal_humano(id)
        ON DELETE NO ACTION
        ON UPDATE CASCADE
);
