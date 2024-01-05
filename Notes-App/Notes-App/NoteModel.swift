//
//  NoteModel.swift
//  Notes-App
//
//  Created by Urvashi Gupta on 04/01/24.
//

import Foundation

struct Note: Decodable{
    
    var _id : String
    var title: String
    var note : String
    var date : String
    
    init(_id: String, title: String, note: String, date: String) {
        self._id = _id
        self.title = title
        self.note = note
        self.date = date
    }
    init(){
        _id = ""
        title = ""
        note = ""
        date = ""
    }
}


