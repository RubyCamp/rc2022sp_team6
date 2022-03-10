class BossBullet
  attr_accessor :mesh
  attr_reader :invalid

  def initialize(x, y, z, scene, player)
    # puts 1111
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(0.3, 0.3, 0.5),
      Mittsu::MeshPhongMaterial.new(color: 0x1f8e83)
    )
    # p 111
    @mesh.position.set(x, y, z)
    # p 1212
    # @gravitytop=0.01
    # p 333
    # @gravitydown=1
    @scene = scene
    # @invalid = false
    # puts 2222
    # p  player.position.x
    # p x
    @player = player
    @vx = player.mesh.position.x - x
    @vy = player.mesh.position.y - y
    @vz = player.mesh.position.z - z
    # puts 111
  end

  def update
    @mesh.position.x += @vx / 54
    @mesh.position.y += @vy / 54
    @mesh.position.z += @vz / 54
    check
  end

  def check
      if @mesh.position.distance_to(@player.mesh.position) <= (1)
        @scene.remove(@mesh)
        @invalid = true
        @player.reset_position
      end
  end
end