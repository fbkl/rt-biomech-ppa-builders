#include <iostream>
#include <spdlog/spdlog.h>
#include <simbody/Simbody.h>
#include <SimTKcommon/internal/common.h> // this is where operator<= lives

int main() {
   	SimTK::Vec3 a{0,0,1};
       	std::string_view msg = "test";
    spdlog::info("{}" <= a, msg);
}

