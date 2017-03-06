//
//  ViewController.swift
//  KivaRest
//
//  Created by Michael Karr on 3/5/17.
//  Copyright © 2017 Michael Karr. All rights reserved.
//

import UIKit

class KivaTableViewController: UITableViewController {
    
    var kivaLoanURL = "http://api.kivaws.org/v1/loans/newest.json"
    var loans = [Loan]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getJSON()
        tableView.estimatedRowHeight = 110.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KivaTableViewCell
        
        cell.nameLabel.text = loans[indexPath.row].name
        cell.nameLabel.text = loans[indexPath.row].name
        cell.nameLabel.text = loans[indexPath.row].name
        cell.amountLabel.text = "$\(loans[indexPath.row].name)"
        
        return cell
    }
    
    func getJSON() {
        guard let loanURL = URL(string: kivaLoanURL) else {
            return
        }
        
        let request = URLRequest(url: loanURL)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
        
            if let error = error {
                print(error)
                return
            }
            
            //Parse the JSON file
            if let data = data {
                self.loans = self.parseJSONData(data: data)
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
            
        })
        task.resume()
        
    }
    
    func parseJSONData(data: Data) -> [Loan] {
        var loans = [Loan]()
        
        do {
            let jsonresult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            let jsonLoans = jsonresult?["loans"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                let loan = Loan()
                loan.name = jsonLoan["name"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                loan.use = jsonLoan["use"] as! String
                let location = jsonLoan["location"] as! [String: AnyObject]
                loan.country = location["country"] as! String
                
                loans.append(loan)
            }
        } catch {
            print(error)
        }
        
        return loans
    }
}

