class Setting < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :image, optional: true

  enum color: {
    white_black: 'WHITE_BLACK',
    black_white: 'BLACK_WHITE',
    na: 'NA'
}, _prefix: true

  enum method: {
    snowflake: 'KOCH_SNOWFLAKE',
    carpet: 'SERPINSKI_CARPET',
    triangle: 'SERPINSKI_TRIANGLE',
    na: 'NA'
  }, _prefix: true

  validates :color, inclusion: { in: colors.keys }
  validates :method, inclusion: { in: methods.keys }
end
