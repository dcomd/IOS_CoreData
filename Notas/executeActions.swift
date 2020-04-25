//
//  executeActions.swift
//  Notas
//
//  Created by Alexandre de Oliveira Nepomuceno on 25/04/20.
//  Copyright © 2020 Alexandre de Oliveira Nepomuceno. All rights reserved.
//

import UIKit
import CoreData
class executeActions {

    func salvarText(texto: String, context: NSManagedObjectContext){
        
        let anotacoes = NSEntityDescription.insertNewObject(forEntityName:"Notas", into: context)
        anotacoes.setValue(_:texto, forKey:"texto")
        anotacoes.setValue(_:Date(), forKey:"data")
        
        do {
            try context.save()
            print("dados salvos com sucesso")
        } catch let erro {
           print("Erro ao salvar anotações" + erro.localizedDescription)
        }
    }
    
    func listarDados(context: NSManagedObjectContext)-> [NSManagedObject]{
        
        var anotacoes: [NSManagedObject] = []
        let requisao = NSFetchRequest<NSFetchRequestResult>(entityName: "Notas")
        let order = NSSortDescriptor(key: "data", ascending: false)
        requisao.sortDescriptors = [order]
        
        do {
           let recuperarInfo = try context.fetch(requisao)
           anotacoes = recuperarInfo as! [NSManagedObject]
            return anotacoes
        } catch {
          return []
        }
    }
    
    func AtualizarDados(texto: String, context: NSManagedObjectContext, anotacoes: NSManagedObject){
        anotacoes.setValue(_:texto, forKey:"texto")
        anotacoes.setValue(_:Date(), forKey:"data")
        do {
            try context.save()
            print("dados salvos com sucesso")
        } catch let erro {
            print("Erro ao salvar anotações" + erro.localizedDescription)
        }
    }
    
    func removerDados(context: NSManagedObjectContext, anotacoes: NSManagedObject ){
        //excuir do bando
        context.delete(anotacoes)
        do{
            try context.save()
        }catch let erro{
            print("Erro ao salvar anotações" + erro.localizedDescription)
        }
    }
}
