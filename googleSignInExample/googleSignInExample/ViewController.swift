//
//  ViewController.swift
//  googleSignInExample
//
//  Created by batuhankarasu on 20.01.2021.
//

import UIKit
import GoogleSignIn
import Firebase

class ViewController: UIViewController {

    @IBAction func btnCikisYapPressed(_ sender: UIButton) {
        
        do {
            oturumKapatma()
            try Auth.auth().signOut()
        }catch let oturumHatasi as NSError {
            print("oturum kapatılırken hata \(oturumHatasi.localizedDescription)")
        }
    }
    @IBOutlet weak var lblInfo: UILabel!
    
    @IBOutlet var btnSignInButton : GIDSignInButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener {(auth,kullanici) in
            if kullanici == nil {
                self.lblInfo.text = "oturum açan kullanıcı yok"
            }else {
                self.lblInfo.text = "kullanıcı ID: \(kullanici?.uid ?? "--")"
            }
        }
    }

    func firebaseLogin(_ kimlik: AuthCredential){
        
        Auth.auth().signIn(with: kimlik ){
            (kullanici,hata) in
            if let hata = hata {
                debugPrint("hata \(hata.localizedDescription)")
            }else {
                debugPrint("başarı")
            }
            
        }
        
    }
    func oturumKapatma () {
        
        
        GIDSignIn.sharedInstance()?.signOut()

         
    }

}

