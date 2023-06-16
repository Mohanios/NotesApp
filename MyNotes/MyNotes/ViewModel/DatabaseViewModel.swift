//
//  DatabaseViewModel.swift
//  MyNotes
//
//  Created by Mohanraj on 31/03/23.
//

import UIKit
import CoreData
import Foundation

@objc protocol databaseHandlerDelegate: class {
    @objc optional func didCreateNewValue(data :String)
    @objc optional func didGetDeleteData(data: String)
    @objc optional func didEditDataValue(data : String)
    @objc optional func didReciveAllData()
    func didFailWithError(error: String)
}

class DatabaseViewModel: NSObject {
    weak var delegate: databaseHandlerDelegate?
    
    func createDatabase(tittle : String , Content : String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "MyNotes", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        user.setValue(tittle, forKey: "title")
        user.setValue(Content, forKey: "content")
        do {
           try managedContext.save()
            delegate?.didCreateNewValue!(data : "Value stored sucessfully")
        } catch let error as NSError {
            delegate?.didFailWithError(error: "not save \(error), \(error.userInfo)")
            print("not save \(error), \(error.userInfo)")
        }
    }
    func deleteOnTodoValue(tittle : String , content : String)
    {
        guard let appDelegate =
               UIApplication.shared.delegate as? AppDelegate else {
               return
             }
             let managedContext =
               appDelegate.persistentContainer.viewContext
        let moc = managedContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyNotes")

            let result = try? moc.fetch(fetchRequest)
               let resultData = result as! [MyNotes]
               for object in resultData {
                 if tittle == object.title && content == object.content{
                    moc.delete(object)
                    do {
                        try moc.save()
                        print("Delete!")
                        delegate?.didGetDeleteData!(data: "Value Deleted sucessfully")
                    } catch let error as NSError  {
                        delegate?.didFailWithError(error: "not save \(error), \(error.userInfo)")
                        print("Could not save \(error), \(error.userInfo)")
                    } catch {

                    }
                    return
                  
                }
               }
    }
    
    func editTodoValue(tittle : String , content : String , setTittleValue: String , setContentValue : String){
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyNotes")
           let result = try? managedObjectContext.fetch(fetchRequest)
           let resultData = result as! [MyNotes]
           for object in resultData {
            print(object.title!)
            print(object.content)
            if object.title == tittle && object.content == content{
                 object.setValue(setTittleValue, forKey: "title")
                object.setValue(setContentValue, forKey: "content")
                do {
                    try managedObjectContext.save()
                    delegate?.didEditDataValue!(data : "Value updated SucessFuly")
                    print("saved!")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                    delegate?.didFailWithError(error: "not save \(error), \(error.userInfo)")
                }
                return
            }else{
                print("fail")
            }
           }
    }
}
