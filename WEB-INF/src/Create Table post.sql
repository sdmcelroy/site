USE site;

DROP TABLE IF EXISTS post;

CREATE TABLE post (
postId			BIGINT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
postIdParent	BIGINT UNSIGNED NOT NULL DEFAULT 0,
postUsrName		varchar(25) NOT NULL,
postSubject		varchar(100),
postSubjectURL	varchar(100),
postBody		MEDIUMTEXT,
postTime 		DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
PRIMARY KEY (postId)
);
