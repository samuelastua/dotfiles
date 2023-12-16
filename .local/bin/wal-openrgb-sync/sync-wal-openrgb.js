"use strict";
// This needs to be transpiled from Typescript to Javascript using tsc wal.ts
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
var openrgb_1 = require("openrgb");
var sleep_1 = require("sleep");
var fs_1 = require("fs");
var os_1 = require("os");
var path = require("path");
var near = require("nearest-color");
// Source: https://stackoverflow.com/a/5624139/3614298
function hexToRgb(hex) {
    // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
    hex = hex.replace(shorthandRegex, function (m, r, g, b) {
        return r + r + g + g + b + b;
    });
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    var res = result ? {
        red: parseInt(result[1], 16),
        green: parseInt(result[2], 16),
        blue: parseInt(result[3], 16)
    } : null;
    console.log("HEX to RGB: ".concat(hex, " =>"), res);
    return res;
}
var nearestPrimaryColor = function (color) {
    var nearest = near.from(color);
    console.log('Nearest primary color:', nearest);
    return nearest;
};
var colorShade = function (col, amt) {
    var _a;
    col = col.replace(/^#/, '');
    if (col.length === 3)
        col = col[0] + col[0] + col[1] + col[1] + col[2] + col[2];
    var _b = col.match(/.{2}/g), r = _b[0], g = _b[1], b = _b[2];
    (_a = [parseInt(r, 16) + amt, parseInt(g, 16) + amt, parseInt(b, 16) + amt], r = _a[0], g = _a[1], b = _a[2]);
    r = Math.max(Math.min(255, r), 0).toString(16);
    g = Math.max(Math.min(255, g), 0).toString(16);
    b = Math.max(Math.min(255, b), 0).toString(16);
    var rr = (r.length < 2 ? '0' : '') + r;
    var gg = (g.length < 2 ? '0' : '') + g;
    var bb = (b.length < 2 ? '0' : '') + b;
    return "#".concat(rr).concat(gg).concat(bb);
};
var walColors = JSON.parse((0, fs_1.readFileSync)(path.join((0, os_1.homedir)(), '.cache/wal/colors.json'), 'utf8'));
Object.keys(walColors.colors).forEach(function (c) { return hexToRgb(walColors.colors[c]); });
var targetColor = hexToRgb(colorShade(walColors.colors.color12, -90));
function start() {
    return __awaiter(this, void 0, void 0, function () {
        var client, controllerCount, tasks, deviceId, device, colors;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    client = new openrgb_1.OpenRGBClient({
                        port: 6742,
                        host: "localhost",
                        name: "Wal.js"
                    });
                    return [4 /*yield*/, client.connect()];
                case 1:
                    _a.sent();
                    return [4 /*yield*/, client.getControllerCount()];
                case 2:
                    controllerCount = _a.sent();
                    Array.prototype.set = function set(str, color) {
                        if (color === void 0) { color = { red: 0x00, green: 0x00, blue: 0xFF }; }
                        for (var i = 0; i < str.length; i++) {
                            this.setChar(str[i], color);
                        }
                        return this;
                    };
                    Array.prototype.reset = function () {
                        this.fill(targetColor);
                        return this;
                    };
                    tasks = [];
                    deviceId = 0;
                    _a.label = 3;
                case 3:
                    if (!(deviceId < controllerCount)) return [3 /*break*/, 6];
                    return [4 /*yield*/, client.getDeviceController(deviceId)];
                case 4:
                    device = _a.sent();
                    console.log('Configuring device:', device.name);
                    colors = Array(device.colors.length).reset();
                    (0, sleep_1.msleep)(200);
                    colors.reset();
                    tasks.push(client.updateLeds(deviceId, colors));
                    _a.label = 5;
                case 5:
                    deviceId++;
                    return [3 /*break*/, 3];
                case 6: return [4 /*yield*/, Promise.all(tasks)];
                case 7:
                    _a.sent();
                    return [4 /*yield*/, client.disconnect()];
                case 8:
                    _a.sent();
                    return [2 /*return*/];
            }
        });
    });
}
start();
