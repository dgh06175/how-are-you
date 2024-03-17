//
//  CircleImage.swift
//  how-are-you
//
//  Created by 이상현 on 3/17/24.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("IMG_0004")
            .frame(width:300, height:300)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage()
}
