# Question a

## Parameters

T set of tasks, index t
C set of computers, index c
rt resources requested by task t
rc available capacity of computer c

## Decision variables

xtc binary, equal to 1 if task t is served from computer c; 0 otherwise
z positive real with the ratio of load of the highest loaded computer (the same as lab 1)

```ilog
min z
such that
1. Each task is assigned to exactly one computer. done

2. The capacity of each computer cannot be exceeded



```
