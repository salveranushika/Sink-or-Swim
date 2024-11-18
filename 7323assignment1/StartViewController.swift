import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var fontSizeLabel: UILabel!
    
    @IBOutlet weak var fontSizeStepper: UIStepper!
    
    
    @IBAction func fontSizeStepperChanged(_ sender: UIStepper) {
        let newFontSize = CGFloat(sender.value)
                fontSizeLabel.font = UIFont.systemFont(ofSize: newFontSize)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    var countdownTimer: Timer?
    var countdownValue: Int = 5
    var imageIndex = 0
        
    // To image list
    let images: [UIImage] = [
        UIImage(named: "Book1")!,
        UIImage(named: "Book2")!,
        UIImage(named: "Book3")!,
        UIImage(named: "Book4")!,
        UIImage(named: "Book5")!,
        UIImage(named: "Book6")!
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // To initialize Stepper and Label
        fontSizeStepper.minimumValue = 10  // Minimum font size
        fontSizeStepper.maximumValue = 30  // Maximum font size
        fontSizeStepper.stepValue = 1      // Step size for increasing/decreasing font
        fontSizeStepper.value = 20         // Initial font size
        fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSizeStepper.value))  // Initialize label font size
        // To set initial image
        imageView.image = images[imageIndex]
        countdownLabel.text = "5"
        
        // To initialize timer, call changeImage method every 5 seconds
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)

    }
    
    @objc func updateCountdown() {
            countdownValue -= 1
            countdownLabel.text = "\(countdownValue)"  // Update countdown label
            
            if countdownValue == 0 {
                // To when countdown ends, switch the image
                changeImage()
                // To reset countdown
                countdownValue = 5
            }
        }
    
    @objc func changeImage() {
        // To switch to the next image
        imageIndex = (imageIndex + 1) % images.count
        imageView.image = images[imageIndex]
    }
    
    // TO stop the timer when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            countdownTimer?.invalidate()
        }

}

