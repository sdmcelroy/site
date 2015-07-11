USE site;

DROP TABLE IF EXISTS usr;

CREATE TABLE usr (
usrId			BIGINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
usrName			varchar(25) NOT NULL,
usrPassword     varchar(25) NOT NULL,
usrDisplayName  varchar(50) NULL,
usrJoin 		DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
PRIMARY KEY (usrId)
);
