#include <simbody/Simbody.h>
#include <spdlog/spdlog.h>
#include <string_view>

int main() {
    std::string_view msg = "Hello with Simbody!";
    spdlog::info("{}", msg);
}

