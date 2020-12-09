class MonitoringsStudent < ApplicationRecord
  belongs_to :user
  belongs_to :monitoring
end
