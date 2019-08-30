//
//  ViewController.swift
//  RNDM
//
//  Created by Islam Kasem on 24/08/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit
import Firebase

enum ThoughtCategory :String {
    case serious = "serious"
    case funny = "funny"
    case creazy = "crazy"
    case popular = "popular"
}

class MainVC: UIViewController ,UITableViewDataSource , UITableViewDelegate{
 
    
//outlets
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    @IBAction func categoryChanged(_ sender: Any) {
   
        switch segmentControl.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1 :
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2 :
           selectedCategory = ThoughtCategory.creazy.rawValue
            
        default:
            selectedCategory = ThoughtCategory.popular.rawValue
        }
        thoughtsListerner.remove()
        setListner()
    }
    
    //variables
    private var thoughts = [Thought]()
    private var thoughtsCollectionRef : CollectionReference!
    private var thoughtsListerner : ListenerRegistration!
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        thoughtsCollectionRef = Firestore.firestore().collection(THOUGHT_REF)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
setListner()
 
    }
    
    func setListner (){
        if selectedCategory == ThoughtCategory.popular.rawValue{
            thoughtsListerner = thoughtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory).order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching Docs\(err)")
                    }else{
                        self.thoughts.removeAll()
                        guard let snap = snapshot else {return}
                        for document in snap.documents{
                            let data = document.data()
                            let username = data[USERNAME] as? String ?? "Anonymous"
                            let timestamp = data[TIME_STAMP] as? Date ?? Date()
                            let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
                            let numLikes = data[NUM_LIKES] as? Int ?? 0
                            let numComments = data[NUM_COMMENTS] as? Int ?? 0
                            let documentId = document.documentID
    
                            let newThought = Thought(username: username, timeStamp: timestamp, thoughtTxt: thoughtTxt, numComments: numComments, numLikes: numLikes, documentId: documentId)
                            self.thoughts.append(newThought)
                            
                        }
                        self.tableView.reloadData()
                    }
            }
        }else{
            thoughtsListerner = thoughtsCollectionRef.whereField(CATEGORY, isEqualTo: selectedCategory).order(by: TIME_STAMP, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let err = error {
                        debugPrint("Error fetching Docs\(err)")
                    }else{
                        self.thoughts.removeAll()
                        guard let snap = snapshot else {return}
                        for document in snap.documents{
                            let data = document.data()
                            let username = data[USERNAME] as? String ?? "Anonymous"
                            let timestamp = data[TIME_STAMP] as? Date ?? Date()
                            let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
                            let numLikes = data[NUM_LIKES] as? Int ?? 0
                            let numComments = data[NUM_COMMENTS] as? Int ?? 0
                            let documentId = document.documentID
                            
                            let newThought = Thought(username: username, timeStamp: timestamp, thoughtTxt: thoughtTxt, numComments: numComments, numLikes: numLikes, documentId: documentId)
                            self.thoughts.append(newThought)
                            print("this is the new thought_Date \(newThought.timeStamp!)")
                            
                        }
                        self.tableView.reloadData()
                    }
            }
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
         thoughtsListerner.remove()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath) as? ThoughtCell
        {
            cell.configureCell (thought: thoughts[indexPath.row])
            return cell
        }else {
            return UITableViewCell()
        }
    }
}

