class Bullet
  attr_accessor :mesh
  attr_reader :invalid

  def initialize(x, y, z, scene)
    @mesh = Mittsu::Mesh.new(
      # Mittsu::BoxGeometry.new(0.05, 0.05, 0.25),
      # Mittsu::BoxGeometry.new(1, 1, 1, 4, 4, 4),
      Mittsu::SphereGeometry.new(0.1, 16, 16),
      # Mittsu::PlaneGeometry.new(4, 1, 4, 4),
      # Mittsu::MeshLambertMaterial.new(color: 0xDFD000)
      Mittsu::MeshPhongMaterial.new(color: 0xDFD000)
    )
    @mesh.position.set(x, y, z)
    @gravitytop=0.01
    # @gravitydown=1
    @scene = scene
    @invalid = false
  end

    
  def update(enemies, enemies2, enemies4, enemies5, enemies6, enemies7)
    @mesh.position.z -= 0.45
    @gravitytop *= 1.12
    @mesh.position.y -= @gravitytop
    check(enemies, enemies2, enemies4, enemies5, enemies6, enemies7)
  end
  def check(enemies, enemies2, enemies4, enemies5, enemies6, enemies7)
    (enemies + enemies2 + enemies4 + enemies5 + enemies6 + enemies7 ).each do |enemy|
      if @mesh.position.distance_to(enemy.mesh.position) <= (enemy.distance)
        @scene.remove(@mesh)
        @invalid = true
        enemy.invalid!
        @scene.remove(enemy.mesh)
      end
    end
  end
end