class Member < ApplicationRecord
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end     

  has_many :events, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :clinics, through: :favorites

  has_many :reviews, dependent: :destroy
  has_many :clinics, through: :reviews

  attachment :profile_image

  # 会員論理削除機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  # google API
  geocoded_by :address
  after_validation :geocode
  
end
