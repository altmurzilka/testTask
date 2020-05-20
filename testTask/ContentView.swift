//
//  ContentView.swift
//  testTask
//
//  Created by алтынпончик on 5/21/20.
//  Copyright © 2020 алтынпончик. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Movie: Identifiable {
    var id : String
    var title : String
    var desc : String
    var date : String
    var image : String
    var rating : Double
}
