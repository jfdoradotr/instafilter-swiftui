//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    let example = Image(.example)
    ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
      Label("Click to share", systemImage: "airplane")
    }
  }
}

#Preview {
  ContentView()
}
