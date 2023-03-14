class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    max = 255
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
    record.errors.add(attribute, :invalid) unless format =~ value

    record.errors.add(attribute, :taken) if record.email_confirmed?
  end
end