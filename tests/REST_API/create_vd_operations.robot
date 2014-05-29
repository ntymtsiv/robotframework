**Settings***
Resource  keywords.robot
Suite Setup  Run keywords  Setup ssh connection  Setup http connection
Suite Teardown  Close All Connections
Resource  config.txt

TC-4 Create a virtual drives (raid arrays)
	${CONTROLLER_ID}=  Get controller id
    ${json}  Insert In Json  controller_id=${controller_id}  virtual_device=${drives_number}
    ${resp}  Send http POST request [Arguments]  ${url}  ${body}
	Should Be Equal As Strings  ${resp.status_code}   200
	${jsondata}=  To JSON  ${resp.content}
	Should Match Regexp  ${jsondata}  ${JSON_ENUMERATE_PD_TEMPLATE} 
#feature_3: Get controller ID