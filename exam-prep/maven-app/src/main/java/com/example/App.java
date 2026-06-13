package com.example;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

public class App {

    public static void main(String[] args) throws IOException {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "3000"));

        HttpServer server = HttpServer.create(new InetSocketAddress("0.0.0.0", port), 0);
        server.createContext("/", App::handleRoot);
        server.createContext("/health", App::handleHealth);
        server.start();

        System.out.println("Server listening on port " + port);
    }

    private static void handleRoot(HttpExchange exchange) throws IOException {
        sendResponse(exchange, 200, "text/plain", "Hello from simple-maven-app");
    }

    private static void handleHealth(HttpExchange exchange) throws IOException {
        sendResponse(exchange, 200, "application/json", "{\"status\":\"ok\"}");
    }

    private static void sendResponse(HttpExchange exchange, int statusCode, String contentType, String body)
            throws IOException {
        byte[] response = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", contentType);
        exchange.sendResponseHeaders(statusCode, response.length);
        try (OutputStream outputStream = exchange.getResponseBody()) {
            outputStream.write(response);
        }
    }
}
