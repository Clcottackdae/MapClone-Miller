//
//  SearchBar.swift
//  MapClone
//
//  Created by DaeSeong on 2022/06/05.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack{
            TextField("지도 검색", text: $text)
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .overlay(HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth:0, maxWidth: .infinity, alignment:  .leading) // maxWidth는 부모뷰의
                        .padding(.leading,8)
                    
                })
        }    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)    }
}
