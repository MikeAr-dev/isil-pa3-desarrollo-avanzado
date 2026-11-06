package com.isil.edu.pe.spedidos.controller;

import com.isil.edu.pe.spedidos.service.PedidoReporteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PedidoReporteWebController {

    private final PedidoReporteService reporteService;

    public PedidoReporteWebController(PedidoReporteService reporteService) {
        this.reporteService = reporteService;
    }

    @GetMapping("/reportes/pedidos")
    public String verReportesJsp(
            @RequestParam(required = false) String cliente,
            @RequestParam(required = false) Double totalMinimo,
            @RequestParam(required = false, defaultValue = "1") Integer minPedidos,
            Model model) {

        model.addAttribute("resumen", reporteService.obtenerResumen());
        model.addAttribute("productosMasVendidos", reporteService.listarProductosMasVendidos());

        if (cliente != null && totalMinimo != null) {
            model.addAttribute("pedidosBusqueda", reporteService.buscarPedidosPorClienteYTotalMinimo(cliente, totalMinimo));
        }

        model.addAttribute("clientesFrecuentes", reporteService.listarClientesFrecuentes(minPedidos));

        return "reportes-pedidos";
    }
}
