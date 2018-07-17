
class Game
  attr_accessor :players, :board

  def initialize
    # Créé 2 joueurs, créé un board
    puts
    puts    '   ╦  ╔═╗╔╦╗╗╔═╗  ╔═╗╦  ╔═╗╦ ╦ '
    puts    '   ║  ║╣  ║  ╚═╗  ╠═╝║  ╠═╣╚╦╝ '
    puts    '   ╩═╝╚═╝ ╩  ╚═╝  ╩  ╩═╝╩ ╩ ╩  '
    puts    ' ╔╦╗╦╔═╗   ╔╦╗╔═╗╔═╗   ╔╦╗╔═╗╔═╗  │ │ '
    puts    '  ║ ║║      ║ ╠═╣║      ║ ║ ║║╣   │ │ '
    puts    '  ╩ ╩╚═╝    ╩ ╩ ╩╚═╝    ╩ ╚═╝╚═╝  o o '
    puts
    puts

    puts 'Quel est le nom du premier joueur ?'
    print '> '
    player1_firstname = gets.chomp
    player1 = Player.new(player1_firstname, 'X'.blue.bold)
    puts
    puts '_' * 38
    puts
    puts
    puts 'Quel est le nom du deuxième joueur ?'
    print '> '
    player2_firstname = gets.chomp
    player2 = Player.new(player2_firstname, 'O'.red.bold)

    @players = [player1, player2]
    @board = Board.new
  end

  def launch_game
    # Lance la partie
    9.times do |i|
      if @board.victory? == 0
        turn(i)
      else
        if @board.victory? == 1
          puts "#{@players[0].firstname} is the "
          puts
          puts '╦ ╦ ╦ ╔╗╔ ╔╗╔ ╔═╗ ╦═╗  │ '
          puts '║║║ ║ ║║║ ║║║ ║╣  ╠╦╝  │ '
          puts '╚╩╝ ╩ ╝╚╝ ╝╚╝ ╚═╝ ╩╚═  o '


        else
          puts "#{@players[1].firstname} is the "
          puts
          puts '╦ ╦ ╦ ╔╗╔ ╔╗╔ ╔═╗ ╦═╗  │ '
          puts '║║║ ║ ║║║ ║║║ ║╣  ╠╦╝  │ '
          puts '╚╩╝ ╩ ╝╚╝ ╝╚╝ ╚═╝ ╩╚═  o '
        end
        exit
      end
    end
    puts '╔╦╗╦╔═╗  │'
    puts ' ║ ║║╣   │'
    puts ' ╩ ╩╚═╝  o'
  end

  def turn(i)
    # Affiche le plateau, demande au joueur il joue quoi, passe au joueur suivant si la partie n'est pas finie
    n = i % 2
    puts "#{@players[i % 2].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
    choice = gets.chomp.to_i

    while !choice.between?(1, 9) || (@board.already_played?(choice) == true)
      if !choice.between?(1, 9)
        puts "Tu dois saisir un nombre entre 1 et 9 ! #{@players[n].firstname}, sur quelle case souhaites-tu vraiment jouer ?"
        choice = gets.chomp.to_i
      elsif @board.already_played?(choice) == true
        puts 'Cette case est déjà prise !'
        puts "#{@players[n].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
        choice = gets.chomp.to_i
      end
    end

    @board.play(choice, @players[n].type)
    @board.print_board
  end
end
