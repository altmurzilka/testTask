//
//  MovieDetails.swift
//  testTask
//
//  Created by алтынпончик on 5/23/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetails : View {
    
    var movie: Movie
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)"))
            HStack {
                Text("Description").foregroundColor(.gray)
                Spacer()
            }
            Text(movie.overview).lineLimit(nil)
            Spacer()
        }.navigationBarTitle(Text(movie.original_title), displayMode: .inline)
            .padding()
    }
}
