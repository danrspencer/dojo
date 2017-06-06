
export const factorise = (value) => {
    const result = [];
    let divisor = 2;

    while (divisor <= value) {
        while (value % divisor === 0) {
            result.push(divisor);
            value = value / divisor;
        }

        divisor++;
    }

    return result;
};