class AttachDesignRenderingJob < ActiveJob::Base
  queue_as :default

  def perform(design, render_url)
    design.rendering = URI.parse(render_url)
    design.save
  end
end