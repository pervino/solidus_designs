FactoryGirl.define do
  factory :design, class: Spree::Design do
    template
    render_url "http://www.google.com"
    size "bordeaux"
  end
end