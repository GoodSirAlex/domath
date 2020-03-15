//
//  globalVariables.swift
//  domath
//
//  Created by Alex on 6/30/18.
//  Copyright © 2018 Suss. All rights reserved.
//

import Foundation

// MARK: bools for game mode

var addModeBool = false
var multiplyModeBool = false
var subtractModeBool = false
var divideModeBool = false
var mixedModeBool = false

var addModeBasic = false
var addModeIntermediate = false
var addModeAdvanced = false
var addModeSilver = false
var addModeGold = false
var addModePlatinum = false
var addModeElite = false

var multiplyModeBasic = false
var multiplyModeIntermediate = false
var multiplyModeAdvanced = false
var multiplyModeSilver = false
var multiplyModeGold = false
var multiplyModePlatinum = false

var subtractModeBasic = false
var subtractModeIntermediate = false
var subtractModeAdvanced = false
var subtractModeSilver = false
var subtractModeGold = false
var subtractModePlatinum = false

var divideModeBasic = false
var divideModeIntermediate = false
var divideModeAdvanced = false
var divideModeElite = false

var scoreCounter = 0

var addModeBestScore = 0
var subtractModeBestScore = 0
var divideModeBestScore = 0
var multiplyModeBestScore = 0
var mixedModeBestScore = 0

// MARK: Properties for settings

var vibrationOff = 1
var soundsOff = 1

var beigeColor = true
var blueColor = false
var greyColor = false

// MARK: Properties for statistics
var maxDailyScore = 0
struct statisticsScore {
    var date: String
    var value: Int
}
var dailyScoresList: [statisticsScore] = []

var scoresDictionaryDate: [String: [Int]] = [:]
var scoresDictionaryDateTime: [String: Int] = [:]

