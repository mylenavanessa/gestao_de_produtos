class Produto < ApplicationRecord
  belongs_to :cliente
  has_many :estoque

  validates :nome, :preco, presence: { message: "Este campo precisa ser preenchido"}

end
