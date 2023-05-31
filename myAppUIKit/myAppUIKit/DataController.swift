//
//  DataController.swift
//  myAppUIKit
//
//  Created by Serdar Onur KARADAĞ on 31.05.2023.
//

import Foundation
import CoreData

class DataController {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchFoods() -> [Food] {
        let request: NSFetchRequest<Food> = Food.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Can't fetch data.")
            return []
        }
    }
    
    func addFood(name:String, calorie: Int32) {
        let food = Food(context: context)
        food.id = UUID()
        food.name = name
        food.calorie = calorie
        
        do {
            try context.save()
            print("added successfully")
        } catch {
            print("Cant save food.")
        }
    }
    
}
