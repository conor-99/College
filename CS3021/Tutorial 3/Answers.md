## Question 1

See `RiscCode.asm`.

## Question 2

To see how the results were calculated see `AnalysedAckermann.c`.

| Register Set | Procedure Calls | Max. RW Depth (+ necessary RWs) | RW Overflows | RW Underflows |
| - | - | - | - | - |
| `6` | `172233` | `511` (`513`) | `172218` | `172218` |
| `8` | `172233` | `511` (`513`) | `172182` | `172182` |
| `16` | `172233` | `511` (`513`) | `171593` | `171593` |

## Question 3

I used the `gettimeofday()` function from `time.h` to get the time (in microseconds) immediately before and after executing `ackermann(3, 6)`. I then subtracted the two values to get the execution time. I ran the function a number of times and calculated the average in order to be more accurate.

The execution time is calculated in microseconds and since I get the average to two decimal places my result is accurate to within `1e-8` seconds.

The implementation I used is in `TimedAckermann.c`. It took an average of `517.17` microseconds to calculate `ackermann(3, 6)`.
