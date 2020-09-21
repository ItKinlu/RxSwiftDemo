//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by SP on 21/9/20.
//

import UIKit

import RxCocoa
import RxSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag();
    
    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var usernameTipsLabel: UILabel!
    @IBOutlet weak var passwrodTextField: UITextField!
    @IBOutlet weak var passwordTipsLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let usernameVild = usernameTextFiled.rx.text.orEmpty.map { (text) -> Bool in
            return text.count > 5;
        }.share(replay: 1, scope: .forever)
        
        usernameVild.bind(to: usernameTipsLabel.rx.isHidden).disposed(by: disposeBag)
        usernameVild.bind(to: passwrodTextField.rx.isEnabled).disposed(by: disposeBag)
        
        let passwordVild = passwrodTextField.rx.text.orEmpty.map { (text) -> Bool in
            return text.count > 5;
        }
        
        passwordVild.bind(to: passwordTipsLabel.rx.isHidden).disposed(by: disposeBag)
        
        
        let everyThindBind = Observable.combineLatest(usernameVild, passwordVild){ $0 && $1 }.share(replay: 1, scope: .whileConnected)
        
        everyThindBind.bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe { [weak self](text) in
            print("btn click")
            print(text)
            self?.showAlert()
        }.disposed(by: disposeBag)
        
        

        
        
    }
    func showAlert() -> Void {
//        let alert = UIAlertView(title: "title", message: "message", delegate: nil, cancelButtonTitle: "cancel", otherButtonTitles: "confirm");
//        alert.show();
//        let alert = UIAlertView(title: "RxExample", message: "This is wonderful!", delegate: nil, cancelButtonTitle: "OK")
        let alertVC = UIAlertController.init(title: "title", message: "message", preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "cacel", style: .cancel) { (action) in
            print("cacel")
        }
        alertVC.addAction(action1)
        self.present(alertVC, animated: true) {
            print("2");
        }
    }


}

