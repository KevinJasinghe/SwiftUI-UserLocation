//
//  ContentView.swift
//  SwiftUI-UserLocation
//
//  Created by Kevin Jasinghe on 2022-04-03.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @State private var viewModel = MapViewModel()
   
    
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

