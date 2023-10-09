class Estoque < ApplicationRecord
  belongs_to :produto

  validates :tipo, inclusion: {in: %w(entrada saida), message: "Este não é um tipo válido, precisa ser 'entrada' ou 'saida'"}

  validates :tipo, :quantidade, presence: { message: "Este campo precisa ser preenchido"}

  scope :entrada , -> { where(tipo: 'entrada') }
  scope :saida , -> { where(tipo: 'saida') }

  after_commit :adicionar_produto, :if=> "tipo == 'entrada'"
  after_commit :remover_produto, :if=> "tipo == 'saida'"

  after_validation :verificar_estoque, :if=> 'quantidade.present?'

  private

  def adicionar_produto
    produto = Produto.find(self.produto_id)

    nova_quantidade = produto.quantidade + self.quantidade
    produto.update(quantidade: nova_quantidade)
  end 

  def remover_produto
    produto = Produto.find(self.produto_id)

    nova_quantidade = produto.quantidade - self.quantidade
    produto.update(quantidade: nova_quantidade)
  end 

  def verificar_estoque
    return unless self.tipo == 'saida'
    produto = Produto.find(self.produto_id)

    if self.quantidade > produto.quantidade
      errors.add(:quantidade, :invalid, message: "não temos estoque suficiente, total de produtos no estoque #{produto.quantidade}")
    end
  end
end
