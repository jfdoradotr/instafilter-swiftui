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
  @State private var filterRadius = 0.5
  @State private var filterScale = 0.5
  @State private var selectedItem: PhotosPickerItem?
  @State private var showingFilters = false

  @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
  private let context = CIContext()

  @AppStorage("filterCount") var filterCount = 0
  @Environment(\.requestReview) var requestReview

  private var isDisabled: Bool {
    processedImage == nil
  }

  private var isIntensity: Bool {
    currentFilter.inputKeys.contains(kCIInputIntensityKey)
  }

  private var isRadius: Bool {
    currentFilter.inputKeys.contains(kCIInputRadiusKey)
  }

  private var isScale: Bool {
    currentFilter.inputKeys.contains(kCIInputScaleKey)
  }

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
        Group {
          if isIntensity {
            HStack {
              Text("Intensity")
              Slider(value: $filterIntensity)
                .onChange(of: filterIntensity, applyProcessing)
            }
          }
          if isRadius {
            HStack {
              Text("Radius")
              Slider(value: $filterRadius)
                .onChange(of: filterRadius, applyProcessing)
            }
          }
          if isScale {
            HStack {
              Text("Scale")
              Slider(value: $filterScale)
                .onChange(of: filterScale, applyProcessing)
            }
          }
        }
        .opacity(isDisabled ? 0.5 : 1)
        .disabled(isDisabled)
        HStack {
          Button("Change Filter", action: changeFilter)
            .disabled(isDisabled)
          Spacer()
          if let processedImage {
            ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
          }
        }
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .confirmationDialog("Select a filter", isPresented: $showingFilters) {
        Button("Bloom") { setFilter(.bloom()) }
        Button("Color Invert") { setFilter(.colorInvert()) }
        Button("Comic Effect") { setFilter(.comicEffect()) }
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
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }

    guard let outputImage = currentFilter.outputImage else { return }
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

    let uiImage = UIImage(cgImage: cgImage)
    processedImage = Image(uiImage: uiImage)
  }

  @MainActor private func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    loadImage()

    filterCount += 1
    if filterCount >= 20 {
      requestReview()
    }
  }
}

#Preview {
  ContentView()
}
