use picturemanager;
drop table picturemanager.picture;
drop table picturemanager.`member`;
CREATE TABLE picturemanager.`member` ( 
	uno integer NOT NULL AUTO_INCREMENT,
	uid varchar(100) NOT NULL,
	upw varchar(100) NOT NULL,
	uname varchar(100) NOT NULL,
	uemail varchar(100) NULL,
	utel varchar(100) NULL,	
	uregdate timestamp DEFAULT now(),
	CONSTRAINT member_pk PRIMARY KEY (uno)
);

CREATE TABLE picturemanager.picture (
	fullname varchar(100) NOT NULL,
	uno INTEGER NOT NULL,
	regdate TIMESTAMP DEFAULT now() NULL,
	CONSTRAINT picture_member_fk FOREIGN KEY (uno) REFERENCES picturemanager.`member`(uno)
	);

select * from picturemanager.`member`;
select * from picturemanager.picture;

update picturemanager.`member` set uname='이유진', uemail='이메일',utel='전화' where uno=2; 