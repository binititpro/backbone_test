--liquibase formatted sql

--changeset Binit:1
create table test1 (
    id int primary key,
    name varchar(255)
);
--rollback drop table test1;

--changeset Vikas:2
insert into test1 (id, name) values (1, 'Binit');
insert into test1 (id, name) values (2, 'Vikas');

--changeset Binit:3 dbms:oracle
create sequence seq_test;