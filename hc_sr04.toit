// Copyright 2021 Ekorau LLC

import gpio.pin

/* 
The HC-SR04 returns a pulse length proportional to range.
The formula is:
range (in) = pulse length (us) / 148
range (cm) = pulse length (us) / 58
Specified range is:
    0.02 - 4.0m or 116 - 23k2 uS
although some have noted that 
    0.10 - 2.5m or 580 - 14k5 uS
is more reliable (https://learn.adafruit.com/ultrasonic-sonar-distance-sensors).
*/

class HC_SR04:

  trig_ /gpio.Pin
  echo_ /gpio.Pin

  statsBefore := process_stats
  statsAfter  := process_stats

  duration_10us ::= Duration --us=10
  duration_1ms ::= Duration --ms=1
  leadingEdge := Time.now
  width := Duration --ms=100

  constructor --trig --echo:
    trig_ = trig
    echo_ = echo

  on:
    trig_.config --output=true
    echo_.config --input=true

  off:
    trig_.close
    echo_.close

  duty_us -> int:

    pulseCount := 0
    loopCount := 0
    
    trig_.set 1
    sleep duration_10us
    trig_.set 0

    exception := catch:
      with_timeout --ms=50:
        while true:
          pulseCount += echo_.get
          loopCount += 1
    if exception:
      print "$pulseCount  $loopCount"
      return (pulseCount / loopCount) * 50000
    return 0

  poll_us -> int:

    window := 50
    pulseW_ms := 0
    with_timeout --ms=500:
        trig_.set 1
        sleep duration_10us
        trig_.set 0

        window.repeat:
          pulseW_ms += echo_.get
          sleep duration_1ms
        return pulseW_ms * 1000
    return -1

  edge_us -> int:
  
    with_timeout --ms=500:
        trig_.set 1
        sleep duration_10us
        trig_.set 0

        statsBefore = process_stats
        echo_.wait_for 1
        leadingEdge = Time.now
        echo_.wait_for 0
        width = Duration.since leadingEdge
        statsAfter = process_stats
        return width.in_us
    return -1

  read_in -> float:
    return duty_us / 148.0

  read_cm -> float:
    return edge_us / 58.0


