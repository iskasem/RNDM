//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Islam Kasem on 24/08/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController ,UITextViewDelegate {
//outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var usernameTxt: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    // Variables
    private var selectedCategory  = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.lightGray
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
    ///43trete
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1 :
            selectedCategory = ThoughtCategory.serious.rawValue
        case 2 :
           selectedCategory = ThoughtCategory.creazy.rawValue
        case 3 :
            selectedCategory = ThoughtCategory.popular.rawValue
        default:
             selectedCategory = ThoughtCategory.funny.rawValue
        }
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        guard let username = usernameTxt.text else {
            return
        }
        Firestore.firestore().collection(THOUGHT_REF).addDocument(data: [
            CATEGORY : selectedCategory,
           NUM_COMMENTS : 0 ,
           NUM_LIKES  : 0 ,
           THOUGHT_TXT : thoughtTxt.text!,
           TIME_STAMP : FieldValue.serverTimestamp(),
           USERNAME : username
                             ]) { (err) in
            if let err = err {
                debugPrint("error adding document\(err)")
            }else{
                self.navigationController?.popViewController(animated: true )
            }
                             
        }
    }
    
   
}
