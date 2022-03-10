require 'mittsu'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
ASPECT = SCREEN_WIDTH.to_f / SCREEN_HEIGHT.to_f

scene = Mittsu::Scene.new
camera = Mittsu::PerspectiveCamera.new(75.0, ASPECT, 0.1, 1000.0)

renderer = Mittsu::OpenGLRenderer.new width: SCREEN_WIDTH, height: SCREEN_HEIGHT, title: '10 OBJ Loader heart'
renderer.shadow_map_enabled = true
renderer.shadow_map_type = Mittsu::PCFSoftShadowMap

loader = Mittsu::OBJMTLLoader.new

heart = loader.load('heart5.obj', 'heart5.mtl')


scene.add(heart)

# 特定の方向からシーンを照らす平行光源
scene.add Mittsu::DirectionalLight.new(0xffffff)

# 環境光（拡散環境光）を発する光源
scene.add Mittsu::AmbientLight.new(0xffffff)

# 設置した位置から全方位に対して 光を発する光源
# scene.add Mittsu::PointLight.new(0xffffff, 1.0)

# 「スポットライト」として用いる光源
# scene.add Mittsu::SpotLight.new(0xffffff, 1.0)


# light = Mittsu::SpotLight.new(0xffffff, 1.0)
# light.position.set(0.0, -150.0, 10.0)


# light.cast_shadow = true
# light.shadow_darkness = 0.5

# light.shadow_map_width = 1024
# light.shadow_map_height = 1024

# light.shadow_camera_near = 1.0
# light.shadow_camera_far = 2000.0
# light.shadow_camera_fov = 60.0

# light.shadow_camera_visible = false
# scene.add(light)

camera.position.z = 10.0
camera.position.y = 0.0

renderer.window.run do
  heart.rotation.y += 0.01
  renderer.render(scene, camera)
end
