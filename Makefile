# مشروع سينمانا PS4 - تطوير حيدر احمد (4GAMER)
# Makefile احترافي للبناء المباشر

# التحقق من وجود مسار Toolchain
ifndef OO_PS4_TOOLCHAIN
    $(error OO_PS4_TOOLCHAIN is not set. Please set it to your OpenOrbis SDK path)
endif

# إعدادات المشروع
TARGET = cinamana_app
TITLE_ID = IV0000-4GAMER001_00-CINAMANAHAIDER01
CONTENT_ID = IV0000-4GAMER001_00-CINAMANAHAIDER01

# المجلدات
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = .

# الملفات
SRCS = $(wildcard $(SRC_DIR)/*.cpp)
OBJS = $(SRCS:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# إعدادات المترجم (تعتمد على OpenOrbis)
CC = clang++
CFLAGS = -target x86_64-pc-freebsd12-elf -fno-use-cxa-atexit -fno-exceptions -fno-rtti -O2 -Wall
LDFLAGS = -target x86_64-pc-freebsd12-elf -nostdlib -L$(OO_PS4_TOOLCHAIN)/lib -lSceLibKernel -lSceUserService -lSceWebBrowser -lc

# الأهداف الرئيسية
all: $(BIN_DIR)/eboot.bin

$(BIN_DIR)/eboot.bin: $(OBJS)
	@echo "Linking..."
	$(CC) $(OBJS) -o $(BIN_DIR)/$(TARGET).elf $(LDFLAGS)
	@echo "Creating eboot.bin..."
	$(OO_PS4_TOOLCHAIN)/bin/create-fself $(BIN_DIR)/$(TARGET).elf $(BIN_DIR)/eboot.bin

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) -c $< -o $@

# تنظيف المشروع
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)/$(TARGET).elf $(BIN_DIR)/eboot.bin

# بناء PKG (يتطلب أدوات إضافية في البيئة)
pkg: all
	@echo "Building PKG..."
	$(OO_PS4_TOOLCHAIN)/bin/create-pkg pkg.gp4

.PHONY: all clean pkg
