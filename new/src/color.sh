#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# ------------------------------------------------------------------------------
# Reset color output (background and foreground colors).
# ------------------------------------------------------------------------------
function devoxio::color.reset() {
    echo -n -e "${__DEVOXIO_COLORS_RESET}"
}

# ------------------------------------------------------------------------------
# Set default output color.
# ------------------------------------------------------------------------------
function devoxio::color.default() {
    echo -n -e "${__DEVOXIO_COLORS_DEFAULT}"
}

# ------------------------------------------------------------------------------
# Set font output color to black.
# ------------------------------------------------------------------------------
function devoxio::color.black() {
    echo -n -e "${__DEVOXIO_COLORS_BLACK}"
}

# ------------------------------------------------------------------------------
# Set font output color to red.
# ------------------------------------------------------------------------------
function devoxio::color.red() {
    echo -n -e "${__DEVOXIO_COLORS_RED}"
}

# ------------------------------------------------------------------------------
# Set font output color to green.
# ------------------------------------------------------------------------------
function devoxio::color.green() {
    echo -n -e "${__DEVOXIO_COLORS_GREEN}"
}

# ------------------------------------------------------------------------------
# Set font output color to yellow.
# ------------------------------------------------------------------------------
function devoxio::color.yellow() {
    echo -n -e "${__DEVOXIO_COLORS_YELLOW}"
}

# ------------------------------------------------------------------------------
# Set font output color to blue.
# ------------------------------------------------------------------------------
function devoxio::color.blue() {
    echo -n -e "${__DEVOXIO_COLORS_BLUE}"
}

# ------------------------------------------------------------------------------
# Set font output color to magenta.
# ------------------------------------------------------------------------------
function devoxio::color.magenta() {
    echo -n -e "${__DEVOXIO_COLORS_MAGENTA}"
}

# ------------------------------------------------------------------------------
# Set font output color to cyan.
# ------------------------------------------------------------------------------
function devoxio::color.cyan() {
    echo -n -e "${__DEVOXIO_COLORS_CYAN}"
}

# ------------------------------------------------------------------------------
# Set font output color background to default.
# ------------------------------------------------------------------------------
function devoxio::color.bg.default() {
    echo -n -e "${__DEVOXIO_COLORS_BG_DEFAULT}"
}

# ------------------------------------------------------------------------------
# Set font output color background to black.
# ------------------------------------------------------------------------------
function devoxio::color.bg.black() {
    echo -n -e "${__DEVOXIO_COLORS_BG_BLACK}"
}

# ------------------------------------------------------------------------------
# Set font output color background to red.
# ------------------------------------------------------------------------------
function devoxio::color.bg.red() {
    echo -n -e "${__DEVOXIO_COLORS_BG_RED}"
}

# ------------------------------------------------------------------------------
# Set font output color background to green.
# ------------------------------------------------------------------------------
function devoxio::color.bg.green() {
    echo -n -e "${__DEVOXIO_COLORS_BG_GREEN}"
}

# ------------------------------------------------------------------------------
# Set font output color background to yellow.
# ------------------------------------------------------------------------------
function devoxio::color.bg.yellow() {
    echo -n -e "${__DEVOXIO_COLORS_BG_YELLOW}"
}

# ------------------------------------------------------------------------------
# Set font output color background to blue.
# ------------------------------------------------------------------------------
function devoxio::color.bg.blue() {
    echo -n -e "${__DEVOXIO_COLORS_BG_BLUE}"
}

# ------------------------------------------------------------------------------
# Set font output color background to magenta.
# ------------------------------------------------------------------------------
function devoxio::color.bg.magenta() {
    echo -n -e "${__DEVOXIO_COLORS_BG_MAGENTA}"
}

# ------------------------------------------------------------------------------
# Set font output color background to cyan.
# ------------------------------------------------------------------------------
function devoxio::color.bg.cyan() {
    echo -n -e "${__DEVOXIO_COLORS_BG_CYAN}"
}

# ------------------------------------------------------------------------------
# Set font output color background to white.
# ------------------------------------------------------------------------------
function devoxio::color.bg.white() {
    echo -n -e "${__DEVOXIO_COLORS_BG_WHITE}"
}