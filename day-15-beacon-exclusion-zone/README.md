# 15 [Beacon Exclusion Zone]

https://adventofcode.com/2022/day/15

When run in _release_ mode, the answer is found in just over 2 seconds. Not 
great, but good enough 👍

## How does it work?

For each line in 0 to the boundary (4.000.000) create ranges for each sensor.
The ranges consist of the outer x-coordinates that are reachable. Then all
ranges for that line are merged. The line where there is more then one merged
range, is the one with the blank spot.  
