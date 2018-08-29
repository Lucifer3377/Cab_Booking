#Created by Chandel on 29/08/2018

def min_max(*args)
   sum = 0
    args.each do |e|
    sum = sum + e
    end
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
    for i in (0...len)
        for j in (0...len)
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
   puts args.inject(1) {|pro,ele| pro * ele}
end

def group_by_marks(marks,cut_off)
    pass_arr = []
    fail_arr = []
    marks.each do |k,v|
        if v < cut_off
            fail_arr << [k.to_s,v]
        else
            pass_arr << [k.to_s,v]
        end
    end
    p Hash["Failed" => fail_arr,"Passed" => pass_arr]
end

#**************************************************************************#



ma = {"Ramesh":23, "Vivek":40, "Harsh":88, "Mohammad":60}
min_max(1,4,7,13,2)
count_large(1,2,4,6,4,6,9,9,9)
matrix_diff([[1,2,3],[4,5,6],[7,8,9]])
all_product(1,2,4)
group_by_marks(ma,30)
