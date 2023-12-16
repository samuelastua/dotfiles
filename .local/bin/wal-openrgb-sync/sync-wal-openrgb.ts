// This needs to be transpiled from Typescript to Javascript using tsc wal.ts

import { OpenRGBClient } from 'openrgb';
import { msleep } from 'sleep';
import { readFileSync } from 'fs';
import { homedir } from 'os';
import * as path from 'path';
import * as near from 'nearest-color';


// Source: https://stackoverflow.com/a/5624139/3614298
function hexToRgb(hex) {
  // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
  const shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  hex = hex.replace(shorthandRegex, function(m, r, g, b) {
    return r + r + g + g + b + b;
  });

  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  const res =  result ? {
    red: parseInt(result[1], 16),
    green: parseInt(result[2], 16),
    blue: parseInt(result[3], 16)
  } : null;
  console.log(`HEX to RGB: ${hex} =>`, res);
  return res;
}


const nearestPrimaryColor = (color) => {
  const nearest = near.from(color);
  console.log('Nearest primary color:', nearest);
  return nearest;
};

const colorShade = (col, amt) => {
  col = col.replace(/^#/, '')
  if (col.length === 3) col = col[0] + col[0] + col[1] + col[1] + col[2] + col[2]

  let [r, g, b] = col.match(/.{2}/g);
  ([r, g, b] = [parseInt(r, 16) + amt, parseInt(g, 16) + amt, parseInt(b, 16) + amt])

  r = Math.max(Math.min(255, r), 0).toString(16)
  g = Math.max(Math.min(255, g), 0).toString(16)
  b = Math.max(Math.min(255, b), 0).toString(16)

  const rr = (r.length < 2 ? '0' : '') + r
  const gg = (g.length < 2 ? '0' : '') + g
  const bb = (b.length < 2 ? '0' : '') + b

  return `#${rr}${gg}${bb}`
}


const walColors = JSON.parse(readFileSync(path.join(homedir(), '.cache/wal/colors.json'), 'utf8'));

Object.keys(walColors.colors).forEach(c => hexToRgb(walColors.colors[c]))
const targetColor = hexToRgb(colorShade(walColors.colors.color12, -90))


declare global {
    interface Array<T> {
        set(string, any): Array<T>;
        reset(): Array<T>;
        setChar(char, any): Array<T>;
    }
}

async function start() {
  const client = new OpenRGBClient({
    port: 6742, 
    host: "localhost",
    name: "Wal.js",
  });

  await client.connect();
  const controllerCount = await client.getControllerCount();

  Array.prototype.set = function set(str, color = { red: 0x00, green: 0x00, blue: 0xFF}) {
    for (let i = 0; i < str.length; i++) {
        this.setChar(str[i], color);
    }
    return this;
  };

  Array.prototype.reset = function() {
    this.fill(targetColor);

    return this;
  };

  const tasks = [];
  for (let deviceId = 0; deviceId < controllerCount; deviceId++) {
    const device = await client.getDeviceController(deviceId);
    console.log('Configuring device:', device.name);

    const colors = Array(device.colors.length).reset();
    msleep(200);
    colors.reset();
    tasks.push(client.updateLeds(deviceId, colors));
  }

  await Promise.all(tasks);
  await client.disconnect();
}

start()
