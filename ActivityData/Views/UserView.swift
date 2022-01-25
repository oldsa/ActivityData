//
//  UserView.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/24/22.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading)
        {
            Text("User id: \(user.id)")
            Text("Number of activities: \(user.numberOfActivities)")
            Text("Number of weeks with 10KM ran: \(user.numberOfWeeksWith10KM)")
            Text("Number of 3 day streaks: \(user.numberOf3DayStreaks)")
            Text("Longest run: \(user.longestRun)")
            Text("Total KM Ran: \(user.totalKMRan)")
        }
    }
}

