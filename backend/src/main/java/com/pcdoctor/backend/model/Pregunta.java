package com.pcdoctor.backend.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "preguntas")
public class Pregunta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pregunta")
    @JsonProperty("idPregunta")
    private Long idPregunta;

    @Column(name = "id_sintoma", nullable = false)
    @JsonProperty("idSintoma")
    private Long idSintoma;

    @Column(name = "texto_pregunta", nullable = false, length = 255)
    @JsonProperty("textoPregunta")
    private String textoPregunta;

    @Column(name = "id_siguiente_si")
    @JsonProperty("idSiguienteSi")
    private Long idSiguienteSi;

    @Column(name = "id_siguiente_no")
    @JsonProperty("idSiguienteNo")
    private Long idSiguienteNo;

    @Column(name = "id_diagnostico_si")
    @JsonProperty("idDiagnosticoSi")
    private Long idDiagnosticoSi;

    @Column(name = "id_diagnostico_no")
    @JsonProperty("idDiagnosticoNo")
    private Long idDiagnosticoNo;

    public Pregunta() {}

    public Long getIdPregunta() { return idPregunta; }
    public void setIdPregunta(Long idPregunta) { this.idPregunta = idPregunta; }

    public Long getIdSintoma() { return idSintoma; }
    public void setIdSintoma(Long idSintoma) { this.idSintoma = idSintoma; }

    public String getTextoPregunta() { return textoPregunta; }
    public void setTextoPregunta(String textoPregunta) { this.textoPregunta = textoPregunta; }

    public Long getIdSiguienteSi() { return idSiguienteSi; }
    public void setIdSiguienteSi(Long idSiguienteSi) { this.idSiguienteSi = idSiguienteSi; }

    public Long getIdSiguienteNo() { return idSiguienteNo; }
    public void setIdSiguienteNo(Long idSiguienteNo) { this.idSiguienteNo = idSiguienteNo; }

    public Long getIdDiagnosticoSi() { return idDiagnosticoSi; }
    public void setIdDiagnosticoSi(Long idDiagnosticoSi) { this.idDiagnosticoSi = idDiagnosticoSi; }

    public Long getIdDiagnosticoNo() { return idDiagnosticoNo; }
    public void setIdDiagnosticoNo(Long idDiagnosticoNo) { this.idDiagnosticoNo = idDiagnosticoNo; }
}