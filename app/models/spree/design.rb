module Spree
  class Design < Spree::Base
    acts_as_paranoid

    belongs_to :user, inverse_of: :designs
    belongs_to :template, touch: true
    belongs_to :original_template

    include Spree::Customization::Source

    has_attached_file :rendering, styles: {large: "600x600>", medium: "400x400>", small: "250x250>"}, default_url: :render_url
    validates_attachment_content_type :rendering, content_type: /\Aimage\/.*\Z/

    validates :medium, presence: true
    validates :render_url, presence: true

    self.whitelisted_ransackable_attributes = ['user_id', 'medium', 'size', 'guest_token', 'template_id']
  end
end
