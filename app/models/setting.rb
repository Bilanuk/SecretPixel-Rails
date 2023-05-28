class Setting < ApplicationRecord
  belongs_to :user

  enum color: {
    red_blue: 'RED_BLUE',
    green_yellow: 'GREEN_YELLOW',
    purple_orange: 'PURPLE_ORANGE'
}, _prefix: true

  enum method: {
    snowflake: 'KOCH_SNOWFLAKE',
    carpet: 'SERPINSKI_CARPET',
    triangle: 'SERPINSKI_TRIANGLE'
  }, _prefix: true
end
