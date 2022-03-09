require_relative 'player'
require_relative 'boss'
require_relative 'score'
require_relative 'enemy2'
require_relative 'enemy3'
require_relative 'enemy4'
require_relative 'enemy5'
require_relative 'enemy6'
require_relative 'enemy7'
require_relative 'enemy_coronavirus'



class Game
  def initialize(renderer, screen_width, screen_height)
    @renderer = renderer
    renderer.auto_clear = false

    @scene = Mittsu::Scene.new
    light = Mittsu::DirectionalLight.new(0xffffff, intensity = 1)
    light.position.set(100, 100, 100)
    @scene.add(light)
    @camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
    # camera.position.z = 20.0
    @score = Score.new(screen_width, screen_height)

    @enemies = [] # 的
    30.times do
      enemy = Enemy.new((rand(-5..5) - 3).to_f, (rand(-5..5) -3).to_f, -40, @renderer, @scene)
      @scene.add(enemy.mesh)
      @enemies << enemy
    end
    # k = Time.now
    # @renderer.window.on_key_typed do |key|
    #   case key
    #   when GLFW_KEY_SPACE
    #     n = Time.now
    #     if  n - k > 1
    #       5.times do
    #         enemy = Enemy.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, -30, @renderer, @scene)
    #         @scene.add(enemy.mesh)
    #         @enemies << enemy
    #       end
    #     end
    #   end
    # end

    @enemies2 = [] # ノット
    10.times do
      enemy2 = Enemy2.new((rand(1..10) -3), (rand(1..5) -3).to_f, -25.0, @renderer, @scene)
      @scene.add(enemy2.mesh)
      @enemies2 << enemy2
    end


    # 赤い壁 Z=-15.0
    # @enemy3 = Enemy3.new(0.0, 0.0, -15.0, @renderer, @scene)
    # @scene.add(@enemy3.mesh)

    @enemies4 = [] # オレンジの多面体（回転）Z=-10.0
    5.times do
      enemy4 = Enemy4.new((rand(1..20) - 3).to_f, 3.0, -10.0, @renderer, @scene)
      @scene.add(enemy4.mesh)
      @enemies4 << enemy4
    end

    @enemies5 = [] # pink色の壁 Z=-5.0
    2.times do
      enemy5 = Enemy5.new(-5.0, (rand(1..5) -3).to_f, -5.0, @renderer, @scene)
      @scene.add(enemy5.mesh)
      @enemies5 << enemy5
    end

    @enemies6 = [] # mintの球 Z=1.0
    1.times do
      enemy6 = Enemy6.new(0.0, -8.0, 1.0, @renderer, @scene)
      @scene.add(enemy6.mesh)
      @enemies6 << enemy6
    end

    @enemies7 = [] # たまご色の壁 Z=15
    2.times do
      enemy7 = Enemy7.new(3.0, (rand(1..5) -3).to_f, 15.0, @renderer, @scene)
      @scene.add(enemy7.mesh)
      @enemies7 << enemy7
    end

    @enemies_virus = [] #コロナウイルス
    5.times do
      enemy_virus = Enemy_virus.new((rand(1..5) -3).to_f, (rand(1..5) -3).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy_virus.mesh)
      @enemies_virus << enemy_virus
    end

    @player = Player.new(0.0, 0, 20.0, @renderer, @scene, @score)
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

    # @enemy3.update

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

    @enemies_virus.each do |enemy|
      enemy.update
    end

    @player.check(@enemies, @enemies2, @enemies4, @enemies5, @enemies6, @enemies7)

    @score.update_points
    @player.bullets.each do |bullet|
      if bullet.mesh.position.y <= -10
        @scene.remove(bullet.mesh)
        @player.bullets.delete(bullet)
        puts 1111
      end
    end
    @renderer.clear
    @renderer.render(@scene, @camera)
    @renderer.render(@score.scene, @score.camera)
  end
end
