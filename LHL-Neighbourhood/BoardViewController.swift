

import UIKit

class BoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        self.navigationController?.navigationBarHidden = false
//        let navBackgroundImage:UIImage! = UIImage(named: "blackpat.png")
//        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, forBarMetrics: .Default)
    
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white2.jpg")!).colorWithAlphaComponent(0.9)
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "c2.jpg")!).colorWithAlphaComponent(0.9)
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation
    // We're gonna pass sectionKey to ListVC instead of query in this VC
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let listVC = segue.destinationViewController as? ListOfToolTableViewController {
            switch segue.identifier ?? "" {
            case "ShowShare":
                listVC.sectionKey = "share"
                listVC.title = "List of Share Items"
            case "ShowBuy":
                listVC.sectionKey = "buy"
                listVC.title = "List of Buy Items"
            case "ShowSell":
                listVC.sectionKey = "sell"
                listVC.title = "List of Sell Items"
            default:
                break
            }
        }

    }
}
