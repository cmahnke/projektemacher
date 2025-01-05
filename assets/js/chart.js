// See https://observablehq.com/@d3/stacked-to-grouped-bars
import * as d3 from 'd3-dsv';
import { bb } from 'billboard.js';

//TODO: This is currently just some example code
function chart(csvFile, element) {
  d3.csv(csvFile).then(function(data) {
    const columns = Object.keys(data[0]);

    const chartData = {
      columns: [
        ['x'].concat(data.map(d => d[Object.keys(data[0])[0]])),
        ...columns.map(col => [col].concat(data.map(d => +d[col])))
      ],
      type: 'bar',
      groups: [columns]
    };

    bb.generate({
      bindto: element,
      data: chartData,
      bar: {
        width: {
          ratio: 0.8
        }
      },
      axis: {
        x: {
          type: 'category'
        }
      }
    });
  });
}

window.chart = chart;
