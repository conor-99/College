## Question 1

### 1. O1 to MUX6

```assembly
ADD		R0, R0, R0
ADD 	R1, R1, R0
ADD 	R1, R0, R1
```

![1](images/1-2.png)

### 2. O0 to MUX7 & O1 to MUX6

```assembly
ADD		R0, R0, R0
ADD 	R1, R1, R0
ADD 	R1, R0, R1
```

![1](images/1-2.png)

### 3. O0 to MUX8

```assembly
ST 		R0, R0, 0
```

![1](images/3-4.png)

### 4. EX to MUX7

```assembly
ST 	R0, R0, 0
```

![1](images/3-4.png)

### 5. DC to MUX9

```assembly
LD 		R0, R0, 0
```

![1](images/5.png)

### 6. O0 to ZD

```assembly
ADD		R0, R0, R0
BEQZ	R0, 0
```

![1](images/6.png)

### 7. RF to MUX1

```assembly
ADD 	R0, R1, R0
JALR	R0, R1
```

![1](images/7.png)

### 8. BTB to MUX1

```assembly
JAL 	R0, 0
```

![1](images/8.png)
