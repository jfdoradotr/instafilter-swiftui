//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
  var body: some View {
    ContentUnavailableView {
      Label("No snippets", systemImage: "swift")
    } description: {
      Text("You don't have any saved snippets yet.")
    } actions: {
      Button("Create snippet") {

      }
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  ContentView()
}
