class SaveVirtualProofJob < ActiveJob::Base
  queue_as :default

  def perform(customization)
    customization.virtual_proof = URI.parse(customization.virtual_proof_url)
    customization.save
  end
end