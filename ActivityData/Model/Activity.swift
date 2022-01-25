//
//  Activity.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/24/22.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id : String {
        activity_id
    }
    
    var user_id: String
    var activity_id: String
    
    var start: String
    var startTime: Date? {
        dateFormatterZulu.date(from: start)
    }
    
    var end: String
        
    var type: String
    var distance: Float?
    var pace: Float?
    var speed: Float?
    var calories: Float?
    var steps: Int?
}

