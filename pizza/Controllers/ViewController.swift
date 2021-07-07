//
//  ViewController.swift
//  pizza
//
//  Created by William on 03/07/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    //MARK: - Storyboard Outlet

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
    }

    //MARK: - Private Functions
    
    private func presentPizzaTable() {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "PizzaTable", bundle: nil)
            guard let viewController = storyBoard.instantiateInitialViewController() else {return}
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    private func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Erro de Login", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel) { _ in
                alert.dismiss(animated: true)
            }
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
    
    //MARK: - Storyboard Action
    
    @IBAction func login(_ sender: Any) {
        guard let login = userTextField.text, let password = passwordTextField.text else { return }

        let body: [String: Any] = [
            "email": login,
            "password": password
        ]
    
        let headers: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Accept", value: "application/json")
        ]

        AF.request("https://p3teufi0k9.execute-api.us-east-1.amazonaws.com/v1/signin", method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).response { result in
            if result.response?.statusCode == 200 {
                self.presentPizzaTable()
            } else {
                self.showAlert(message: "")
            }
        }
    }
}

