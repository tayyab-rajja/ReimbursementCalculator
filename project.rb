class Project
  attr_reader :start_date, :end_date, :city_type

  def initialize(start_date, end_date, city_type)
    @start_date = Date.strptime(start_date, "%m/%d/%y")
    @end_date = Date.strptime(end_date, "%m/%d/%y")
    @city_type = city_type
  end
end
