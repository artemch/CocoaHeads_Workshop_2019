//
//  CameraImagePickerController.swift
//  UIKitLib
//
//  Created by Artem Chabannyi on 6/5/19.
//

import UIKit

public protocol CameraImagePickerController: UIViewController {
    
    var sourceType: UIImagePickerController.SourceType { get set }
    
    var mediaTypes: [String] { get set }
    
    var allowsEditing: Bool { get set }
    
    var showsCameraControls: Bool { get set }
    
    var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? { get set }
    
    var cameraViewTransform: CGAffineTransform { get set }
    
    var cameraFlashMode: UIImagePickerController.CameraFlashMode { get set }
    
    func takePicture()
    
}

extension UIImagePickerController: CameraImagePickerController {}

/// On Simulator it create CameraImagePickerControllerStub which does not work.
public func getCameraImagePickerController() -> CameraImagePickerController {
    #if targetEnvironment(simulator)
    let imagePickerController = CameraImagePickerControllerStub()
    return imagePickerController
    #else
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .camera
    return imagePickerController
    #endif
}

open class CameraImagePickerControllerStub: UIViewController, CameraImagePickerController {
    
    // MARK: - CameraImagePickerController
    
    open var cameraFlashMode: UIImagePickerController.CameraFlashMode = .auto
    
    open var sourceType: UIImagePickerController.SourceType = .camera
    
    open var mediaTypes: [String] = []
    
    open var allowsEditing: Bool = false
    
    open var showsCameraControls: Bool = true
    
    weak open var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?
    
    open var cameraViewTransform: CGAffineTransform = .identity
    
    public func takePicture() {
        DispatchQueue.main.async {
            let image = UIImage(color: .red) ?? UIImage()
            let imageInfo: [UIImagePickerController.InfoKey : Any] = [UIImagePickerController.InfoKey.originalImage: image]
            self.delegate?.imagePickerController?(UIImagePickerController(),
                                                  didFinishPickingMediaWithInfo: imageInfo)
        }
    }
    
    // MARK: - Initializations and Deallocations
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
}
