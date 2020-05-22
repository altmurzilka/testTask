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
                .resizable().frame(width: 370, height: 370)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .aspectRatio(contentMode: .fit)
            HStack {
                Text("\(movie.original_title)").foregroundColor(.gray)
                Spacer()
                Text("\(movie.release_date)").foregroundColor(.gray)
            }
            HStack {
                Text("Description").foregroundColor(.gray).padding(.vertical, 10)
                Spacer()
            }
            Text(movie.overview).lineLimit(nil)
            Spacer()
            HStack {
                Spacer()
                Text("Rating: \(movie.vote_average, specifier: "%g")").font(.headline)
            }
        }.navigationBarTitle(Text(movie.original_title), displayMode: .inline)
            .padding()
    }
}
