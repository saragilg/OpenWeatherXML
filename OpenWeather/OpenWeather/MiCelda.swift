//
//  MiCelda.swift
//  OpenWeather
//
//  Created by Sara Gil González on 8/2/21.
//  Copyright © 2021 Sara Gil González. All rights reserved.
//

import UIKit

class MiCelda: UITableViewCell {

    
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var precip: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var pronostico: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
