//
//  AddListViewController.swift
//  TodoData
//
//  Created by Droadmin on 12/12/23.
//

import UIKit
protocol RealoadData : AnyObject {
    func fatchData()
}
class AddListViewController: UIViewController {
    var date:String? = nil
    @IBOutlet weak var selectedImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var nameTxt: UITextField!
    weak var realoadData: RealoadData?

    override func viewDidLoad() {
        super.viewDidLoad()
        DBManager.dbManager.createDatabase()
        DBManager.dbManager.createTable()
        self.title = "ToDo Add List"

    }
    func showAlert(with title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func submitBtn(_ sender: UIButton) {
        let alertMsg = self.nameTxt.text?.count == 0 ? "Please enter name" : descriptionTxt.text?.count == 0 ? "Please enter description" : self.date?.count == 0 ? "Please Selecte Date" : ""
        if alertMsg.count > 0 {
            self.showAlert(with: "", message: alertMsg)
        }else {
            DBManager.dbManager.insert(name: nameTxt.text ?? "", description: descriptionTxt.text ?? "", image: selectedImg.image, date: self.date ?? "")
            self.showAlert(with: "Success", message: "Record inserted success fully" , completion: {
                self.realoadData?.fatchData()
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}
//MARK: - Selected Image Display
extension AddListViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBAction func selectPhotoBtn(_ sender: UIButton) {
        let alertControl = UIAlertController(title: "Select Image", message: "Select Image From", preferredStyle: .actionSheet)
        let camaraBtn = UIAlertAction(title: "Camera", style: .default){(_)in
            self.showImagePicker(selectedSource: .camera)
        }
        let gallaryBtn = UIAlertAction(title: "Gallary", style: .default){(_)in
            self.showImagePicker(selectedSource: .photoLibrary)
        }
        let canselBtn = UIAlertAction(title: "Cancle", style: .cancel,handler:  nil)
        alertControl.addAction(camaraBtn)
        alertControl.addAction(gallaryBtn)
        alertControl.addAction(canselBtn)
        alertControl.popoverPresentationController?.sourceView = self.view
        alertControl.popoverPresentationController?.permittedArrowDirections = []
        self.present(alertControl,animated: true)
    }
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource)else{
            print("Selected Source not availabel")
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = selectedSource
        imagePicker.allowsEditing = false
        self.present(imagePicker,animated: true)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage]as? UIImage{
            selectedImg.image = selectedImage
        }else{
            print("Image not found")
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
