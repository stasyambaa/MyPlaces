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
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?, rating: Double) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
        self.rating = rating
    }
}
