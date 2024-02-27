# Acu4GL for ODBC, using the latest MySQL ODBC drivers 8.0.28+ tries, to INSERT NULL for every field
## Environment
AcuCOBOL-GT extend  
Windows  
Linux and UNIX  

## Situation
When using Acu4GL for ODBC and using the MySQL ODBC driver version 8.0.28+, programs fail when inserting data.  
An error is returned:  

```
*** S1000: [MySQL][ODBC 8.0(a) Driver][mysqld-8.0.30]Column 'ftestcnd_key' cannot be null ***
```

In the log it looks like the program is trying to insert null in every field:  

```
09:34:28.552264 <SQL
09:34:28.552267 insert into ftestdat (ftestcnd_key, ftest_key1_seg1, ftest_key1_seg2, ftest
09:34:28.552269 nd_altkey2, ftestcnd_number, ftestcnd_info, ftestcnd_in) values (null,
09:34:28.552272 null, null, null, null, null, null)
09:34:28.552274 EndSQL>
```

Testing MySQL ODBC driver 8.0.20 the program works OK and doesn’t try to insert NULL in every field:  

```
10:08:02.576015 <SQL
10:08:02.576018 insert into ftestdat (ftestcnd_key, ftest_key1_seg1, ftest_key1_seg2,
10:08:02.576021 ftestcnd_altkey2, ftestcnd_number, ftestcnd_info, ftestcnd_in) values
10:08:02.576023 ('0503', '05', '05', '0503', '000005.00', null, '03')
10:08:02.576026 EndSQL>
```

Why has the behaviour changed when using these newest MySQL ODBC drivers?  

## Resolution
This appears to be an acknowledged issue by MySQL/ODBC - see [patch notes for 8.0.31](https://dev.mysql.com/doc/relnotes/connector-odbc/en/news-8-0-31.html)   
The issue is related to support for wide character values in MySQL which was added in MySQL very recently.  
MySQL claim to have fixed it but it still exists in the latest ODBC driver release.   

It's recommended to either:  
- Use MySQL/ODBC drivers version 8.0.27 or earlier.
- Use version 8.0.28-8.0.30 with the driver metadata option, to disable the INFORMATION_SCHEMA table, enabled (8.0.31 removed this option without fixing the issue).