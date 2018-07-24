class Notify < ApplicationRecord
    has_and_belongs_to_many :students
    mount_uploader :image, ImageUploader
end
