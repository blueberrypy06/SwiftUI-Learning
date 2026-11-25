//
//  CodablePractice.swift
//  iExpense
//
//  Created by 문준민 on 11/25/26.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct CodablePractice: View {
    @State private var user = User(
        firstName: "",
        lastName: ""
    )
    
    var body: some View {
        NavigationStack {
            Form {
                Section("User Information") {
                    TextField("First Name", text: $user.firstName)
                    TextField("Last Name", text: $user.lastName)
                }

                Section {
                    Button("Save User", action: saveUser)
                    Button("Load User", action: loadUser)
                }
            }
            .navigationTitle("User Profile")
            .onAppear(perform: loadUser)
        }
    }
    
    private func saveUser() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "UserData")
        }
    }

    private func loadUser() {
        guard let data = UserDefaults.standard.data(
            forKey: "UserData"
        ) else {
            return
        }

        if let savedUser = try? JSONDecoder().decode(
            User.self,
            from: data
        ) {
            user = savedUser
        }
    }
}

#Preview {
    CodablePractice()
}
