//
//  DBManage.swift
//  TodoData
//
//  Created by Droadmin on 12/12/23.
//

import Foundation
import SQLite3
import UIKit

class DBManager {
    static let dbManager = DBManager()
    
    var db:OpaquePointer?
    
    private init(){}
    func createDatabase() -> OpaquePointer?{
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Database.db")
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Database connection opened successfully \(fileURL)")
            return db
        } else {
            print("Failed to open database connection")
            return nil
        }
    }
    func createTable(){
        let tableQuery = "CREATE TABLE IF NOT EXISTS TodoList(Id INTEGER PRIMARY KEY,name TEXT,description TEXT,image BLOB,date TEXT);"
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, tableQuery, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("student table created")
            }else{
                print("student table not created")
            }
            sqlite3_finalize(statement)
        } else{
            print("could not prepared")
        }
   
    }
    func insert (name:String,description:String,image:UIImage?,date:String){
        // image ni binary data store karava mate
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        let imageData = image?.jpegData(compressionQuality: 1.0)
        let insertData = "INSERT INTO TodoList (name,description,image,date)VALUES(?, ?, ?, ?);"
        var statement: OpaquePointer?
        //-1 length indicate kare 6e jethi query ni length automatic tarike se calulate ho
        if sqlite3_prepare_v2(db, insertData, -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (description as NSString).utf8String, -1, nil)

            sqlite3_bind_blob(statement, 3, (imageData as NSData?)?.bytes, Int32(imageData?.count ?? 0), SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, (date as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data inserted successfully.")
            } else {
                print("Failed to insert data into the database.")
            }
            
            let status = sqlite3_finalize(statement)
            print("Staus: \(status)")
        } else {
            print("Error preparing statement for insertion: \(String(cString: sqlite3_errmsg(db)))")
        }
    }
    func readData() -> [ReadData] {
        var data: [ReadData] = []
        data.removeAll()
        let query = "SELECT * FROM TodoList"
        
        DBManager.dbManager.createDatabase()
        
        var statement: OpaquePointer? // SQLite Query execute karne ke liye istmal hota hai
        
        if sqlite3_prepare_v2(DBManager.dbManager.db, query, -1, &statement, nil) == SQLITE_OK {
            // sqlite3_step function ek row ko fetch karne ke liye istemal hota hai.
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let description = String(cString: sqlite3_column_text(statement, 2))
                let date = String(cString: sqlite3_column_text(statement, 4))
               
                
                if let Pointer = sqlite3_column_blob(statement, 3){
                    let Size = sqlite3_column_bytes(statement, 3)// image data ka size fatch karake size variable me store kar dena
                    let image = Data(bytes: Pointer , count: Int(Size))// mili hui image ko data me convert karne ke liye use hua he
                    if let image = UIImage(data: image){
                        let todoData = ReadData(id: id, name: name, description: description,image: image, date: date )
                        data.append(todoData)
                        
                        print("Fetched data - id: \(id), Name: \(name), Description: \(description), Image: \(image),Date: \(date)")
                    }
                }else{
                    print("not fatch image")
                }
                
            }
            sqlite3_finalize(statement)
            
        } else {
            print("Failed to prepare query")
        }
             
       return data
    }
    
    
}
