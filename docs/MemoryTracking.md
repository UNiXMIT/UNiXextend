# Investigating Memory Leaks

There are few methods, included with the AcuCOBOL-GT extend, that can help in tracking down memory leaks:

- [The debugger U command](https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKUSUSDBUGS011.html) 
- [Memory Handling Descriptions](https://docs.rocketsoftware.com/bundle/acucobolgt_dg_1051_html/page/BKUSUSPROGS045.html)

## The debugger U command
This command displays the amount of dynamically allocated memory currently used by the runtime system, in the debugger window. Its shows how much memory is allocated for various subsystems, and it is possible to find a loop in the COBOL (say, at a top-level menu) that allows you to test memory at the top of each loop. If you see something increasing consistently, you can start to narrow down where it is happening.  

If you see the memory expanding in Task manager, but you don't see the memory increase by executing the U debugger command, then there are (at least) two possibilities:

1. We are allocating memory for Windows features that require a special memory allocator (these won't be reported in the memcheck.txt file).
2. We are allocating and freeing memory correctly, but that is causing memory fragmentation, causing the expansion you are seeing. There is not a lot we can do about that, except to suggest that the COBOL programmer try to keep things around, rather than destroying and recreating them.

## Memory Handling Descriptions
Memory handling descriptions report detailed information about memory allocation, reallocation, and frees. Normally you will see paired M_alloc/M_free lines (with perhaps a bunch of lines between).  

To look for memory that hasn't been freed, go to the end of the file. This is the final memory dump for memory that was allocated but not freed when the runtime shuts down.    
```
usable memory allocated: 47657 bytes
```
If this is a substantial amount then you should use the debugger U command, outlined above, to track down where in the program the memory increases without being freed.