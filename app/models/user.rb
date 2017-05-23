class User < ActiveRecord::Base

  validates_length_of :password, in: 6..12

  def is_verify?
    self.is_verify ==0? false : true
  end
end
