FactoryGirl.define do
  factory :property do
    beds { rand(1..5) }
    baths { rand(1..4) }
    sequence(:title) { |n| "Imóvel código #{n}, com #{beds} quarto(s) e #{baths} banheiro(s)" }
    price { rand(10_000..100_000) }
    description 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    square_meters { rand(20..240) }
    x { rand(0..1400) }
    y { rand(1..1000) }
  end
end
