module Spree
  class Design < Spree::Base
    acts_as_paranoid

    include Spree::Customization::Article

    belongs_to :user, inverse_of: :designs
    belongs_to :template, -> { with_deleted }, touch: true
    belongs_to :source, -> { with_deleted }, class_name: "Spree::Design"

    has_one :design_option, foreign_key: "id", :primary_key "spree_design_option_id"

    after_create :attach_rendering

    has_attached_file :rendering, styles: { large: "600x600>", medium: "400x400>", small: "250x250>" }, default_url: :render_url
    validates_attachment_content_type :rendering, content_type: /\Aimage\/.*\Z/

    # validates :template, presence: true
    validates :render_url, presence: true
    validates :size, presence: true

    self.whitelisted_ransackable_attributes = ['user_id', 'medium', 'size', 'guest_token']
    self.whitelisted_ransackable_associations = ['template']

    def render_url=(url)
      self.rendering = nil

      attach_rendering
      super(url)
    end

    private

    def attach_rendering
      return unless self.persisted?
      AttachDesignRenderingJob.perform_later self
    end
  end
end
