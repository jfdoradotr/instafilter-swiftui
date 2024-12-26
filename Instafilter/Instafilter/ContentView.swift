//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var processedImage: Image?
  @State private var filterIntensity = 0.5

  var body: some View {
    VStack {
      Spacer()
        // image area
      Spacer()
      HStack {
        Text("Intensity")
        Slider(value: $filterIntensity)
      }
      HStack {
        Button("Change Filter") {

        }
        Spacer()
        // share the picture
      }
    }
    .padding([.horizontal, .bottom])
    .navigationTitle("Instafilter")
  }
}

#Preview {
  ContentView()
}
