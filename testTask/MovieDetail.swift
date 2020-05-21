//
//  MovieDetail.swift
//  testTask
//
//  Created by алтынпончик on 5/21/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetail: View {
    
    var results : [Movie]
    
    var url = ""
    var name = ""
    var rating : CGFloat = 0
    var overview = ""
    var rel_date = ""
    
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
                .resizable().frame(width: 370, height: 370)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .aspectRatio(contentMode: .fit)
            HStack {
                Text("Description").foregroundColor(.gray)
                Spacer()
            }
            Text(overview).lineLimit(nil)
            Spacer()
        }
    }
}


