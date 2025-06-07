# 🛠️ Guía básica: Terreno editable en videojuegos – Voxels, Chunks, Tiles y más

Bienvenido a esta guía para **principiantes**. Aquí aprenderás cómo funcionan las bases de la **construcción y destrucción de terrenos** en videojuegos, usando ejemplos claros y comparando técnicas.

---

## 🔷 ¿Qué son los **voxels**?

- **Voxels** = “volumetric pixels” (píxeles con volumen).  
- En videojuegos, se ven como **cubos** o “bloques” (estilo LEGO).  
- Se usan para representar mundos en 3D que pueden **modificarse en tiempo real**: excavar, construir, destruir.

🎮 **Ejemplos famosos de voxels**:
- **Minecraft** – Cada bloque es un voxel editable.  
- **7 Days to Die** – Mundo voxel con destrucción total.  
- **Space Engineers** – Construcción/destrucción de naves voxel.  
- **Tear down** – Sandbox con entornos completamente destructibles.  
- **Vintage Story** – Sandbox voxel realista.

---

## 🌍 ¿Qué son los **chunks**?

- Los mundos voxel pueden ser enormes. Renderizarlo todo **de golpe** sería muy pesado.  
- Por eso, se **dividen en porciones** llamadas **chunks** (ej.: 16×16×16 bloques).  
- Cada chunk solo se carga o actualiza cuando está cerca del jugador.  
- Esto mejora el **rendimiento** y permite mundos infinitos.

---

## 🧩 **¿Por qué usar voxels y chunks?**

✅ **Terreno editable / destructible** – Juegos donde los jugadores modifican el mundo.  
✅ **Mundos grandes** – Solo cargas lo que ves, no todo el mapa.  
✅ **Simplicidad geométrica** – Cubos fáciles de modelar y renderizar.

❌ **No se recomienda** si:  
- Tu mundo es **estático** (no se destruye ni construye).  
- Quieres gráficos realistas y optimizados con mallas detalladas.  
- No necesitas editar el terreno en tiempo real.

---

## ⚡️ **¿Qué pasa si quieres un terreno más suave? – Marching Cubes**

- Técnica para crear **mallas suaves** a partir de datos voxel.  
- Ideal para terrenos alienígenas, orgánicos o fluidos (cuevas, montañas suaves).  
- Genera **mallas trianguladas** en vez de cubos.  
- Más **costoso computacionalmente** que los voxels cúbicos.

🎮 **Ejemplos famosos con marching cubes**:
- **Astroneer** – Terreno redondeado y editable en tiempo real.
- **Donkey Kong Bananza** – Destruccion redondeado y editable en tiempo real.
- **Planet Nomads** – Mundo alienígena editable y suave.  
- **Astral Terra** – Terreno orgánico voxel.

---

## 🟩 **¿Y qué pasa en 2D? – Tiles**

En 2D, no hablamos de voxels sino de **tiles** (baldosas o celdas).  
- Cada tile funciona como un “mini bloque” que puedes colocar o destruir.  
- Mucho más simple y **menos exigente**.

🎮 **Ejemplos famosos en 2D**:
- **Terraria** – Mundo 2D destructible con tiles.  
- **Starbound** – Sandbox 2D con tiles modificables.  
- **Stardew Valley** – Mundo 2D con tiles modificables.
- **Forager** – Mundo basado en tiles para farming y construcción.

---

## 🟠 **¿Y si no quieres usar nada de esto? – Terreno fijo con mallas**

Si tu mundo es **estático** o solo quieres “decorar”, es mejor usar **mallas 3D normales** o **tiles fijos**:

✅ **Mallas estáticas (3D)** – Modeladas en Blender, no cambian en tiempo real.  
- Ejemplo: **The Witcher 3**, **Skyrim**, **Assassin’s Creed**.

✅ **Tiles fijos (2D)** – Mapas que no cambian, perfectos para plataformas o aventuras fijas.  
- Ejemplo: **Celeste**, **Hollow Knight**.

---

## 🎯 **¿Qué técnica usar y cuándo?**

| Técnica                | Ideal para…                             | Ejemplos famosos                  |
|------------------------|----------------------------------------|------------------------------------|
| Voxels cúbicos         | Terreno editable en 3D estilo lego | Minecraft, Tear down        |
| Marching Cubes         | Terreno suave, fluido y orgánico       | Astroneer, Donkey Kong Bananza    |
| Tiles (2D)             | Terreno editable 2D                    | Terraria, Starbound               |
| Mallas estáticas(3D) o Tiles estaticos(2D)   | Terreno sin edición  | Witcher 3, Skyrim, Hollow Knight...  |

---

## 🚀 **Conclusión**

🔷 Si quieres que el jugador **rompa y construya el mundo**, usa voxels (3D) o tiles (2D).  
⚡️ Si buscas un terreno suave y orgánico, explora **marching cubes**.  
🟠 Si tu mundo **no cambia**, usa **mallas estáticas** (3D) o tiles normales (2D).  

Esta demo está pensada para que entender desde cero con **voxels, chunks y terreno editable** en Godot. ¡Perfecto para practicar y dar vida a tus ideas!

---

👉 **¿Me ha falta algo? ¿Quieres expandir esta guia?**

Puedes contribuir con tu conocimiento para ayudar al resto 🌍.
No dudes en hacer una pull request o abrir una issue en este repositorio de GitHub.

Gracias por llegar aqui!!

¡A darle caña y a construir 🔨 o destruir 😈 mundos! 🚀

