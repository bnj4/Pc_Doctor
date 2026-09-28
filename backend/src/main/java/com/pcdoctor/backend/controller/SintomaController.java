package com.pcdoctor.backend.controller;

import com.pcdoctor.backend.model.Sintoma;
import com.pcdoctor.backend.repository.SintomaRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/sintomas")
@CrossOrigin(origins = "*")
public class SintomaController {

    private final SintomaRepository sintomaRepository;

    public SintomaController(SintomaRepository sintomaRepository) {
        this.sintomaRepository = sintomaRepository;
    }

    @GetMapping
    public List<Sintoma> listarSintomas() {
        return sintomaRepository.findAll();
    }
}