let invocations = [];

exports.handler = async (event) => {
    let timestamp = new Date().valueOf();
    let isoString = new Date().toISOString();
    invocations.push(timestamp);
    
    let params = event.queryStringParameters;
    if (params && params.hasOwnProperty('cmd') && params.cmd == 'RESET') {
        invocations = [];
        return {
            statusCode: 200,
            body: JSON.stringify({ ThisInvocation: isoString })
        };
    }
    
    let timeSinceLast = 0;
    let averageGap = 0;
    if (invocations.length > 1) {
        timeSinceLast = (timestamp - invocations[invocations.length - 2]) / 1000;
        for (var i = 1; i < invocations.length; i++) {
            averageGap += invocations[i] - invocations[i - 1];
        }
        averageGap /= (invocations.length - 1) * 1000;
    }
    
    let response = {
        statusCode: 200,
        body: JSON.stringify({
            ThisInvocation: isoString,
            TimeSinceLast: timeSinceLast,
            TotalInvocationsOnThisContainer: invocations.length,
            AverageGapBetweenInvocations: averageGap
        })
    };
    
    return response;
};
