<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3D Customization</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        #model-container {
            width: 100%;
            height: 500px;
            border: 2px solid gray;
            background-color: lightgray;
            overflow: hidden;
            position: relative;
        }

        .movable-text {
            position: absolute;
            color: white;
            font-size: 16px;
            cursor: move;
            background: rgba(0, 0, 0, 0.5);
            padding: 2px 6px;
            border-radius: 4px;
        }
    </style>
</head>

<body class="bg-gray-100">
    <header class="bg-blue-600 text-white p-4">
        <h1 class="text-2xl font-bold">3D Customization Tool</h1>
    </header>

    <main class="flex flex-col items-center justify-center py-10">
        <div class="w-full max-w-4xl bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold mb-4">Customize Your Model</h2>
            <div id="model-container">
                <!-- Draggable text area for user customization -->
                <div id="customText" class="movable-text">Your Text Here</div>
            </div>

            <!-- Text Input Field -->
            <div class="flex items-center mt-4">
                <label for="textInput" class="mr-2">Enter Text:</label>
                <input type="text" id="textInput" class="border rounded px-2 py-1" placeholder="Your Text Here" />
                <button class="bg-blue-500 text-white px-4 py-2 rounded ml-4 hover:bg-blue-600" id="updateTextBtn">Update Text</button>
            </div>

            <div class="flex justify-around items-center mt-4">
                <div class="flex items-center">
                    <label for="colorPicker" class="mr-2">Choose Color:</label>
                    <input type="color" id="colorPicker" class="border rounded" />
                </div>
                <button class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600" id="resetBtn">Reset</button>
                <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600" id="saveBtn">Save</button>
            </div>
        </div>
    </main>

    <footer class="bg-gray-800 text-white text-center p-4 mt-10">
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/build/three.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/GLTFLoader.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/exporters/GLTFExporter.js"></script>

    <script>
        const scene = new THREE.Scene();
        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        const renderer = new THREE.WebGLRenderer({ antialias: true });
        const container = document.getElementById('model-container');

        renderer.setSize(container.clientWidth, container.clientHeight);
        container.appendChild(renderer.domElement);

        const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
        scene.add(ambientLight);

        const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
        directionalLight.position.set(5, 5, 5);
        scene.add(directionalLight);

        const directionalLight2 = new THREE.DirectionalLight(0xffffff, 1);
        directionalLight2.position.set(-5, -5, -5);
        scene.add(directionalLight2);

        let model;

        const loader = new THREE.GLTFLoader();
        loader.load('models/tshirt.glb', (gltf) => {
            model = gltf.scene;
            model.scale.set(0.5, 0.5, 0.5);
            scene.add(model);

            const box = new THREE.Box3().setFromObject(model);
            const center = box.getCenter(new THREE.Vector3());
            model.position.set(-center.x, -center.y, 0);
            model.position.y += model.scale.y * (box.max.y - box.min.y) / 5;

            model.traverse((child) => {
                if (child.isMesh) {
                    child.material = new THREE.MeshStandardMaterial({
                        color: 0xffffff,
                        metalness: 0.5,
                        roughness: 0.5
                    });
                }
            });

            camera.position.z = Math.max(box.max.x, box.max.y, box.max.z) * 1.3;
        }, undefined, (error) => {
            console.error('Error loading model:', error);
        });

        const controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;
        controls.dampingFactor = 0.25;
        controls.screenSpacePanning = false;
        controls.maxPolarAngle = Math.PI / 2;

        const animate = function() {
            requestAnimationFrame(animate);
            controls.update();
            renderer.render(scene, camera);
        };
        animate();

        const colorPicker = document.getElementById('colorPicker');
        colorPicker.addEventListener('input', (event) => {
            const selectedColor = event.target.value;
            scene.traverse((child) => {
                if (child.isMesh) {
                    child.material.color.set(selectedColor);
                }
            });
        });

        document.getElementById('resetBtn').addEventListener('click', () => {
            colorPicker.value = '#ffffff';
            scene.traverse((child) => {
                if (child.isMesh) {
                    child.material.color.set(0xffffff);
                }
            });
        });

        document.getElementById('saveBtn').addEventListener('click', () => {
            const exporter = new THREE.GLTFExporter();
            exporter.parse(scene, (result) => {
                const blob = new Blob([result], { type: 'application/octet-stream' });
                const link = document.createElement('a');
                link.href = URL.createObjectURL(blob);
                link.download = 'custom_model.glb';
                link.click();
            }, { binary: true });
        });

        window.addEventListener('resize', () => {
            const width = container.clientWidth;
            const height = container.clientHeight;

            renderer.setSize(width, height);
            camera.aspect = width / height;
            camera.updateProjectionMatrix();
        });

        // Function to update the texture on the model with the text
        function updateTextOnModel(text) {
            const canvas = document.createElement('canvas');
            const context = canvas.getContext('2d');
            canvas.width = 512;
            canvas.height = 512;

            // Set the background color (optional)
            context.fillStyle = 'white';
            context.fillRect(0, 0, canvas.width, canvas.height);

            // Set the text properties
            context.font = 'bold 48px Arial';
            context.fillStyle = 'black';
            context.textAlign = 'center';
            context.textBaseline = 'middle';
            context.fillText(text, canvas.width / 2, canvas.height / 2);

            // Create the texture from the canvas
            const texture = new THREE.CanvasTexture(canvas);

            // Apply the texture to the model
            model.traverse((child) => {
                if (child.isMesh) {
                    child.material.map = texture; // Apply the texture to the material's map property
                    child.material.needsUpdate = true; // Update the material
                }
            });
        }

        // Event listener for updating the text
        document.getElementById('updateTextBtn').addEventListener('click', () => {
            const userText = document.getElementById('textInput').value;
            document.getElementById('customText').innerText = userText;
            updateTextOnModel(userText);
        });

        // Adding drag functionality for the text
        const customText = document.getElementById('customText');
        let isDragging = false;
        let offsetX, offsetY;

        customText.addEventListener('mousedown', (e) => {
            isDragging = true;
            offsetX = e.clientX - customText.offsetLeft;
            offsetY = e.clientY - customText.offsetTop;
        });

        window.addEventListener('mousemove', (e) => {
            if (isDragging) {
                customText.style.left = `${e.clientX - offsetX}px`;
                customText.style.top = `${e.clientY - offsetY}px`;
            }
        });

        window.addEventListener('mouseup', () => {
            isDragging = false;
        });
    </script>
</body>

</html>
