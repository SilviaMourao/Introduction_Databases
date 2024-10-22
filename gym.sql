DROP TABLE IF EXISTS Joins;
DROP TABLE IF EXISTS Scheduled;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS Offers_2;
DROP TABLE IF EXISTS Is_Suitable;
DROP TABLE IF EXISTS Includes_2;
DROP TABLE IF EXISTS Register;
DROP TABLE IF EXISTS Belongs;
DROP TABLE IF EXISTS Is_Authorised;
DROP TABLE IF EXISTS Is_Qualified;
DROP TABLE IF EXISTS Type_Of_Sport;
DROP TABLE IF EXISTS Type_Of_Equipment;
DROP TABLE IF EXISTS Space;
DROP TABLE IF EXISTS Gym;
DROP TABLE IF EXISTS Health_Benefits;
DROP TABLE IF EXISTS Gym_User;
DROP TABLE IF EXISTS Gym_Trainer;
DROP TABLE IF EXISTS Gym_Manager;
DROP TABLE IF EXISTS User_Info;

CREATE TABLE User_Info (
	U_NI_Nr   		INTEGER (9),  
	U_Passport_Nr	VARCHAR (7)  NOT NULL, 
	U_Address	     	VARCHAR (100),
	U_Phone_Nr    	INTEGER (9),
	U_Birth_Date  	DATE,
	U_Email       		VARCHAR (60),
	U_Name	      	VARCHAR (60),
	U_Gender	      	VARCHAR (1),
	CONSTRAINT pk_user_info PRIMARY KEY (U_NI_Nr),
	CONSTRAINT ck_passport UNIQUE (U_Passport_Nr)
);

INSERT INTO User_Info (U_NI_Nr, U_Passport_Nr, U_Address, U_Phone_Nr, U_Birth_Date, U_Email, U_Name, U_Gender) VALUES (250330250, 'P983258', 'Rua Azul', 902123259, '1970-10-12','sgym@gym.com', 'Silvia M', 'F');
INSERT INTO User_Info (U_NI_Nr, U_Passport_Nr, U_Address, U_Phone_Nr, U_Birth_Date, U_Email, U_Name, U_Gender) VALUES (223250231, 'P983128', 'Rua Verde', 902323256, '1981-03-24', 'mgym@gym.com', 'Mario R', 'M');
INSERT INTO User_Info (U_NI_Nr, U_Passport_Nr, U_Address, U_Phone_Nr, U_Birth_Date, U_Email, U_Name, U_Gender) VALUES (252350540, 'P922258', 'Rua Lilas', 902335388, '1980-09-09', 'agym@gym.com', 'Ana F', 'F');
INSERT INTO User_Info (U_NI_Nr, U_Passport_Nr, U_Address, U_Phone_Nr, U_Birth_Date, U_Email, U_Name, U_Gender) VALUES (255553250, 'P222458', 'Rua Branca', 902123233, '1982-01-13', 'alexgym@gym.com', 'Alex C', 'O');

CREATE TABLE Gym_Manager (
	M_NI_Nr	      INTEGER (9),
	CONSTRAINT pk_mgr PRIMARY KEY (M_NI_Nr),
	CONSTRAINT fk_mgr FOREIGN KEY (M_NI_Nr) REFERENCES User_Info (U_NI_Nr)
);

INSERT INTO Gym_Manager (M_NI_Nr) VALUES (250330250);

CREATE TABLE Gym_Trainer (
	T_NI_Nr	      INTEGER (9),
	CONSTRAINT pk_tra PRIMARY KEY (T_NI_Nr),
	CONSTRAINT fk_tra FOREIGN KEY (T_NI_Nr) REFERENCES User_Info (U_NI_Nr)
);
INSERT INTO Gym_Trainer (T_NI_Nr) VALUES (223250231);


CREATE TABLE Gym_User (
	Us_NI_Nr       INTEGER (9),
	CONSTRAINT pk_use PRIMARY KEY (Us_NI_Nr),
	CONSTRAINT fk_use FOREIGN KEY (Us_NI_Nr) REFERENCES User_Info (U_NI_Nr)
);

INSERT INTO Gym_User (Us_NI_Nr) VALUES 
(252350540),
(255553250);

CREATE TABLE Health_Benefits (
	HB_ID 		 INTEGER (7),
	HB_Description VARCHAR (60),
	CONSTRAINT pk_Health_Benefits PRIMARY KEY (HB_ID)
);
INSERT INTO Health_Benefits (HB_ID, HB_Description) VALUES
(0000001, 'Cardio'),
(0000002, 'Muscular Strength'),
(0000003, 'Calories loss');
 
CREATE TABLE Gym (
G_VAT_Nr 		INTEGER (11), 
G_Name 		VARCHAR(60)  NOT NULL, 
G_City 		VARCHAR(60), 
G_Address 		VARCHAR(100), 
G_Phone		INTEGER(9), 
G_Email 		VARCHAR(60), 
G_Opening_Date 	DATE,
G_Opening_Time 	TIME,  
G_Closing_Time 	TIME, 
M_NI_Nr		INTEGER(9),
CONSTRAINT pk_gym PRIMARY KEY (G_VAT_Nr),
CONSTRAINT fk_gym FOREIGN KEY (M_NI_Nr) REFERENCES Gym_Manager (M_NI_Nr),
CONSTRAINT g_time CHECK (G_Opening_Time < G_Closing_Time),
CONSTRAINT ck_name UNIQUE (G_Name)
);

INSERT INTO Gym (G_VAT_Nr, G_Name, G_City, G_Address, G_Phone, G_Email, G_Opening_Date, G_Opening_Time, G_Closing_Time, M_NI_Nr) VALUES
(01111111111, 'FITGym Lisboa', 'Lisboa', 'Rua Dr. Sebastião', 210234567, 'fitgymlisboa@gym.com', '12/03/2017', '07:00:00', '22:00:00', 250330250),
(01111111112, 'FITGym Porto', 'Porto', 'Rua do Arco Amarelo', 232266567, 'fitgymporto@gym.com', '23/10/2019', '08:30:00', '24:00:00', 250330250);

CREATE TABLE Space (
	SP_Name 	VARCHAR (60),
 	SP_Area_M2	 NUMERIC (6,2),
  	G_VAT_Nr 	INTEGER (11),
 	CONSTRAINT pk_Space PRIMARY KEY (SP_Name, G_VAT_Nr),
 	CONSTRAINT fk_Space FOREIGN KEY (G_VAT_Nr) REFERENCES Gym (G_VAT_Nr) ON DELETE CASCADE,
	CONSTRAINT ch_space CHECK (SP_Area_M2 > 0)
);

INSERT INTO Space (SP_Name, SP_Area_M2, G_VAT_Nr) VALUES
('Piscina_1', 80, 01111111111),
('Sala_1', 20, 01111111111),
('Sala_Musculacao_1', 50, 01111111111);

CREATE TABLE Type_Of_Equipment (
 	E_ID 		INTEGER (4),
 	E_Name 	VARCHAR (60),
 	CONSTRAINT pk_Type_Of_Equipment PRIMARY KEY (E_ID)
);

INSERT INTO Type_Of_Equipment (E_ID, E_Name) VALUES
(0009,'Tapete'),
(0011,'Haltere 5kgs');

CREATE TABLE Type_Of_Sport (
 	S_ID 				INTEGER (5),
 	S_Exercise_Duration_Min 	INTEGER (4),
 	S_Description 			VARCHAR (60),
 	S_Price_Class 			NUMERIC (4,2), 
 	S_Rec_Age_Group 		VARCHAR (30),
 	S_Name 			VARCHAR (60),
 	S_Lvl_Phy_Demand		INTEGER (3),
 	CONSTRAINT pk_Type_Of_Sport PRIMARY KEY (S_ID),
	CONSTRAINT ch_price CHECK (S_Price_Class >= 0)
);


INSERT INTO Type_Of_Sport (S_ID, S_Exercise_Duration_Min, S_Description, S_Price_Class, S_Rec_Age_Group, S_Name, S_Lvl_Phy_Demand) VALUES
(001, 50, 'Ginastica na Piscina, mobilidade aquatica', 8.00, '+35 anos', 'Hidro-ginastica', 40),
(002, 45, 'Pilates com bola, treino core', 5.00, 'Todas as Idades', 'Pilates com Bola', 50);


CREATE TABLE Is_Qualified (
	T_NI_Nr          INTEGER (9),
	S_ID  		INTEGER (5),
	CONSTRAINT pk_is_q PRIMARY KEY (T_NI_Nr,S_ID),
	CONSTRAINT fk_is_q_trainer FOREIGN KEY (T_NI_Nr) REFERENCES Gym_Trainer (T_NI_Nr),
	CONSTRAINT fk_is_q_sport FOREIGN KEY (S_ID) REFERENCES Type_Of_Sport (S_ID)
);

INSERT INTO Is_Qualified (T_NI_Nr, S_ID) VALUES
(223250231, 001),
(223250231, 002);


CREATE TABLE Is_Authorised (
	Us_NI_NR	   INTEGER (9),
	S_ID 	  	   INTEGER (5),
	CONSTRAINT pk_auth PRIMARY KEY (Us_NI_Nr, S_ID),
	CONSTRAINT fk_auth_gym FOREIGN KEY (Us_NI_Nr) REFERENCES Gym_User (Us_NI_Nr),
	CONSTRAINT fk_auth_sport FOREIGN KEY (S_ID) REFERENCES Type_Of_Sport (S_ID)
);

INSERT INTO Is_Authorised (Us_NI_Nr, S_ID) VALUES
(252350540, 001),
(252350540, 002),
(255553250, 002);

CREATE TABLE Belongs (
	T_NI_Nr	INTEGER (9),
	G_VAT_Nr	INTEGER (11),
	CONSTRAINT pk_Belongs PRIMARY KEY (T_NI_Nr, G_VAT_Nr),
	CONSTRAINT fk_Belongs_trainer FOREIGN KEY (T_NI_Nr) REFERENCES Gym_Trainer (T_NI_Nr),
CONSTRAINT fk_Belongs_gym FOREIGN KEY (G_VAT_Nr) REFERENCES Gym (G_VAT_Nr)
);

INSERT INTO Belongs (T_NI_Nr, G_VAT_Nr) VALUES
(223250231, 01111111111);

CREATE TABLE Register (
	Us_NI_NR	INTEGER (9),
	G_VAT_NR	INTEGER (11),
	CONSTRAINT pk_Register PRIMARY KEY (Us_NI_NR, G_VAT_Nr),
	CONSTRAINT fk_Register_user FOREIGN KEY (Us_NI_NR) REFERENCES Gym_User (Us_NI_NR),
CONSTRAINT fk_Register_gym FOREIGN KEY (G_VAT_Nr) REFERENCES Gym (G_VAT_Nr)
);

INSERT INTO Register (Us_NI_Nr, G_VAT_Nr) VALUES
(252350540,  01111111111),
(255553250,  01111111111);

CREATE TABLE Includes_2 (
	I_Nr 		INTEGER (11),
	SP_Name 	VARCHAR (60),
 	G_VAT_Nr 	INTEGER (11),
	E_ID 		INTEGER (4),
	CONSTRAINT pk_Includes_2 PRIMARY KEY (SP_Name, G_VAT_Nr, E_ID),
	CONSTRAINT fk_Includes_2 FOREIGN KEY (SP_Name, G_VAT_Nr) REFERENCES Space (SP_Name, G_VAT_Nr),
	CONSTRAINT fk2_Includes_2 FOREIGN KEY (E_ID) REFERENCES Type_Of_Equipment  (E_ID)
);

INSERT INTO Includes_2 (I_Nr, SP_Name, G_VAT_Nr, E_ID) VALUES
(20, 'Sala_Musculacao_1',  01111111111, 0011),
(40, 'Sala_1',  01111111111, 0009);

CREATE TABLE Is_Suitable (
 	SP_Name 	VARCHAR (60),
  	G_VAT_Nr 	INTEGER (11),
 	S_ID	 	INTEGER (5),
 	IS_Capacity 	INTEGER (4),
 	CONSTRAINT pk_is_suitable PRIMARY KEY (SP_Name, G_VAT_Nr, S_ID),
	CONSTRAINT fk_is_suitable FOREIGN KEY (SP_Name, G_VAT_Nr) REFERENCES Space (SP_Name, G_VAT_Nr) ON DELETE CASCADE, 
	CONSTRAINT fk2_is_suitable FOREIGN KEY (S_ID) REFERENCES Type_Of_Sport (S_ID) ON DELETE CASCADE
);

INSERT INTO Is_Suitable (SP_Name, G_VAT_Nr, S_ID, IS_Capacity) VALUES
('Piscina_1',  01111111111, 001, 40),
('Sala_1',  01111111111, 002, 30);

CREATE TABLE Offers_2 (
	S_ID	 	INTEGER (5),
	HB_ID 		INTEGER (7),
	CONSTRAINT pk_offers_2 PRIMARY KEY (S_ID, HB_ID),
	CONSTRAINT fk_offers_2 FOREIGN KEY (S_ID) REFERENCES Type_Of_Sport (S_ID),
	CONSTRAINT fk2_offers_2 FOREIGN KEY (HB_ID) REFERENCES Health_Benefits (HB_ID)
);

INSERT INTO Offers_2 (S_ID, HB_ID) VALUES
(001, 0000001),
(001, 0000003),
(002, 0000001),
(002, 0000002);

CREATE TABLE Class (
C_ID INTEGER (8), 
T_NI_Nr INTEGER (9),
CONSTRAINT pk_class PRIMARY KEY (C_ID),
CONSTRAINT fk_class_assigned FOREIGN KEY (T_NI_Nr) REFERENCES Gym_Trainer (T_NI_Nr)
);

INSERT INTO Class (C_ID, T_NI_Nr) VALUES
(1, 223250231),
(2, 223250231);
 
CREATE TABLE Scheduled (
	C_ID		INTEGER (8),
	C_Start_Time	TIMESTAMP,	
	C_End_Time	TIMESTAMP,
	C_Weekday	VARCHAR (15),
	SP_Name 	VARCHAR (60),
  	G_VAT_Nr 	INTEGER (11),
 	S_ID	 	INTEGER (5),
	CONSTRAINT pk_scheduled PRIMARY KEY (C_ID, SP_Name, G_VAT_Nr, S_ID),
	CONSTRAINT fk_scheduled1 FOREIGN KEY (C_ID) REFERENCES Class (C_ID),
	CONSTRAINT fk_scheduled2 FOREIGN KEY (SP_Name, G_VAT_NR, S_ID) REFERENCES Is_Suitable (SP_Name, G_VAT_NR, S_ID) ON DELETE CASCADE
);

INSERT INTO Scheduled (C_ID, C_Start_Time, C_End_Time, C_Weekday, SP_Name, G_VAT_Nr, S_ID) VALUES
(1, '2021-10-12 12:00:00', '2021-10-12 12:45:00', 'Terça-feira', 'Piscina_1', 01111111111, 001),
(2, '2021-10-12 16:15:00', '2021-10-12 17:00:00', 'Segunda-feira', 'Sala_1', 01111111111, 002);

CREATE TABLE Joins (
	Us_NI_Nr        INTEGER (9),
	C_ID  	 	INTEGER (8),
	J_Timestamp  	TIMESTAMP,
	J_Validate   	BOOLEAN,
	CONSTRAINT pk_joins PRIMARY KEY (Us_NI_Nr, C_ID),
	CONSTRAINT fk_joins_user FOREIGN KEY (Us_NI_Nr) REFERENCES Gym_User (Us_NI_Nr),
	CONSTRAINT fk_joins_class FOREIGN KEY (C_ID) REFERENCES Class(C_ID)
);

INSERT INTO Joins (Us_NI_Nr, C_ID, J_Timestamp, J_Validate) VALUES
(252350540, 1, '2021-10-12 11:45:00 ', TRUE),
(252350540, 2, '2021-10-12 16:00:00', TRUE),
(255553250, 2, '2021-10-12 16:20:00', FALSE);
