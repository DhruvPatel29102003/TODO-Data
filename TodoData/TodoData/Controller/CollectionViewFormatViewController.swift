//
//  CollectionViewFormatViewController.swift
//  TodoData
//
//  Created by Droadmin on 11/12/23.
//

import UIKit


class CollectionViewFormatViewController: UIViewController,RealoadData {

    
    var dbData:[ReadData] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dbData = DBManager.dbManager.readData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dbData = DBManager.dbManager.readData()
        collectionView.reloadData()
    }
    func fatchData() {
        dbData = DBManager.dbManager.readData()
        collectionView.reloadData()

    }
    func updateDataForSelectedDate(selectedDate: String) {
        let filteredData = dbData.filter { $0.date == selectedDate }
        updateCollectionView(newData: filteredData)
    }

    func updateCollectionView(newData: [ReadData]) {
        dbData = newData
        collectionView.reloadData()
    }
}
extension CollectionViewFormatViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dbData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath)as! CollectionViewCell
        
        cell.dbNameLbl.text = dbData[indexPath.row].name
        cell.dbDateLbl.text = dbData[indexPath.row].date
        cell.dbImage.image = dbData[indexPath.row].image
        
        return cell
    }
    
    
}
