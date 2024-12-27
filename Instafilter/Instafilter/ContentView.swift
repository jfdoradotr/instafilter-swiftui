//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
  @State private var processedImage: Image?
  @State private var filterIntensity = 0.5
  @State private var selectedItem: PhotosPickerItem?
  @State private var showingFilters = false

  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  private let context = CIContext()

  @AppStorage("filterCount") var filterCount = 0
  @Environment(\.requestReview) var requestReview

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
        .buttonStyle(.plain)
        .onChange(of: selectedItem, loadImage)
        Spacer()
        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
            .onChange(of: filterIntensity, applyProcessing)
        }
        HStack {
          Button("Change Filter", action: changeFilter)
          Spacer()
          if let processedImage {
            ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .confirmationDialog("Select a filter", isPresented: $showingFilters) {
        Button("Crystallize") { setFilter(.crystallize()) }
        Button("Edges") { setFilter(.edges()) }
        Button("Gaussian Blur") { setFilter(.gaussianBlur()) }
        Button("Pixellate") { setFilter(.pixellate()) }
        Button("Sepia Tone") { setFilter(.sepiaTone()) }
        Button("Unsharp Mask") { setFilter(.unsharpMask()) }
        Button("Vignette") { setFilter(.vignette()) }
        Button("Cancel", role: .cancel) { }
      }
    }
  }

  private func changeFilter() {
    showingFilters = true
  }

  private func loadImage() {
    Task {
      guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
      guard let inputImage = UIImage(data: imageData) else { return }

      let beginImage = CIImage(image: inputImage)
      currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
      applyProcessing()
    }
  }

  private func applyProcessing() {
    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

    guard let outputImage = currentFilter.outputImage else { return }
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

    let uiImage = UIImage(cgImage: cgImage)
    processedImage = Image(uiImage: uiImage)
  }

  private func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()
  }
}

#Preview {
  ContentView()
}
