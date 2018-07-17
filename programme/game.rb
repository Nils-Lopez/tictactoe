class Game
  attr_accessor :players, :board

  def initialize
    # Créé 2 joueurs, créé un board
    puts "
    ╦  ╔═╗╔╦╗╗╔═╗  ╔═╗╦  ╔═╗╦ ╦
    ║  ║╣  ║  ╚═╗  ╠═╝║  ╠═╣╚╦╝
    ╩═╝╚═╝ ╩  ╚═╝  ╩  ╩═╝╩ ╩ ╩
    ╔╦╗╦╔═╗   ╔╦╗╔═╗╔═╗   ╔╦╗╔═╗╔═╗  │ │
     ║ ║║      ║ ╠═╣║      ║ ║ ║║╣   │ │
     ╩ ╩╚═╝    ╩ ╩ ╩╚═╝    ╩ ╚═╝╚═╝  o o
    \n\n" #texte au format ascii
#créé le player1, une nouvelle instance de le classe Player, lui demande son nom et lui attribue un symbole.
#Le '.blue.bold' est une méthode de la gem colorize
    puts 'Quel est le nom du premier joueur ?'
    print '> '
    player1_firstname = gets.chomp
    player1 = Player.new(player1_firstname, 'X'.blue.bold)
    puts '_' * 37
    puts
    puts 'Quel est le nom du deuxième joueur ?'
    print '> '
    player2_firstname = gets.chomp
    player2 = Player.new(player2_firstname, 'O'.red.bold)

    @players = [player1, player2] #créé un array des joueurs pour pouvoir opérer l'alternance - @players[0] = player 1 / @players[1] = player2
    @board = Board.new
  end

  def launch_game
    # Lance la partie
    #il y a 9 tours maximum, sinon il y a une égalité
    9.times do |i|
      #appelle @board.victory pour déterminer avant chaque tour si une condition de victoire est remplie? Si non, on lance le prochain tour, si oui, on retrouve le nom du joueur qui a gagné pour l'afficher

      if @board.victory? == 0
        turn(i)
      else
        if @board.victory? == 1 #si le joueur ayant les 'X' gagne (voir méthode victory? dans game.rb)
          puts "#{@players[0].firstname} is the "
          puts "
      ╦ ╦ ╦ ╔╗╔ ╔╗╔ ╔═╗ ╦═╗  │
      ║║║ ║ ║║║ ║║║ ║╣  ╠╦╝  │
      ╚╩╝ ╩ ╝╚╝ ╝╚╝ ╚═╝ ╩╚═  o "

        else #si le joueur ayant les 'O' gagne (voir méthode victory? dans game.rb)
          puts "#{@players[1].firstname} is the "
          puts "
      ╦ ╦ ╦ ╔╗╔ ╔╗╔ ╔═╗ ╦═╗  │
      ║║║ ║ ║║║ ║║║ ║╣  ╠╦╝  │
      ╚╩╝ ╩ ╝╚╝ ╝╚╝ ╚═╝ ╩╚═  o "
        end
        exit
      end
    end
    puts "
      ╔╦╗╦╔═╗  │
       ║ ║║╣   │
       ╩ ╩╚═╝  o "
  end

  def turn(i)
    n = i % 2 #A chaque itération, i est incrémenté de 1, n est pair ou impair, n = i % 2 vaut 0 ou 1
    puts "#{@players[n].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
    choice = gets.chomp.to_i
    #regarde si la valeur donnée par l'utilisateur est valide, si elle ne l'est pas, une boucle s'ouvre pour afficher la cause de l'invalidité et réafficher le formulaire. La boucle ne se ferme que quand les deux conditions sont respectées
    while !choice.between?(1, 9) || (@board.already_played?(choice) == true)
      if !choice.between?(1, 9)
        puts "Tu dois saisir un nombre entre 1 et 9 ! #{@players[n].firstname}, sur quelle case souhaites-tu vraiment jouer ?"
        choice = gets.chomp.to_i
      elsif @board.already_played?(choice) == true #reprend condition de la méthode définie dans la classe Board
        puts 'Cette case est déjà prise !'
        puts "#{@players[n].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
        choice = gets.chomp.to_i
      end
    end
    #si toutes les conditions de validité sont respectées, on appelle la méthode play (de la classe Board) qui remplace la valeur de la case par le symbole attribué au joueur et on affiche le résultat sur le board
    @board.play(choice, @players[n].type)
    @board.print_board
  end
end
