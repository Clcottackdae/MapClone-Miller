//
//  ContentView.swift
//  MapClone
//
//  Created by DaeSeong on 2022/06/04.
//

import SwiftUI
import MapKit

struct ContentView: View {
   
    @State var text : String = ""
    var body: some View {
     
        ZStack{
        MapView()
            .ignoresSafeArea()

        BottomSheetView()
                .searchable(text: $text)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
