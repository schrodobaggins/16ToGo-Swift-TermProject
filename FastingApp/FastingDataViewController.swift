//
//  FastingDataViewController.swift
//  16ToGo Fasting Countdown
//
//  Created by Michael Schroeder
//

import UIKit

class FastingDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var fastingTimerViewController: FastingTimerViewController?
    
    let brain = FastListBrain() // instance variable of the brain model
    var FastList: [Fast] = [] // variable for the list of fast objects
    
    @IBOutlet weak var tableView: UITableView! // table view variable
    
    var totalFastAmount: Double = 0 // variable for the total hours fasted
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self // sets delegate
        tableView.dataSource = self // allows data change of table
        
        NotificationCenter.default.addObserver(self, selector: #selector(getFastList), name: FastListBrain.getList, object: nil) // subscribes to the get list channel
        brain.getFastList() // requests to get ist
        calcTotalFast() // calls function to calculate total hours fasted
    }
    
    func calcTotalFast() {
        var currFastAmount: Double = 0 // variable for current fast info
        for element in FastList{ // iterate through list of fast objects
            currFastAmount = element.timeFasted // gets fast length of the current element being looked at
//            print(currFastAmount)
            totalFastAmount = totalFastAmount + currFastAmount // accumulates the total fast amount
        }
    }
    
    @objc func getFastList() {
        FastList = FastListBrain.FastList // copies over the fast list
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self) // unsubscribes
    }
    
    @IBOutlet weak var HeaderLabelCell: UITableView! // header label
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // amount of rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell() // cell to return
        let row = indexPath.row // row of table
        
        var isInteger = totalFastAmount.truncatingRemainder(dividingBy: 1) == 0 // check if value can be an integer
        var hoursMsg = "hours" // hours message
        var totalFastStr: String = "" //total fast string
//        print(isInteger)
        if(isInteger){ // if can be an integer
//            print("inside \(totalFastStr)")
            totalFastStr = String(format: "%.0f", totalFastAmount) // remove trailing 0
            if totalFastAmount == 1{
//                print("one")
                hoursMsg = "hour" // hour message
            }
            
//            print(totalFastStr)
        } else {
//            print("not int \(totalFastAmount)")
            totalFastStr = String(format: "%.2f", totalFastAmount) // leave the decimals
        }
//        print(row)
        switch row{ // different cases for each row's output
        case 0: // total hours fasted cell
            cell.textLabel?.text = "Total hours fasted: \(totalFastStr)"
//                + String(format: "%.2f", totalFastAmount)
        case 1: // average fast length cell
            var averageFast = totalFastAmount / Double(FastList.count) // calculates average fast length
            var averageFastStr: String = ""
            isInteger = averageFast.truncatingRemainder(dividingBy: 1) == 0
            if isInteger && averageFast != 0{ // value can be an integer
                averageFastStr = String(format: "%.0f", averageFast) // remove trailing 0s
                if averageFast == 1 {
                    hoursMsg = "hour"
                }
            } else {
                averageFastStr = String(format: "%.2f", averageFast) //keep decimal
            }
            
            cell.textLabel?.text = "Average fast length: \(averageFastStr) \(hoursMsg)" //String(format: "%.2f", averageFast) + " \(hoursMsg)"
        case 2: // navigation tab to another screen showing the list of fasts
            cell.textLabel?.text = "List of fasts"
            cell.accessoryType = .disclosureIndicator // icon
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row // row of current table
//        print(row)
        
        if row == 2{
//            print("switching nav controller")
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main) // storyboard instance
            let destination = storyboard.instantiateViewController(withIdentifier: "FastListViewController") as! FastListViewController // destination view controller
            navigationController?.pushViewController(destination, animated: true) // shows the next destinatin screen
        }
    }
}
