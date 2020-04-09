import UIKit
import CoreData
class EmojiTableViewController: UITableViewController {
    var emojiArray = [Emoji]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = UIColor(patternImage: UIImage(named: "359397.jpg")!)
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetch = Emoji.fetchRequest() as NSFetchRequest<Emoji>
        do {
            emojiArray =  try context.fetch(fetch)
            tableView.reloadData()
        } catch let error as NSError {
            print(error)
        }
    }
    @IBAction func addEmoji(_ sender: UIBarButtonItem) {
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else{return UITableViewCell()}
        let emoji = emojiArray[indexPath.row]
        cell.emojiLabel.text = emoji.emoji
        cell.emojiName.text = emoji.name
        return cell
    }
    
    @IBAction func addedEmoji(_ unwind: UIStoryboardSegue){
        guard let vc = unwind.source as? AddedViewController else{return}
        if vc.emojiTextField.text != "" || vc.nameOfEmojiTextField.text != ""{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newEmoji = Emoji(context: context)
        newEmoji.emoji = vc.emojiTextField.text
        newEmoji.name = vc.nameOfEmojiTextField.text
            newEmoji.info = vc.infoOfEmojiTextField.text
            do {
                try context.save()
                tableView.reloadData()
            } catch let error as NSError {
                print(error)
            }
            print(emojiArray)
        }
        else{
            let alertController = UIAlertController(title: "Пусто", message: "Братан да ты ничего не добавил. Вернись и введи эмоджи и его имя", preferredStyle: .alert)
            let okeyAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(okeyAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // guard let vc = storyboard?.instantiateViewController(withIdentifier: "SelectedEmojiViewController") as? SelectedEmojiViewController else{return}
       // navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if emojiArray.count > indexPath.row{
                let emojis = emojiArray[indexPath.row]
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                context.delete(emojis)
                emojiArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SelectedEmojiViewController{
            let emojis = emojiArray[tableView.indexPathForSelectedRow!.row]
            if let emoji = emojis.emoji, let name = emojis.name, let info = emojis.info{
                vc.emoji = emoji
                vc.name = name
                vc.info = info
            }
        }
    }
    }
