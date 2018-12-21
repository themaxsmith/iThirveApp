//
//  Global.swift
//  iThirveApp
//
//  Created by Orbis Student on 11/9/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
import UIKit
class Global {
    var selectedType:typesOfGoals? = typesOfGoals(name: "Not Named", #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    var startDate = Date()
    
var types:[typesOfGoals] = [typesOfGoals(name: "Spirtual", #colorLiteral(red: 0.9458187222, green: 0.7334021926, blue: 0.3021544218, alpha: 1)),typesOfGoals(name: "Financial",#colorLiteral(red: 0.8009896874, green: 0.4788030982, blue: 0.7005690932, alpha: 1)),typesOfGoals(name: "Emotional", #colorLiteral(red: 0.5810223222, green: 0.7761070132, blue: 0.7162308693, alpha: 1)), typesOfGoals(name: "Professional",#colorLiteral(red: 0.9248451591, green: 0.4834753871, blue: 0.3483814597, alpha: 1)), typesOfGoals(name: "Relationship", #colorLiteral(red: 0.5137552023, green: 0.1924897432, blue: 0.3086739182, alpha: 1)), typesOfGoals(name: "Physical",#colorLiteral(red: 0.8689427972, green: 0.2297409177, blue: 0.4471674562, alpha: 1)) ]
    var endDate = Calendar.current.date(byAdding: .day, value: 31, to: Date())
   static var global: Global = Global()
    var canEdit = true
  var key = ""
    var appKey = ""
    var isLoggingIn = false
    var email = ""
    var data = ""
    var serverDate = ""
    var log = false
    var reset = false
    var assessOutput = ""
}
