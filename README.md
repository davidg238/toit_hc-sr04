# toit_hc-sr04
Sample code to connect a HC-SR04 to ESP32, running Toit

This is a work in progress, to see what is possible with the existing SDK (v1.0.3 firmware).

The echo pulse width was measured 3 ways, none of them satisfactorily:  
- <b>duty_us</b> determines the duty cycle of the pulse over a 50mS period, in a tight loop
- <b>poll_us</b> samples the echo signal over a period, to determine the pulse width.
- <b>edge_us</b> is the simple implementation, creating a duration by the rising and falling edges.

An excerpt from the console log, using the <b>duty_us</b>, is below.

| Message                                                                       | Created    |
|-------------------------------------------------------------------------------|------------|
|Time: 01:36 Count: 300 Mean 60.8 samp_var 8.3 pop_var 8.2 Min 39.6 Max 71.9|16:36:05|
|Time: 01:26 Count: 300 Mean 61.2 samp_var 7.3 pop_var 7.3 Min 41.2 Max 76.3|16:26:05|
|Time: 01:16 Count: 300 Mean 60.6 samp_var 17.8 pop_var 17.8 Min 23.8 Max 68.5|16:16:05|
|Time: 01:6 Count: 300 Mean 61.3 samp_var 17.2 pop_var 17.1 Min 34.3 Max 107.6|16:06:05|
|Time: 00:56 Count: 300 Mean 60.9 samp_var 11.5 pop_var 11.5 Min 13.4 Max 66.4|15:56:05|
|Time: 00:46 Count: 300 Mean 60.9 samp_var 8.5 pop_var 8.5 Min 26.9 Max 75.3|15:46:05|
|Time: 00:36 Count: 300 Mean 61.0 samp_var 9.2 pop_var 9.2 Min 20.4 Max 75.4|15:36:05|
|Time: 00:26 Count: 300 Mean 60.9 samp_var 3.6 pop_var 3.6 Min 44.1 Max 70.7|15:26:05|
|Time: 00:16 Count: 300 Mean nan samp_var nan pop_var nan Min 21.7 Max 83.7|15:16:11|
|Time: 00:6 Count: 300 Mean 60.6 samp_var 4.6 pop_var 4.6 Min 43.9 Max 68.7|15:06:10|
|Time: 23:56 Count: 300 Mean 61.3 samp_var 7.1 pop_var 7.1 Min 33.9 Max 81.3|14:56:10|