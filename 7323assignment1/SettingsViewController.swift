import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var brightnessSlider: UISlider!
    
    // To create IBOutlet to access the UIDatePicker and UILabel in the Storyboard
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBAction func brightnessSliderChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
                    let brightness = slider.value
                    UIScreen.main.brightness = CGFloat(brightness)
                }
    }
    
    @IBOutlet weak var darkModelSwitch: UISwitch!
   
    @IBAction func darkModelSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
                // To enable dark mode
                overrideUserInterfaceStyle = .dark
                UserDefaults.standard.set(true, forKey: "isDarkMode")
            } else {
                // To disable dark mode
                overrideUserInterfaceStyle = .light
                UserDefaults.standard.set(false, forKey: "isDarkMode")
            }

            // To broadcast a notification to other view controllers to update the interface style
            NotificationCenter.default.post(name: NSNotification.Name("DarkModeChanged"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brightnessSlider.value = Float(UIScreen.main.brightness)
        // To do any additional setup after loading the view.
        // To retrieve dark mode setting from UserDefaults
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        darkModelSwitch.isOn = isDarkMode
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        
        // To check if the user's birthday is saved
        if let savedDate = UserDefaults.standard.object(forKey: "userBirthday") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none

            // To update the UIDatePicker and UILabel to display the saved birthday
            datePicker.date = savedDate
            birthdayLabel.text = "My Birthday: \(dateFormatter.string(from: savedDate))"
        } else {
            birthdayLabel.text = "My Birthday: Not set"
        }
        
        // To set initial birthday display
                
        // To set DatePicker's default value to the current date
        datePicker.date = Date()

        // To add listener for changes in DatePicker's value
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        // To retrieve saved gender from UserDefaults
        if let savedGender = UserDefaults.standard.string(forKey: "userGender") {
                selectedGender = savedGender

            // To update the selection in Segmented Control
            switch savedGender {
            case "male":
                genderSegmentedControl.selectedSegmentIndex = 0
            case "female":
                genderSegmentedControl.selectedSegmentIndex = 1
            case "non-binary":
                genderSegmentedControl.selectedSegmentIndex = 2
            default:
                genderSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
            }
        } else {
            genderLabel.text = "My gender is __"
        }
        genderSegmentedControl.isHidden = true

        // To add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        genderLabel.isUserInteractionEnabled = true
        genderLabel.addGestureRecognizer(tapGesture)
        updateGenderLabel()
    }
    
    // To define IBAction, called when the date changes
    @objc func dateChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        // To get the selected date and format it as a string
        let selectedDate = dateFormatter.string(from: sender.date)
            
        // To update UILabel to display the birthday
        birthdayLabel.text = "My Birthday: \(selectedDate)"
        
        // To save the selected date to UserDefaults
        UserDefaults.standard.set(sender.date, forKey: "userBirthday")
    }
    
    var selectedGender: String? {
        didSet {
            if let gender = selectedGender {
                genderLabel.text = "My gender is \(gender)"
                updateGenderLabel()
                genderSegmentedControl.isHidden = true
            }
        }
    }
    
    // To show Segmented Control when the gender label is tapped
    @objc func labelTapped() {
        genderSegmentedControl.isHidden = false
    }
    
    // To update the label when the user selects a gender in Segmented Control
    @IBAction func genderSelectionChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedGender = "male"
            UserDefaults.standard.set("male", forKey: "userGender")
        case 1:
            selectedGender = "female"
            UserDefaults.standard.set("female", forKey: "userGender")
        case 2:
            selectedGender = "non-binary"
            UserDefaults.standard.set("non-binary", forKey: "userGender")
        default:
            break
        }
        // To ensure the data is saved to UserDefaults
        UserDefaults.standard.synchronize()
    }

    
    // To update UILabel and set background color for the selected gender or "__"
    func updateGenderLabel() {
        let genderText = selectedGender ?? "__"
        let fullText = "My gender is \(genderText)"

        // To create a mutable attributed string
        let attributedString = NSMutableAttributedString(string: fullText)

        // To find the part to highlight (i.e., "__" or the selected gender)
        let range = (fullText as NSString).range(of: genderText)

        // To set background color to light blue
        attributedString.addAttribute(.backgroundColor, value: UIColor.systemBlue.withAlphaComponent(0.3), range: range)
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: range)

        // To set the attributed string to the UILabel
        genderLabel.attributedText = attributedString
    }

}

