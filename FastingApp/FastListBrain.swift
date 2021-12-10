//
//  FastListBrain.swift
//  16ToGo Fasting Countdown
//
//  Created by Michael Schroeder
//

import Foundation

class FastListBrain {
    
    static let listHasUpdated = Notification.Name("FastListBrain.listHasUpdated") // variable for notification that list has updated
    static let getList = Notification.Name("FastListBrain.getList") // variable for getting the list
    
    static var FastList: [Fast] = [] // variable that holds all the fast items
    
    func addFastToList(newFastItem: Fast) {
//        print("adding new fast \(newFastItem)")
        FastListBrain.FastList.append(newFastItem) // adds the fast item to the list
//        print(FastList)
        NotificationCenter.default.post(name: FastListBrain.listHasUpdated, object:  nil) // sends out a post notification to let subscribers know the list has updated
    }
    
    func getFastList() {
        NotificationCenter.default.post(name: FastListBrain.getList, object: nil) // sends out post notification letting subscribers know to get list
    }
}
