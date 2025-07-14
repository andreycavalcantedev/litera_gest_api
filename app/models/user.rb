require 'cpf_cnpj'

class User < ApplicationRecord
  has_secure_password

  has_many :book_users, dependent: :destroy
  has_many :books, through: :book_users

  belongs_to :address, optional: true, dependent: :destroy

  belongs_to :library, optional: true

  before_create :generate_accession_number

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

  def generate_accession_number
    loop do
      self.accession_number = "#{Time.current.strftime("%y%m%d%H%M%S")}#{rand(0..9)}"
      break unless User.exists?(accession_number: accession_number)
    end
  end
end
