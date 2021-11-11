import UIKit
import CoreML
import AVFoundation
import Vision

class HomeViewController: UIViewController, UINavigationControllerDelegate {
    
    private var imageView: UIImageView!
    private var classifier: UILabel!
    private var appHeader: UILabel!
    private var takePhotoButton: PrimaryButton!
    private var openGalleryButton: PrimaryButton!
    
    private let sharedAppearance = AppearanceHandler()
    
    private var flashMode: AVCaptureDevice.FlashMode = .auto

    
    var modelCancer: SkinCancer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        modelCancer = SkinCancer()
    }
    
    private func setupUI() {
        appHeader = UILabel()
        appHeader.text = GeneralStrings.appTitle
        appHeader.font = sharedAppearance.headingBoldFont(withSize: 32)
        appHeader.textColor = sharedAppearance.primaryColour
        view.addSubview(appHeader)
        imageView = UIImageView()
        imageView.layer.borderColor = sharedAppearance.greyColourAlpha20.cgColor
        imageView.layer.borderWidth = 2
        view.addSubview(imageView)
        classifier = UILabel()
        classifier.font = sharedAppearance.headingBoldFont(withSize: 16)
        classifier.textColor = sharedAppearance.greyColour
        view.addSubview(classifier)

        takePhotoButton = PrimaryButton(text: HomeScreenStrings.photo)
        view.addSubview(takePhotoButton)
        openGalleryButton = PrimaryButton(text: HomeScreenStrings.gallery)
        view.addSubview(openGalleryButton)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        appHeader.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalToSuperview().offset(Spaces.big.size*4)
        }

        imageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(appHeader.snp.bottom).offset(Spaces.big.size*2)
            make.height.equalTo(400)
        }
        
        classifier.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(imageView.snp.bottom).offset(Spaces.small.size)
        }
        
        takePhotoButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(classifier.snp.bottom).offset(Spaces.small.size)
        }
        takePhotoButton.addTarget(self, action: #selector(self.pressOpenCameraButton(sender:)), for: .touchUpInside)
        
        openGalleryButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Spaces.medium.size)
            make.leading.equalToSuperview().offset(Spaces.medium.size)
            make.top.equalTo(takePhotoButton.snp.bottom).offset(Spaces.small.size)
        }
        openGalleryButton.addTarget(self, action: #selector(self.pressOpenGalleryButton(sender:)), for: .touchUpInside)
    }
    
    @objc func pressOpenCameraButton(sender: UIButton!) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        vc.cameraFlashMode = .on
    }
    
    @objc func pressOpenGalleryButton(sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}

// Handle Image taken from camera or gallery
extension HomeViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        classifier.text = "Analyzing Image..."
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")]! as? UIImage else {
            return
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 224, height: 224), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 224, height: 224))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        imageView.image = newImage
        
        guard let prediction = try? modelCancer.prediction(image: pixelBuffer!) else {
            classifier.text = "Result: What is that ?"
            return
        }
        classifier.text = "Result: Possibly \(prediction.classLabel)."

     
    }
    
}
