//
//  ContentView.swift
//  testTask
//
//  Created by алтынпончик on 5/21/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import URLImage

struct ContentView: View {
    @ObservedObject var obs = observer()
    var body: some View {
        ZStack { LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
            NavigationView {
                List(obs.moviesList){i in
                    ListRow(url: i.poster_path, name: i.original_title, rating: i.vote_average, rel_date: i.release_date)
                }
                .navigationBarTitle("News", displayMode: .inline)
            }
        }
    }
}

class observer : ObservableObject {
    
    @Published var moviesList = [Movie]()
    
    init() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=3d19363f85ab4a409c9fb1d53e5b61e3&language=en-US"
        let sess = URLSession(configuration: .default)
        
        sess.dataTask(with: URL(string: url)!) {(data, _, _) in
            do{
                let fetch = try JSONDecoder().decode(MovieList.self, from: data!)
                
                DispatchQueue.main.async {
                    self.moviesList = fetch.results
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct MovieList: Decodable {
    var results : [Movie]
}

struct Movie: Identifiable, Decodable {
    var vote_count: Int
    var id: Int
    var vote_average: CGFloat
    var title: String
    var poster_path: String
    var original_language: String
    var original_title: String
    var adult: Bool
    var overview: String
    var release_date: String
}


struct ListRow : View {
    
    var url = ""
    var name = ""
    var rating : CGFloat = 0
    var overview = ""
    var rel_date = ""
    var body: some View {
        ZStack {
            AnimatedImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(url)"))
                .resizable().frame(width: 370, height: 370)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .aspectRatio(contentMode: .fit)
                .opacity(0.2)
            
            VStack(spacing: 10.0) {
                Text(name)
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                // Text("\(rating, specifier: "%g")")
               // Text(overview).lineLimit(2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
