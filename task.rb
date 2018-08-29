#Created by Chandel on 28/08/2018

#************************************************************************#
#import modules

require 'logger'

#************************************************************************#

class Father
    @@log = Logger.new("log.txt")
    @@log.formatter = proc do |severity, datetime, progname, msg|
        date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
        if severity == "INFO" or severity == "WARN"
            "[#{date_format}] #{severity}  (#{progname}): #{msg}\n"
        else        
            "[#{date_format}] #{severity} (#{progname}): #{msg}\n"
        end
    end
    @@allarray = {"user" => [],"book" => [],"cab" => [],"pay" => [],"current_user" => ""}

    def self.display_all
        @@allarray.each do |k,v|
            p "key is #{k}"
            p "value is #{v}"
        end
    end

    def self.getHash
        @@allarray
    end

    def self.getLog
        @@log
    end

end

#************************************************************************#

class User < Father
    attr_accessor :name,:contact,:dob,:user_ID,:location
    def initialize
        @user_ID = nil
        @name = nil
        @contact = nil
        @dob = nil
        @location = nil
    end

    def addUser(u_name,u_contact,u_dob,u_loc)
        self.user_ID = 1 + Random.rand(100)
        self.name = u_name
        self.contact = u_contact
        self.dob = u_dob
        self.location = u_loc
        @@allarray["user"] << self
        #@@log.info(self.to_s)
    end

    def check_if_user_exists(u_name,u_dob)
        @@allarray["user"].each do |obj|
            if obj.name == u_name && obj.dob == u_dob
                @@allarray["current_user"] = obj.user_ID
                @@log.info(obj)
                return true
            else
                return false
            end
        end
    end

    def checkUser?(u_name)
        @@log.info(@@allarray["user"])
        if @@allarray["user"].count > 0
            @@allarray["user"].each do |obj|
                if obj.name == u_name
                    return true
                else
                    return false
                end
            end
        else
            return false
        end
    end
end
#**************************************************************************#

class BookCab < Father
    attr_accessor :booking_ID,:source,:destination,:cab_ID,:user_ID
    def initialize
        @user_ID = nil
        @booking_ID = nil
        @source = nil
        @cab_ID = nil
        @destination = nil

    end
    def confirmBooking(src,dst)
        self.booking_ID = 100 + Random.rand(100)
        self.source = src
        self.destination = dst
        user_id = @@allarray["current_user"].to_i
        self.user_ID = user_id
        loc ="" 
        @@allarray["user"].each do |e| 
            if e.user_ID == user_id
                loc = e.location
            end
        end
        cab_obj = Cab.new
        if(Cab.cab_avail(loc) > 0)
            p "\n\npicking cab"
            self.cab_ID = cab_obj.pick_cab(loc)
        else
            return nil
        end
        
        @@allarray["book"] << self
        fare_per_km = 0
        @@allarray["cab"].each do |e|
            if self.cab_ID == e.cab_ID
                fare_per_km = e.cost_per_km
            end
        end
        total_payment = fare_per_km*( 1 + Random.rand(10))
        Payment.new.addPay(user_id,self.cab_ID,total_payment)
        #@@log.info(self.to_s)
    end
end

#**************************************************************************#

class Cab < Father
    attr_accessor :cab_ID,:cab_location,:cab_availability,:cost_per_km
    def initialize
        @cab_ID = nil
        @cab_location = nil
        @cab_availability = true
        @cost_per_km = 0
    end

    def addCab(cab_loc,cost)
        self.cab_ID = 200 + Random.rand(300)
        self.cab_location = cab_loc
        self.cost_per_km = cost 

        @@allarray["cab"] << self
        #@@log.info(self)
    end

    def self.cab_avail(loc)
        cab_count = 0
        @@log.info(@@allarray["cab"])
        @@log.warn("location #{loc}")
        @@allarray["cab"].each do |cab|
            
            str1 = cab.cab_location.downcase
            str2 = loc.downcase
            @@log.info("cab_location => #{str1} user_location => #{str2}")
            if str1 == str2 && cab.cab_availability
                cab_count += 1
            end
        end
        cab_count
    end

    def pick_cab(loc)                                                           
        cab_array = []
        @@log.info("picking cab in #{loc}")
        @@log.info(@@allarray["cab"])
        @@allarray["cab"].each do |e| 
            str1 = e.cab_location.downcase
            str2 = loc.downcase
            @@log.info("matching for #{str1} and #{str2} #{str1.eql? str2}")

            cab_array << e if (str1 == str2) && (e.cab_availability)
        end
        @@log.info(cab_array)

        random_pick = (0 + Random.rand(cab_array.length))

        
        cab_array[random_pick].cab_availability = false
        cab_array[random_pick].cab_ID
    end
end

#**************************************************************************#

class Payment < Father
    attr_accessor :amount_rem,:user_ID,:cab_ID

    def initialize
        @amount_rem = 0
        @user_ID = nil
        @cab_ID = nil
    end

    def addPay(user,cab,amount)
        self.amount_rem = amount
        self.user_ID = user
        self.cab_ID = cab

        @@allarray["pay"] << self
        @@log.info(self)
    end

    def self.getFare
        user_id = @@allarray["current_user"]
        cab_id = ""
        @@allarray["book"].each do |e|
            if user_id == e.user_ID
                cab_id = e.cab_ID
            end
        end
        total_cost = 0
        @@allarray["pay"].each do |e|
            if cab_id.to_i == e.cab_ID
                total_cost = e.amount_rem
            end
        end
        total_cost
    end
end

#**************************************************************************#
#global functions

def user_menu
    print "Enter an option from the below menu\n 
            1. New User \n 
            2. Registered User \n
            3. Display Hashes \n
            4. Exit \n"
end

def cab_menu
    print "Choose an option from below\n
            1.Book Cab \n
            2.Check Cab Availability \n
            3.Go Back \n"
end

def payment_menu(dest)
    print "\n\n You've arrived at #{dest} \n
    1.Check fare \n
    2.Go Back"
end

def dummy_data
    Cab.new.addCab("Pune",10)
    Cab.new.addCab("Baner",20)
    Cab.new.addCab("Pune",10)
    Cab.new.addCab("Baner",10)
    Cab.new.addCab("Pune",10)
    Cab.new.addCab("Baner",20)
    Cab.new.addCab("Pune",20)
    Cab.new.addCab("Baner",30)
    Cab.new.addCab("Pune",10)
    Cab.new.addCab("Baner",10)
end

def pay_menu_logic(pay_option,dst)
    case pay_option.to_i
        
    when 1
        p "Please pay Rs #{Payment.getFare}"
        payment_menu(dst)
        print "=>"
        pay_option = gets
        pay_menu_logic(pay_option,dst)
    when 2
        Father.getHash["book"] = []
        cab_menu
        print "=>"
        cab_option = gets
        cab_menu_logic(cab_option)
        return
    end
end

def cab_menu_logic(book_choice)
    case book_choice.to_i
    when 1
        puts "Enter the pick up location"
        print "=>"
        src = gets
        puts "Enter the drop off location"
        print "=>"
        dst = gets
        if(!BookCab.new.confirmBooking(src.chomp,dst.chomp).nil?)
            p "\n\n Cab booked"
            payment_menu(dst)
            print "=>"
            pay_option = gets
            pay_menu_logic(pay_option,dst)
        else
            p "\n\n No Cabs avaialable"
        end
    when 2
        user_id = Father.getHash["current_user"]
        Father.getLog.info("user_ID => #{user_id}")
        user_location = ""
        Father.getHash["user"].each do |e| 
            if e.user_ID == user_id.to_i
                Father.getLog.info("location of user => #{e.location}")
                user_location = e.location 
            end
        end
        Father.getLog.info("user location => #{user_location}")
        p "#{Cab.cab_avail(user_location)} cabs are available"
        cab_menu
        print "=>"
        cab_option = gets
        cab_menu_logic(cab_option)

    when 3
        Father.getHash["current_user"] = ""
        return
    end
end

#********************************Menu driven logic**************************************#
user_menu
dummy_data
print "=>"
option = gets.to_i
loop do    
    case option
        when 1
            begin
                puts "Enter your name"
                print "=>"
                u_name = gets                    
                raise if User.new.checkUser?(u_name.chomp)
            rescue
                puts "User name already exists ! Please try another....."
                retry           
            end
            print "Enter your dob \n"
            print "=>"
            u_dob = gets
            print "Enter your current location (eg: pune)\n"
            print "=>"
            u_loc = gets
            print "Enter your contact number \n"
            print "=>"
            u_con = gets
            user = User.new
            user.addUser(u_name.chomp,u_con.chomp,u_dob.chomp,u_loc.chomp)
            user_menu
            print "=>"
            option = gets.to_i
        when 2
                puts "Enter your name"
                print "=>"
                name = gets
                puts "Enter your dob"
                print "=>"
                dob = gets
                if !User.new.check_if_user_exists(name.chomp,dob.chomp)
                    puts "The username or dob doesnot match..."
                else
                    cab_menu
                    print "=>"
                    cab_option = gets
                    cab_menu_logic(cab_option)

                end
                user_menu
                print "=>"
                option = gets.to_i
            
        when 3
            Father.display_all  
            user_menu
            print "=>"
            option = gets.to_i
        else 
            exit(true)
    end
end