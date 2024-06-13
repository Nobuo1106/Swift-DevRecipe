//
//  FileManipulateViewController.swift
//  DevRecipe
//
//  Created by 五十嵐伸雄 on 2024/02/29.
//

import UIKit

class FileManipulateViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        print(NSHomeDirectory() + "/Documents")
    }
    
    private func setupTextField() {
        let toolBar = UIToolbar()
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "完了", style: UIBarButtonItem.Style.plain, target: self, action: #selector(DoneButtonDidTap(_:)))
        let cancelButton: UIBarButtonItem = UIBarButtonItem(title: "キャンセル", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelButtonDidTap(_:)))
        toolBar.setItems([cancelButton, flexibleItem, doneButton], animated: true)
        toolBar.sizeToFit()
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    @objc func DoneButtonDidTap(_ sender: UIButton){
        self.view.endEditing(true)
    }
    @objc func cancelButtonDidTap(_ sender: UIButton){
        textField.text = ""
    }
    
    @IBAction func saveButtonDidTap(_ sender: UIButton) {
        
        guard let fileName = textField.text else {
            return
        }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(fileName).txt")

        do {
            try textView.text?.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File saved: \(fileURL.path)")
        } catch {
            print("Failed to save text file: \(error)")
        }
    }
}

extension FileManipulateViewController: UITextFieldDelegate {
    
}
