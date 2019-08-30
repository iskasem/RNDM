//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Islam Kasem on 27/08/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    //outlets
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeStampLb: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configureCell(thought : Thought){
        usernameLbl.text = thought.username
        //timeStampLb.text = "\(thought.timeStamp)"
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timestamp = formatter.string(from: thought.timeStamp)
        timeStampLb.text = timestamp
        
      
    }
}
