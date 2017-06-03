FactoryGirl.define do
  factory :property do
    title 'Imóvel código N, com 1 quarto e 1 banheiro'
    price 540_000
    description 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
    beds 1
    baths 1
    square_meters 42
    x 667
    y 556
  end
end
