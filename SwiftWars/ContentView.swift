//
//  ContentView.swift
//  SwiftWars
//
//  Created by Vladislav Prusakov on 21.02.2020.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @Resource(name: "movies") var movies: [Movie]
    @Environment(\.title) var title: String
    @Resource(name: "title") var moviesSectionTitle: String
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {        
        NavigationView {
            VStack {
                List {
                    Section {
                        AvatarField(username: $viewModel.username)
                            .font(.body)
                            .frame(height: 60)
                    }
                    
                    Section(header: Text(moviesSectionTitle)) {
                        ForEach(viewModel.movies) { (movie: Movie) in
                            NavigationLink(destination: Text(movie.title)) {
                                MovieRow(movie: movie)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarItems(trailing: RefreshButton(action: refresh))
            .onAppear { self.viewModel.getAllMovies() }
            .navigationBarTitle(self.title)
        }
    }
    
    func refresh() {
        self.viewModel.getAllMovies()
    }
}

class ViewModel: ObservableObject {
    
    var username: String = ""
    @Published var movies: [Movie] = []
    var task: AnyCancellable?
    
    func getAllMovies() {
        
        self.task = nil
        self.movies = []
        
        self.task = MoviesService.shared.getPopularMovies().sink(receiveCompletion: { completion in
            print(completion)
        }, receiveValue: { movies in
            self.movies = movies
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

struct AvatarField: View {
    
    @Resource(name: "avatar") var logo: Image
    
    @Binding var username: String
    
    var body: some View {
        HStack {
            logo
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            
            TextField("UserName", text: $username)
        }
    }
}

struct MovieRow: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.system(size: 17, weight: .bold))
                
                Text(movie.releaseDate)
                    .font(.system(size: 15, weight: .regular))
            }
            
            Spacer()
            
            Text(String(movie.voteAverage))
                .foregroundColor(movie.voteAverageColor)
                .font(.system(size: 20, weight: .bold))
        }
    }
}
