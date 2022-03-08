require_relative 'player'
require_relative 'enemy'
require_relative 'score'

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
      enemy3 = Enemy3.new(-5.0, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy3.mesh)
      @enemies3 << enemy3
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


    @player.check(@enemies)

    @score.update_points

    @renderer.clear
    @renderer.render(@scene, @camera)
    @renderer.render(@score.scene, @score.camera)
  end
end
