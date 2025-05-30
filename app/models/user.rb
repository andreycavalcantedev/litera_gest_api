require 'cpf_cnpj'

class User < ApplicationRecord
  has_secure_password

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  belongs_to :library, optional: true

  validates :email, presence: true, uniqueness: true
  validates :password_digest, length: { minimum: 6 }

  validates :cpf, presence: true, uniqueness: true
  before_validation :cpf_formated
  validate :valid_cpf

  validates :card_identity, presence: true, uniqueness: true

  scope :by_library, ->(library_id) { where(library_id: library_id) }

  private

  def valid_cpf
    return if cpf.blank?

    unless CPF.valid?(cpf)
      errors.add(:cpf, "inválido")
    end
  end

  def cpf_formated
    self.cpf = CPF.new(cpf).formatted if CPF.valid?(cpf)
  end
end
