FactoryBot.define do
  factory :order do
    user
    billing_amount { 1000 }
    zipcode { '100-0001' }
    street { '1 Chome-1-1 Marunouchi' }
    building { 'Tokyo Station' }
  end
end
