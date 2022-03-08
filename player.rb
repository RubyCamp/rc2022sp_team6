require_relative 'bullet'

class Player
  attr_accessor :mesh

  def initialize(x, y, z)
    @mesh = Mittsu::Mesh.new(
      Mittsu::BoxGeometry.new(1.0, 1.0, 1.0),
      Mittsu::MeshBasicMaterial.new(color: 0x00ff00)
    )
    @mesh.position.set(x, y, z)
    @bullets = []
  end

  def update(renderer, scene)
    @mesh.position.y += 0.01 if renderer.window.key_down?(GLFW_KEY_UP)
    @mesh.position.y -= 0.01 if renderer.window.key_down?(GLFW_KEY_DOWN)
    @mesh.position.x -= 0.01 if renderer.window.key_down?(GLFW_KEY_LEFT)
    @mesh.position.x += 0.01 if renderer.window.key_down?(GLFW_KEY_RIGHT)
    @mesh.position.z += 0.01 if renderer.window.key_down?(GLFW_KEY_Z)
    @mesh.position.z -= 0.01 if renderer.window.key_down?(GLFW_KEY_A)

    renderer.window.on_key_typed do |key|
      case key
      when GLFW_KEY_SPACE
        bullet = Bullet.new(@mesh.position.x, @mesh.position.y, @mesh.position.z)
        scene.add(bullet.mesh)
        @bullets << bullet
      end
    end

    @bullets.each do |bullet|
      bullet.update
    end
  end

  def check(enemies, scene)
    enemies.each do |enemy|
      @bullets.each do |bullet|
        if bullet.mesh.position.distance_to(enemy.mesh.position) <= 0.1 + 0.5
          enemy.mesh.material.color.set(0xff0000)
          scene.remove(bullet.mesh)
          @bullets.delete(bullet)
        else
          # 衝突してない
        end
      end
    end
  end
end