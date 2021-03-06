*** Settings ***
Library  CommonKeywords
Library  DatabaseLibrary

Library  RequestsLibrary
Library  SSHLibrary
Resource  config.txt


*** Keywords ***

Creating RAID with invalid raid level should fail   [Arguments]  ${raid_level}

	${json}  Add In Temp Json  level  ${raid_level}
	${resp}  Create RAID ${json}
	Status should be  Creating RAID failed: level error
	Should Be Equal As Strings  ${resp.status}  400

Create RAID with  [Arguments]  ${json}
   ${resp}=  Put  fuel_api  ${CONTROLLER_VERIFY_WORK}   
   Should Be Equal As Strings  ${resp.status_code}  200
   Should Contain  ${resp.content}  success


Create RAID level : drive's number  [Arguments]  ${raid_level}  ${drives_number}
    ${CONTROLLER_ID}=  Get controller id
    ${json}=  Create json for create RAID  ${CONTROLLER_ID}  drives_number=${drives_number} raid_level=${raid_level}
    ${resp}=  Send http POST request  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices  ${json}
    Should Be Equal As Strings  ${resp.status_code}   201
    ${jsondata}=  To JSON  ${resp.content}
    Should Be Equal As Strings  ${jsondata["data"]["raid_level"]}  ${raid_level}
    Should Be Equal As Strings  ${jsondata["data"]["controller_id"]}  ${CONTROLLER_ID}
    Check existing of RAID  ${CONTROLLER_ID}  ${jsondata["data"]["virtual_drive"]}  raid_level=${raid_level}
    Delete VD  ${CONTROLLER_ID}   ${jsondata["data"]["virtual_drive"]} 



Create RAID level : drive's number : hotspare  [Arguments]  ${rd_lvl}  ${drives_number}  ${hot_spare_number}
   Should Be Equal As Strings  ${rd_lvl}   ${rd_lvl} 

Create RAID's  [Arguments]  @{varargs}
     ${json}  Create Json From List Of Levels  @{varargs}

     Should Be Equal As Strings  ${json}  1 


Execute query  [Arguments]  ${query}
      Connect To Database Using Custom Params  psycopg2  database='nailgun', user='nailgun', password='nailgun', host='10.20.0.2', port = '5432'
      ${queryResults}  Query  ${query}
      [return]  ${queryResults}

Execute Command on fuel master  [Arguments]  ${command}
      Switch Connection  fuel_master
      Login  root  r00tme
      ${output}=  Execute Command  ${command}
      Close Connection
      Should Be Equal As Strings  ${output}  1 
      Verify Raid via api  rd_lvl=${rd_lvl}  virtual_device=${drives_number}  
      Verify Raid via db  rd_lvl=${rd_lvl}  virtual_device=${drives_number}

Verify Raid via api  @{parameters}
    Close Connection     

Setup ssh connection
  Open Connection  ${FUEL_MASTER_ADDR}  alias=fuel_master

Setup http connection 
  Create Session  api  http://${API_ADDRESS}

Get controller id
    ${resp}=  Send http GET request with URL  ${ENUMERATE_CONTROLLERS}
    Should Be Equal As Strings  ${resp.status_code}   200
    ${jsondata}=  To JSON  ${resp.content}
    [return]    ${jsondata['data'][0]['controller_id']}


Set ENUMERATE_PD   [Arguments]  ${CONTROLLER_ID}
   ${ENUMERATE_PD}=   /v0.5/controllers/${CONTROLLER_ID}/physicaldevices

Send http POST request  [Arguments]  ${url}  ${body}
    ${resp}  Post  api  ${url}  ${body}
    [return]  ${resp}

Send http GET request with URL  [Arguments]  ${url}
	${resp}  Get  api  ${url}
	[return]  ${resp}

Send http DELETE request with URL  [Arguments]  ${url}
  ${resp}  Delete  api  ${url}
  [return]  ${resp}

Create default raid
    ${controller_id}=  Get controller id
    ${json}  Insert In Json  controller_id=${controller_id}  virtual_device=${drives_number}
    ${resp}  Send http POST request [Arguments]  ${url}  ${body}

Create json for create RAID  [Arguments]  ${CONTROLLER_ID}  @{args}
  ${resp}=  Send http GET request with URL     /v0.5/controllers/${CONTROLLER_ID}/physicaldevices
  ${jsondata}=  To JSON  ${resp.content}
  ${json}=  Create Json For Raid Creating  ${CONTROLLER_ID}  ${jsondata}  @{args}
  [return]  ${json}

Check existing of RAID  [Arguments]  ${CONTROLLER_ID}  ${vd_id}  @{args}
  ${resp}=  Send http GET request with URL  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices
  ${jsondata}=  To JSON  ${resp.content}
  VD Should Be In VD List  ${jsondata}  ${vd_id}  @{args}

Delete VD  [Arguments]  ${CONTROLLER_ID}  ${vd_id}
    ${resp}=  Send http DELETE request with URL  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices/${vd_id}
  #  Should Be Equal As Strings  ${resp.status_code}   204
