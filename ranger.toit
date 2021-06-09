// Copyright 2021 Ekorau LLC

import gpio.pin
import .hc_sr04
import statistics

main:

// Tested on ESP32_Core_Board_V2 and Adafruit HUZZAH32

    ranger := HC_SR04 
                --trig=gpio.Pin 21
                --echo=gpio.Pin 22

    ranger.on
    stats := statistics.OnlineStatistics
    count := 300
/*
    range := ranger.read_in
    print "Range: $(%.1f range) in"
    
*/
/*
    exception := catch:
        range := ranger.read_in
        print "Range: $(%.1f range) in"
    if exception:
        print "ranger timeout"
*/

    count.repeat: | i |

        stats.update(ranger.read_in)
        sleep --ms=1000

    time := Time.now.local
    print "Time: $(%02d time.h):$(%1d time.m) Count: $(stats.count) Mean $(%.1f stats.mean) samp_var $(%.1f stats.sample_variance) pop_var $(%.1f stats.population_variance) Min $(%.1f stats.min) Max $(%.1f stats.max)"

    ranger.off
