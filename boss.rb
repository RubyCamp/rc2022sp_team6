require_relative './boss_bullet'

class Enemy
  attr_accessor :mesh
  attr_reader :invalid, :distance

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(1, 1, 1),
      Mittsu::MeshPhongMaterial.new(color: 0x0000ff)
    )
    @mesh.position.set(x, y, z)

    @renderer = renderer
    @scene = scene
    @invalid = false
    @distance = 2
    @lasttime = Time.now
    @bullets = []
  end

  def update(player)
    # p player
    @mesh.rotation.x += 0.1
    @mesh.rotation.y += 0.1
    nowtime=Time.now
    if nowtime - @lasttime > (rand(5..30)) && (@mesh.position.z - player.mesh.position.z).abs <= 50
      boss_bullet = BossBullet.new(@mesh.position.x, @mesh.position.y, @mesh.position.z, @scene, player)

      @scene.add(boss_bullet.mesh)
      @bullets << boss_bullet
      @lasttime = nowtime
      # shotcount -= 1
    end

    @bullets.each do |bullet|
      bullet.update
    end
  end
  def invalid!
    @invalid = true
  end
  def invalid!
    @invalid = true
  end
end
