require 'mittsu'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
ASPECT = SCREEN_WIDTH.to_f / SCREEN_HEIGHT.to_f

renderer = Mittsu::OpenGLRenderer.new width: SCREEN_WIDTH, height: SCREEN_HEIGHT, title: 'Hello, World!'

scene = Mittsu::Scene.new

camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)
# camera.position.z = 10.0

enemies = []
bullets = []

5.times do
  enemy = Mittsu::Mesh.new(
    Mittsu::BoxGeometry.new(1.0, 1.0, 1.0),
    Mittsu::MeshBasicMaterial.new(color: 0x0000ff)
  )
  enemy.position.set((rand(1..5) - 3).to_f, (rand(1..5) -3).to_f, 0.0)
  scene.add(enemy)
  enemies << enemy
end

player = Mittsu::Mesh.new(
  Mittsu::BoxGeometry.new(1.0, 1.0, 1.0),
  Mittsu::MeshBasicMaterial.new(color: 0x00ff00)
)
player.position.set(0.0, 0.0, 10.0)

scene.add(player)

player.add(camera)

renderer.window.run do
  player.position.y += 0.01 if renderer.window.key_down?(GLFW_KEY_UP)
  player.position.y -= 0.01 if renderer.window.key_down?(GLFW_KEY_DOWN)
  player.position.x -= 0.01 if renderer.window.key_down?(GLFW_KEY_LEFT)
  player.position.x += 0.01 if renderer.window.key_down?(GLFW_KEY_RIGHT)
  player.position.z += 0.01 if renderer.window.key_down?(GLFW_KEY_Z)
  player.position.z -= 0.01 if renderer.window.key_down?(GLFW_KEY_A)

  renderer.window.on_key_typed do |key|
    case key
    when GLFW_KEY_SPACE
      bullet = Mittsu::Mesh.new(
        Mittsu::BoxGeometry.new(0.2, 0.2, 0.2),
        Mittsu::MeshBasicMaterial.new(color: 0x00ff00)
      )
      bullet.position.set(player.position.x, player.position.y, player.position.z)
      scene.add(bullet)
      bullets << bullet
    end
  end

  bullets.each do |bullet|
    bullet.position.z -= 0.01
  end

  enemies.each do |enemy|
    bullets.each do |bullet|
      if bullet.position.distance_to(enemy.position) <= 0.1 + 0.5
        enemy.material.color.set(0xff0000)
        scene.remove(bullet)
        bullets.delete(bullet)
      else
        # 衝突してない
      end
    end
  end

  renderer.render(scene, camera)
end