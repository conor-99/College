## Question 1

See `RiscCode.asm`.

## Question 2

To-do.

## Question 3

I used the `gettimeofday()` function from `time.h` to get the time (in microseconds) immediately before and after executing `ackermann(3, 6)`. I then subtracted the two values to get the execution time. I ran the function a number of times and calculated the average in order to be more accurate.

The execution time is calculated in microseconds and since I get the average to two decimal places my result is accurate to within `1e-8` seconds.

The implementation I used is in `TimedAckermann.c`. It took `517.17` microseconds to run.
