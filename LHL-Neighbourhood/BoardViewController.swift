

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet weak var managerBoardButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white2.jpg")!).colorWithAlphaComponent(0.9)
        self.navigationController?.navigationBarHidden = false
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "white.jpg")!).colorWithAlphaComponent(0.9)
        navigationController!.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.barTintColor = UIColor(red: 0.0431, green: 0.0824, blue: 0.4392, alpha: 1.0)
        if let user = User.currentUser(){
        if(user.manager){
         managerBoardButton.hidden=false
            }}
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(logout))

    }
    
    func logout() {
        
        User.logOutInBackgroundWithBlock() {
            err in
            if (err == nil) {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
    }
    
    @IBAction func chatPressed(sender: UIButton) {
        
        let sb = UIStoryboard(name: "ChatStoryboard", bundle: nil)
        guard let vc = sb.instantiateInitialViewController() else {
            fatalError("couldn't find vc")
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
//        vc?.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
//        self.presentViewController(vc!, animated: true, completion: nil)
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
    
//    func getUser()->Bool{
//        if let user = User.currentUser(){
//            if let user = user.manager{
//               return
//            }
//            print(userName)}
//        }

}
