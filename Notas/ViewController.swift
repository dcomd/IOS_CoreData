//
//  ViewController.swift
//  Notas
//
//  Created by Alexandre de Oliveira Nepomuceno on 25/04/20.
//  Copyright © 2020 Alexandre de Oliveira Nepomuceno. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!

    @IBOutlet weak var texto: UITextView!
    
    @IBAction func salvar(_ sender: Any) {
        if anotacao != nil{
            executeActions().AtualizarDados(texto: self.texto.text ,context: self.context, anotacoes: anotacao)
        }else{
            executeActions().salvarText(texto:self.texto.text, context:self.context)
        }
        //retornar para tela principal
        self.navigationController?.popToRootViewController(animated:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //chamar o teclado assim que abrir o viewController
        self.texto.becomeFirstResponder()
        
        if anotacao != nil{
            if let textoRecuperado = anotacao.value(forKey: "texto"){
                self.texto.text = String(describing: textoRecuperado)
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }


}

