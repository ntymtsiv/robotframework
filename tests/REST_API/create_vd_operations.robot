**Settings***
Resource  keywords.robot
Suite Setup  Run keywords  Setup ssh connection  Setup http connection
Suite Teardown  Close All Connections
Resource  config.txt

# positive for raid level 1
TC-1 create raid 1 with 2 drives  Create RAID level : drive's number  1  2
TC-2 create raid 1 with 3 drives  Create RAID level : drive's number  1  12
TC-3 create raid 1 with 10 drives  Create RAID level : drive's number  1  24

# positive for raid level 10
TC-4 create raid 10 with 4 drives  Create RAID level : drive's number  10  4
TC-5 create raid 10 with 18 drives  Create RAID level : drive's number  10  18
TC-6 create raid 10 with 24 drives  Create RAID level : drive's number  10  24

# positive for raid level 0
TC-7 create raid 0 with 2 drives  Create RAID level : drive's number  0  2
TC-8 create raid 0 with 15 drives  Create RAID level : drive's number  0  15
TC-9 create raid 0 with 24 drives  Create RAID level : drive's number  0  24

# positive for raid level 50
TC-10 create raid 50 with 6 drives  Create RAID level : drive's number  50  6
TC-11 create raid 50 with 20 drives  Create RAID level : drive's number  50  10
TC-12 create raid 50 with 24 drives  Create RAID level : drive's number  50  24

# positive for raid level 60
TC-13 create raid 60 with 8 drives  Create RAID level : drive's number  60  8
TC-14 create raid 60 with 18 drives  Create RAID level : drive's number  60  18
TC-15 create raid 60 with 24 drives  Create RAID level : drive's number  60  24

# positive for raid level 6
TC-16 create raid 6 with 4 drives  Create RAID level : drive's number  6  4
TC-17 create raid 6 with 18 drives  Create RAID level : drive's number  6  18
TC-18 create raid 6 with 24 drives  Create RAID level : drive's number  6  24

# positive for raid level 5
TC-19 create raid 5 with 3 drives  Create RAID level : drive's number  5  3
TC-20 create raid 5 with 7 drives  Create RAID level : drive's number  5  7
TC-21 create raid 5 with 24 drives  Create RAID level : drive's number  5  24
