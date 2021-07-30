# Network Share vs AcuServer Performance

Network Shares can be fast when only one user is working with a Vision file, especially when data is only being READ and not changing. This is because Windows Shares have been optimised for this kind of situation and a lot of caching happens.  

AcuServer is faster when more than one user starts working with the same file. It delivers consistent results despite the number of users.  

The following tests show that Network Shares are very fast with one user, but as the number of users increase, the performance of Network Shares dramatically decreases. AcuServer results are not as fast with a single users but remain consistent as the number of users increase.  

**NOTE:** These tests may not reflect exactly how your program works but the general trend should still apply. You should perfor concurrent tests with your program/setup to see how AcuServer compare to Network Shares as numbers of user increase.  

**Tests done with AcuCOBOL-GT extend 10.4.0 on Windows Server 2019 AWS VMs**  

**Number of Records to READ/WRITE/REWRITE** - 50000    

| Number of Clients | READ/WRITE/REWRITE | Network Share           | AcuServer               |
|-------------------|--------------------|-------------------------|-------------------------|
|                   |                    | Avg. Duration (Seconds) | Avg. Duration (Seconds) |
| 1                 | WRITE              | 6                       | 44                      |
| 1                 | REWRITE            | 7                       | 86                      |
| 2                 | REWRITE            | 1236                    | 86                      |
| 5                 | REWRITE            | 2859                    | 89                      |
| 10                | REWRITE            | 7217                    | 120                     |
| 1                 | READ               | 2                       | 41                      |
| 2                 | READ               | 291                     | 40                      |
| 5                 | READ               | 577                     | 41                      |
| 10                | READ               | 1742                    | 53                      |

#### AWS VM Specs - t2.xlarge
**CPU**	- 4 vCPU @ 2.30 GHz   
**RAM**	- 16GB  
**Network**	- 800Mbps UP/DOWN  
