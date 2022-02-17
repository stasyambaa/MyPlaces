//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 17.02.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            
            realm.add(place)
        }
    }
}
