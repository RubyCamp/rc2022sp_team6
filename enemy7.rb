class Enemy7  # たまご色
  attr_accessor :mesh

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(5.0, 10.0, 0.2),
      Mittsu::MeshBasicMaterial.new(color: 0xeaee6d)
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
