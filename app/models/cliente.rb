class Cliente < ApplicationRecord
  has_many :produtos

  validates :nome, :cnpj, :email, :telefone, presence: { message: "Este campo precisa ser preenchido"}

  validates :cnpj, length: { is: 14, message: "Apenas os 14 digitos numericos"} 
end
