//
//  AddDetailsViewController.swift
//  MyNotes
//
//  Created by Mohanraj on 31/03/23.
//

import UIKit

class AddDetailsViewController:UIViewController {
  @IBOutlet weak var editBtn: UIButton!
  @IBOutlet weak var tittleTxtFld: UITextField!
  @IBOutlet weak var contentTxtFld: UITextView!
  @IBOutlet weak var deleteBtn: UIButton!
  
  @IBOutlet weak var saveLbl: UILabel!
  var getTittleValue = ""
  var contentValue = ""
  var dataSource = DatabaseViewModel()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      dataSource.delegate = self
    prepareViews()
  }
  
  private func prepareViews(){
      tittleTxtFld.delegate = self
      contentTxtFld.delegate = self
      if getTittleValue == "" && contentValue == ""{
          saveLbl.text = "Save"
      }else{
          saveLbl.text = "Update"
          tittleTxtFld.text = getTittleValue
      contentTxtFld.text = contentValue
      }
  }
  @IBAction func editClicked(_ sender: Any) {
      tittleTxtFld.isUserInteractionEnabled = true
      contentTxtFld.isUserInteractionEnabled = true
  }
  @IBAction func saveClicked(_ sender: Any) {
      if getTittleValue == "" && contentValue == ""{
          if tittleTxtFld.text?.count == 0 && contentTxtFld.text.count == 0{
              displayAlertMessage(parentView: self, title: "Message", message: "Please note anything") { UIAlertAction in

              }
              return
          }
          dataSource.createDatabase(tittle: tittleTxtFld.text ?? "", Content: contentTxtFld.text)
      }else{
          dataSource.editTodoValue(tittle : getTittleValue , content : contentValue , setTittleValue: tittleTxtFld.text ?? "", setContentValue : contentTxtFld.text ?? "")
          
      }
  }
  
  @IBAction func deleteClicked(_ sender: Any) {
      dataSource.deleteOnTodoValue(tittle:getTittleValue , content : contentValue)
  }
  
  @IBAction func cancelClicked(_ sender: Any) {
      navigationController?.popViewController(animated: true)
  }
  @IBAction func backClicked(_ sender: Any) {
      navigationController?.popViewController(animated: true)
  }


}
extension AddDetailsViewController :  databaseHandlerDelegate{
  func didEditDataValue(data: String) {
      displayAlertMessage(parentView: self, title: "Message", message: data) { UIAlertAction in
          self.navigationController?.popViewController(animated: true)

      }
  }
  
  
  func didCreateNewValue(data: String) {
      displayAlertMessage(parentView: self, title: "Message", message: data) { UIAlertAction in
          self.navigationController?.popViewController(animated: true)

      }
  }
  
  func didFailWithError(error: String) {
      displayAlertMessage(parentView: self, title: "Message", message: error) { UIAlertAction in
          self.navigationController?.popViewController(animated: true)

      }
  }
  
  
}
extension AddDetailsViewController : UITextFieldDelegate,UITextViewDelegate{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
      textField.resignFirstResponder()
      view.endEditing(true)
  }
  func textViewDidEndEditing(_ textView: UITextView) {
      textView.resignFirstResponder()
      view.endEditing(true)
  }
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
      if (text == "\n") {
          textView.resignFirstResponder()
      }
      return true
  }}
