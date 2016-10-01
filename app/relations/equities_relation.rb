class EquitiesRelation < ROM::Relation[Application::ORM]
  register_as :equities

  dataset Table::EQUITIES_TABLE_NAME

  use :pagination

  use :time_series

  def by_ticker(ticker)
    restrict(key_conditions: {
      ticker: {
        comparison_operator: 'EQ',
        attribute_value_list: [ticker]
      }
    })
  end

  def by_ascending
    restrict(scan_index_forward: true)
  end

  def by_descending
    restrict(scan_index_forward: false)
  end
end
