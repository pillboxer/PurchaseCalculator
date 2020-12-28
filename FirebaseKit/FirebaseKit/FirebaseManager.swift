//
//  FirebaseManager.swift
//  FirebaseKit
//
//  Created by Henry Cooper on 16/12/2020.
//
import Firebase
import FirebaseDatabase
import Combine

public class FirebaseManager: ObservableObject {
    
    public static let shared = FirebaseManager()
    
    lazy var databaseReference: DatabaseReference = {
        Database.database().reference()
    }()
    
    init() {
        FirebaseApp.configure()
    }

    public func listenTo(_ child: String, retrievedDataHandler: @escaping (Data?) -> Void) {
        databaseReference.child(child).observe(.value) { (snapshot) in
            let data = self.getJSONData(from: snapshot)
            retrievedDataHandler(data)
        }
    }
    
    public func getJSONData(from snapshot: DataSnapshot) -> Data? {
        if let value = snapshot.value {
            return try? JSONSerialization.data(withJSONObject: value, options: [])
        }
        return nil
    }
    
    public func addToChild(_ string: String, values: [String : Any], completion: @escaping (Bool) -> Void) {
        databaseReference.child(string).childByAutoId().setValue(values) { (error, _) in
            completion(error == nil)
        }
    }
    
    public func addValue(_ string: String, to child: String, of parent: String, with key: String, completion: @escaping (Bool) -> Void) {
        databaseReference.child(parent).child(key).child(child).childByAutoId().setValue(string) { (error, _) in
            completion(error == nil)
        }
    }
    
    public func updateValue(of child: String, with parent: String, parentKey: String, to value: String, completion: @escaping (Bool) -> Void) {
        databaseReference.child(parent).child(parentKey).updateChildValues([child : value]) { (error, _) in
            completion(error == nil)
        }
    }
    
    public func getChild(_ string: String?, retrievedSnapshotHandler: @escaping (DataSnapshot) -> Void) {
        if let string = string {
            databaseReference.child(string).observeSingleEvent(of: .value) { (snapshot) in
                retrievedSnapshotHandler(snapshot)
            }
        }
        else {
            databaseReference.observe(.value) { (snapshot) in
                retrievedSnapshotHandler(snapshot)
            }
        }
    }
}
