module Spree
  module Designs
    module PermissionSets
      class DefaultCustomer < Spree::PermissionSets::Base
        def activate!
          can :create, Design
          can [:read, :update], Design do |design, token|
            design.user == user || design.guest_token && design == design.guest_token
          end
        end
      end
    end
  end
end