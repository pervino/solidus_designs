class AttachDesignRenderingJob < ActiveJob::Base
  queue_as :high_priority

  def perform(design)
    design.rendering = URI.parse(design.render_url)
    design.save
  end
end
