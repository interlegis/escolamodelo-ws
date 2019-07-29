class ApiAccess < ApplicationRecord
  validates :cpf, length: { is: 14 }
end
