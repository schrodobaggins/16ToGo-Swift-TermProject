//
//  FastListViewController.swift
//  16ToGo Fasting Countdown
//
//  Created by Michael Schroeder
//

import UIKit

class FastListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var fastList: [Fast] = [] // variable for the list of all fast items
    
    @IBOutlet weak var tableView: UITableView! // outlet for table vies
    var brain = FastListBrain() // instance of the fast list brain class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self // sets table view delegate
        tableView.dataSource = self  // allows table data to be added
        
        self.title = "List of Fasts"
        NotificationCenter.default.addObserver(self, selector: #selector(getFastList), name: FastListBrain.getList, object: nil) // subscribes to get list
        brain.getFastList() // sends out request to get list

        // this is a sort to sort the list by end time in descending order
        fastList.sort { (lhs: Fast, rhs: Fast) -> Bool in
            return lhs.endTime > rhs.endTime
        }
//        print(fastList)
    }
    
    @objc func getFastList() {
        fastList = FastListBrain.FastList // copies the fast list to this view controller
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self) // removes subscribe
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print(fastList.count)
        return fastList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() // cell to return
        let row = indexPath.row // row of the table
        let startDate = fastList[row].startTime // variable to get the start time of the current fast
        let endDate = fastList[row].endTime // variable to get the end time of the current fast
        var fastLength = fastList[row].timeFasted // variable for how long the fast was
        
        let isInteger = fastLength.truncatingRemainder(dividingBy: 1) == 0 // checks if variable can be an int
        var hoursMsg = "hours"
        var fastLengthStr: String = ""
//        print(isInteger)
        if(isInteger){ // can be an int
//            print("inside \(fastLength)")
            fastLengthStr = String(format: "%.0f", fastLength) // remove trailing 0s
            if fastLength == 1{
//                print("one")
                hoursMsg = "hour"
            }
            
//            print(fastLengthStr)
            
        } else {
//            print("not int \(fastLength)")
            fastLengthStr = String(format: "%.2f", fastLength) // keep decimals
        }
        
        
        // formatting date to our usage
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz" // format comming in
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterPrint.dateFormat = "MMM dd, yyyy h:MM a" // how we want it formatted
        
        cell.textLabel?.numberOfLines = 0 // lets text wrap
        cell.textLabel?.text = "Start: " + dateFormatterPrint.string(from: startDate) +
            "\nEnd: " + dateFormatterPrint.string(from: endDate) +
            "\nDuration of fast: \(fastLengthStr) \(hoursMsg)" // output for the cell
        return cell
    }
}
