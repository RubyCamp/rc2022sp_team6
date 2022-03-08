require_relative 'player'
require_relative 'enemy'

class Game
  def initialize
    @scene = Mittsu::Scene.new

    @camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
    # camera.position.z = 10.0

    @enemies = []

    5.times do
      enemy = Enemy.new((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0)
      @scene.add(enemy.mesh)
      @enemies << enemy
    end

    @player = Player.new(0.0, 0.0, 10.0)

    @scene.add(@player.mesh)

    @player.mesh.add(@camera)
  end

  def play(renderer)
    @player.update(renderer, @scene)

    @enemies.each do |enemy|
      enemy.update
    end

    @player.check(@enemies, @scene)

    renderer.render(@scene, @camera)
  end
end


