package com.pcdoctor.backend.controller;

import com.pcdoctor.backend.model.Diagnostico;
import com.pcdoctor.backend.model.Pregunta;
import com.pcdoctor.backend.repository.DiagnosticoRepository;
import com.pcdoctor.backend.repository.PreguntaRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/diagnostico")
@CrossOrigin(origins = "*")
public class DiagnosticoController {

    private final PreguntaRepository preguntaRepository;
    private final DiagnosticoRepository diagnosticoRepository;

    public DiagnosticoController(PreguntaRepository preguntaRepository, DiagnosticoRepository diagnosticoRepository) {
        this.preguntaRepository = preguntaRepository;
        this.diagnosticoRepository = diagnosticoRepository;
    }

    @GetMapping("/inicial/{idSintoma}")
    public Pregunta obtenerPreguntaInicial(@PathVariable Long idSintoma) {
        List<Pregunta> preguntas = preguntaRepository.findByIdSintoma(idSintoma);
        if (preguntas != null && !preguntas.isEmpty()) {
            return preguntas.get(0);
        }
        return null;
    }

    @GetMapping("/pregunta/{idPregunta}")
    public Pregunta obtenerPreguntaPorId(@PathVariable Long idPregunta) {
        return preguntaRepository.findById(idPregunta).orElse(null);
    }

    @GetMapping("/resultado/{idDiagnostico}")
    public Diagnostico obtenerDiagnosticoFinal(@PathVariable Long idDiagnostico) {
        return diagnosticoRepository.findById(idDiagnostico).orElse(null);
    }
}