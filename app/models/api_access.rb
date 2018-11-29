class ApiAccess < ApplicationRecord
  belongs_to :user
  belongs_to :api_access_level
end
