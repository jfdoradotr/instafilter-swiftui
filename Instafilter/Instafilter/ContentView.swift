//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
  var body: some View {
    ContentUnavailableView("No snippets available", systemImage: "swift")
  }
}

#Preview {
  ContentView()
}
