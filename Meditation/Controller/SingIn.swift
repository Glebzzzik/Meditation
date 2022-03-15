//
//  ViewController.swift
//  Meditation
//
//  Created by Глеб Голощапов on 14.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.text = "junior@wsr.ru"
        passwordInput.text = "junior"
    }

    
    @IBAction func signInAvction(_ sender: Any) {
        
        guard emailInput.text != "" && passwordInput.text != "" else { return alert(message: "Заполните поля")}
        
        guard isValidEmail(email: emailInput.text!) == true else { return alert(message: "Некорректный Email")}
        
        let url = "mskko2021.mad.hakta.pro/api/user/login"
        
        let body: [String: String] = [
            "email": "\(emailInput.text!)",
            "password": "\(passwordInput.text!)" ]
        
        performSegue(withIdentifier: "goHome", sender: nil)
        
//        AF.request(url, method: .post, parameters: body, encoder: JSONParameterEncoder.default).validate().response { response in
//            switch response.result {
//            case .success(let value):
//                let answer = JSON(value)
//                print(answer)
//            case .failure(let error):
//                self.alert(message: error.localizedDescription)
//            }
//        }
        
    }
    
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._]+@[A-Za-z0-9]+\\.[A-Za-z]{2,3}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    
    func alert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
