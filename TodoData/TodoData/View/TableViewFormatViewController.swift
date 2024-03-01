//
//  TableViewFormatViewController.swift
//  TodoData
//
//  Created by Droadmin on 11/12/23.
//

import UIKit


class TableViewFormatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,RealoadData {
   

    static let tableViewControllerData = TableViewFormatViewController()
    var dbData:[ReadData] = []
    let imageCache = NSCache<AnyObject, AnyObject>()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbData = DBManager.dbManager.readData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dbData = DBManager.dbManager.readData()
        tableView.reloadData()
    }
    func updateDataForSelectedDate(selectedDate: String) {
        let filteredData = dbData.filter { $0.date == selectedDate }
        updateTableView(newData: filteredData)
    }

    func updateTableView(newData: [ReadData]) {
        dbData = newData
        tableView.reloadData()
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")as! TableViewCell

        cell.dbNameLbl.text = dbData[indexPath.row].name
        cell.dbDateLbl.text = dbData[indexPath.row].date
        cell.dbImage.image = dbData[indexPath.row].image
        return cell
    }
    func fatchData() {
        dbData = DBManager.dbManager.readData()
        tableView.reloadData()
    }
    
}
