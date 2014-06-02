**Settings***
Resource  keywords.robot
Library  Collections 
Suite Setup  Run keywords  Setup ssh connection  Setup http connection
Suite Teardown  Close All Connections
Resource  config.txt
***Test Cases***

#Preconditions
#	${CONTROLLER_ID}=  Get controller id

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
 #       ${json}=  Create json for create RAID  ${CONTROLLER_ID}  drives_number=2 raid_level=1

  #  ${resp}  Send http POST request  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices  ${json}
#	Should Be Equal As Strings  ${resp.status_code}   201
#	${jsondata}=  To JSON  ${resp.content}  
#	Should Be Equal As Strings  ${jsondata["data"]["raid_level"]}  1
#	Should Be Equal As Strings  ${jsondata["data"]["controller_id"]}  ${CONTROLLER_ID}
#	List Count Should Be  ${jsondata["data"]["physical_drives"]}  2

TC-5 Check existing of RAID
	${CONTROLLER_ID}= Get controller id	
	${resp}=  Send http GET request with URL  /v0.5/controllers/${CONTROLLER_ID}/virtualdevices
	${jsondata}=  To JSON ${resp.content}
	VD Should Be In VD List ${jsondata}  ${CONTROLLER_ID}  0  @{args}
#feature_3: Get controller ID
#GET /v1/servers/<server_id>/controllers/<controller_id>/

#feature_4: Get controller PCI address
#GET /v1/servers/<server_id>/controllers/<controller_id>/




