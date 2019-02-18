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
VALUES (3, 'repair', 900, '2018-8-2', NULL, 3, 'communityA');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (10, 'repair', 500, '2018-2-2', NULL, 8, 'communityA');


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

INSERT INTO facilityComplaintIncident (facilityComplaintID, houseID) VALUES (1, 2);
INSERT INTO facility_complaint (facilityComplaintID, facilityComplaintTime, facilityComplaintReason, facilityID)
VALUES (2, '2018-7-3', 'bad', 2);
INSERT INTO facilityComplaintIncident (facilityComplaintID, houseID) VALUES (2, 3);





#communityB!!!!!
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (5, 'c1', '2018-11-2', 'fine', 'communityB');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (6, 'c2', '2018-11-2', 'fine', 'communityB');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (7, 'c3', '2018-11-2', 'fine', 'communityB');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (8, 'hhh1', '2018-12-22', 'bad', 'communityB');


INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (5, '1', '1', '1', 'False', NULL, 'communityB');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (6, '2', '2', '2', 'False', NULL, 'communityB');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (7, '3', '3', '3', 'False', NULL, 'communityB');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (8, '4', '4', '4', 'False', NULL, 'communityB');


INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (8, 'annoyed999', '2018-7-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (5, 8);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (9, 'annoyed!', '2018-7-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (6, 9);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (10, 'annoyed...', '2018-8-2', 'proc', NULL);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (6, 10);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (7, 10);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (11, 'annoyed......', '2018-10-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (5, 11);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (6, 11);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (7, 11);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (12, 'annoyed777', '2018-11-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (5, 12);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (13, 'annoyed666', '2018-11-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (5, 13);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (14, 'annoyed888', '2018-11-2', 'annoying!!!!', NULL);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (5, 14);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (6, 14);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (7, 14);

INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (11, 'bad', 1, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (12, 'bad', 2, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (13, 'bad', 3, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (14, 'fine', 4, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (15, 'bad', 1, '2018-8-2');

INSERT INTO facility_complaint (facilityComplaintID, facilityComplaintTime, facilityComplaintReason, facilityID)
VALUES (3, '2018-7-2', 'bad', 5);


INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (9, 'repairF1', 'res', NULL, 11, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (10, 'repairHardF', 'res', NULL, 12, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (11, 'proc233', 'res', NULL, 13, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (12, 'proc666', 'res', NULL, 15, '2018-9-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (16, 'proc666', 'res', NULL, 15, '2018-9-2');


INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (11, 'repair', 100, '2018-8-2', NULL, 9, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (12, 'repair', 100, '2018-8-2', NULL, 10, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (13, 'repair', 900, '2018-8-2', NULL, 11, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (20, 'repair', 500, '2018-2-2', NULL, 16, 'communityB');


INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (16, 'bad', 5, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (17, 'fine', 6, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (18, 'bad', 7, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (19, 'fine', 8, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (20, 'bad', 6, '2018-12-22');


INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (13, 'repairF1', 'res', NULL, 16, '2018-11-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (14, 'repairHardF', 'res', NULL, 18, '2018-11-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (15, 'proc233', NULL, NULL, 20, NULL);


INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (15, 'repair', 100, '2018-11-2', NULL, 13, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (16, 'repair', 100, '2018-11-2', NULL, 14, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (17, 'repair', 100, '2018-11-2', NULL, 14, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (18, 'repair', 100, '2018-12-23', NULL, 15, 'communityB');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (19, 'repair', 100, '2018-12-24', NULL, 15, 'communityB');

INSERT INTO facilityComplaintIncident (facilityComplaintID, houseID) VALUES (3, 6);
INSERT INTO facility_complaint (facilityComplaintID, facilityComplaintTime, facilityComplaintReason, facilityID)
VALUES (4, '2018-7-3', 'bad', 6);
INSERT INTO facilityComplaintIncident (facilityComplaintID, houseID) VALUES (4, 7);


#communityC!!!!!
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (9, 'c1', '2018-11-2', 'fine', 'communityC');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (10, 'c2', '2018-11-2', 'fine', 'communityC');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (11, 'c3', '2018-11-2', 'fine', 'communityC');
INSERT INTO facility (facilityID, facilityName, latestCheck, facilityState, community)
VALUES (12, 'hhh1', '2018-12-22', 'bad', 'communityC');


INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (9, '1', '1', '1', 'False', NULL, 'communityC');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (10, '2', '2', '2', 'False', NULL, 'communityC');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (11, '3', '3', '3', 'False', NULL, 'communityC');
INSERT INTO house (houseID, buildingNumber, unitNumber, roomNumber, ifFree, chargesID, community)
VALUES (12, '4', '4', '4', 'False', NULL, 'communityC');


INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (15, 'annoyed999', '2018-7-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (9, 15);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (16, 'annoyed!', '2018-7-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (10, 16);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (17, 'annoyed...', '2018-8-2', 'proc', NULL);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (10, 17);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (11, 17);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (18, 'annoyed......', '2018-10-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (9, 18);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (10, 18);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (11, 18);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (19, 'annoyed777', '2018-11-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (9, 19);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (20, 'annoyed666', '2018-11-2', 'proc', 'res');
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (9, 20);
INSERT INTO common_complaint (commonComplaintID, commonComplaintReason, commonComplaintTime, commonComplaintProcess, commonComplaintResult)
VALUES (21, 'annoyed888', '2018-11-2', 'annoying!!!!', NULL);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (9, 21);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (10, 21);
INSERT INTO complaintIncident (houseID, commonComplaintID) VALUES (11, 21);

INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (21, 'bad',9, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (22, 'bad', 10, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (23, 'bad', 11, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (24, 'fine', 12, '2018-7-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (25, 'bad', 9, '2018-8-2');

INSERT INTO facility_complaint (facilityComplaintID, facilityComplaintTime, facilityComplaintReason, facilityID)
VALUES (5, '2018-7-2', 'bad', 9);


INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (17, 'repairF1', 'res', NULL, 21, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (18, 'repairHardF', 'res', NULL, 22, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (19, 'proc233', 'res', NULL, 23, '2018-8-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (20, 'proc666', 'res', NULL, 25, '2018-9-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (21, 'proc666', 'res', NULL, 25, '2018-9-2');


INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (21, 'repair', 100, '2018-8-2', NULL, 17, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (22, 'repair', 100, '2018-8-2', NULL, 18, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (23, 'repair', 900, '2018-8-2', NULL, 19, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (30, 'repair', 500, '2018-2-2', NULL, 21, 'communityC');


INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (26, 'bad', 9, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (27, 'fine', 10, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (28, 'bad', 11, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (29, 'fine', 12, '2018-10-2');
INSERT INTO check_facility (checkFacilityID, checkResult, facilityID, checkTime) VALUES (30, 'bad', 10, '2018-12-22');


INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (25, 'repairF1', 'res', NULL, 26, '2018-11-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (26, 'repairHardF', 'res', NULL, 28, '2018-11-2');
INSERT INTO repair_record (repairRecordID, repairProcess, repairResult, facilityComplaintID, checkFacilityID, repairTime)
VALUES (27, 'proc233', NULL, NULL, 30, NULL);


INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (25, 'repair', 100, '2018-11-2', NULL, 25, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (26, 'repair', 100, '2018-11-2', NULL, 26, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (27, 'repair', 100, '2018-11-2', NULL, 26, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (28, 'repair', 100, '2018-12-23', NULL, 27, 'communityC');
INSERT INTO charges (chargesID, chargesType, chargesAmount, chargesDate, parking_revenueID, repairRecordID, community)
VALUES (29, 'repair', 100, '2018-12-24', NULL, 27, 'communityC');

INSERT INTO facilityComplaintIncident (facilityComplaintID, houseID) VALUES (5, 10);
INSERT INTO facility_complaint (facilityComplaintID, facilityComplaintTime, facilityComplaintReason, facilityID)
VALUES (6, '2018-7-3', 'bad', 6);
INSERT INTO facilityComplaintIncident (facilityComplaintID, houseID) VALUES (6, 11);