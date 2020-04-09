import UIKit
import CoreData
class SelectedEmojiViewController: UIViewController {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameOfEmojiLabel: UILabel!
    @IBOutlet weak var informationOfEmotiTextView: UITextView!
    var name = ""
    var emoji = ""
    var info = ""
        var emojiArray = [Emoji]()
    override func viewDidLoad() {
        super.viewDidLoad()
      //  let emoji = emojiArray[index]
        emojiLabel.text = emoji
        nameOfEmojiLabel.text = name
        informationOfEmotiTextView.text = info
    }
    override func viewWillAppear(_ animated: Bool) {
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          let context = appDelegate.persistentContainer.viewContext
          let fetch = Emoji.fetchRequest() as NSFetchRequest<Emoji>
          do {
              emojiArray =  try context.fetch(fetch)
          } catch let error as NSError {
              print(error)
          }
      }
    
 
}
