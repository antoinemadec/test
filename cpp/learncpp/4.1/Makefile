SRC_DIR = .
OBJ_DIR = .
CXXFLAGS  = -g -c -Wall -I.
LDFLAGS =
SRCS = $(SRC_DIR)/main.cpp $(SRC_DIR)/add.cpp
OBJS = $(OBJ_DIR)/main.o $(OBJ_DIR)/add.o
# Note: The above will soon get unwieldy.
# The wildcard and patsubt commands will come to your rescue.

all: main

main: $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@
