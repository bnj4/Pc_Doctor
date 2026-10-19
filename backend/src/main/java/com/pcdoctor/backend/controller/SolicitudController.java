package com.pcdoctor.backend.controller;

import com.pcdoctor.backend.model.Cliente;
import com.pcdoctor.backend.model.Diagnostico;
import com.pcdoctor.backend.model.SolicitudReparacion;
import com.pcdoctor.backend.repository.ClienteRepository;
import com.pcdoctor.backend.repository.DiagnosticoRepository;
import com.pcdoctor.backend.repository.SolicitudReparacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/api/solicitudes")
@CrossOrigin(origins = "*")
public class SolicitudController {

    @Autowired
    private SolicitudReparacionRepository solicitudRepository;

    @Autowired
    private ClienteRepository clienteRepository;

    @Autowired
    private DiagnosticoRepository diagnosticoRepository;

    // Crear agendamiento de visita vinculando cliente y diagnóstico
    @PostMapping
    public SolicitudReparacion crearSolicitud(@RequestBody Map<String, Object> payload) {
        Long idCliente = Long.valueOf(payload.get("idCliente").toString());
        Long idDiagnostico = Long.valueOf(payload.get("idDiagnostico").toString());
        String fechaVisita = payload.get("fechaVisita").toString();

        Cliente cliente = clienteRepository.findById(idCliente).orElse(null);
        Diagnostico diagnostico = diagnosticoRepository.findById(idDiagnostico).orElse(null);

        if (cliente == null || diagnostico == null) {
            throw new RuntimeException("Cliente o Diagnóstico no encontrado");
        }

        SolicitudReparacion solicitud = new SolicitudReparacion();
        solicitud.setCliente(cliente);
        solicitud.setDiagnostico(diagnostico);
        solicitud.setFechaVisitaAgendada(LocalDate.parse(fechaVisita));

        return solicitudRepository.save(solicitud);
    }
}