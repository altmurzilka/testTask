//
//  WebResponse.swift
//  MovieAppTestTask
//
//  Created by Алтын on 9/19/20.
//

import Foundation

final class WebResponse{
    
    var json : [String:Any]?
    var error : Error?
    var isError : Bool{
        return error != nil
    }
    var messageError : String{
        guard let error = error else { return "Error"}
        return error.localizedDescription
    }
    
    convenience init(json : [String:Any]?, error : Error?) {
        self.init()
        self.json = json
        self.error = error
    }
}
