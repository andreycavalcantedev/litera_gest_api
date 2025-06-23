require 'cpf_cnpj'

class Library < ApplicationRecord
  has_many :users

  belongs_to :address, optional: true
                                                                                                                             
  before_save :cnpj_formatted                                                                                                                                                                                                               

  validate :valid_cnpj                                                                                                                                                                                                                                                                                                                                         

  private

  def valid_cnpj
    unless CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'inválido')
    end
  end

  def cnpj_formatted
    self.cnpj = CNPJ.new(cnpj).formatted if cnpj.present?
  end
end
