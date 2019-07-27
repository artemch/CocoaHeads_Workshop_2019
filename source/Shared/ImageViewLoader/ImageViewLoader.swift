import Foundation
import Nuke

public typealias ImageDisplayingView = UIImageView

public class ImageViewLoader {
    
    public weak var view: ImageDisplayingView?
    
    public var placeholder: UIImage?
    
    private var imageTask: ImageTask? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    // MARK: - Initializations and Deallocations
    
    public init(view: ImageDisplayingView? = nil,
                placeholder: UIImage? = nil)
    {
        self.view = view
        self.placeholder = placeholder
    }
    
    // MARK: - Public methods
    
    public func loadImage(url: URL?) {
        if let url = url {
            self.loadImageInternal(url: url)
        } else {
            self.reset()
        }
    }
    
    public func loadImage(url: String?) {
        self.loadImage(url: url.flatMap { URL(string: $0) })
    }
    
    public func loadImage(image: UIImage?) {
        self.view?.image = image ?? self.placeholder
        self.imageTask = nil
    }
    
    public func clear() {
        self.reset()
    }
    
    public func cancel() {
        self.reset()
    }
    
    // MARK: - Private methods
    
    private func reset() {
        self.imageTask = nil
        self.view?.image = self.placeholder
    }
    
    private func loadImageInternal(url: URL) {
        let task = ImagePipeline.shared.loadImage(
            with: url,
            progress: nil,
            completion: { [weak self] response, error in
                self?.update(image: response?.image)
        })
        self.imageTask = task
    }
    
    private func update(image: UIImage?) {
        self.view?.image = image ?? self.placeholder
    }
}

