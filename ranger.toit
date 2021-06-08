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
    statsP := statistics.OnlineStatistics
    statsE := statistics.OnlineStatistics
    count := 100
    timeoutP := 0
    timeoutE := 0

    range := ranger.read_in
    print "Range: $(%.1f range) in"
    

/*
    exception := catch:
        range := ranger.read_in
        print "Range: $(%.1f range) in"
    if exception:
        print "ranger timeout"
*/
/*
    count.repeat: | i |

        exception := catch:
            statsP.update(ranger.poll_us)
        if exception:
            timeoutP += 1

        exception = catch:
            statsE.update(ranger.edge_us)
        if exception:
            timeoutE += 1

        sleep --ms=1000

    time := Time.now.local
    print "Time: $(%02d time.h):$(%1d time.m) Poll $(statsP.count) TimOuts $(timeoutP) Mean $(%.1f statsP.mean)" // samp_var $(%.1f statsP.sample_variance) pop_var $(%.1f statsP.population_variance) Min $(%.1f statsP.min) Max $(%.1f statsP.max)"
    print "Time: $(%02d time.h):$(%1d time.m) Edge $(statsE.count) TimOuts $(timeoutE) Mean $(%.1f statsE.mean)" // samp_var $(%.1f statsE.sample_variance) pop_var $(%.1f statsE.population_variance) Min $(%.1f statsE.min) Max $(%.1f statsE.max)"
    print "-------------------------------------"
*/
    ranger.off
