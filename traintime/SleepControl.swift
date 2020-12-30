//
//  SleepControl.swift
//  traintime
//
//  Created by Andy on 12/30/20.
//

import Foundation
import UIKit

struct SleepControl {
  static func disableSleep() {
    // Cycle the idle timer setting to disable it. See:  https://stackoverflow.com/questions/12856099/how-to-re-enable-the-idle-timer-in-ios-once-it-has-been-disabled-to-allow-the-d
    UIApplication.shared.isIdleTimerDisabled = false
    UIApplication.shared.isIdleTimerDisabled = true
  }

  static func enableSleep() {
    UIApplication.shared.isIdleTimerDisabled = false
  }
}
