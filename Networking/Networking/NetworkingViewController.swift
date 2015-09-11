//
//  NetworkingViewController.swift
//  Networking
//
//  Created by Trainer on 11/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class NetworkingViewController: UIViewController, NSURLConnectionDataDelegate {

    // outlets
    @IBOutlet weak var log: UITextView!
    
    // service paths
    let baseURL = "http://leonbaird.co.uk"
    let api = "iphone"
    let service = "input.php"
    
    func getFullURL() -> String {
        return "\(baseURL)/\(api)/\(service)"
    }
    
    func getURLEncodedVariables() -> String {
        return "username=Leon%20Baird&password=bob&apikey=lb3837498373493749"
    }
    
    func getFullURLWithVariables() -> String {
        return getFullURL() + "?" + getURLEncodedVariables()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        log.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Actions
    
    @IBAction func getRequest(sender: AnyObject) {
        do {
            let downloadedData = try String(contentsOfURL: NSURL(string: getFullURLWithVariables())!)
            printToLog("We have downloaded the data: \(downloadedData)", log: log)
        } catch {
            printToLog("Failed to download data", log: log)
        }
    }
    
    var connection:NSURLConnection!
    
    @IBAction func postRequest(sender: AnyObject) {
        let url = NSURL(string: getFullURL())!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue(
            "application/x-www-form-urlencoded; charset=UTF-8",
            forHTTPHeaderField: "Content-Type"
        )
        request.HTTPBody = getURLEncodedVariables().dataUsingEncoding(NSUTF8StringEncoding)
        request.timeoutInterval = 20
        
        connection = NSURLConnection(request: request, delegate: self)
        connection.start()
    }
    
    @IBAction func downloadJSON(sender: AnyObject) {
        let url = NSURL(string: "http://leonbaird.co.uk/iphone/userdata.json")!
        if let jsonData = NSData(contentsOfURL: url) {
            do {
                let parsedData = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        as! Dictionary<String, [Dictionary<String, AnyObject>]>
                printToLog("Downloaded JSON \(parsedData)", log: log)
                let personName = parsedData["users"]![0]["name"] as! String
                printToLog("The name is \(personName)", log: log)
            } catch {
                printToLog("Failed to download JSON", log: log)
            }
        }
    }
    
    // MARK: - Connection Delegate
    
    var downloadedData:NSMutableData?
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        printToLog("Responce Received", log: log)
        downloadedData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        downloadedData!.appendData(data)
        printToLog("Data Recevied", log: log)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        printToLog("Connection has finied", log: log)
        self.connection = nil
        let downloadedtext = String(data: downloadedData!, encoding: NSUTF8StringEncoding)
        printToLog("Downloaded text: \(downloadedtext!)", log: log)
        downloadedData = nil
    }
    

}

func printToLog(text:String, log:UITextView) {
    log.text = "\(log.text)\n==> \(text)"
}



