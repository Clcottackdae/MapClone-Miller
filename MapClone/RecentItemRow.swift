//
//  RecentItemRow.swift
//  MapClone
//
//  Created by DaeSeong on 2022/06/05.
//

import SwiftUI

struct RecentItemRow: View {
    
    var headline : String
    var subHeadline : String
    var body: some View {
        
        HStack{
            
            Circle()
                .frame(width: 30, height: 30)
                
            
            VStack(alignment: .leading){
                HStack{
                Text(headline)
                    .font(.headline)
                
                }
                Text(subHeadline)
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
            }
        }
        .background(.white)
        .cornerRadius(10)
        .frame(minWidth:0, maxWidth: .infinity, alignment:  .leading)
    }
}

struct RecentItemRow_Previews: PreviewProvider {
    static var previews: some View {
        RecentItemRow(headline: "지정된 핀 ", subHeadline: "포항시 지곡동 청암로 근처")
            .previewLayout(.sizeThatFits)
    }
}
