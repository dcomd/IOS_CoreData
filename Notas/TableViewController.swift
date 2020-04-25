//
//  TableViewController.swift
//  Notas
//
//  Created by Alexandre de Oliveira Nepomuceno on 25/04/20.
//  Copyright © 2020 Alexandre de Oliveira Nepomuceno. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var context: NSManagedObjectContext!
    var dados:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       AtualizarDados()
       tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "dadosCelula", for: indexPath)
        let anotacoes = self.dados [indexPath.row]
        let texto = anotacoes.value(forKey: "texto")
        let dataRecuperada = anotacoes.value(forKey: "data")
        
        //formatar data
        let newDate = DateFormatter()
        newDate.dateFormat = "dd/MM/yyyy hh:mm"
        let ajustDate = newDate.string(from: dataRecuperada as! Date)
        
        celula.textLabel?.text = texto as? String
        celula.detailTextLabel?.text = ajustDate
        return celula
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let indice = indexPath.row
            let anotacoes = self.dados[indice]
            
            // excluir do banco de dados
            executeActions().removerDados(context: self.context, anotacoes: anotacoes)
            //limpar do array
            self.dados.remove(at: indice)
            //excluir unico item da tabela sem atualizar ela toda com animação
            self.tableView.deleteRows(at: [indexPath] , with: .automatic)
        }
    }
    
    //recuperar a linha selecionada
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let indice = indexPath.row
        let anotacoes = self.dados[indice]
        self.performSegue(withIdentifier: "verDados", sender: anotacoes)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verDados"{
            let destino = segue.destination as! ViewController
            destino.anotacao = sender as! NSManagedObject
        }
    }
    
    func AtualizarDados(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        dados = executeActions().listarDados(context:context )
    }

}
