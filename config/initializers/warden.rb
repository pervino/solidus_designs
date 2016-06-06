Warden::Manager.after_set_user except: :fetch do |user, auth, opts|
  if auth.cookies.signed[:guest_token].present?
    Spree::Design.where(guest_token: auth.cookies.signed[:guest_token], user_id: nil).each do |design|
      design.update_column("user_id", user.id)
    end
  end
end