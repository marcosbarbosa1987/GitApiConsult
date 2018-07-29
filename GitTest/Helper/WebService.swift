//
//  WebService.swift
//  GitTest
//
//  Created by Marcos Barbosa on 28/07/2018.
//  Copyright © 2018 n/a. All rights reserved.
//

import Foundation

@objc protocol JsonOutput {
    func json(json: Dictionary<String, AnyObject>)
    @objc optional func jsonArray(json: NSArray)
}

class WebService: JsonOutput{
    
    internal func json(json: Dictionary<String, AnyObject>) {}
    
    
    public var output: JsonOutput? = nil
    
    //variavel do loading
    //let indicator = ActivityIndicator()
    
    private var urlServer: String = ""
    private var function: String         /*Caso seja GET enviar os parametros concatenados   (FUNCAO?CAMPO=VALOR&CAMPO=VALOR&...)*/
    private var fields: String         /*Campo(s) para enviar                              (CAMPO=VALOR&CAMPO=VALOR&...) OPCIONAL, ENVIAR ""*/
    private var authUser: String    //Usuário para autenticação OPCIONAL, ENVIAR ""/
    private var authPassword: String      //Usuário para autenticação OPCIONAL, ENVIAR ""/
    private var kind: String           //DELETE,GET,POST ou PUT/
    private var indicatorLoading: Bool
    private var token: String

    //Instancia Em Branco.
    init() {
        self.function = ""
        self.fields = ""
        self.authPassword = ""
        self.authUser = ""
        self.kind = ""
        self.indicatorLoading = false
        self.token = ""
    }
    
    
    
    public func showData(){
        
        print("""
            Campos preenchidos:
            URL: \(urlServer)
            Função: \(function)
            Tipo de requisição: \(kind)
            Usuário: \(authUser)
            Senha: \(authPassword)
            Parametros: \(fields),
            Indicator: \(indicatorLoading),
            Token: \(token)
            """);
        
    }
    
    public func conectar(){
        self.showData()
        
//        if getAtivarIndicator(){
//            self.indicator.startActivity()
//        }
        
        
        //variavel de requisicao ira receber o caminho da constante acima
        guard let url = URL(string: urlServer + function) else {return}
        print("url =\(url)")
        
        var requisition = URLRequest(url:url)
        
        //informa o tipo de envio
        requisition.httpMethod = kind
        
        //Caso tenha preenchido a autenticação
        if(authUser != "" && authPassword != ""){
            //Usar da sessão.
            let user = authUser
            let password   = authPassword
            //Converte os dados para enviar via HEADER
            let login = String(format: "%@:%@", user, password)
            let loginData = login.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            requisition.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }else if (token != ""){
            requisition.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        //Caso não seja GET, e tenha campos
        if(kind != "GET" && fields != "") {
            //constante ira cricar uma string com o id que o webService espera receber e com valor ja associado
            let postField = fields
            //abaixo será feira uma associacao de tipo de codificação de caracteres
            requisition.httpBody = postField.data(using: String.Encoding.utf8)
        }
        
        let config: URLSessionConfiguration = .default
        config.httpMaximumConnectionsPerHost = 3
        config.timeoutIntervalForRequest = 20
        let session: URLSession = URLSession(configuration: config)
        
        let task: URLSessionTask = session.dataTask(with: requisition) { (responseWS, responseOrNil, errorOrNil)->() in
            DispatchQueue.main.async() {
                
                var errorDescription: String = ""
                
                if let error = errorOrNil {
                    switch error {
                    case URLError.networkConnectionLost, URLError.notConnectedToInternet:
                        print("no network connection")
                        errorDescription = "Sem conexão com a internet!"
                    case URLError.cannotFindHost, URLError.notConnectedToInternet:
                        print("cannot find the host, could be too busy, try again in a little while")
                        errorDescription = "Não foi possível conectar ao servidor!"
                    case URLError.cancelled:
                        print("don´t bother the user, we are doing what they want")
                        errorDescription = "O login foi cancelado!"
                    case URLError.timedOut:
                        print("timeout")
                        errorDescription = "Parece que a conexão esta meio lenta, tente de novo em instantes!"
                    default:
                        print("unknown error")
                        errorDescription = "Ocorreu um erro, tente de novo em instantes!"
                    }
                    
//                    if self.getAtivarIndicator(){
//                        self.indicator.stopActivity()
//                    }
                    let errorDictionary: Dictionary = ["status": -10, "message": "\(errorDescription)"] as Dictionary<String, AnyObject>
                    
                    if(self.output != nil){
                        self.output?.json(json: errorDictionary as Dictionary<String, AnyObject>)
                    }
                    return
                }
                
                
                if let responseWS = responseWS {
                    
                    do{
                        
                        if let json = try JSONSerialization.jsonObject(with: responseWS, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject>{
                            
                            //Retornando para o protocolo o jSON
                            if(self.output != nil){
                                self.output?.json(json: json)
                            }
                            
//                            if self.getAtivarIndicator(){
//                                self.indicator.stopActivity()
//                            }
                        }
                        
                        if let jsonArray = try JSONSerialization.jsonObject(with: responseWS, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray{
                            
                            //Retornando para o protocolo o jSON
                            if(self.output != nil){
                                self.output?.jsonArray!(json: jsonArray)
                            }
                            
//                            if self.getAtivarIndicator(){
//                                self.indicator.stopActivity()
//                            }
                        }
                        
                        
                    }catch {
                        //se nao conseguir se conectar ao webservice ira mostrar o erro aqui
                        print("Erro ao usar o Webservice: \(String(describing: errorOrNil))")
                        
                        if(self.output != nil){
                            let errorDescription = "Ocorreu um erro!"
                            let errorDictionary: Dictionary = ["status": -9, "resultado": "\(errorDescription)"] as Dictionary<String, AnyObject>
                            self.output?.json(json: errorDictionary as Dictionary<String, AnyObject>)
                        }
                        
//                        if self.getAtivarIndicator(){
//                            self.indicator.stopActivity()
//                        }
                        
                    }
                    
                }
                
            }
        }
        task.resume()
        
    }
    
}
