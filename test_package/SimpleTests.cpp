#include <iostream>
#include <ixwebsocket/IXWebSocket.h>
#include <string>
#include <vector>
#include <chrono>
#include <thread>

class SocketWrapper {
private:
    ix::WebSocket webSocket;
    std::vector<std::string> receivedMessages;
public:
    SocketWrapper() {
        webSocket.setUrl(std::string("ws://echo.websocket.org"));
        webSocket.setOnMessageCallback(
            [this](const ix::WebSocketMessagePtr& message) {
                if (message->type == ix::WebSocketMessageType::Open) {
                    std::cout << "Connected\n";
                    //webSocket.send(std::string("Congrats, your local version of IXWebSocket works!"));
                } else if (message->type == ix::WebSocketMessageType::Close) {
                    std::cout << "Closing socket...\n";
                } else if (message->type == ix::WebSocketMessageType::Message) {
                    std::cout << message->str << std::endl;
                    receivedMessages.push_back(message->str);
                } else if (message->type == ix::WebSocketMessageType::Error) {
                    std::cout << message->errorInfo.reason;
                } 
            });
        webSocket.start();

    }

    bool hasReceived() { return receivedMessages.size() > 0; }
    void close() { this->webSocket.close(); }
    bool ready() { 
        return this->webSocket.getReadyState() == ix::ReadyState::Open; 
    }
    void send(std::string message) { this->webSocket.send(message); }
};

int main() {
    std::cout << "Starting socket..." << std::endl;
    SocketWrapper socketWrapper;
    while(!socketWrapper.hasReceived()) {
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
        if (socketWrapper.ready()) {
            socketWrapper.send("Congrats, your local version of IXWebSocket works!");
        }
    }
    std::cout << "Message received! Closing socket." << std::endl;
    socketWrapper.close();
    std::cout << "Socket disconnected." << std::endl;

}
