package com.pcdoctor.backend.model;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "diagnosticos")
public class Diagnostico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_diagnostico")
    @JsonProperty("idDiagnostico")
    private Long idDiagnostico;

    @Column(nullable = false, length = 150)
    @JsonProperty("titulo")
    private String titulo;

    @Column(name = "nivel_probabilidad", nullable = false, length = 50)
    @JsonProperty("nivelProbabilidad")
    private String nivelProbabilidad;

    @Column(name = "causa_probable", columnDefinition = "TEXT")
    @JsonProperty("causaProbable")
    private String causaProbable;

    @Column(name = "solucion_recomendada", columnDefinition = "TEXT")
    @JsonProperty("solucionRecomendada")
    private String solucionRecomendada;

    @Column(name = "diagnostico_secundario", columnDefinition = "TEXT")
    @JsonProperty("diagnosticoSecundario")
    private String diagnosticoSecundario;

    public Diagnostico() {}

    public Long getIdDiagnostico() { return idDiagnostico; }
    public void setIdDiagnostico(Long idDiagnostico) { this.idDiagnostico = idDiagnostico; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getNivelProbabilidad() { return nivelProbabilidad; }
    public void setNivelProbabilidad(String nivelProbabilidad) { this.nivelProbabilidad = nivelProbabilidad; }

    public String getCausaProbable() { return causaProbable; }
    public void setCausaProbable(String causaProbable) { this.causaProbable = causaProbable; }

    public String getSolucionRecomendada() { return solucionRecomendada; }
    public void setSolucionRecomendada(String solucionRecomendada) { this.solucionRecomendada = solucionRecomendada; }

    public String getDiagnosticoSecundario() { return diagnosticoSecundario; }
    public void setDiagnosticoSecundario(String diagnosticoSecundario) { this.diagnosticoSecundario = diagnosticoSecundario; }
}