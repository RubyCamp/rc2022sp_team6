class Bullet
  attr_accessor :mesh

  def initialize(x, y, z)
    @mesh = Mittsu::Mesh.new(
      # Mittsu::BoxGeometry.new(0.05, 0.05, 0.25),
      # Mittsu::BoxGeometry.new(1, 1, 1, 4, 4, 4),
      Mittsu::SphereGeometry.new(0.1, 16, 16),
      # Mittsu::PlaneGeometry.new(4, 1, 4, 4),
      # Mittsu::MeshLambertMaterial.new(color: 0xDFD000)
      Mittsu::MeshPhongMaterial.new(color: 0xDFD000)
    )
    @mesh.position.set(x, y, z)
  end

  def update
    @mesh.position.z -= 0.2
  end
end