import openai

def send_text_to_chatgpt(text):
  response = openai.Completion.create(
    prompt=text,
    engine="davinci",
    max_tokens=50,
  )

  return response.choices[0].text

# Crea un archivo Python que contenga la función
with open("send_text_to_chatgpt.py", "w") as f:
  f.write(f"def send_text_to_chatgpt(text):\n\n  return {send_text_to_chatgpt.__code__.co_code}")

# Importa el archivo Python en tu aplicación Flutter
import send_text_to_chatgpt

# Usa la función en Python en tu aplicación Flutter
def on_text_recognized(text):
  response = send_text_to_chatgpt(text)

  # Muestra la respuesta de la API de ChatGPT en la pantalla
