*** Settings ***
library  DatabaseLibrary
Library  CommonKeywords
Library  Collections
Library  String
Library  OperatingSystem

Suite Teardown  Delete All Sessions
Resource  config.txt
Resource  keywords.robot




***Test Cases***
[tags] negatie for raid level
not exists level  Creating RAID with invalid raid level should fail  17
letters in level  Creating RAID with invalid raid level should fail  1a7
level  Creating RAID with invalid raid level should fail  17




#	Get github /users/bulkan
#	Verify controller work 
#	Delete old RAID
#	Create RAID 10 with 24 drive's
#	Verify RAID 10 with 24 drive's

~