//
//  ViewController.swift
//  ApiConnectionDemo
//
//  Created by ADMIN on 19/03/2020.
//  Copyright © 2020 ADMIN. All rights reserved.
//

import UIKit

class HolidaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Variables
    var listOfHolidays = [HolidayDetail]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: IBActions
    @IBAction func reloadButtonTapped(_ sender: Any) {
        let holidayRequest = HolidayRequest(year: 2020, countryCode: "ES")
        holidayRequest.getHolidays {[weak self] result in
            switch result {
            case.failure(let error):
                print(error)
            case.success(let holidays):
                self?.listOfHolidays = holidays
            }
        }
    }
    
    //MARK: Life-cycle start
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //MARK: TableView implementation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //FIXME: return actual number of rows
        return listOfHolidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableHolidayCell", for: indexPath)
        // prepare cell
        let holiday = listOfHolidays[indexPath.row]
        cell.textLabel?.text = "\(holiday.localName) (\(holiday.name))"
        cell.detailTextLabel?.text = "Is celebrated: \(holiday.date)"
        // return populated cell
        return cell
    }
    
    
}

