FactoryGirl.define do
  factory :equity, class: Equity do
    ticker { ('a'..'z').to_a.sample(rand(2..4)).join }

    sequence(:updated_at) { |n| Time.now.utc.to_f + (n * 60) }

    high { rand(Math::E..Math::PI) + 4 }

    low { rand(Math::E..Math::PI) + 2 }

    last { rand(Math::E..Math::PI) }

    volume { rand(10000..40000) }

    change { rand(Math::E..Math::PI) }

    bid { rand(Math::E..Math::PI) + 2 }

    ask { rand(Math::E..Math::PI) + 6 }

    initialize_with { Equity.new attributes }
  end
end
