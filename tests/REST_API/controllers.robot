**Settings***
Resource  keywords.robot
Suite Setup  Run keywords  Setup ssh connection  Setup http connection
Suite Teardown  Close All Connections
Resource  config.txt
***Test Cases***

#Preconditions
#	${CONTROLLER_ID}=  Get controller id

TC
	Should Match Regexp  ${JSON_EENUMERATE_CONTROLLERS_EXAMPLE}  ${JSON_EENUMERATE_CONTROLLERS_TEMPLATE}

TC-1 Enumerate controllers
	${resp}=  Send http GET request with URL  ${ENUMERATE_CONTROLLERS}
	Should Be Equal As Strings  ${resp.status_code}   200
	${jsondata}=  To JSON  ${resp.content}
	Should Match Regexp  ${jsondata}  ${JSON_EENUMERATE_CONTROLLERS_TEMPLATE}

TC-2 Enumerate physical drives attached to the controller
	${CONTROLLER_ID}=  Get controller id
	${resp}=  Send http GET request with URL     /v0.5/controllers/${CONTROLLER_ID}/physicaldevices
	Should Be Equal As Strings  ${resp.status_code}   200
	${jsondata}=  To JSON  ${resp.content}
	Should Match Regexp  ${jsondata}  ${JSON_ENUMERATE_PD_TEMPLATE}


TC-3 Enumerate virtual drives (raid arrays)
	Create default raid
	${CONTROLLER_ID}=  Get controller id
	${resp}=  Send http GET request with URL  ${ENUMERATE_PD}
	Should Be Equal As Strings  ${resp.status_code}   200
	${jsondata}=  To JSON  ${resp.content}
	Should Match Regexp  ${jsondata}  ${JSON_ENUMERATE_PD_TEMPLATE} 

#feature_3: Get controller ID
#GET /v1/servers/<server_id>/controllers/<controller_id>/

#feature_4: Get controller PCI address
#GET /v1/servers/<server_id>/controllers/<controller_id>/


***Keywords***
Send http GET request with URL  [Arguments]  ${url}
	${response}  Get  fuel_api  /
	Should Match Regexp  200  [0-9]{3} 


