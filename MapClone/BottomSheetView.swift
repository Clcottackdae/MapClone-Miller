//
//  BottomSheetView.swift
//  MapClone
//
//  Created by DaeSeong on 2022/06/04.
//

import SwiftUI

struct BottomSheetView: View {
    var interval : CGFloat = 100
    @State var searchText  = ""
    @State var offset : CGFloat = 0
    @State var lastOffset : CGFloat = 0
    @State private var lastDragPosition : DragGesture.Value?
    @GestureState var gestureOffset : CGFloat = 0
    var body: some View {
        GeometryReader{ geometryProxy -> AnyView in
            let height = geometryProxy.frame(in: .global).height
            return AnyView(
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(.systemGray6))
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 20))
                    
                    
                    VStack(){
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 40, height: 5)
                            .padding(.top,7)
                        
                        HStack{
                            SearchBar(text: $searchText)
                                .padding(.leading)
                            
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color(.systemGray5))
                                .padding(.trailing)
                        }
                        
                        favoritesView
                        recentItemView
                        guideView
                        
                        
                        Button {
                            
                        } label: {
                            Text("나의 위치 표시")
                                .foregroundColor(Color(.systemBlue))
                                .font(.subheadline)
                                .bold()
                                .frame(minWidth:0, maxWidth: .infinity, minHeight:40)

                        }
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal)

                        Button {
                            
                        } label: {
                            Text("문제 리포트")
                                .foregroundColor(Color(.systemBlue))
                                .font(.subheadline)
                                .bold()
                                .frame(minWidth:0, maxWidth: .infinity, minHeight:40)
                        }
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal)


                        Spacer()
                        
                    }
                    .frame(maxHeight : .infinity, alignment: .top)
                    
                }
                    .offset(y: height - interval)
                    .offset(y: -offset > 0 ? (-offset <= (height - interval) ? offset : -(height - interval)) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                    })
                        .onChanged({ value in
                            lastDragPosition = value
                            print(value)
                        })
                            .onEnded({ value in
                                
                                let timeDiff = value.time.timeIntervalSince(self.lastDragPosition?.time ?? Date())
                                let speed = CGFloat(value.predictedEndLocation.y - value.location.y)  / CGFloat(timeDiff)
                                let maxHeight = height
                                withAnimation {
                                    print(speed)
                                    if -offset > interval && -offset < maxHeight * 0.34  {
                                        offset = -(maxHeight * 0.33)
                                    }
                                    else if -offset > maxHeight * 0.34 {
                                        offset = -(maxHeight * 0.8)
                                    }
                                    else {
                                        offset = 0
                                    }
                                    lastOffset = offset
                                }
                            })
                            )
                
            )
        }
        .ignoresSafeArea(.all, edges: .bottom)
        
        // 바텀시트 변경함수
    }
    func onChange(){
        DispatchQueue.main.async {
            offset = gestureOffset + lastOffset
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView()
    }
}


extension BottomSheetView {
    var favoritesView : some View {
        
        VStack{
            
            HStack {
                Text("즐겨찾기")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
                    .bold()
                
                Spacer()
                
                Text("자세히")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemBlue))
                
            }
            .padding(.horizontal)
            
            
            ZStack{
                
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 130)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                
                HStack(spacing : 20){
                    
                    
                    VStack{
                        ZStack{
                            Circle()
                                .foregroundColor(Color(.systemGray5))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "house.fill")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color(.systemBlue))
                            
                        }
                        
                        Text("집")
                            .font(.subheadline)
                        
                        Text("추가")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                    }
                    
                    
                    VStack{
                        ZStack{
                            Circle()
                                .foregroundColor(Color(.systemGray5))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "briefcase.fill")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color(.systemBlue))
                            
                        }
                        
                        Text("직장")
                            .font(.subheadline)
                        
                        
                        Text("추가")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack{
                        ZStack{
                            Circle()
                                .foregroundColor(Color(.systemGray5))
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "plus")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color(.systemBlue))
                            
                        }
                        
                        Text("추가")
                            .font(.subheadline)
                        Text("")
                        
                    }
                    
                    Spacer()
                }.padding(.horizontal,30)
            }                .padding(.bottom)
            
        }
        
    }
    
    var recentItemView : some View {
        VStack(alignment: .leading){
            HStack {
                Text("최근 항목")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
                    .bold()
                
                Spacer()
                
                Text("자세히")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemBlue))
                
            }
            .padding(.horizontal)
            
            
            
            List{
                Section{
                    RecentItemRow(headline: "지정된 핀",
                                  subHeadline: "포항시 지곡동 청암로 근처")
                    
                    RecentItemRow(headline: "포항공과대학교 학생회관",
                                  subHeadline: "포항시  청암로 77")
                    RecentItemRow(headline: "천주교서울대교구주교좌명동대성당",
                                  subHeadline: "아셈타워에서 가는 경로")
                }
            }
           
            .listStyle(.insetGrouped)
            .cornerRadius(10)
            .environment(\.defaultMinListRowHeight, 70)
            .frame(height : 210)
            .onAppear {
                UITableView.appearance().contentInset.top = -35 // 이 방법말고는,,?
                
            }
            .disabled(true)
            .padding(.bottom)
            
        }
    }
    
    var guideView : some View {
        VStack(alignment: .leading){
            HStack {
                Text("나의 가이드")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
                    .bold()
                
                Spacer()
                
            
                
            }
            .padding(.horizontal)
        ZStack{
            Rectangle()
                .frame(height : 70)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            HStack{
            Image(systemName: "plus")
                .frame(width: 45, height: 45)
                .foregroundColor(Color(.systemBlue))
                .background(Color(.systemGray5))
                .cornerRadius(10)
                
                Text("새로운 가이드")
                    .font(.headline)
                    .foregroundColor(Color(.systemBlue))
                
                
                Spacer()
            }
            .padding()

            }
        .padding(.horizontal)
    }
    }
}
