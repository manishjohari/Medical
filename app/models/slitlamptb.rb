class Slitlamptb < ActiveRecord::Base
belongs_to :patienttbs

  has_attached_file :pimage,
  :styles => { :thumbnail => '320x240!'},
  :url => "/:attachment/:id/:style/:basename.:extension",
  :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"

end
