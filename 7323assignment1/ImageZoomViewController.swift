import UIKit

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!
    var scrollView: UIScrollView!
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // To set the background to semi-transparent black
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)

        // To create a UIScrollView to support zooming
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0  // Minimum zoom scale
        scrollView.maximumZoomScale = 3.0  // Maximum zoom scale
        scrollView.contentSize = view.bounds.size
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)

        // To create a UIImageView to display the zoomed image
        imageView = UIImageView(frame: scrollView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        scrollView.addSubview(imageView)

        // To tap on the blank area to close the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissZoomView))
        view.addGestureRecognizer(tapGesture)
    }

    // To tap on the blank area to close the zoomed view
    @objc func dismissZoomView() {
        self.dismiss(animated: true, completion: nil)
    }

    // To specify the view to zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

