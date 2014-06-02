**Settings***
Resource  keywords.robot
Library  Collections 
Suite Setup  Run keywords  Setup ssh connection  Setup http connection
Suite Teardown  Close All Connections
Resource  config.txt
***Test Cases***

Preconditions
	${CONTROLLER_ID}=  Get controller id
	Set Global Variable  CONTROLLER_ID  ${CONTROLLER_ID}
	Change Drives From Bad State To Good  ${CONTROLLER_ID}

#TC
#	Should Match Regexp  ${JSON_EENUMERATE_CONTROLLERS_EXAMPLE}  ${JSON_EENUMERATE_CONTROLLERS_TEMPLATE}

#TC-1 Enumerate controllers
#	${resp}=  Send http GET request with URL  ${ENUMERATE_CONTROLLERS}
#	Should Be Equal As Strings  ${resp.status_code}   200
#	${jsondata}=  To JSON  ${resp.content}
#	Dictionary Should Contain Key  ${jsondata["data"][0]}  controller_id 

#TC-2 Enumerate physical drives attached to the controller
#	${CONTROLLER_ID}=  Get controller id
#	${resp}=  Send http GET request with URL     /v0.5/controllers/${CONTROLLER_ID}/physicaldevices
#	Should Be Equal As Strings  ${resp.status_code}   200
#	${jsondata}=  To JSON  ${resp.content}
#	Dictionary Should Contain Key  ${jsondata["data"][0]}  state


#TC-3 Enumerate virtual drives (raid arrays)
#	Create default raid
#	${CONTROLLER_ID}=  Get controller id
#	${resp}=  Send http GET request with URL  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices
#	Should Be Equal As Strings  ${resp.status_code}   200
#	${jsondata}=  To JSON  ${resp.content}
#	Should Match Regexp  ${jsondata}  ${JSON_ENUMERATE_PD_TEMPLATE} 

#TC-4 Create a virtual drives (raid arrays)
#	${CONTROLLER_ID}=  Get controller id
 #  ${json}=  Create json for create RAID  ${CONTROLLER_ID}  drives_number=2 raid_level=1
  # ${resp}  Send http POST request  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices  ${json}
#	Should Be Equal As Strings  ${resp.status_code}   201
#	${jsondata}=  To JSON  ${resp.content}  
#	Should Be Equal As Strings  ${jsondata["data"]["controller_id"]}  ${CONTROLLER_ID}
#	List Count Should Be  ${jsondata["data"]["physical_drives"]}  2
#	Check existing of RAID  ${CONTROLLER_ID}  ${jsondata["data"]["virtual_drive"]  raid_level=1
 #   Delete VD  ${CONTROLLER_ID}   ${jsondata["data"]["virtual_drive"]} 

TC-1 create raid 1 with 2 drives  Create RAID level : drive's number  1  2
TC-2 create raid 1 with 3 drives  Create RAID level : drive's number  0  2
TC-3 create raid 1 with 10 drives  Create RAID level : drive's number  10  4
TC-4 create raid 1 with 23 drives  Create RAID level : drive's number  5  3
TC-5 create raid 1 with 24 drives  Create RAID level : drive's number  6  4

#feature_3: Get controller ID
#GET /v1/servers/<server_id>/controllers/<controller_id>/

#feature_4: Get controller PCI address
#GET /v1/servers/<server_id>/controllers/<controller_id>/




