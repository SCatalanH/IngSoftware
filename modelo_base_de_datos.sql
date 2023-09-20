CREATE TABLE cliente (
    cliente_id NUMBER NOT NULL,
    rut        VARCHAR2(18) NOT NULL
);

CREATE UNIQUE INDEX cliente__idx ON
    cliente (
        rut
    ASC );

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cliente_id );

CREATE TABLE empleado (
    empleado_id NUMBER NOT NULL,
    rut         VARCHAR2(18) NOT NULL
);

CREATE UNIQUE INDEX empleado__idx ON
    empleado (
        rut
    ASC );

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( empleado_id );

CREATE TABLE factura (
    factura_id NUMBER NOT NULL,
    reserva_id NUMBER NOT NULL,
    monto      NUMBER NOT NULL,
    fecha      DATE NOT NULL
);

CREATE UNIQUE INDEX factura__idx ON
    factura (
        reserva_id
    ASC );

ALTER TABLE factura ADD CONSTRAINT factura_pk PRIMARY KEY ( factura_id );

CREATE TABLE habitacion (
    habitacion_id NUMBER NOT NULL,
    hotel_id      NUMBER NOT NULL,
    tipo          VARCHAR2(20) NOT NULL,
    capacidad     NUMBER NOT NULL,
    precio        NUMBER NOT NULL
);

ALTER TABLE habitacion ADD CONSTRAINT habitacion_pk PRIMARY KEY ( habitacion_id,
                                                                  hotel_id );

CREATE TABLE hotel (
    hotel_id  NUMBER NOT NULL,
    nombre    VARCHAR2(30) NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL
);

ALTER TABLE hotel ADD CONSTRAINT hotel_pk PRIMARY KEY ( hotel_id );

CREATE TABLE reserva (
    reserva_id        NUMBER NOT NULL,
    habitacion_id     NUMBER NOT NULL,
    hotel_id          NUMBER NOT NULL,
    cliente_id        NUMBER NOT NULL,
    fecha_entrada     DATE NOT NULL,
    fecha_salida      DATE NOT NULL,
    cantidad_personas NUMBER NOT NULL,
    factura_id        NUMBER NOT NULL
);

CREATE UNIQUE INDEX reserva__idx ON
    reserva (
        factura_id
    ASC );

ALTER TABLE reserva ADD CONSTRAINT reserva_pk PRIMARY KEY ( reserva_id );

CREATE TABLE usuario (
    rut            VARCHAR2(18) NOT NULL,
    nombre         VARCHAR2(30) NOT NULL,
    apellido       VARCHAR2(30) NOT NULL,
    email          VARCHAR2(30) NOT NULL,
    nro_telefonico VARCHAR2(30)
);

ALTER TABLE usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( rut );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_usuario_fk FOREIGN KEY ( rut )
        REFERENCES usuario ( rut );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_usuario_fk FOREIGN KEY ( rut )
        REFERENCES usuario ( rut );

ALTER TABLE factura
    ADD CONSTRAINT factura_reserva_fk FOREIGN KEY ( reserva_id )
        REFERENCES reserva ( reserva_id );

ALTER TABLE habitacion
    ADD CONSTRAINT habitacion_hotel_fk FOREIGN KEY ( hotel_id )
        REFERENCES hotel ( hotel_id );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_cliente_fk FOREIGN KEY ( cliente_id )
        REFERENCES cliente ( cliente_id );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_factura_fk FOREIGN KEY ( factura_id )
        REFERENCES factura ( factura_id );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_habitacion_fk FOREIGN KEY ( habitacion_id,
                                                       hotel_id )
        REFERENCES habitacion ( habitacion_id,
                                hotel_id );

