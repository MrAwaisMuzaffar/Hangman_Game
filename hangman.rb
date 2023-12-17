# I need a function that can select a random english word 
# whose length is beteen 6 and 12 letters
def pick_word()
    guess_word = ""    
    lines = File.readlines('words.txt')
    while(guess_word =="") do
        random_number = rand(1..10000)
        if lines[random_number].length >= 7 && lines[random_number].length <=13
            guess_word = lines[random_number] 
        end
    end 
    guess_word
end
# I need a interface that will check what does the user want,
# 1 to play game,  2 to see old scored, 
# if play game, user will decide which type of game does user wants
# to paly is , with limited time or free time
def choose()
    puts "Press 1 to play the game"
    puts "Press 2 to continue."
    puts "Press 3 to see scores."
    puts "Press 3 to quit "
    input = gets.to_i
        if input == 1 
            puts "Press 1  to see timed game and 2 for regular."
            input = gets.to_i
            if input ==1 
                regularGame(1)       
            else
                regularGame(0)
            end
        elsif input == 2
           puts  regularGame(2)
        
        else
            return
        end
        
end

def regularGame (isTimed)
    time = Time.now
    is_correct = 0
    if(isTimed == 2)
        file_data = File.readlines('savedGame.txt')
        max_time = time.strftime("%S").to_i+file_data[0].to_i
        wrong_guesses = file_data[1].to_i
        guess = file_data[2] 
        word= file_data[3]
        isTimed =file_data[4]
        puts "Word is #{file_data[2]}"
    else
        wrong_guesses = 6
        word = pick_word().chomp
        guess ="".rjust(word.length,'_')
        max_time = time.strftime("%S").to_i+120
       
    end

        while 1
        currnet_time = Time.now.strftime("%S").to_i
        puts "You have got #{wrong_guesses} guesse."
       
        if isTimed ==1
           puts "You have got #{max_time - currnet_time } seconds."
        end
         
        puts "Your word is #{guess}, cheat #{word}"
        puts "Enter your guess OR ss to save the game."
        input = gets.chomp        
# Here the file will be saved if wanted.
# first time,then guesses left and at last word. 
       if (input == "ss")  
            File.open("savedGame.txt","w") do |file|
                file.puts (max_time - currnet_time)
                file.puts wrong_guesses
                file.puts guess
                file.puts word
                file.puts isTimed
                puts "Your progress is saved"
                return
            end
        end
        word.split("").each_with_index do |letter ,index|
                if letter == input
                    guess[index] = letter 
                    is_correct = 1
                end
        
            end
        
        if guess == word
            puts "You have won the game!"
            return 
        elsif wrong_guesses == 0
            puts "You have lost,Why not try again!"
            return
        elsif max_time - Time.now.to_i>=0 && isTimed ==1 
            puts"Pardon! Time is reached!"
            return 
        end
    end
    if is_correct ==0
        wrong_guesses = wrong_guesses -1
        is_correct =1
    end

end
choose()
