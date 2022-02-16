//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Станислав Шапетько on 14.02.2022.
//


import UIKit


struct Place {
    
    var name: String
    var location: String?
    var type: String?
    // добавленная вручную картинка
    var image: UIImage?
        // стартовый набор картинок по имени
    var restaurantImage: String?
    
     static let restaurantNames = ["Burger Heroes", "Kitchen", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
    
    static func getPlaces() -> [Place] {
         
        var places = [Place]()
        for place in restaurantNames {
            places.append(Place(name: place, location: "Уфа", type: "Ресторан", image: nil, restaurantImage: place ))
        }
        
        return places
    }
}
