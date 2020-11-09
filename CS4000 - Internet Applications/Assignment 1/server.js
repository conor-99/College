const express = require('express');
const app = express();
const port = 3000;
const fetch = require('node-fetch');
const path = require('path');
let publicPath = path.resolve(__dirname, 'public');

app.use(express.static(publicPath));
app.get('/weather/:city', getWeather);
app.listen(port, () => console.log(`Weather app listening on port ${port}`));

const API_URL = 'https://api.openweathermap.org/data/2.5/forecast';
const API_KEY = '3e2d927d4f28b456c6bc662f34350957';

function getWeather(req, res) {

    let city = req.params.city;
    let url = `${API_URL}?q=${city}&units=metric&APPID=${API_KEY}`;
    
    let promise = fetch(url);

    promise
        .then(resp => resp.json())
        .then(data => {
            if (data.cod === '404') {
                res.json({result: {
                    validCity: false,
                    weatherData: {}
                }});
            } else {
                res.json({result: {
                    validCity: true,
                    weatherData: parseWeather(data)
                }});
            }
        })
        .catch(function () {
            res.json({result: {
                validCity: false,
                weatherData: {}
            }});
        });

    promise.catch(function () {
        res.json({result: {
            validCity: false,
            weatherData: {}
        }});
    });

}

function parseWeather(data) {
    let cityFullName = `${data.city.name}, ${data.city.country}`;
    let anyRain = false;
    let dailyForecast = [];
    let tempRanges = [false, false, false]

    for (day = 0; day < 5; day++) {

        let totalRain = 0;
        let meanTemp = 0;
        let maxWindSpeed = 0;

        // 8 3-hour segments per day
        for (step = 0; step < 8; step++) {
            let weather = data.list[(day * 8) + step];
            if (weather.hasOwnProperty('rain')) totalRain += weather.rain['3h'];
            meanTemp += weather.main.temp;
            maxWindSpeed = Math.max(maxWindSpeed, weather.wind.speed);
        }

        meanTemp /= 8;
        if (totalRain > 0) anyRain = true;
        
        if (meanTemp < 10) tempRanges[0] = true;
        else if (meanTemp > 20) tempRanges[2] = true;
        else tempRanges[1] = true;

        dailyForecast.push({
            rain: totalRain.toFixed(2),
            temp: meanTemp.toFixed(1),
            wind: maxWindSpeed.toFixed(2)
        });
    }

    return {
        cityFullName: cityFullName,
        anyRain: anyRain,
        tempRanges: tempRanges,
        dailyForecast: dailyForecast
    };
}
