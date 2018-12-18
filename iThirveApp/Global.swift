//
//  Global.swift
//  iThirveApp
//
//  Created by Orbis Student on 11/9/18.
//  Copyright © 2018 JJ SchraderBachar. All rights reserved.
//

import Foundation
class Global {
    var selectedType:typesOfGoals? = typesOfGoals(name: "Not Namedß")
    var startDate = Date()
var types:[typesOfGoals] = [typesOfGoals(name: "Spirtual"),typesOfGoals(name: "Financial"),typesOfGoals(name: "Emotional"), typesOfGoals(name: "Professional"), typesOfGoals(name: "Relationship"), typesOfGoals(name: "Physical") ]
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
}
