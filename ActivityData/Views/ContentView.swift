//
//  ContentView.swift
//  ActivityData
//
//  Created by Anthony Olds on 1/24/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var userID = ""
    @State var navigateToUserView = false
    @State var user = User(id: "")
    
    var body: some View {
        NavigationView {
            VStack(alignment:.center) {
                NavigationLink(isActive: $navigateToUserView, destination: {UserView(user: user)}, label: {
                    EmptyView()
                })
                TextField("Enter User ID", text: $userID)
                Button(action: {
                    user = modelData.getUser(userid: userID)
                    navigateToUserView = true
                }, label: {
                    Text("Go")
                })
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
