# toit_hc-sr04
Sample code to connect a HC-SR04 to ESP32 running Toit

This is a work in progress, to see what is possible with the existing SDK.

Three ways to measure the echo pulse width are attempted, none of them work as is:  
- <b>duty_us</b> attempts to determine the duty cycle of the pulse over a 50mS period.  Yields `Reset due to task watchdog. crashes=4`
- <b>poll_us</b> samples the echo signal over a period, to determine the pulse width. Yields wrong ranges, with significant variation.
- <b>edge_us</b> is the simple implementation, creating a duration by the rising and falling edges. Yields wrong ranges, with significant variation.
