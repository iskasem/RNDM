//
//  Thought.swift
//  RNDM
//
//  Created by Islam Kasem on 26/08/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import Foundation
class Thought {
    private(set) var username :String!
    private(set) var timeStamp :Date!
    private(set) var thoughtTxt :String!
    private(set) var numComments :Int!
    private(set) var numLikes :Int!
    private(set) var documentId :String!
    
    init(username: String , timeStamp :Date ,thoughtTxt : String , numComments : Int , numLikes :Int , documentId :String ){
        self.username = username
        self.timeStamp = timeStamp
        self.numLikes = numLikes
        self.numComments = numComments
        self.thoughtTxt = thoughtTxt
        self.documentId = documentId
    }
}
