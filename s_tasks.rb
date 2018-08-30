#Created by Chandel on 29/08/2018

def min_max(*args)
    sum = args.sum
    puts "#{sum - args.max} #{sum - args.min}"
end

def count_large(*args)
    puts args.count(args.max)
end

def matrix_diff(matrix)
    sum1 = 0
    sum2 = 0
    matrix.each_with_index{ |a,i| sum1 += a[i] }
    matrix.each_with_index{ |a,i| sum2 += a[a.length-i-1] }
    p (sum1 - sum2).abs
end

def all_product(*args)
   puts args.inject(&:*)
end

def group_by_marks(marks,cut_off)
    p marks.group_by {|k,v| v < cut_off ? 'Failed' : 'Passed'}
    #h = Hash["Failed" => [],"Passed" => []]
    #marks.map {|k,v| v < cut_off ? (h["Failed"] << [k.to_s,v]) : (h["Passed"] << [k.to_s,v])}
    #p h
end

#**************************************************************************#



ma = {"Ramesh":23, "Vivek":40, "Harsh":88, "Mohammad":60}
min_max(1,4,7,13,2)
count_large(1,2,4,6,4,6,9,9,9)
matrix_diff([[1,2,3],[4,5,6],[7,8,9]])
all_product(1,2,4)
group_by_marks(ma,30)
