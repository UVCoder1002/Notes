//
//  NetworkService.swift
//  Notes-App
//
//  Created by Urvashi Gupta on 04/01/24.
//

import Foundation
import Alamofire

class NetworkService{
    
    var delegate : DataDelegate?
     static let functions = NetworkService()
    
     func fetchNotes(){
        AF.request("http://192.168.1.5:8081/fetch").response { response in
            
            if let data = response.data{
                let newData = String(data: data, encoding: .utf8)
                print("new Data: \(newData)")
                self.delegate?.updateNote(newArray: newData!)
            }
        }
    }
    
    func addNote(date: String,title: String,note: String){
        AF.request("http://192.168.1.5:8081/create",method: .post,encoding: URLEncoding.httpBody,headers: ["title": title,"date": date,"note" : note]).responseDecodable(of: String.self){ response in
            
        }
    }
    func updateNote(date: String,title: String,note: String,id:String){
        AF.request("http://192.168.1.5:8081/update",method: .post,encoding: URLEncoding.httpBody,headers: ["title": title,"date": date,"note" : note,"id": id]).responseDecodable(of: String.self){ response in
            
        }
    }
    
    func deleteNote(id:String){
        AF.request("http://192.168.1.5:8081/delete",method: .post,encoding: URLEncoding.httpBody,headers: ["id": id]).responseDecodable(of: String.self){ response in
            
        }
    }
    
}
