<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Módulo de Reportes y Supervisión - Sistema de Pedidos</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; color: #333; }
        h1, h2 { color: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; background: #fff; }
        th, td { border: 1px solid #dee2e6; padding: 10px; text-align: left; }
        th { background-color: #e9ecef; }
        .card { background: #fff; padding: 20px; margin-bottom: 20px; border-radius: 5px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"], input[type="number"] { padding: 8px; width: 250px; border: 1px solid #ccc; border-radius: 4px; }
        button { padding: 8px 15px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #0056b3; }
        .metrics { display: flex; gap: 20px; }
        .metric-box { background: #e2f0d9; padding: 15px; border-radius: 5px; flex: 1; text-align: center; }
    </style>
</head>
<body>

    <h1>Panel de Supervisión y Reportes de Pedidos</h1>
    <p>Bienvenido al módulo analítico integrado mediante Spring JDBC y Spring MVC.</p>

    <!-- Resumen General -->
    <div class="card">
        <h2>Indicadores Generales</h2>
        <c:if test="${not empty resumen}">
            <div class="metrics">
                <div class="metric-box">
                    <h3>Total Pedidos</h3>
                    <p>${resumen.totalPedidos}</p>
                </div>
                <div class="metric-box">
                    <h3>Total Unidades</h3>
                    <p>${resumen.totalUnidades}</p>
                </div>
                <div class="metric-box">
                    <h3>Importe Acumulado</h3>
                    <p>$ ${resumen.importeAcumulado}</p>
                </div>
                <div class="metric-box">
                    <h3>Ticket Promedio</h3>
                    <p>$ ${resumen.ticketPromedio}</p>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Filtro de Búsqueda Avanzada (Consulta 1 con Spring JDBC) -->
    <div class="card">
        <h2>Consulta 1: Búsqueda Avanzada por Cliente y Monto Mínimo</h2>
        <form method="get" action="${pageContext.request.contextPath}/reportes/pedidos">
            <div class="form-group">
                <label for="cliente">Cliente (búsqueda parcial):</label>
                <input type="text" id="cliente" name="cliente" value="${param.cliente}" required />
            </div>
            <div class="form-group">
                <label for="totalMinimo">Total Mínimo ($):</label>
                <input type="number" step="0.01" id="totalMinimo" name="totalMinimo" value="${param.totalMinimo}" required />
            </div>
            <button type="submit">Filtrar Pedidos</button>
        </form>

        <c:if test="${not empty pedidosBusqueda}">
            <h3 style="margin-top: 20px;">Resultados de Búsqueda</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Total</th>
                        <th>Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${pedidosBusqueda}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.cliente}</td>
                            <td>${p.productoNombre}</td>
                            <td>${p.cantidad}</td>
                            <td>$ ${p.total}</td>
                            <td>${p.fecha}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

    <!-- Filtro de Clientes Frecuentes (Consulta 2 con Spring JDBC / Group By) -->
    <div class="card">
        <h2>Consulta 2: Clientes Frecuentes y Consolidado</h2>
        <form method="get" action="${pageContext.request.contextPath}/reportes/pedidos">
            <div class="form-group">
                <label for="minPedidos">Mínimo de Pedidos (Umbral):</label>
                <input type="number" id="minPedidos" name="minPedidos" value="${empty param.minPedidos ? 1 : param.minPedidos}" min="1" required />
            </div>
            <!-- Mantener los parámetros de búsqueda avanzada si estaban activos -->
            <input type="hidden" name="cliente" value="${param.cliente}" />
            <input type="hidden" name="totalMinimo" value="${param.totalMinimo}" />
            <button type="submit">Actualizar Clientes Frecuentes</button>
        </form>

        <c:if test="${not empty clientesFrecuentes}">
            <h3 style="margin-top: 20px;">Ranking de Clientes Frecuentes</h3>
            <table>
                <thead>
                    <tr>
                        <th>Cliente</th>
                        <th>Total Pedidos</th>
                        <th>Total Unidades</th>
                        <th>Importe Acumulado</th>
                        <th>Ticket Promedio</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cf" items="${clientesFrecuentes}">
                        <tr>
                            <td>${cf.cliente}</td>
                            <td>${cf.totalPedidos}</td>
                            <td>${cf.totalUnidades}</td>
                            <td>$ ${cf.importeAcumulado}</td>
                            <td>$ ${cf.ticketPromedio}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

</body>
</html>
