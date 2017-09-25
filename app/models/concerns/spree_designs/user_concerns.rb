module SpreeDesigns::UserConcerns
  extend ActiveSupport::Concern

  included do
    has_many :designs, -> { order 'created_at DESC' }, inverse_of: :user
  end
end
