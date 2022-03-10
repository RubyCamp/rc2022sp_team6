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
require_relative 'goal_ruby'
require_relative 'boss_bullet'



class Game
  attr_accessor :game_end
  def initialize(renderer, screen_width, screen_height)
    @renderer = renderer
    renderer.auto_clear = false

    @game_end = false

    @scene = Mittsu::Scene.new
    light = Mittsu::DirectionalLight.new(0xffffff, intensity = 1)
    light.position.set(100, 100, 100)
    @scene.add(light)
    @camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
    # camera.position.z = 20.0
    @score = Score.new(screen_width, screen_height)

    @enemies = [] # 的
    25.times do
      enemy = Enemy.new((rand(-5..5)).to_f, (rand(-5..5)).to_f, -40, @renderer, @scene)
      @scene.add(enemy.mesh)
      @enemies << enemy
    end

    #@ruby = Ruby.new(0, 0, -20, @renderer, @scene) #ruby追記
    #@scene.add(@ruby.mesh)
    @rubies = []
=begin
    40.times do
      ruby = Ruby.new((rand(1..11) - 6).to_f, (rand(1..11) - 6).to_f, -45.0, @renderer, @scene)
      @scene.add(ruby.mesh)
      @rubies << ruby
    end
=end
    for i in 0..14 do
      theta_ruby = Math::PI*24/180*i
      ruby = Ruby.new(Math.cos(theta_ruby)*5, Math.sin(theta_ruby)*3, -45.0, @renderer, @scene)
      @scene.add(ruby.mesh)
      @rubies << ruby
    end
    for i in 0..9 do
      theta_ruby = Math::PI*36/180*i
      ruby = Ruby.new(Math.cos(theta_ruby)*10/3, Math.sin(theta_ruby)*2, -45.0, @renderer, @scene)
      @scene.add(ruby.mesh)
      @rubies << ruby
    end
    for i in 0..4 do
      theta_ruby = Math::PI*72/180*i
      ruby = Ruby.new(Math.cos(theta_ruby)*5/3, Math.sin(theta_ruby), -45.0, @renderer, @scene)
      @scene.add(ruby.mesh)
      @rubies << ruby
    end
    ruby = Ruby.new(0, 0, -45.0, @renderer, @scene)
    @scene.add(ruby.mesh)
    @rubies << ruby

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
    15.times do
      enemy2 = Enemy2.new(rand(-5..5), rand(-5..5).to_f, -25.0, @renderer, @scene)
      @scene.add(enemy2.mesh)
      @enemies2 << enemy2
    end


    # 赤い壁 Z=-15.0
    # @enemy3 = Enemy3.new(0.0, 0.0, -15.0, @renderer, @scene)
    # @scene.add(@enemy3.mesh)

    @enemies4 = [] # オレンジの多面体（回転）Z=-10.0
    5.times do
      enemy4 = Enemy4.new(rand(-5..5).to_f, 3.0, -10.0, @renderer, @scene)
      @scene.add(enemy4.mesh)
      @enemies4 << enemy4
    end

    @enemies5 = [] # pink色の壁 Z=-5.0
    4.times do
      enemy5 = Enemy5.new(-5.0, rand(-5..5).to_f, -5.0, @renderer, @scene)
      @scene.add(enemy5.mesh)
      @enemies5 << enemy5
    end

    @enemies6 = [] # mintの球 Z=1.0
    1.times do
      enemy6 = Enemy6.new(0.0, -5.0, 1.0, @renderer, @scene)
      @scene.add(enemy6.mesh)
      @enemies6 << enemy6
    end

    @enemies7 = [] # たまご色の壁 Z=15
    3.times do
      enemy7 = Enemy7.new(3.0, rand(-4..3).to_f, 10.0, @renderer, @scene)
      @scene.add(enemy7.mesh)
      @enemies7 << enemy7
    end

    @enemies_virus = [] #コロナウイルス
    4.times do
      enemy_virus = Enemy_virus.new(rand(-3..5).to_f, rand(-3..5).to_f, 0.0, @renderer, @scene)
      @scene.add(enemy_virus.mesh)
      @enemies_virus << enemy_virus
    end

    @player = Player.new(0, 0, 20.0, @renderer, @scene, @score)
    @scene.add(@player.mesh)
    @player.mesh.add(@camera)
  end

  def play
    #@player.update
    #@ruby.update
    @rubies.each do |ruby|
      ruby.update
    end
    # @player.update(@enemies, @enemies2, @enemies4, @enemies5, @enemies6, @enemies7)

    @enemies.each do |enemy|
      enemy.update(@player)
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

    # if @renderer.window.key_down?(GLFW_KEY_ESCAPE)
    if @player.mesh.position.z < -50
      @game_end = true
    end

    @player.update(@enemies, @enemies2, @enemies4, @enemies5, @enemies6, @enemies7)

    @player.check(@enemies, @enemies2, @enemies4, @enemies5, @enemies6, @enemies7)

    @score.update_points

    @player.bullets.each do |bullet|
      if bullet.mesh.position.y <= -10
        @scene.remove(bullet.mesh)
        @player.bullets.delete(bullet)
      end
    end

    # @boss.bullets.each do |boss_bullet|
    #   if boss_bullet.mesh.position.z >= 60
    #     @scene.remove(boss_bullet.mesh)
    #     @boss.bullets.delete(boss_bullet)
    #   end
    # end


    @enemies.delete_if {|enemy| enemy.invalid}
    @enemies2.delete_if {|enemy| enemy.invalid}
    @enemies4.delete_if {|enemy| enemy.invalid}
    @enemies5.delete_if {|enemy| enemy.invalid}
    @enemies6.delete_if {|enemy| enemy.invalid}
    @enemies7.delete_if {|enemy| enemy.invalid}
    @renderer.clear
    @renderer.render(@scene, @camera)
    @renderer.render(@score.scene, @score.camera)
  end
end
