class ReimbursementCalculator
  LOW_COST_CITY_TRAVEL_DAY_RATE = 45
  HIGH_COST_CITY_TRAVEL_DAY_RATE = 55
  LOW_COST_CITY_FULL_DAY_RATE = 75
  HIGH_COST_CITY_FULL_DAY_RATE = 85
  LOW_COST_CITY = "Low Cost City".freeze

  def initialize(projects)
    @projects = projects
  end

  def calculate
    @projects.sort_by! { |project| project.start_date }
    total_reimbursement = 0

    @projects.each_with_index do |project, index|
      total_reimbursement += travel_day_rate(project.city_type) if index == 0
      total_reimbursement += travel_day_rate(project.city_type) if index == @projects.length - 1

      gap = 0
      if @projects[index + 1]
        gap = @projects[index + 1].start_date - project.end_date
        if gap > 1
          total_reimbursement += travel_day_rate(project.city_type)
          total_reimbursement += travel_day_rate(@projects[index + 1].city_type)
        end
      end

      total_reimbursement += full_day_reimbursement(project, gap, index)
    end

    total_reimbursement.to_i
  end

  private

  def travel_day_rate(city_type)
    city_type == LOW_COST_CITY ? LOW_COST_CITY_TRAVEL_DAY_RATE : HIGH_COST_CITY_TRAVEL_DAY_RATE
  end

  def full_day_rate(city_type)
    city_type == LOW_COST_CITY ? LOW_COST_CITY_FULL_DAY_RATE : HIGH_COST_CITY_FULL_DAY_RATE
  end

  def full_day_reimbursement(project, gap, index)
    full_day_reimbursement = full_day_rate(project.city_type)
    if gap <= 1 && index != 0 && index != (@projects.length - 1)
      check_full_days(project, index, full_day_reimbursement)
    elsif (project.end_date - project.start_date - 1) > 0
      previous_gap(project, index, full_day_reimbursement)
    else
      0
    end
  end

  def check_full_days(project, index, full_day_reimbursement)
    if (project.start_date != project.end_date) ||
      (project.start_date == project.end_date && project.start_date != @projects[index - 1].end_date)
      if project.start_date > @projects[index - 1].end_date + 1
        (project.end_date - project.start_date) * full_day_reimbursement
      else
        (project.end_date - project.start_date + 1) * full_day_reimbursement
      end
    else
      0
    end
  end

  def previous_gap(project, index, full_day_reimbursement)
    if index == 0 || project.start_date > @projects[index - 1].end_date + 1
      (project.end_date - project.start_date - 1) * full_day_reimbursement
     else
       (project.end_date - project.start_date) * full_day_reimbursement
     end
  end
end
