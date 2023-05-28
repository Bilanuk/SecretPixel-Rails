class Setting < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :image, optional: true

  enum color: {
    red_blue: 'RED_BLUE',
    green_yellow: 'GREEN_YELLOW',
    purple_orange: 'PURPLE_ORANGE',
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
