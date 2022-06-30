import AVFoundation

protocol Camera {
    
    var session : AVCaptureSession? { get set }
    var output : AVCapturePhotoOutput? { get set }
    var previewLayer : AVCaptureVideoPreviewLayer { get set }
    
    func checkCameraPermission()
    
}

class CameraManager : Camera {
    
    var session: AVCaptureSession?
    
    var output : AVCapturePhotoOutput? = AVCapturePhotoOutput()
    
    var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {[weak self] granted in
                guard granted else { return }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
                
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output!) {
                    session.addOutput(output!)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                session.startRunning()
                self.session = session
                
            } catch {
                print("GG")
            }
        }
    }
    
    
}
