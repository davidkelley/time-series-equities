FactoryGirl.define do
  factory :equities_table, class: Hash do
    table_name { Table::EQUITIES_TABLE_NAME }

    attribute_definitions do
      [
        {
          attribute_name: :ticker,
          attribute_type: :S
        },
        {
          attribute_name: :updated_at,
          attribute_type: :N
        }
      ]
    end

    key_schema do
      [
        {
          attribute_name: :ticker,
          key_type: :HASH
        },
        {
          attribute_name: :updated_at,
          key_type: :RANGE
        }
      ]
    end

    provisioned_throughput do
      {
        :read_capacity_units => 1,
        :write_capacity_units => 1
      }
    end

    initialize_with { attributes }
  end
end
