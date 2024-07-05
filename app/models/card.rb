class Card < ApplicationRecord
  belongs_to :load_learnset
  validates :definition, :term, presence: true

  def multiple_choice(terms_and_definitions)
    terms_and_definitions.transform_values do |e|
      [e] + terms_and_definitions.values.reject { |defn| defn == e }.sample(rand(2..4)).shuffle
    end
  end
end
