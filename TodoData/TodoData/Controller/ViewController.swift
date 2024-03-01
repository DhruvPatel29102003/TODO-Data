//
//  ViewController.swift
//  TodoData
//
//  Created by Droadmin on 11/12/23.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()

    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var addListBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFirstDefualtView()
        createDatePicker()

        // Do any additional setup after loading the view.
    }
    func loadFirstDefualtView(){
        let tableViewDataVc = UIStoryboard(name: "TableviewFormat", bundle: nil).instantiateViewController(withIdentifier: "TableViewFormatViewController") as! TableViewFormatViewController
        addChild(tableViewDataVc)
        tableViewDataVc.view.frame = containerView.bounds
        containerView.addSubview(tableViewDataVc.view)
        containerView.bringSubviewToFront(addListBtn)
        tableViewDataVc.didMove(toParent: self)
    }
    
    @IBAction func popeverBtn(_ sender: UIButton) {
        if let popoverContentViewController = UIStoryboard(name: "Popover", bundle: nil).instantiateViewController(withIdentifier: "PopoverViewController") as? PopoverViewController {
            popoverContentViewController.modalPresentationStyle = .popover
            let popoverController = popoverContentViewController.popoverPresentationController
            popoverController?.sourceView = sender
            popoverController?.sourceRect = sender.bounds
            popoverController?.delegate = self
            popoverController?.permittedArrowDirections = .up
            popoverContentViewController.preferredContentSize = CGSize(width: 200, height: 140)
            popoverContentViewController.tableviewAndCollectionViewBtnDelegate = self
            self.present(popoverContentViewController, animated: true)
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    // MARK: - Open Date Picker
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        dateTxt.inputAccessoryView = toolbar
        dateTxt.inputView = datePicker
        datePicker.datePickerMode = .date
        dateFormatter.dateStyle = .medium
        dateTxt.text = dateFormatter.string(from: Date())
    
        
        if #available(iOS 13.2, *) {
            datePicker.preferredDatePickerStyle = .inline // Wheels,Compact
        }


    }
    @objc func donePressed(){
        dateFormatter.dateStyle = .medium
        let selectedDate = dateFormatter.string(from: datePicker.date)
        dateTxt.text = selectedDate
        self.view.endEditing(true)
        updateTableViewDataForSelectedDate(selectedDate: selectedDate)

        
    }
    func updateTableViewDataForSelectedDate(selectedDate: String) {
        guard let tableViewFormatVC = children.first as? TableViewFormatViewController else {
            return
        }
        tableViewFormatVC.updateDataForSelectedDate(selectedDate: selectedDate)
               
    }


    
    // MARK: - Navigate Another View

    @IBAction func addToDoListBtn(_ sender: UIButton) {
        let addListVc = UIStoryboard(name: "AddList", bundle: nil).instantiateViewController(withIdentifier: "AddListViewController")as! AddListViewController
        addListVc.date = dateTxt.text
        self.navigationController?.pushViewController(addListVc, animated: true)
    }
    
}


// MARK: - TableView Button Delegate

extension ViewController : TableViewButtonDelegate {
    func collectionViewBtn(sender: UIButton) {
        let tableViewDataVc = UIStoryboard(name: "TableviewFormat", bundle: nil).instantiateViewController(withIdentifier: "TableViewFormatViewController")as! TableViewFormatViewController
        let collectionViewVC = UIStoryboard(name: "CollectionViewFormatData", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewFormatViewController")as! CollectionViewFormatViewController
        tableViewDataVc.view.removeFromSuperview()
        collectionViewVC.willMove(toParent: self)
        collectionViewVC.view.frame = containerView.bounds
        containerView.addSubview(collectionViewVC.view)
        containerView.bringSubviewToFront(addListBtn)

        addChild(collectionViewVC)
        collectionViewVC.didMove(toParent: self)
    }
    
    func tableviewBtn(sender: UIButton) {
        let tableViewDataVc = UIStoryboard(name: "TableviewFormat", bundle: nil).instantiateViewController(withIdentifier: "TableViewFormatViewController")as! TableViewFormatViewController
        let collectionViewVC = UIStoryboard(name: "CollectionViewFormatData", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewFormatViewController")as! CollectionViewFormatViewController
        //tableViewDataVc.view.removeFromSuperview()
        collectionViewVC.view.removeFromSuperview()
        tableViewDataVc.willMove(toParent: self)
        tableViewDataVc.view.frame = containerView.bounds
        containerView.addSubview(tableViewDataVc.view)
        containerView.bringSubviewToFront(addListBtn)

        addChild(tableViewDataVc)
        tableViewDataVc.didMove(toParent: self)
    }
    
    
}


