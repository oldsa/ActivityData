//
//  DayOfActivities.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/25/22.
//

import Foundation

class DayOfActivities
{
    init(date: Date)
    {
        self.date = date
    }
    
    let date : Date
    
    private var activites = [Activity]()
    
    var contains1KMRun = false
    var totalKMRun : Float = 0.0
    var longestRun : Float = 0.0
    
    func addActivity(activity: Activity)
    {
        activites.append(activity)
        
        if(activity.distance ?? 0 > 1)
        {
            contains1KMRun = true
        }
        
        if(activity.distance ?? 0 > longestRun)
        {
            longestRun = activity.distance ?? 0
        }
        
        totalKMRun += activity.distance ?? 0
    }
}
