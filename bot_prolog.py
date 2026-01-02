import subprocess

def clasificar_roca(foliacion, grano, textura, mineral):
    consulta = f"""
    consult(main),
    limpiar_hechos,
    assert(foliacion({foliacion})),
    assert(grano({grano})),
    assert(textura({textura})),
    assert(mineral({mineral})),
    resolver(Roca, Grado, Protolitos),
    write(Roca), write('|'),
    write(Grado), write('|'),
    write(Protolitos),
    halt.
    """

    proceso = subprocess.run(
        ["swipl", "-q"],
        input=consulta,
        text=True,
        capture_output=True
    )

    salida = proceso.stdout.strip().split('|')

    return (
        f"🪨 Roca: {salida[0]}\n"
        f"🔥 Grado metamórfico: {salida[1]}\n"
        f"🧱 Protolito(s): {salida[2]}"
    )
