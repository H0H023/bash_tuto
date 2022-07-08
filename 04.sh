#!/bin/bash

# use ':'and "'" symbols as multiline comment

: '
The following script calculates
the square value of the number, 5.
'
((area=5*5))
echo $area
