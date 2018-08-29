#Created by Chandel on 29/08/2018

def min_max(*args)
    sum = args.inject(&:+)
    puts "#{sum - args.max} #{sum - args.min}"
end

def count_large(*args)
    puts args.count(args.max)
end

def matrix_diff(matrix)
    matrix.each do |e|
        if (matrix.length != e.length)
            puts "Not a square matrix"
            return
        end
    end
    len = matrix.length
    first_diag = 0
    sec_diag = 0
    (0...len).each do |i|
        (0...len).each do |j|
            if (i == j)                
                first_diag += matrix[i][j]      
            end
            if (i == len - j - 1)
                sec_diag += matrix[i][j]
            end

        end
    end
    
    p (first_diag - (sec_diag)).abs
end

def all_product(*args)
   puts args.inject(&:*)
end

def group_by_marks(marks,cut_off)
    h = Hash["Failed" => [],"Passed" => []]
    marks.each {|k,v| v < cut_off ? (h["Failed"] << [k.to_s,v]) : (h["Passed"] << [k.to_s,v])}
    p h
end

#**************************************************************************#



ma = {"Ramesh":23, "Vivek":40, "Harsh":88, "Mohammad":60}
min_max(1,4,7,13,2)
count_large(1,2,4,6,4,6,9,9,9)
matrix_diff([[1,2,3],[4,5,6],[7,8,9]])
all_product(1,2,4)
group_by_marks(ma,30)
