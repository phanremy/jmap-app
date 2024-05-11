import { Controller } from '@hotwired/stimulus'

/*
 * Values:
 *
 * Notes:
 *
 * Example:
 *
 */
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.map.on('load', function () {
      // Add a marker for the weather location
      var marker = new mapboxgl.Marker()
        .setLngLat([2.3522, 48.8566]) // Paris longitude and latitude
        .addTo(this.map);

      // Add the weather data to the data layer on the map
      this.map.addSource('weather-data', {
        type: 'geojson',
        data: {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [2.3522, 48.8566] // Paris longitude and latitude
          },
          properties: {
            temperature: 17.5,
            humidity: 60,
            weather_conditions: 'Cloudy'
          }
        }
      });

      this.map.addLayer({
        id: 'weather-layer',
        type: 'circle',
        source: 'weather-data',
        paint: {
          'circle-radius': 10,
          'circle-color': '#007cbf'
        }
      });
    });
  }
}
