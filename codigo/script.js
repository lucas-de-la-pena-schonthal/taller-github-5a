
const enlaces = document.querySelectorAll('.enlace-menu');
const secciones = document.querySelectorAll('.seccion-pagina');

// Control del menú principal superior
enlaces.forEach(enlace => {
    enlace.addEventListener('click', (e) => {
        e.preventDefault();
        const inicio = document.getElementById("inicio");
        if (inicio) {
            inicio.classList.add("seccion-oculta");
        }
        enlaces.forEach(link => link.classList.remove('activo'));
        enlace.classList.add('activo');
        const seccionId = enlace.getAttribute('data-target');
        secciones.forEach(seccion => {
            if (seccion.id === seccionId) {
                seccion.classList.remove('seccion-oculta');
            } else {
                seccion.classList.add('seccion-oculta');
            }
        });
        const menuPlanifica = document.getElementById('menu-planifica');
        const vistaCalculadora = document.getElementById('vista-calculadora');
        const vistaTiempos = document.getElementById('vista-tiempos');
        if (menuPlanifica && vistaCalculadora && vistaTiempos) {
            menuPlanifica.style.display = 'flex';
            vistaCalculadora.classList.add('id-oculto');
            vistaTiempos.classList.add('id-oculto');
        }
    });
});

// Intercambio de herramientas dentro de Planificación
const menuPlanifica = document.getElementById('menu-planifica');
const vistaCalculadora = document.getElementById('vista-calculadora');
const vistaTiempos = document.getElementById('vista-tiempos');
const btnIrCalculadora = document.getElementById('btn-ir-calculadora');
const btnIrTiempos = document.getElementById('btn-ir-tiempos');
const volverCalc = document.getElementById('volver-calc');
const volverTiempos = document.getElementById('volver-tiempos');

// REEMPLAZÁ EL IF VIEJO POR ESTE IF SEGURO QUE PROTEGE TODO EL BLOQUE
if (btnIrCalculadora && btnIrTiempos && volverCalc && volverTiempos) {
    btnIrCalculadora.addEventListener('click', () => {
        menuPlanifica.style.display = 'none';
        vistaCalculadora.classList.remove('id-oculto');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
    btnIrTiempos.addEventListener('click', () => {
        menuPlanifica.style.display = 'none';
        vistaTiempos.classList.remove('id-oculto');
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
    volverCalc.addEventListener('click', () => {
        vistaCalculadora.classList.add('id-oculto');
        menuPlanifica.style.display = 'flex';
        document.getElementById('resultado-caja').classList.add('id-oculto');
    });
    volverTiempos.addEventListener('click', () => {
        vistaTiempos.classList.add('id-oculto');
        menuPlanifica.style.display = 'flex';
        document.getElementById('resultado-tiempos-caja').classList.add('id-oculto');
    });
}

// Matemática de la calculadora de temas por día
const btnCalcular = document.getElementById('btn-calcular');
if (btnCalcular) {
    btnCalcular.addEventListener('click', () => {
        const materias = parseInt(document.getElementById('materias').value) || 1;
        const temas = parseInt(document.getElementById('temas').value) || 0;
        const dias = parseInt(document.getElementById('dias').value) || 0;
        const horas = parseFloat(document.getElementById('horas').value) || 0;
        const planTexto = document.getElementById('plan-texto');
        const resultadoCaja = document.getElementById('resultado-caja');

        if (temas <= 0 || dias <= 0 || horas <= 0) {
            planTexto.innerHTML = "⚠️ Por favor, completa todos los campos con números mayores a 0.";
            resultadoCaja.classList.remove('id-oculto');
            return;
        }
        const diasDeEstudio = dias > 1 ? dias - 1 : dias;
        const temasPorDia = (temas / diasDeEstudio).toFixed(1);
        const horasPorMateria = (horas / materias).toFixed(1);
        let mensaje = `Para llegar bien a tus exámenes, te conviene estudiar aproximadamente <strong>${temasPorDia} temas por día</strong> durante los primeros <strong>${diasDeEstudio} días</strong>.<br><br>Dedicale cerca de <strong>${horasPorMateria} horas diarias</strong> a cada materia.`;
        if (dias > 1) {
            mensaje += `<br><br>💡 <strong>Tip Pro:</strong> Reservá el último día completo exclusivamente para hacer un repaso general y descansar antes del examen.`;
        }
        planTexto.innerHTML = mensaje;
        resultadoCaja.classList.remove('id-oculto');
    });
}

// Control del medidor de avance y la barra de progreso
const btnEvaluar = document.getElementById('btn-evaluar');
if (btnEvaluar) {
    btnEvaluar.addEventListener('click', () => {
        const total = parseInt(document.getElementById('total-temas').value) || 0;
        const estudiados = parseInt(document.getElementById('estudiados-temas').value) || 0;
        const diasFaltan = parseInt(document.getElementById('dias-restantes').value) || 0;
        const resultadoTiemposCaja = document.getElementById('resultado-tiempos-caja');
        const progresoRelleno = document.getElementById('progreso-relleno');
        const tiemposTexto = document.getElementById('tiempos-texto');

        if (total <= 0 || diasFaltan <= 0 || estudiados < 0) {
            tiemposTexto.innerHTML = "⚠️ Por favor, ingresá valores válidos.";
            resultadoTiemposCaja.classList.remove('id-oculto');
            return;
        }
        let porcentaje = Math.round((estudiados / total) * 100);
        if (porcentaje > 100) porcentaje = 100;
        progresoRelleno.style.width = `${porcentaje}%`;
        progresoRelleno.innerText = `${porcentaje}%`;
        const temasRestantes = total - estudiados;
        if (temasRestantes <= 0) {
            tiemposTexto.innerHTML = "🎉 <strong>¡Excelente!</strong> Ya terminaste de estudiar todo el contenido. Dedicá el tiempo restante a repasar y descansar.";
            progresoRelleno.style.backgroundColor = "#2ecc71";
            resultadoTiemposCaja.classList.remove('id-oculto');
            return;
        }
        const ritmoNecesario = temasRestantes / diasFaltan;
        if (ritmoNecesario <= 1) {
            tiemposTexto.innerHTML = `🟢 <strong>Vas muy bien:</strong> Te quedan por estudiar ${temasRestantes} temas. Manteniendo un ritmo tranquilo de ${ritmoNecesario.toFixed(1)} temas por día llegás perfecto. ¡Seguí así y reservá tiempo para repasar!`;
            progresoRelleno.style.backgroundColor = "#2ecc71";
        } else if (ritmoNecesario <= 2.5) {
            tiemposTexto.innerHTML = `🟡 <strong>Vas justo:</strong> Te quedan por estudiar ${temasRestantes} temas. Tenés que estudiar ${ritmoNecesario.toFixed(1)} temas por día. Intentá dedicarle un poco más de tiempo estos días para no presionarte al final.`;
            progresoRelleno.style.backgroundColor = "#f1c40f";
        } else {
            tiemposTexto.innerHTML = `🔴 <strong>Necesitás reorganizarte:</strong> Te quedan ${temasRestantes} temas en muy pocos días (${ritmoNecesario.toFixed(1)} temas por día). Es mucho contenido junto; te sugerimos usar nuestra <strong>Calculadora de estudio</strong> para armar un plan de shock de inmediato.`;
            progresoRelleno.style.backgroundColor = "#e74c3c";
        }
        resultadoTiemposCaja.classList.remove('id-oculto');
    });
}

// Procesamiento de puntajes del Test de estudio
const formularioTest = document.getElementById('formulario-test');
if (formularioTest) {
    formularioTest.addEventListener('submit', (e) => {
        e.preventDefault();
        let lectorVisual = 0, escritor = 0, auditivo = 0, kinestesico = 0;
       
        const obtenerValor = (name) => {
            const elegido = document.querySelector(`input[name="${name}"]:checked`);
            return elegido ? parseInt(elegido.value) : 0;
        };

        // Suma de puntajes agrupados por perfil según tus 12 preguntas
        lectorVisual += obtenerValor('p1') + obtenerValor('p5') + obtenerValor('p10');
        escritor += obtenerValor('p3') + obtenerValor('p7') + obtenerValor('p11');
        auditivo += obtenerValor('p4') + obtenerValor('p6') + obtenerValor('p9');
        kinestesico += obtenerValor('p2') + obtenerValor('p8') + obtenerValor('p12');

        const puntajes = [
            { nombre: "📖 Lector/Visual", puntos: lectorVisual, desc: "Aprendés mejor al leer y organizar información visualmente de forma clara." },
            { nombre: "✍️ Escritor", puntos: escritor, desc: "Aprendés mejor al escribir, resumir, hacer apuntes propios y transformar los datos." },
            { nombre: "🎧 Auditivo", puntos: auditivo, desc: "Aprendés mejor al escuchar explicaciones, grabaciones o debatir los temas en voz alta." },
            { nombre: "🤲 Kinestésico", puntos: kinestesico, desc: "Aprendés mejor resolviendo, probando y aplicando la información en la práctica." }
        ];

        // Ordenamos los perfiles de mayor a menor puntuación
        puntajes.sort((a, b) => b.puntos - a.puntos);
        const mayorPuntaje = puntajes[0].puntos;
       
        // Filtramos empates o resultados muy cercanos (diferencia de hasta 1 punto)
        const ganadores = puntajes.filter(p => (mayorPuntaje - p.puntos) <= 1);
        let diagnosticoHTML = "";

        if (ganadores.length === 1) {
            diagnosticoHTML = `Tu perfil predominante es <strong>${ganadores[0].nombre}</strong> (${ganadores[0].puntos} pts).<br><br>${ganadores[0].desc}<br><br>💡 Te recomendamos visitar nuestra sección de <strong>Métodos de estudio</strong> y probar técnicas asociadas a tu perfil.`;
        } else {
            let nombresGanadores = ganadores.map(g => g.nombre).join(" y ");
            diagnosticoHTML = `¡Tienes un perfil combinado! Tus formas de estudio principales son <strong>${nombresGanadores}</strong>.<br><br>Significa que te rinde muchísimo mezclar estrategias visuales o escritas con debates o prácticas directas según la materia.<br><br>💡 ¡Probá combinar los diferentes métodos que tenemos en la web!`;
        }

        // Mostramos la caja de resultados e inyectamos el texto
        const resultadoTestCaja = document.getElementById('resultado-test-caja');
        document.getElementById('test-texto-diagnostico').innerHTML = diagnosticoHTML;
        resultadoTestCaja.classList.remove('id-oculto');
        resultadoTestCaja.scrollIntoView({ behavior: 'smooth' });
    });
}

document.addEventListener("DOMContentLoaded", () => {
    secciones.forEach(seccion => {
        if (seccion.id === "inicio") {
            seccion.classList.remove("seccion-oculta");
        } else {
            seccion.classList.add("seccion-oculta");
        }
    });
});