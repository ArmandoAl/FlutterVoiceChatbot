import wisper

def convert_voice_to_text(audio_bytes):
  response = wisper.recognize_from_bytes(audio_bytes)

  return response.text

# Crea un archivo Python que contenga la función
with open("convert_voice_to_text.py", "w") as f:
  f.write(f"def convert_voice_to_text(audio_bytes):\n\n  return {convert_voice_to_text.__code__.co_code}")

# Importa el archivo Python en tu aplicación Flutter
import convert_voice_to_text

# Usa la función en Python en tu aplicación Flutter
def on_button_pressed():
  audio_bytes = await get_audio_from_user()

  response = convert_voice_to_text(audio_bytes)

  // Muestra la respuesta en la pantalla
