CREATE DATABASE IF NOT EXISTS nave_espacial_titanic
	DEFAULT CHARACTER SET utf8mb3
    COLLATE utf8mb3_spanish2_ci;
USE nave_espacial_titanic;
CREATE TABLE pasajero (
	id			INTEGER     AUTO_INCREMENT,
    nombre		VARCHAR(90) NOT NULL, -- Incluye nombres y apellidos
    edad		INTEGER     NOT NULL,
    estatus		BOOLEAN     DEFAULT false, -- True si es VIP, false si no
    n_planeta	VARCHAR(20) NOT NULL,
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
    compuesto		VARCHAR(20) 	NOT NULL,
    PRIMARY KEY (nombre),
    KEY (nombre_sist),
    KEY(compuesto),
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
    nombre          VARCHAR(20) NOT NULL,
	PRIMARY KEY (nombre)
);
CREATE TABLE elemento_quimico (
	nombre			VARCHAR(20) NOT NULL,
    simbolo			VARCHAR(3) NOT NULL,
    num_atomico		INTEGER NOT NULL,
	PRIMARY KEY (nombre)
);
CREATE TABLE cabina ();
CREATE TABLE cubierta();

