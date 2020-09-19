//
//  StringExtension.swift
//  MovieAppTestTask
//
//  Created by Алтын on 9/19/20.
//

import Foundation

extension String{
    
    func formatedDate() -> String{
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "ru-RU")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
}
