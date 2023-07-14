//
//  PhotoView.swift
//  bc
//
//  Created by Evgeny Hailov on 11.07.2023.
//

import Foundation
import SwiftUI

struct PhotoView: View {

    @Binding var showImagePicker: Bool
    @Binding var image: UIImage?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var isShown: Bool
    @Binding var image: UIImage?

    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        isShown = false
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    @Binding var image: UIImage?

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(isShown: $isShown, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
}

