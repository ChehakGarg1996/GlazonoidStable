//
//  UserHandler.swift
//  Glazonoid
//
//  Created by cubastion on 29/09/20.
//  Copyright © 2020 Ruchit. All rights reserved.
//

import Foundation

struct User: Codable {
    var userId: String
    var authToken: String
    var name : String
    var email : String
    var image : URL?
    
    static var StorageKey: String {
        return "userData"
    }
}

class UserHandler {
    
    static func save(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: User.StorageKey)
        }
    }
    
    static var user: User? {
        guard let data = UserDefaults.standard.data(forKey: User.StorageKey) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data) 
    }
    
    static func delete() {
//        GIDSignIn.sharedInstance()?.disconnect()
        UserDefaults.standard.removeObject(forKey: User.StorageKey)
    }
}
