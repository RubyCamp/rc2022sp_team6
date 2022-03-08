require_relative 'player'
require_relative 'enemy'
require_relative 'score'
require_relative 'enemy2'
require_relative 'enemy3'
require_relative 'enemy4'
require_relative 'enemy5'
require_relative 'enemy6'
require_relative 'enemy7'



class Game
  def initialize(renderer, screen_width, screen_height)
    @renderer = renderer
    renderer.auto_clear = false

    @scene = Mittsu::Scene.new
    @camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
    # camera.position.z = 10.0
    @score = Score.new(screen_width, screen_height)

    @enemies = []
    5.times do
      enemy = Enemy.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy.mesh)
      @enemies << enemy
    end

    @enemies2 = []
    2.times do
      enemy2 = Enemy2.new(5.0, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy2.mesh)
      @enemies2 << enemy2
    end

    @enemies3 = []
    2.times do
      enemy3 = Enemy3.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy3.mesh)
      @enemies3 << enemy3
    end

    @enemies4 = []
    2.times do
      enemy4 = Enemy4.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy4.mesh)
      @enemies4 << enemy4
    end

    @enemies5 = []
    2.times do
      enemy5 = Enemy5.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy5.mesh)
      @enemies5 << enemy5
    end

    @enemies6 = []
    2.times do
      enemy6 = Enemy6.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy6.mesh)
      @enemies6 << enemy6
    end

    @enemies7 = []
    2.times do
      enemy7 = Enemy7.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy7.mesh)
      @enemies7 << enemy7
    end
    
    @player = Player.new(0.0, 0.0, 10.0, @renderer, @scene, @score)
    @scene.add(@player.mesh)
    @player.mesh.add(@camera)
  end

  def play
    @player.update

    @enemies.each do |enemy|
      enemy.update
    end
    @enemies2.each do |enemy|
      enemy.update
    end

    @enemies3.each do |enemy|
      enemy.update
    end

    @enemies4.each do |enemy|
      enemy.update
    end

    @enemies5.each do |enemy|
      enemy.update
    end

    @enemies6.each do |enemy|
      enemy.update
    end

    @enemies7.each do |enemy|
      enemy.update
    end


    @player.check(@enemies)

    @score.update_points

    @renderer.clear
    @renderer.render(@scene, @camera)
    @renderer.render(@score.scene, @score.camera)
  end
end
