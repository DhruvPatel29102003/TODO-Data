//
//  PopoverViewController.swift
//  TodoData
//
//  Created by Droadmin on 11/12/23.
//

import UIKit
protocol TableViewButtonDelegate:AnyObject{
    func tableviewBtn(sender: UIButton)
    func collectionViewBtn(sender: UIButton)
}

class PopoverViewController: UIViewController {

    @IBOutlet weak var collectionViewBtn: UIButton!
    @IBOutlet weak var tableViewBtn: UIButton!
    weak var tableviewAndCollectionViewBtnDelegate: TableViewButtonDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickBtn(_ sender: UIButton) {
        if sender == tableViewBtn {
            tableviewAndCollectionViewBtnDelegate?.tableviewBtn(sender: sender)
            self.dismiss(animated: true)
        }else if sender == collectionViewBtn {
            tableviewAndCollectionViewBtnDelegate?.collectionViewBtn(sender: sender)
            self.dismiss(animated: true)
        }
    }
    
    

}
