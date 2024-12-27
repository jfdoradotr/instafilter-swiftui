# Instafilter

## Overview  

The **Instafilter** project spans **Day 62 to Day 67** of the 100 Days of SwiftUI course. Over these days, we explored how to combine **SwiftUI** and **Core Image** to build an engaging photo filter app. This project highlights SwiftUI’s flexibility and Core Image’s powerful image processing capabilities, while also introducing several new concepts that are foundational for creating interactive and user-friendly apps.  

By the end of this project, you’ll have gained hands-on experience with advanced SwiftUI techniques and Core Image integration, helping you take your iOS development skills to the next level.  

---  

## Features  

1. **Photo Selection**: Seamlessly import images using `PhotosPicker`.  
2. **Dynamic Filters**: Apply Core Image filters with adjustable parameters like intensity, radius, and scale.  
3. **Interactive Controls**: Use sliders to modify filter parameters in real time.  
4. **Filter Selection**: A `confirmationDialog` allows users to choose from a variety of filters.  
5. **Share Processed Images**: Effortlessly share edited photos using SwiftUI’s `ShareLink`.  
6. **ContentUnavailableView**: Display a polished message when no photo is selected.  
7. **App Store Reviews**: Prompt users for feedback after applying filters multiple times to encourage engagement.  

---  

## Days Breakdown  

### **Day 62–64**: Core Image Basics and SwiftUI Integration

- Learned to use `CoreImage.CIFilterBuiltins` for streamlined filter management.  
- Explored how to create an image processing pipeline using `CIContext` and `CIFilter`.  
- Integrated Core Image filters into a SwiftUI project with dynamic parameter adjustments.  

### **Day 65**: Advanced SwiftUI Features

- Implemented **confirmation dialogs** to manage filter selection elegantly.  
- Used `onChange()` to respond to state changes dynamically, enhancing interactivity.  
- Added **ShareLink** to share processed images with other apps seamlessly.  

### **Day 66**: Fine-Tuning the App

- Used **ContentUnavailableView** to handle empty states gracefully.  
- Leveraged `AppStorage` to persist user actions and prompt App Store reviews.  

### **Day 67**: Wrapping Up and Challenges

- Finalized the app with additional refinements and polish.  
- Discussed challenges for extending functionality and practicing concepts.  

---  

## Challenges  

To consolidate your knowledge, try tackling these challenges:  

1. **Conditional Control Activation**  
   - Make the **Change Filter** button and sliders disabled when no image is selected.  

2. **Multiple Parameter Sliders**  
   - Add more sliders to control multiple filter parameters like radius, intensity, and scale simultaneously.  

3. **Explore New Filters**  
   - Experiment with Core Image filters and add three new ones to your app. Customize their parameters for unique effects.  

---  

## Key SwiftUI Concepts  

- **Confirmation Dialogs**: Present filter options cleanly and interactively.  
- **`onChange()`**: Dynamically respond to user actions like adjusting sliders or importing photos.  
- **ContentUnavailableView**: Provide meaningful UI feedback for empty or unconfigured states.  
- **Persistent State with `AppStorage`**: Track user progress and trigger feedback actions.  

---  

## Core Image Techniques  

- **CIFilter**: Access and configure Core Image filters efficiently using `CIFilterBuiltins`.  
- **CIContext**: Render Core Image outputs into usable formats.  
- **Dynamic Input Keys**: Adjust filter parameters dynamically based on their available input keys.  

---  

## Usage  

### Interface Walkthrough  

1. **Import an Image**  
   Tap the **PhotosPicker** area to select an image from your library.  

2. **Apply Filters**  
   - Tap the **Change Filter** button to select a filter from the available options.  
   - Adjust the sliders to modify filter settings in real time.  

3. **Share or Save**  
   Once satisfied with the edits, tap the **Share** button to share your processed image.  

4. **Feedback Prompt**  
   After applying 20 filters, the app will request an App Store review.  

---  

## Code Highlights  

### Conditional Control Activation

```swift  
private var isDisabled: Bool {  
  processedImage == nil  
}  
```  

### Dynamic Filter Adjustment

```swift  
if inputKeys.contains(kCIInputIntensityKey) {  
  currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)  
}  
```  

### App Store Review Prompt

```swift  
filterCount += 1  
if filterCount >= 20 {  
  requestReview()  
}  
```  

---  

## Conclusion  

The **Instafilter** project is a milestone in the 100 Days of SwiftUI journey. It combines advanced SwiftUI features with powerful Core Image capabilities, giving you a complete workflow for building photo filter apps.
