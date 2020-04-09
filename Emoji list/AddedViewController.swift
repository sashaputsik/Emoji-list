import UIKit

class AddedViewController: UIViewController {
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameOfEmojiTextField: UITextField!
    @IBOutlet weak var infoOfEmojiTextField: UITextField!
    let emojiArray = [Emoji]()
    override func viewDidLoad(){
        super.viewDidLoad()
        nameOfEmojiTextField.autocapitalizationType = .sentences
        infoOfEmojiTextField.autocapitalizationType = .sentences
        emojiTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardClose))
        view.addGestureRecognizer(tap)
    }
    @objc func keyboardClose(){
        emojiTextField.resignFirstResponder()
        nameOfEmojiTextField.resignFirstResponder()
        infoOfEmojiTextField.resignFirstResponder()
    }
    
    @IBAction func addedEmoji(_ sender: UIBarButtonItem) {
    
}
    
}

extension AddedViewController: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 1{
            textField.resignFirstResponder()
        }
    }
}
