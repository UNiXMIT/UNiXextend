       SELECT Books
           ASSIGN       TO  "Books.dat"
           ORGANIZATION IS INDEXED
           ACCESS MODE  IS DYNAMIC
           FILE STATUS  IS Books-status
           RECORD KEY   IS Books-id
           ALTERNATE RECORD KEY IS Books-branch
           WITH DUPLICATES .
