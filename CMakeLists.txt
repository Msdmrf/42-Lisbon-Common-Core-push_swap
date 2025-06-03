# When making the push_swap_visualizer build, there is an warning that is seen
# as an error and won't let the visualizer to reach "[100%] Built target tests".
# To fix this, change the "CMakeLists.txt" file located at "push_swap_visualizer/src"
# with the information below.

add_library(VisualizerLib STATIC utils.cpp queues.cpp pushswap.cpp gui.cpp)

target_link_libraries(VisualizerLib PUBLIC ImGui-SFML::ImGui-SFML)
target_include_directories(VisualizerLib PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/../include")
target_compile_features(VisualizerLib PRIVATE cxx_std_17)
target_compile_options(VisualizerLib PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4 /WX>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
)

add_executable(visualizer main.cpp)
target_compile_features(visualizer PRIVATE cxx_std_17)
target_link_libraries(visualizer PRIVATE VisualizerLib)