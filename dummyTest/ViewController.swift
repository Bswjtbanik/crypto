//
//  ViewController.swift
//  dummyTest
//
//  Created by Biswajit Banik on 10/1/18.
//  Copyright © 2018 Biswajit Banik. All rights reserved.
//

import UIKit
import Cryptor

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keyChange()
    }

    
    func keyChange(){
        let key = CryptoUtils.byteArray(fromHex: "2b7e151628aed2a6abf7158809cf4f3c")
        let iv = CryptoUtils.byteArray(fromHex: "00000000000000000000000000000000")
        let plainText = CryptoUtils.byteArray(fromHex: "6bc1bee22e409f96e93d7e117393172a")
        
        var textToCipher = plainText
        print("textToCipher : " , textToCipher )
        
        if plainText.count % Cryptor.Algorithm.aes.blockSize != 0 {
            textToCipher = CryptoUtils.zeroPad(byteArray: plainText, blockSize: Cryptor.Algorithm.aes.blockSize)
        }
        do {
            let cipherText = try Cryptor(operation: .encrypt, algorithm: .aes, options: .none, key: key, iv: iv).update(byteArray: textToCipher)?.final()
            
            print(CryptoUtils.hexString(from: cipherText!))
            
            let decryptedText = try Cryptor(operation: .decrypt, algorithm: .aes, options: .none, key: key, iv: iv).update(byteArray: cipherText!)?.final()
            
            print(CryptoUtils.hexString(from: decryptedText!))
        } catch let error {
            guard let err = error as? CryptorError else {
                // Handle non-Cryptor error...
                return
            }
            // Handle Cryptor error... (See Status.swift for types of errors thrown)
        }
    }
    

}

