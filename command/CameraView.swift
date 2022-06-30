import UIKit
import AVFoundation

class CameraView : UIViewController {
    
    var camera = CameraManager()
    
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    private lazy var cameraButton : UIButton = {
       let button = UIButton(frame: CGRect(x: 0,
                                           y: 0,
                                           width: 80,
                                           height: 80))
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 6
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(makePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var newPhoto : UIButton = {
        let button = UIButton(frame: CGRect(x: view.frame.width-20,
                                           y: 0,
                                           width: 80,
                                           height: 80))
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 6
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(makeNewPhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        camera.checkCameraPermission()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.addSubview(cameraButton)
        tabBarController?.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        camera.previewLayer.frame = view.bounds
        
        cameraButton.center = CGPoint(x: (tabBarController?.tabBar.frame.size.width)!/2,
                                      y: (tabBarController?.tabBar.frame.size.height)! - 60)
        
        
    }
    
    @objc
    private func makePhoto() {
        camera.output?.capturePhoto(with: AVCapturePhotoSettings(),
                                    delegate: self)
        
    }
    
    @objc
    private func makeNewPhoto() {
        tabBarController?.tabBar.isHidden = false
        camera.previewLayer.removeFromSuperlayer()
        camera.previewLayer = AVCaptureVideoPreviewLayer()
        camera.output = AVCapturePhotoOutput()
        setUpView()
        camera.previewLayer.frame = view.bounds
        camera.setUpCamera()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.cameraButton.removeFromSuperview()
    }
}

private extension CameraView {
    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(newPhoto)
        newPhoto.center = view.center
        view.layer.addSublayer(camera.previewLayer)
    }
}

extension CameraView : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: data)
        tabBarController?.tabBar.isHidden = true
        camera.session?.stopRunning()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        
    }
}
