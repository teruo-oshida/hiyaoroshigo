class Vote < ApplicationRecord
  belongs_to :drinking

  MIN_SCORE = 1
  MAX_SCORE = 5
end
