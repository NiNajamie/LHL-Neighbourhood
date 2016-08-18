

import UIKit

class BoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white2.jpg")!).colorWithAlphaComponent(0.9)
        self.navigationController?.navigationBarHidden = false
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white.jpg")!).colorWithAlphaComponent(0.9)
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    @IBAction func chatPressed(sender: UIButton) {
        
        let sb = UIStoryboard(name: "ChatStoryboard", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        vc?.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(vc!, animated: true, completion: nil)
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
