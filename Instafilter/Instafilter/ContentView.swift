//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
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
    let inputImage = UIImage(resource: .example)
    let beginImage = CIImage(image: inputImage)

    let context = CIContext()
    let currentFilter = CIFilter.sepiaTone()

    currentFilter.inputImage = beginImage
    currentFilter.intensity = 1

    guard let outputImage = currentFilter.outputImage else { return }
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

    let uiImage = UIImage(cgImage: cgImage)
    image = Image(uiImage: uiImage)
  }
}

#Preview {
  ContentView()
}
