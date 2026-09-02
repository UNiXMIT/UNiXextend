       SELECT Department
           ASSIGN       TO  "Department.dat"
           ORGANIZATION IS INDEXED
           ACCESS MODE  IS DYNAMIC
           FILE STATUS  IS Depart-status
           RECORD KEY   IS mkey = Departme-key, Departme-sub
           ALTERNATE RECORD KEY IS Departme-key
           WITH DUPLICATES 
           ALTERNATE RECORD KEY IS Departme-branch.
