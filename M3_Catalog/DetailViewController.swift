//
//  DetailViewController.swift
//  M3_Catalog
//
//  Created by sdt5 on 2015. 10. 26..
//  Copyright © 2015년 TAcademyBola. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var itemName : String = "";
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(animated: Bool) {
     
        //웹뷰 띄우기!
        if let itemURL = NSURL(string: "https://en.wikipedia.org/wiki/\(itemName)")
        {
            let request = NSURLRequest(URL: itemURL)
            self.webView.loadRequest(request);
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
