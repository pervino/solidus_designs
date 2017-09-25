class SpreeDesigns::PermissionSets::DefaultCustomer < Spree::PermissionSets::Base
  def activate!
    can :create, Spree::Design
    can [:read, :update], Spree::Design do |design, token|
      true
      # design.user == user || design.guest_token && design == design.guest_token
    end
  end
end
