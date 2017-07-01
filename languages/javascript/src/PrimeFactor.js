export function factorise(value) {
  const result = [];

  for (let divisor = 2; divisor < value; divisor++) {
    while (value > divisor && value % divisor === 0) {
      result.push(divisor);
      value = value / divisor;
    }
  }

  if (value > 1) {
    result.push(value);
  }

  return result;
}
