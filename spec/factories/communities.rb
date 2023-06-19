FactoryBot.define do
  factory :community do
    user
    name { 'Test Community' }
    description { 'This is a test community.' }
    image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.jpg'), 'image/jpg') }
  end
end
