CREATE TABLE IF NOT EXISTS facility (
  facilityID    INT,
  facilityName  VARCHAR(5),
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
  repairRecordID      INT,
  repairProcess       VARCHAR(45),
  repairResult        VARCHAR(10),
  facilityComplaintID INT,
  checkFacilityID     INT,
  repairTime          DATE,
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

CREATE TABLE parking_revenue (
  parking_revenueID INT         NOT NULL,
  type              VARCHAR(45) NOT NULL,
  leaseLength       INT         NOT NULL,
  leaseTime         DATE        NOT NULL,
  buyTime           VARCHAR(45) NOT NULL,
  PRIMARY KEY (parking_revenueID)
);

CREATE TABLE IF NOT EXISTS charges (
  chargesID         INT,
  chargesType       VARCHAR(45),
  chargesAmount     INT,
  chargesDate       DATE,
  parking_revenueID INT,
  repairRecordID    INT,
  community         VARCHAR(45),
  PRIMARY KEY (chargesID),
  FOREIGN KEY (parking_revenueID) REFERENCES parking_revenue (parking_revenueID),
  FOREIGN KEY (repairRecordID) REFERENCES repair_record (repairRecordID)
);

CREATE TABLE IF NOT EXISTS house (
  houseID        INT         NOT NULL,
  buildingNumber VARCHAR(45) NOT NULL,
  unitNumber     VARCHAR(45) NOT NULL,
  roomNumber     VARCHAR(45) NOT NULL,
  ifFree         VARCHAR(45) NOT NULL,
  chargesID      INT,
  community      VARCHAR(45),
  PRIMARY KEY (houseID),
  FOREIGN KEY (chargesID) REFERENCES charges (chargesID)
);


CREATE TABLE IF NOT EXISTS inhabitant (
  inhabitantID   INT         NOT NULL,
  phoneNumber    VARCHAR(45) NOT NULL,
  inhabitantName VARCHAR(45) NOT NULL,
  ifOwner        VARCHAR(45) NOT NULL,
  houseID        INT,
  PRIMARY KEY (inhabitantID)
);


CREATE TABLE parkingspace (
  parkingSpaceID INT         NOT NULL,
  type           VARCHAR(45) NOT NULL,
  community      VARCHAR(45) NOT NULL,
  PRIMARY KEY (parkingSpaceID)
);

CREATE TABLE temp_parkingspace (
  temp_parkingspaceID INT         NOT NULL,
  startTime           DATE        NOT NULL,
  endTime             DATE        NOT NULL,
  state               VARCHAR(45) NOT NULL,
  tempParkingname     VARCHAR(45) NOT NULL,
  carNumber           INT         NOT NULL,
  PRIMARY KEY (temp_parkingspaceID)
);


CREATE TABLE IF NOT EXISTS complaintIncident (
  houseID           INT,
  commonComplaintID INT,
  PRIMARY KEY (houseID, commonComplaintID),
  FOREIGN KEY (houseID) REFERENCES house (houseID),
  FOREIGN KEY (commonComplaintID) REFERENCES common_complaint (commonComplaintID)
)
CREATE TABLE IF NOT EXISTS facilityComplaintIncident (
  facilityComplaintID INT,
  houseID             INT,
  PRIMARY KEY (facilityComplaintID, houseID),
  FOREIGN KEY (facilityComplaintID) REFERENCES facility_complaint (facilityComplaintID),
  FOREIGN KEY (houseID) REFERENCES house (houseID)
)

CREATE TABLE IF NOT EXISTS ownership (
  inhabitantID INT,
  houseID      INT,
  PRIMARY KEY (inhabitantID, houseID),
  FOREIGN KEY (inhabitantID) REFERENCES inhabitant (inhabitantID),
  FOREIGN KEY (houseID) REFERENCES house (houseID)
)