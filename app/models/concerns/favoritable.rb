module Favoritable
  extend ActiveSupport::Concern
included do
  has_many :favorites,dependent: :destroy
  def favorite!#la exclamacion e spara decier que este metodo ejecutara cambios en la db
    favorites.create(user:Current.user)
  end
  def unfavorite!#la exclamacion e spara decier que este metodo ejecutara cambios en la db
    favorite.destroy
  end

  def favorite
    favorites.find_by(user: Current.user)
  end
end

end
