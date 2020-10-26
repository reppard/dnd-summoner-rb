def get_sum_of_best_of_4d6
  4.times.collect{ 1 + rand(6) }.sort[1..3].sum
end

6.times do
  puts get_sum_of_best_of_4d6
end
