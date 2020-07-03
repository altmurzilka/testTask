//
//  ContentView.swift
//  testTask
//
//  Created by алтынпончик on 5/21/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI
import URLImage
import SwiftyJSON
import SDWebImageSwiftUI
import Combine


struct ContentView: View {
    @ObservedObject var obs = observer()
    var body: some View {
        ZStack { LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            NavigationView {
                List(obs.moviesList){i in
                    NavigationLink(destination: MovieDetails(movie: i)){
                        ListRow(url: i.poster_path, name: i.original_title, rating: i.vote_average, overview: i.overview)
                    }.padding(.trailing, -32.0)
                }
                .navigationBarTitle("News", displayMode: .inline)
            }
        }
    }
}

class observer : ObservableObject {
    
    @Published var moviesList = [Movie]()
    
    var pageStatus = PageStatus.ready(nextPage: 1)
    
    let sourse = "https://api.themoviedb.org/3/movie/popular?api_key=3d19363f85ab4a409c9fb1d53e5b61e3&language=en-US&page="
    @Published var endOfList = false
    var cancellable : Set<AnyCancellable> = Set()
    
    init() {
        fetchData()
    }
    
    func shouldLoadMore(i : Movie) -> Bool{
        if let lastId = moviesList.last?.id{
            if i.id == lastId{
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    func fetchData() {
        guard case let .ready(page) = pageStatus else {
            return
        }
        pageStatus = .loading(page: page)
        
        URLSession.shared.dataTaskPublisher(for: URL(string: "\(sourse)\(page)")!).tryMap { output in
            guard let _ = output.response as? HTTPURLResponse else {
                throw MyError.httpError
            }
            return output.data
        }
        .decode(type: MovieList.self, decoder: JSONDecoder())
        .replaceError(with: MovieList(page: Int, results: []))
        .eraseToAnyPublisher()
        
        
        
        
        try JSONDecoder().decode(MovieList.self, from: data!)
        
        DispatchQueue.main.async {
            self.moviesList = fetch.results
        }
    } catch {
    print(error.localizedDescription)
    }
}.resume()
}
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
                    .padding()
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

enum MyError: Error {
    case limitError
    case httpError
    case parseError
}

enum PageStatus {
    case ready (nextPage: Int)
    case loading (page: Int)
    case done
}


