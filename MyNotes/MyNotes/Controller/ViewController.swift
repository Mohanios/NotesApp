//
//  ViewController.swift
//  MyNotes
//
//  Created by Mohanraj on 31/03/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource = DatabaseViewModel()

    var tittleData : [String]? = []
    var messageData : [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.delegate = self
      tableView.delegate = self
      tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        retriveData()
      
    }
    @IBAction func addButtonClicked(_ sender: Any) {
        let addVc = (self.storyboard?.instantiateViewController(identifier: "AddDetailsViewController"))! as AddDetailsViewController
        self.navigationController?.pushViewController(addVc, animated: true)
    }
    func retriveData()
    {
        tittleData?.removeAll()
        messageData?.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyNotes")
        request.returnsObjectsAsFaults = false
        do{
            let result = try managedContext.fetch(request)
            let count  = try managedContext.count(for: request)
             if count > 0
            {
                for data in result as! [NSManagedObject]
                {
                  
                    tittleData?.append(data.value(forKey: "title") as? String ?? "")
                    messageData?.append(data.value(forKey: "content") as? String ?? "")
                }
                tableView.reloadData()
            }
            else
            {
                tableView.reloadData()
                print("error")
            }
        }
        catch {
            print("fail")
        }
    }
    @objc func deleteClicked(sender : UIButton){
        dataSource.deleteOnTodoValue(tittle:tittleData?[sender.tag] ?? "" , content : messageData?[sender.tag] ?? "")
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tittleData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNotesTableViewCell", for: indexPath) as! MyNotesTableViewCell
        cell.selectionStyle = .none
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteClicked(sender:)), for: .touchUpInside)
        cell.tittleLabel.text = tittleData?[indexPath.row]
        cell.contentLabel.text = messageData?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addVc = (self.storyboard?.instantiateViewController(identifier: "AddDetailsViewController"))! as AddDetailsViewController
        addVc.getTittleValue = tittleData?[indexPath.row] ?? ""
        addVc.contentValue = messageData?[indexPath.row] ?? ""
        self.navigationController?.pushViewController(addVc, animated: true)
    }
    
}

extension ViewController : databaseHandlerDelegate {
    func didGetDeleteData(data: String) {
        retriveData()
        displayAlertMessage(parentView: self, title: "Message", message: data) { UIAlertAction in
                  self.navigationController?.popViewController(animated: true)
      
              }
    }
    func didFailWithError(error: String) {
        displayAlertMessage(parentView: self, title: "Message", message: error) { UIAlertAction in

        }
    }
    
    
}

