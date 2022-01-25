//
//  User.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/24/22.
//

import Foundation

class User: Identifiable {
    
    init(id: String)
    {
        self.id = id
    }
    
    var id: String
    
    var numberOfActivities = 0
    var numberOf3DayStreaks = 0
    var numberOfWeeksWith10KM = 0
    var longestRun : Float = 0
    var totalKMRan : Float = 0
    
    //List of activities indexed by the day they were started on
    var DaysOfActivity = [Date : DayOfActivities]()
    
    func addActivity(activity: Activity)
    {
        numberOfActivities += 1
        let dateOfActivity = Calendar.current.startOfDay(for: activity.startTime ?? dateFormatterZuluMS.date(from: activity.start)!)
        if let dayOfActivity = DaysOfActivity[dateOfActivity]
        {
            dayOfActivity.addActivity(activity: activity)
        }
        else {
            let newDayOfActivities = DayOfActivities(date: dateOfActivity)
            newDayOfActivities.addActivity(activity: activity)
            DaysOfActivity[dateOfActivity] = newDayOfActivities
        }
    }
    
    func calculateValues()
    {
        //Gets all the days with activity sorted
        let datesWithActivity = DaysOfActivity.keys.sorted()
        
        numberOf3DayStreaks = 0
        numberOfWeeksWith10KM = 0
        totalKMRan = 0
        
        var currentStreak = 0
        var kmThisWeek : Float = 0.0
        var prevDay : DayOfActivities? = nil
        for day in datesWithActivity {
            
            if let prevDay = prevDay {
                
                //if this day is more than a day past the last date clear currentStreek
                let numberOfDays = Calendar.current.dateComponents([.day], from: prevDay.date, to: day)
                if(numberOfDays.day! > 1)
                {
                    currentStreak = 0
                }
                
                //if this day is a new week clear kmThisWeek 2 = Monday / new week (1-7)
                let previousWeekday = Calendar.current.component(.weekday, from: prevDay.date)
                
                //if previous day was sunday then the new day will be a new week
                //if the previous day was Monday since monday is 2, the prev index + number of days later must be under 9 (7 + 2)
                if(previousWeekday == 1 || (previousWeekday + numberOfDays.day!) > 9)
                {
                    if(kmThisWeek > 10)
                    {
                        numberOfWeeksWith10KM += 1
                    }
                    kmThisWeek = 0
                }
                
            }
            
            if let dayOfActivities = DaysOfActivity[day] {
                if(longestRun < dayOfActivities.longestRun)
                {
                    longestRun = dayOfActivities.longestRun
                }
                
                totalKMRan += dayOfActivities.totalKMRun
                kmThisWeek += dayOfActivities.totalKMRun
                
                //Do 1km check
                if(dayOfActivities.contains1KMRun)
                {
                    currentStreak += 1
                    if(currentStreak == 3)
                    {
                        numberOf3DayStreaks += 1
                        currentStreak = 0
                    }
                }
                else {
                    currentStreak = 0
                }
                
                prevDay = dayOfActivities
            }
        }
        
        //When we get ot the end of the list we want to add the last week with 10km even though we haven't started a new week
        if(kmThisWeek > 10)
        {
            numberOfWeeksWith10KM += 1
        }
    }
}
