class Page
  attr_accessor :number, :is_active
  alias_method :is_active?, :is_active

  def initialize(num)
    @number = num
    @is_active = false
  end

end