class User < ApplicationRecord
  has_many :jidoris

  def total_points
    if self.jidoris.size <= 0
      return 0
    else
      return self.jidoris.pluck(:points).inject(:+)
    end
  end
end
