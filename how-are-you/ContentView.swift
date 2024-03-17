//
//  ContentView.swift
//  how-are-you
//
//  Created by 이상현 on 3/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Hello, Learners!")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                
                HStack {
                    Text("애플 디벨로퍼 아카데미에 오신것을 환영합니다.")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("@POSTECH")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About Apple Developer Academy")
                    .font(.title2)
                Text("애플 아카데미에 대해 더 알아보세요")
            }
            .padding()
            
            Spacer()
        }

    }
}

#Preview {
    ContentView()
}
