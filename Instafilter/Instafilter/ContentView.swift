//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
  @State private var pickerItem: PhotosPickerItem?
  @State private var selectedImage: Image?

  var body: some View {
    VStack {
      PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
    }
    .onChange(of: pickerItem) {
      Task {
        selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
      }
    }
  }
}

#Preview {
  ContentView()
}
