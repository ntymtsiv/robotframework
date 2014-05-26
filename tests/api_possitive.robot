
**Settings***
Resource  keywords.robot
Suite Setup  Run keywords  Setup ssh connection  Create Session  fuel_api  ${FUEL_MASTER_ADDR}
Suite Teardown  Close All Connections

***Test Cases***

# positive for raid level 1
TC-1 create raid 1 with 2 drives  Create RAID level : drive's number  1  2
TC-2 create raid 1 with 3 drives  Create RAID level : drive's number  1  3
TC-3 create raid 1 with 10 drives  Create RAID level : drive's number  1  10
TC-4 create raid 1 with 23 drives  Create RAID level : drive's number  1  23
TC-5 create raid 1 with 24 drives  Create RAID level : drive's number  1  24


# positive for raid level 10
TC-6 create raid 10 with 4 drives  Create RAID level : drive's number  10  4
TC-7 create raid 10 with 8 drives  Create RAID level : drive's number  10  8
TC-8 create raid 10 with 18 drives  Create RAID level : drive's number  10  18
TC-9 create raid 10 with 22 drives  Create RAID level : drive's number  10  22
TC-10 create raid 10 with 24 drives  Create RAID level : drive's number  10  24

# positive for raid level 0
TC-11 create raid 0 with 2 drives  Create RAID level : drive's number  0  2
TC-12 create raid 0 with 3 drives  Create RAID level : drive's number  0  3
TC-13 create raid 0 with 15 drives  Create RAID level : drive's number  0  15
TC-14 create raid 0 with 23 drives  Create RAID level : drive's number  0  23
TC-15 create raid 0 with 24 drives  Create RAID level : drive's number  0  24

# positive for raid level 50
TC-16 create raid 50 with 6 drives  Create RAID level : drive's number  50  6
TC-17 create raid 50 with 8 drives  Create RAID level : drive's number  50  8
TC-18 create raid 50 with 20 drives  Create RAID level : drive's number  50  10
TC-19 create raid 50 with 22 drives  Create RAID level : drive's number  50  22
TC-20 create raid 50 with 24 drives  Create RAID level : drive's number  50  24

# positive for raid level 60
TC-21 create raid 60 with 8 drives  Create RAID level : drive's number  60  8
TC-22 create raid 60 with 16 drives  Create RAID level : drive's number  60  16
TC-23 create raid 60 with 18 drives  Create RAID level : drive's number  60  18
TC-24 create raid 60 with 22 drives  Create RAID level : drive's number  60  22
TC-25 create raid 60 with 24 drives  Create RAID level : drive's number  60  24

# positive for raid level 6
TC-26 create raid 6 with 4 drives  Create RAID level : drive's number  6  4
TC-27 create raid 6 with 5 drives  Create RAID level : drive's number  6  5
TC-28 create raid 6 with 18 drives  Create RAID level : drive's number  6  18
TC-29 create raid 6 with 23 drives  Create RAID level : drive's number  6  23
TC-30 create raid 6 with 24 drives  Create RAID level : drive's number  6  24

# positive for raid level 5
TC-31 create raid 5 with 3 drives  Create RAID level : drive's number  5  3
TC-32 create raid 5 with 4 drives  Create RAID level : drive's number  5  4
TC-33 create raid 5 with 7 drives  Create RAID level : drive's number  5  7
TC-34 create raid 5 with 23 drives  Create RAID level : drive's number  5  23
TC-35 create raid 5 with 24 drives  Create RAID level : drive's number  5  24




# Create RAID with hot spare
TC-X create raid 10 with 4 drives 1 hot spare  Create RAID level : drive's number : hotspare  10  4  1

TC-X create raid 10 , 0 , 1 , 40  Create RAID's  10  0  1 40