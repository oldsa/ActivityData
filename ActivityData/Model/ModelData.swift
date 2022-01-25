//
//  ModelData.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/24/22.
//

import Foundation

final class ModelData: ObservableObject {
    
    var activities: [Activity] = load()

    //Users mapped by user id
    func getUsers() -> [String: User]
    {
        var users = [String: User]()
        for activity in activities {
            if let user = users[activity.user_id]
            {
                user.addActivity(activity: activity)
            }
            else {
                let newUser = User(id: activity.user_id)
                newUser.addActivity(activity: activity)
                users[activity.user_id] = newUser
            }
        }
        
        for user in users.values
        {
            user.calculateValues()
        }
        
        return users
    }
    
    func getUser(userid: String) -> User
    {
        let user = User(id: userid)
        let userActivities = activities.filter {
            $0.user_id == userid
        }
        for activity in userActivities {
            user.addActivity(activity: activity)
        }
        user.calculateValues()
        return user
    }
}

func load() -> [Activity]
{
    var listOfActivities = [Activity]()
    
    let paths = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil)
    for activityFile in paths! {
        
        let data: Data
        do {
            data = try Data(contentsOf: activityFile)
        } catch {
            print("Couldn't load \(activityFile) from bundle:\n\(error)")
            continue
        }
        
        do {
            let decoder = JSONDecoder()
            let activity = try decoder.decode(Activity.self, from: data)
            listOfActivities.append(activity)
        } catch {
            print("Couldn't parse \(activityFile) as \(Activity.self):\n\(error)")
        }
        
    }
    
    return listOfActivities
}
