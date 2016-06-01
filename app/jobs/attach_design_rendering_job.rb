class AttachDesignRenderingJob < ActiveJob::Base
  queue_as :default

  def perform(design)
    design.rendering = URI.parse(design.render_url)
    design.save
  end
end