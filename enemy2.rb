class Enemy2  # 小さい障害物ノット
  attr_accessor :mesh

  def initialize(x, y, z, renderer, scene)
    @mesh = Mittsu::Mesh.new(
      Mittsu::TorusKnotGeometry.new(0.5, 0.15),
      Mittsu::MeshBasicMaterial.new(color: 0x009140)
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