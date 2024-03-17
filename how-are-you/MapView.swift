//
//  SwiftUIView.swift
//  how-are-you
//
//  Created by 이상현 on 3/17/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(initialPosition: .region(region))
    }
}

private var region: MKCoordinateRegion {
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.014_295, longitude: 129.325_753),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
}

#Preview {
    MapView()
}
