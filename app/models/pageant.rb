class Pageant < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :user
    
    validates_presence_of :image
    validates  :description, presence: true
    validates  :category, presence: true
    validates  :name, presence: true
    
    def self.search(search)
        if search
            where(["name LIKE?", "%#{search}%"])
        else
            all 
        end
            
    end
    
end
