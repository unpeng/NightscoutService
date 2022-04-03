//
//  StoredGlucoseSample.swift
//  NightscoutServiceKit
//
//  Created by Darin Krauss on 10/13/19.
//  Copyright © 2019 LoopKit Authors. All rights reserved.
//

import LoopKit
import NightscoutUploadKit

extension StoredGlucoseSample {

    var glucoseEntry: GlucoseEntry {
        let glucoseTrend: GlucoseEntry.GlucoseTrend?
        if let trend = trend {
            glucoseTrend = GlucoseEntry.GlucoseTrend(rawValue: trend.rawValue)
        } else {
            glucoseTrend = nil
        }

        return GlucoseEntry(
            glucose: quantity.doubleValue(for: .milligramsPerDeciliter),
            date: startDate,
            device: "loop://\(UIDevice.current.name)",
            glucoseType: wasUserEntered ? .meter : .sensor,
            trend: glucoseTrend,
            changeRate: trendRate?.doubleValue(for: .milligramsPerDeciliterPerMinute),
            isCalibration: isDisplayOnly
        )
    }

}
