**Settings***
Resource  keywords.robot
Suite Setup  Run keywords  Setup ssh connection  Setup http connection 
Suite Teardown  Close All Connections


***Test Cases***
TC-1 create raid 1 with 2 drives  Create RAID level : drive's number  1  2
#run command via cli2  Execute Command on fuel master  ls
#run command via cli3  Execute Command on fuel master  ls
#EXECUTE QUERU  Execute query  update clusters set name = 'my_first_os';
#EXECUTE QUERU  
#	${result}  Execute query  select name from clusters;
#	 Should Be Equal As Strings  ${result}  1 