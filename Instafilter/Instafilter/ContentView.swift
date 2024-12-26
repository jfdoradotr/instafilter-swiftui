//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
  @State private var processedImage: Image?
  @State private var filterIntensity = 0.5
  @State private var selectedItem: PhotosPickerItem?

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        PhotosPicker(selection: $selectedItem) {
          if let processedImage {
            processedImage
              .resizable()
              .scaledToFit()
          } else {
            ContentUnavailableView(
              "No picture",
              systemImage: "photo.badge.plus",
              description: Text("Tap to import a photo")
            )
          }
        }
        Spacer()
        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
        }
        HStack {
          Button("Change Filter", action: changeFilter)
          Spacer()
          // share the picture
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
    }
  }

  private func changeFilter() {

  }
}

#Preview {
  ContentView()
}
