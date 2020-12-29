//
//  SimpleTimer.swift
//  traintime
//
//  Created by Andy on 12/25/20.
//

import Foundation

class SimpleTimer: ObservableObject {
  var stimer: Timer
  @Published var elTime: Int

  init() {
    elTime = 0
    stimer = Timer.init()
  }

  func startTimer() {
    stimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
  }

  func pauseTimer() {
    stimer.invalidate()
  }
  
  func resetTimer() {
    stimer.invalidate()
    elTime = 0
  }
  
  func h() -> Int {
    return Int(floor(Double(elTime / 3600)))
  }
  
  func m() -> Int {
    return Int(floor(Double((elTime % 3600) / 60)))
  }
  
  func s() -> Int {
    return Int((elTime % 3600) % 60)
  }

  func pad(v: Int) -> String {
    return (v > 9 ? String(v) : "0" + String(v))
  }
  
  @objc func timerTick() {
    elTime += 1
    //print("tick: ", elTime)
  }
}
