FactoryBot.define do
  factory :order do
    user
    billing_amount { 1000 }
    zipcode { '100-0001' }
    street { '北区' }
    building { '北区アパート101' }
  end
end
