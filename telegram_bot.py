import os
from telegram import Update
from telegram.ext import (
    ApplicationBuilder,
    CommandHandler,
    MessageHandler,
    ContextTypes,
    filters,
)

from bot_prolog import clasificar_roca

# Estados de la conversación
FOLIACION, GRANO, TEXTURA, MINERAL = range(4)


async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text(
        "🪨 *METAMORPHIA*\n"
        "Clasificador experto de rocas metamórficas\n\n"
        "Responderás algunas preguntas geológicas y el sistema "
        "deducirá el tipo de roca, su grado metamórfico y posibles protolitos.\n\n"
        "*¿La roca presenta foliación?*\n"
        "(responde: si / no)",
        parse_mode="Markdown",
    )
    context.user_data.clear()
    context.user_data["estado"] = FOLIACION


async def manejar_mensajes(update: Update, context: ContextTypes.DEFAULT_TYPE):
    texto = update.message.text.lower().strip()
    estado = context.user_data.get("estado")

    # 1️⃣ Foliación
    if estado == FOLIACION:
        context.user_data["foliacion"] = texto
        await update.message.reply_text(
            "¿Cuál es el *tamaño de grano*?\n"
            "(fino / medio / grueso)",
            parse_mode="Markdown",
        )
        context.user_data["estado"] = GRANO

    # 2️⃣ Tamaño de grano
    elif estado == GRANO:
        context.user_data["grano"] = texto
        await update.message.reply_text(
            "¿Presenta alguna *textura especial*?\n"
            "(satinada / no)",
            parse_mode="Markdown",
        )
        context.user_data["estado"] = TEXTURA

    # 3️⃣ Textura
    elif estado == TEXTURA:
        context.user_data["textura"] = texto if texto != "no" else "ninguna"
        await update.message.reply_text(
            "¿Cuál es el *mineral índice principal*?",
            parse_mode="Markdown",
        )
        context.user_data["estado"] = MINERAL

    # 4️⃣ Mineral índice → razonamiento
    elif estado == MINERAL:
        context.user_data["mineral"] = texto

        resultado = clasificar_roca(
            context.user_data["foliacion"],
            context.user_data["grano"],
            context.user_data["textura"],
            context.user_data["mineral"],
        )

        await update.message.reply_text(
            "🧠 *Resultado de la inferencia geológica:*\n\n"
            f"{resultado}",
            parse_mode="Markdown",
        )

        # Reiniciar conversación
        context.user_data.clear()


def main():
    token = os.getenv("BOT_TOKEN")
    if not token:
        raise RuntimeError("❌ No se encontró la variable de entorno BOT_TOKEN")

    app = ApplicationBuilder().token(token).build()

    # aquí van tus handlers (mensajes, comandos, etc.)

    print("🤖 Bot METAMORPHIA activo 24/7...")
    app.run_polling()


if __name__ == "__main__":
    main()


