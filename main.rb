require_relative "project"
require_relative "reimbursement_calculator"
require "Date"


set1 = [ Project.new("9/1/15", "9/3/15", 'Low Cost City') ]
set1_reimbursement = ReimbursementCalculator.new(set1)
puts "Set 1 Total Reimbursement: #{set1_reimbursement.calculate}"

set2 = [
  Project.new("9/1/15", "9/1/15", "Low Cost City"),
  Project.new("9/2/15", "9/6/15", "High Cost City"),
  Project.new("9/6/15", "9/8/15", "Low Cost City"),
]
set2_reimbursement = ReimbursementCalculator.new(set2)
puts "Set 2 Total Reimbursement: #{set2_reimbursement.calculate}"

set3 = [
  Project.new("9/1/15", "9/3/15", "Low Cost City"),
  Project.new("9/5/15", "9/7/15", "High Cost City"),
  Project.new("9/8/15", "9/8/15", "High Cost City"),
]
set3_reimbursement = ReimbursementCalculator.new(set3)
puts "Set 3 Total Reimbursement: #{set3_reimbursement.calculate}"

set4 = [
  Project.new("9/1/15", "9/1/15", "Low Cost City"),
  Project.new("9/1/15", "9/1/15", "Low Cost City"),
  Project.new("9/2/15", "9/2/15", "High Cost City"),
  Project.new("9/2/15", "9/3/15", "High Cost City"),
]
set4_reimbursement = ReimbursementCalculator.new(set4)
puts "Set 4 Total Reimbursement: #{set4_reimbursement.calculate}"
