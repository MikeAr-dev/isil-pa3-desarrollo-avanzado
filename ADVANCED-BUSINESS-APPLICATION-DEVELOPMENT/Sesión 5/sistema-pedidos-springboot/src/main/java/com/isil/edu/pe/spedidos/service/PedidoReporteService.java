package com.isil.edu.pe.spedidos.service;

import com.isil.edu.pe.spedidos.entity.Pedido;
import com.isil.edu.pe.spedidos.repository.projection.ClienteFrecuenteProjection; // O tu DTO correspondiente
import com.isil.edu.pe.spedidos.service.domain.ProductoVendido;
import com.isil.edu.pe.spedidos.service.domain.ResumenPedidos;
import java.util.List;

public interface PedidoReporteService {

    ResumenPedidos obtenerResumen();

    List<Pedido> buscarPorCliente(String cliente);

    List<ProductoVendido> listarProductosMasVendidos();

    // --- NUEVOS MÉTODOS PARA LA PA3 ---
    List<Pedido> buscarPedidosPorClienteYTotalMinimo(String cliente, Double totalMinimo);

    List<ClienteFrecuenteProjection> listarClientesFrecuentes(Integer minPedidos);
}
