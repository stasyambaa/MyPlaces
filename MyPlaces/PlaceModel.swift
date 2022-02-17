//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 14.02.2022.
//


import RealmSwift
import UIKit


class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    // добавленная вручную картинка
    @objc dynamic var imageData: Data?
        // стартовый набор картинок по имени
    
    
     let restaurantNames = ["Burger Heroes", "Kitchen", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
    
     func savePlaces() {
         
        for place in restaurantNames {
            
            let newPlace =  Place()
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else {return}
            
            newPlace.name = place
            newPlace.location = "Ufa"
            newPlace.type = "Restaurant"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }
    }
}
