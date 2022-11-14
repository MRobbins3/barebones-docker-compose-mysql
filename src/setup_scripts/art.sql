# Creates the every_bunny database. Create the bunny table.
# TODO create the adopter, vet, and medical_record tables, if needed for class data

CREATE DATABASE IF NOT EXISTS every_bunny;

USE every_bunny;

DROP TABLE IF EXISTS bunny;

CREATE TABLE bunny (
    microchip_id    int auto_increment,
    name            varchar(30),
    species         varchar(50),
    color           varchar(10),
    weight          int(3),
    sex             char(1),
    PRIMARY KEY (microchip_id)
) AUTO_INCREMENT=9;

INSERT INTO bunny VALUES
    (1, 'Hoppy', 'Angora', 'White', 8, 'F'),
    (2, 'Deku', 'Usagi', 'Green', 9, 'M'),
    (3, 'All Might', 'Usagi', 'Yellow', 8, 'M'),
    (4, 'Bugs', 'Eastern Cottontail', 'Piebald', 3, 'M'),
    (5, 'Tulip', 'Holland Lop', 'Grey', 4, 'F'),
    (6, 'Hugh Jackman', 'Eastern Cottontail', 'Grey', 2, 'M'),
    (7, 'Mirko', 'Usagi', 'White', 11, 'F'),
    (8, 'Loki', 'Flemish Giant', 'Rufus', 15, 'I');

