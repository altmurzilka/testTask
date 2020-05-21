//
//  ContentView.swift
//  testTask
//
//  Created by алтынпончик on 5/21/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject var obs = observer()
    var body: some View {
        ZStack { LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
            NavigationView {
                List(obs.moviesList){i in
                    ListRow(url: i.poster_path, name: i.original_title, rating: i.vote_average, overview: i.overview)
                }
                .navigationBarTitle("News")
            }
        }
    }
}

class observer : ObservableObject {
    
    @Published var moviesList = [dataType2]()
    
    init() {
        let url = "https://api.themoviedb.org/3/movie/top_rated?api_key=3d19363f85ab4a409c9fb1d53e5b61e3&language=en-US&page=1"
        let sess = URLSession(configuration: .default)
        
        sess.dataTask(with: URL(string: url)!) {(data, _, _) in
            do{
                let fetch = try JSONDecoder().decode(dataType.self, from: data!)
                
                DispatchQueue.main.async {
                    self.moviesList = fetch.results
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct dataType: Decodable {
    var results : [dataType2]
}

struct dataType2: Identifiable, Decodable {
    var id : Int
    var original_title: String
    var vote_average: CGFloat
    var poster_path: String
    var overview: String
}


struct ListRow : View {
    
    var url = ""
    var name = ""
    var rating : CGFloat = 0
    var overview = ""
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
                .padding()
                // Text("Rating = \(rating, specifier: "%g")")
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
