require_relative 'player'
require_relative 'boss'
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
    light = Mittsu::DirectionalLight.new(0xffffff, intensity = 1)
    light.position.set(50, 50, 1)
    @scene.add(light)
    @camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
    # camera.position.z = 20.0
    @score = Score.new(screen_width, screen_height)

    @enemies = []
    5.times do
      enemy = Enemy.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, -5, @renderer, @scene)
      @scene.add(enemy.mesh)
      @enemies << enemy
    end

    @enemies2 = []
    enemy2 = Enemy2.new(2.5, 1.5, 4, @renderer, @scene)
    @scene.add(enemy2.mesh)
    @enemies2 << enemy2

    @enemies3 = []
    enemy3 = Enemy3.new(-0.5, 3.5, 4, @renderer, @scene)
    @scene.add(enemy3.mesh)
    @enemies3 << enemy3

    @enemies4 = []
    enemy4 = Enemy4.new(2.0, 3, 0.0, @renderer, @scene)
    @scene.add(enemy4.mesh)
    @enemies4 << enemy4

    @enemies5 = []
    enemy5 = Enemy5.new(1.0, 4, 0.0, @renderer, @scene)
    @scene.add(enemy5.mesh)
    @enemies5 << enemy5

    @enemies6 = []
    enemy6 = Enemy6.new(0, 5, 0.0, @renderer, @scene)
    @scene.add(enemy6.mesh)
    @enemies6 << enemy6

    @enemies7 = []
    enemy7 = Enemy7.new(1, 0, 4, @renderer, @scene)
    @scene.add(enemy7.mesh)
    @enemies7 << enemy7

    @player = Player.new(0.0, 0, 10.0, @renderer, @scene, @score)
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
    @player.bullets.each do |bullet|
     
      if bullet.position.y <= -5
        @scene.remove(bullet)
      end
    end
    @renderer.clear
    @renderer.render(@scene, @camera)
    @renderer.render(@score.scene, @score.camera)

   
    
  
  end
end
