//
//  TableViewController.swift
//  pizza
//
//  Created by William on 06/07/21.
//

import UIKit
import Alamofire

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Storyboard outlet
    
    @IBOutlet weak var pizzaTable: UITableView!
    var pizzaList: [Pizza] = []
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        pullPizzas()
    }
    
    //MARK: - Private Functions
    
    private func pullPizzas() {
        
        AF.request("https://p3teufi0k9.execute-api.us-east-1.amazonaws.com/v1/pizza").responseData { response in
            
            guard let data = response.data else {return}
            do {
                let pizzas = try JSONDecoder().decode([Pizza].self, from: data)
                self.pizzaList = pizzas
                DispatchQueue.main.async {
                    self.pizzaTable.reloadData()
                }
               // self.pizzaTable.reloadData()
            }   catch {
                    print(error)
                    return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PizzaCellController else {
            return UITableViewCell()
        }
        
        return cell
        }
    private func configureTableView() {
        pizzaTable.register(UINib(nibName: "cell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        pizzaTable.delegate = self
        pizzaTable.dataSource = self
    }
}

