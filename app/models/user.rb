class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :valid_passport_data

  def generate_auth_token!
    update(auth_token: SecureRandom.base64)
  end

  def as_json_instance
    as_json(except: %i[password_digest auth_token])
  end

  def self.as_json_collection(users)
    users.map(&:as_json_instance)
  end

  private

  def valid_passport_data
    return unless passport_data.present?

    validate_passport_data_format
    validate_passport_data_field('number', :invalid_number)
    validate_passport_data_field('issued_by', :invalid_issued_by)
    validate_passport_data_field('issued_at', :invalid_issued_at)
  end

  def validate_passport_data_format
    errors.add(:passport_data, :invalid_format) unless passport_data.is_a?(Hash)
  end

  def validate_passport_data_field(field, error_key)
    errors.add(:passport_data, error_key) unless passport_data[field].present?
  end
end
