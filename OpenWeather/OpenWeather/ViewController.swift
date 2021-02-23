//
//  ViewController.swift
//  OpenWeather
//
//  Created by Sara Gil González on 8/2/21.
//  Copyright © 2021 Sara Gil González. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var currentIcon: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentPrecip: UILabel!
    @IBOutlet weak var currentPronost: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var parser = XMLParser()        // Parseador
    var dias = [[String:String]]()      // Array de diccionario dias
    var dia = [String:String]()     // Diccionario dia
    var nodo = ""
    var isWeather : Bool = false
    var isCurrent : Bool = false
    var cIcon = String()
    var cPronost = String()
    var cTemp = String()
    var cPrecip = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlTxt="http://api.worldweatheronline.com/premium/v1/weather.ashx?key=8a7b34041ff14af9939114715210502&q=Toledo,Spain&num_of_days=10&fx24=yes&lang=es&mca=no&tp=24&format=xml"
        let url = URL(string: urlTxt)
        parser = XMLParser(contentsOf:(url)!)!
        parser.delegate = self
        parser.parse()
        pintaCurrent()
        //tableView.reloadData()

    }
    
    func pintaCurrent() {
        currentPronost.text = cPronost
        currentTemp.text = cTemp
        currentPrecip.text = cPrecip
        
        let url = URL(string: cIcon)
        let data = try? Data(contentsOf: url!)
        currentIcon.image = UIImage(data : data!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dias.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "RowTiempo", for: indexPath) as! MiCelda
            
        let dia = dias[indexPath.row]
        
        celda.fecha.text = dia["fecha"]
        celda.pronostico.text = dia["pronostico"]
        celda.minTemp.text = dia["min"]
        celda.maxTemp.text = dia["max"]
        celda.precip.text = dia["precipitacion"]
        if let icon = dia["icon"] {
            let url = URL(string: icon)
            let data = try? Data(contentsOf: url!)
            celda.imageIcon.image = UIImage(data : data!)
        }
            
        return celda
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if (elementName == "weather") {
            isWeather = true
            dia = [String:String]()
            
        }else if (elementName == "current_condition"){
            isCurrent = true
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "weather") {
            dias.append(dia)
            isWeather = false
        }else if (elementName == "current_condition"){
            isCurrent = false
        }else if (elementName == "temp_C" && isCurrent){
            cTemp = nodo
        }else if (elementName == "weatherIconUrl" && isCurrent) {
            cIcon = nodo
        }else if (elementName == "lang_es" && isCurrent) {
            cPronost = nodo
        }else if (elementName == "precipMM" && isCurrent) {
            cPrecip = nodo
        }else if (elementName == "date") {
            dia["fecha"] = nodo
        }else if (elementName == "maxtempC"){
            dia["max"] = nodo
        }else if (elementName == "mintempC") {
            dia["min"] = nodo
        }else if (elementName == "precipMM") {
            dia["precipitacion"] = nodo
        }else if (elementName == "lang_es") {
            dia["pronostico"] = nodo
        }else if (elementName == "weatherIconUrl") {
            dia["icon"] = nodo
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        nodo = string
    }

}

