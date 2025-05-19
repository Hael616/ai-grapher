// example usage
// import { trace } from '$lib/utils/logger';
// trace('Error from logger', { error: new Error('test error') });

// It should take a list of arguments

export const trace = (...args: unknown[]) => {
  console.error("Trace", ...args);
};

export const info = (...args: unknown[]) => {
  console.info("Info", ...args);
};

export const warn = (...args: unknown[]) => {
  console.warn("Warn", ...args);
};

export const debug = (...args: unknown[]) => {
  if (process.env.NODE_ENV === "development") {
    console.log("Debug", ...args);
  }
};

export default {
  trace,
  info,
  warn,
  debug,
};
