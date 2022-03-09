class Enemy6  # mintの障害物
  attr_accessor :mesh

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::SphereGeometry.new(5, 32, 16),
      Mittsu::MeshBasicMaterial.new(color: 0x6deeccf) # mint
    )
    @mesh.position.set(x, y, z)

    @renderer = renderer
    @scene = scene
  end

  def update
    # @mesh.rotation.x += 0.1
    # @mesh.rotation.y += 0.1
    # @mesh.position.z += 0.01
  end
end
