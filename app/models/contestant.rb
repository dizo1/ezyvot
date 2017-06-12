class Contestant < ApplicationRecord
    acts_as_votable
    mount_uploader :image, ImageUploader
    
    belongs_to :user
    belongs_to :pageant

end
