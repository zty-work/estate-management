CREATE TABLE IF NOT EXISTS facility (
  facilityID    INT,
    facilityName  VARCHAR(45),
  latestCheck   DATE,
  facilityState VARCHAR(45),
    community     VARCHAR(45),
  PRIMARY KEY (facilityID)
);

CREATE TABLE IF NOT EXISTS check_facility (
  checkFacilityID INT,
  checkResult     VARCHAR(45),
  facilityID      INT,
  checkTime       DATE,
  PRIMARY KEY (checkFacilityID),
  FOREIGN KEY (facilityID) REFERENCES facility (facilityID)
);

CREATE TABLE IF NOT EXISTS facility_complaint (
  facilityComplaintID     INT,
  facilityComplaintTime   DATE,
  facilityComplaintReason VARCHAR(45),
  facilityID              INT,
  PRIMARY KEY (facilityComplaintID),
  FOREIGN KEY (facilityID) REFERENCES facility (facilityID)
);

CREATE TABLE IF NOT EXISTS repair_record (
  repairRecordID       INT,
  repairProcess        VARCHAR(45),
  repairResult         VARCHAR(45),
  facilityComplaintID INT,
  checkFacilityID      INT,
  repairTime      DATE,
  PRIMARY KEY (repairRecordID),
  FOREIGN KEY (facilityComplaintID) REFERENCES facility_complaint (facilityComplaintID),
  FOREIGN KEY (checkFacilityID) REFERENCES check_facility (checkFacilityID)
);

CREATE TABLE IF NOT EXISTS common_complaint (
  commonComplaintID      INT,
  commonComplaintReason  VARCHAR(45),
  commonComplaintTime    DATE,
  commonComplaintProcess VARCHAR(45),
  commonComplaintResult  VARCHAR(45),
  PRIMARY KEY (commonComplaintID)
);

/*CREATE TABLE IF NOT EXISTS community (
  communityID   INT         NOT NULL,
  communityName VARCHAR(45) NOT NULL,
  PRIMARY KEY (communityID)
);*/

CREATE TABLE IF NOT EXISTS parking_revenue (
  parking_revenueID INT         NOT NULL,
  type              VARCHAR(45) NOT NULL,
  leaseLength       INT ,
  leaseTime         DATE ,
  buyTime           VARCHAR(45),
  houseID           INT,
  PRIMARY KEY (parking_revenueID)
  /*修改，增加了house ID*/
);

CREATE TABLE IF NOT EXISTS charges (
  chargesID         INT,
  chargesType       VARCHAR(45),
  chargesAmount     INT,
  chargesDate       DATE,
  shouldPay         VARCHAR(45),
  parking_revenueID INT,
  repairRecordID    INT,
  community         VARCHAR(45),
  houseID INT,
  PRIMARY KEY (chargesID),
  FOREIGN KEY (houseID) REFERENCES house(houseID),
  FOREIGN KEY (parking_revenueID) REFERENCES parking_revenue (parking_revenueID),
  FOREIGN KEY (repairRecordID) REFERENCES repair_record (repairRecordID)
);
/*CREATE TABLE IF NOT EXISTS properityFee(
  properityFeeID INT,
  feeAmount INT,
  payDate DATE,
  year INT,
  month INT,
  community VARCHAR(45),
  houseID INT,
  PRIMARY KEY (properityFeeID),
  FOREIGN KEY (houseID) REFERENCES house(houseID)
);*/
CREATE TABLE IF NOT EXISTS house (
  houseID        INT         NOT NULL,
  buildingNumber VARCHAR(45) NOT NULL,
  unitNumber     VARCHAR(45) NOT NULL,
  roomNumber     VARCHAR(45) NOT NULL,
  ifFree         VARCHAR(45) NOT NULL,
  community      VARCHAR(45) NOT NULL ,
  PRIMARY KEY (houseID)
);


CREATE TABLE IF NOT EXISTS inhabitant (
  /*这里将身份证号的类型改掉了*/
  inhabitantID   NUMERIC         NOT NULL,
  phoneNumber    VARCHAR(45) ,
  inhabitantName VARCHAR(45) NOT NULL,
  ifOwner        VARCHAR(45) NOT NULL,
  houseID        INT,
  PRIMARY KEY (inhabitantID)
);


CREATE TABLE parkingspace (
  parkingSpaceID INT         NOT NULL,
  type           VARCHAR(45) NOT NULL,
  community     varchar(45)    NOT NULL ,
  houseID  INT,
  /*communityID    INT         NOT NULL,*/
  PRIMARY KEY (parkingSpaceID)
  /*FOREIGN KEY (communityID) REFERENCES community (communityID)*/
);

CREATE TABLE temp_parkingspace (
  temp_parkingspaceID INT         NOT NULL,
  /*修改了开始时间和结束时间的类型*/
  startTime           DATETIME    ,
  endTime             DATETIME   ,
  state               VARCHAR(45) NOT NULL,
  tempParkingname     VARCHAR(45),
  /*修改了car Number类型*/
  carNumber           VARCHAR(45),
  PRIMARY KEY (temp_parkingspaceID)
);


CREATE TABLE IF NOT EXISTS complaintIncident (
  houseID           INT,
  commonComplaintID INT,
  PRIMARY KEY (houseID, commonComplaintID),
  FOREIGN KEY (houseID) REFERENCES house (houseID),
  FOREIGN KEY (commonComplaintID) REFERENCES common_complaint (commonComplaintID)
);
CREATE TABLE IF NOT EXISTS facilityComplaintIncident (
  facilityComplaintID INT,
  houseID             INT,
  PRIMARY KEY (facilityComplaintID, houseID),
  FOREIGN KEY (facilityComplaintID) REFERENCES facility_complaint (facilityComplaintID),
  FOREIGN KEY (houseID) REFERENCES house (houseID)
);
ALTER TABLE facility CONVERT TO CHARACTER SET utf8;
ALTER TABLE charges CONVERT TO CHARACTER SET utf8;
ALTER TABLE check_facility CONVERT TO CHARACTER SET utf8;
ALTER TABLE facility_complaint CONVERT TO CHARACTER SET utf8;
ALTER TABLE house CONVERT TO CHARACTER SET utf8;
ALTER TABLE inhabitant CONVERT TO CHARACTER SET utf8;
ALTER TABLE parking_revenue CONVERT TO CHARACTER SET utf8;
ALTER TABLE complaintIncident CONVERT TO CHARACTER SET utf8;
ALTER TABLE facilityComplaintIncident CONVERT TO CHARACTER SET utf8;
ALTER TABLE parkingspace CONVERT TO CHARACTER SET utf8;
ALTER TABLE repair_record CONVERT TO CHARACTER SET utf8;
ALTER TABLE temp_parkingspace CONVERT TO CHARACTER SET utf8;
ALTER TABLE facility CONVERT TO CHARACTER SET utf8;

/*CREATE TABLE IF NOT EXISTS ownership (
  inhabitantID INT,
  houseID      INT,
  PRIMARY KEY (inhabitantID, houseID),
  FOREIGN KEY (inhabitantID) REFERENCES inhabitant (inhabitantID),
  FOREIGN KEY (houseID) REFERENCES house (houseID)
)*/



INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1111,1,1,11,'False',null,'communityC');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1112,1,1,12,'False',null,'communityA');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1113,1,1,13,'False',null,'communityA');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1114,1,1,14,'False',null,'communityA');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1115,2,1,11,'False',null,'communityC');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1116,2,1,12,'False',null,'communityC');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1117,2,1,13,'True',null,'communityB');

INSERT INTO house (houseID,buildingNumber,unitNumber,roomNumber,ifFree,chargesID,community)
VALUES(1118,3,1,14,'True',null,'communityB');

INSERT INTO parkingspace(parkingSpaceID,type,community,houseID)
VALUES(1,'temp','communityA',null);

INSERT INTO parkingspace(parkingSpaceID,type,community,houseID)
VALUES(6,'temp','communityC',null);

INSERT INTO parkingspace(parkingSpaceID,type,community,houseID)
VALUES(9,'temp','communityC',null);

INSERT INTO parkingspace(parkingSpaceID,type,community,houseID)
VALUES(8,'temp','communityB',null);

INSERT INTO parkingspace(parkingSpaceID,type,community,houseID)
VALUES(7,'temp','communityB',null);

INSERT INTO temp_parkingspace(temp_parkingspaceID, startTime, endTime, state, tempParkingname, carNumber)
VALUES (1,null,null,'free',null,null);

INSERT INTO temp_parkingspace(temp_parkingspaceID, startTime, endTime, state, tempParkingname, carNumber)
VALUES (6,null,null,'free',null,null);

INSERT INTO temp_parkingspace(temp_parkingspaceID, startTime, endTime, state, tempParkingname, carNumber)
VALUES (9,null,null,'free',null,null);

INSERT INTO temp_parkingspace(temp_parkingspaceID, startTime, endTime, state, tempParkingname, carNumber)
VALUES (8,null,null,'free',null,null);

INSERT INTO temp_parkingspace(temp_parkingspaceID, startTime, endTime, state, tempParkingname, carNumber)
VALUES (7,null,null,'free',null,null);

INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (1, 'fc1', '2018-11-2', 'fine', 'communityA');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (2, 'fc2', '2018-11-2', 'fine', 'communityA');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (3, 'fc3', '2018-11-2', 'fine', 'communityA');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (4, 'fff1', '2018-12-22', 'bad', 'communityA');


INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (1, '1', '1', '1', 'False', NULL, 'communityA');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (2, '1', '1', '2', 'False', NULL, 'communityA');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (3, '2', '1', '1', 'False', NULL, 'communityA');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (4, '2', '1', '2', 'False', NULL, 'communityA');


INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (1, 'annoyed999', '2018-7-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (1, 1);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (2, 'annoyed!', '2018-7-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (2, 2);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (3, 'annoyed...', '2018-8-2', 'proc', NULL);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (2, 3);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (3, 3);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (4, 'annoyed......', '2018-10-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (1, 4);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (2, 4);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (3, 4);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (5, 'annoyed777', '2018-11-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (1, 5);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (6, 'annoyed666', '2018-11-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (1, 6);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (7, 'annoyed888', '2018-11-2', 'annoying!!!!', NULL);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (1, 7);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (2, 7);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (3, 7);

INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (1, 'bad', 1, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (2, 'bad', 2, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (3, 'bad', 3, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (4, 'fine', 4, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (5, 'bad', 1, '2018-8-2');

INSERT INTO facility_complaint (facilityComplaintID, facilityComplaintTime, facilityComplaintReason, facilityID)
VALUES (1, '2018-7-2', 'bad', 1);

INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (1, 'repairF1', 'res', NULL, 1, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (2, 'repairHardF', 'res', NULL, 2, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (3, 'proc233', 'res', NULL, 3, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (4, 'proc666', 'res', NULL, 5, '2018-9-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (8, 'proc666', 'res', 1, 5, '2018-9-2');


INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (1, 'repair', 100, '2018-8-2', NULL, 1, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (2, 'repair', 100, '2018-8-2', NULL, 2, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (3, 'repair', 100, '2018-8-2', NULL, 3, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (4, 'repair', 100, '2018-2-2', NULL, 8, 'communityA');


INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (6, 'bad', 1, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (7, 'fine', 2, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (8, 'bad', 3, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (9, 'fine', 4, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (10, 'bad', 2, '2018-12-22');


INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (5, 'repairF1', 'res', NULL, 6, '2018-11-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (6, 'repairHardF', 'res', NULL, 8, '2018-11-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (7, 'proc233', NULL, NULL, 10, NULL);


INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (5, 'repair', 100, '2018-11-2', NULL, 5, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (6, 'repair', 100, '2018-11-2', NULL, 6, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (7, 'repair', 100, '2018-11-2', NULL, 6, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (8, 'repair', 100, '2018-12-23', NULL, 7, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (9, 'repair', 100, '2018-12-24', NULL, 7, 'communityA');








