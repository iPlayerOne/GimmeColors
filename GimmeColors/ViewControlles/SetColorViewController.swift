//
//  SetColorViewController.swift
//  GimmeColors
//
//  Created by ikorobov on 13.08.2022.
//

import UIKit

class SetColorViewController: UIViewController {

    @IBOutlet weak var setColorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var viewColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorView.backgroundColor = viewColor
//        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redTextField, greenTextField, blueTextField)
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    @IBAction func rgbSliders(_ sender: UISlider) {
        switch sender {
            case redSlider:
                setValue(for: redTextField)
            case greenSlider:
                setValue(for: greenTextField)
            default:
                setValue(for: blueTextField)
        }
        setColor()
    }
    
    private func setColor() {
        setColorView.backgroundColor = UIColor(
            red: Int(redSlider.value),
            green: Int(greenSlider.value),
            blue: Int(blueSlider.value),
            a: 1)
    }

    private func setValue(for fields: UITextField...) {
        fields.forEach { field in
            switch field {
                case redTextField:
                    field.text = string(from: redSlider)
                case greenTextField:
                    field.text = string(from: greenSlider)
                default:
                    field.text = string(from: blueSlider)
            }
            
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.0f", slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }

}

extension SetColorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField {
                case redTextField:
                    redSlider.setValue(currentValue, animated: true)
                case greenTextField:
                    greenSlider.setValue(currentValue, animated: true)
                default:
                    blueSlider.setValue(currentValue, animated: true)
            }
            
            setColor()
            return
        }
        
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            let keyboardToolbar = UIToolbar()
            keyboardToolbar.sizeToFit()
            textField.inputAccessoryView = keyboardToolbar
            
            let doneButton = UIBarButtonItem(
                barButtonSystemItem: .done,
                target: self,
                action: #selector(didTapDone)
            )
            
            let flexBarButton = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )
            
            keyboardToolbar.items = [flexBarButton, doneButton]
        }
    }
}
