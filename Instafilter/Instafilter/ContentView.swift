//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ShareLink(item: URL(string: "https://swiftyjourney.com")!) {
      Label("Spread the word about Swift", systemImage: "swift")
    }
  }
}

#Preview {
  ContentView()
}
