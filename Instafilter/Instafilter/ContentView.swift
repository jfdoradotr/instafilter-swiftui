//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var image: Image?

  var body: some View {
    VStack {
      image?
        .resizable()
        .scaledToFit()
    }
    .onAppear(perform: loadImage)
  }

  private func loadImage() {
    image = Image(.example)
  }
}

#Preview {
  ContentView()
}
