import http from "node:http";
import { WebSocket, WebSocketServer } from "ws";
import { pool } from "./db/client";

export function attachRealtime(server: http.Server): WebSocketServer {
  const wss = new WebSocketServer({ server, path: "/ws" });

  wss.on("connection", (socket) => {
    socket.send(JSON.stringify({ type: "hello", message: "CandyBaby market stream" }));
  });

  const listener = pool.connect().then(async (client) => {
    await client.query("LISTEN market_tick");
    await client.query("LISTEN market_event");
    client.on("notification", (message) => {
      if (!message.payload) {
        return;
      }
      for (const clientSocket of wss.clients) {
        if (clientSocket.readyState === WebSocket.OPEN) {
          clientSocket.send(message.payload);
        }
      }
    });
    console.log("Listening for market_tick and market_event");
  });

  listener.catch((error) => {
    console.error("Failed to attach LISTEN/NOTIFY", error);
  });

  return wss;
}
