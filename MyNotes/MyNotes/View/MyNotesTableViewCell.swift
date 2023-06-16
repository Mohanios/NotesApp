//
//  MyNotesTableViewCell.swift
//  MyNotes
//
//  Created by Mohanraj on 31/03/23.
//

import UIKit

class MyNotesTableViewCell: UITableViewCell {
  @IBOutlet weak var outerView: UIView!
  @IBOutlet weak var deleteBtn: UIButton!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var tittleLabel: UILabel!
  override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
  }
}
