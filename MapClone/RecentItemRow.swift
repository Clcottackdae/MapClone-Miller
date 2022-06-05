//
//  RecentItemRow.swift
//  MapClone
//
//  Created by DaeSeong on 2022/06/05.
//

import SwiftUI

struct RecentItemRow: View,Hashable {
    static var sampleData = [  RecentItemRow(headline: "지정된 핀",
                                             subHeadline: "포항시 지곡동 청암로 근처"),
                               
                               RecentItemRow(headline: "포항공과대학교 학생회관",
                                             subHeadline: "포항시  청암로 77"),
                               RecentItemRow(headline: "천주교서울대교구주교좌명동대성당",
                                             subHeadline: "아셈타워에서 가는 경로")]
    
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
