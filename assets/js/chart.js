// See https://observablehq.com/@d3/stacked-to-grouped-bars
//import { bb, bar } from 'billboard.js';
import * as echarts from 'echarts';

const defaultHeightVH = 50;

async function loadCSVFromURL(url) {
  try {
    const response = await fetch(url);
    const text = await response.text();
    const lines = text.split('\n');
    const headers = lines[0].split(',');
    const data = [];

    for (let i = 1; i < lines.length; i++) {
      const row = lines[i].split(',');
      data.push(row);
    }

    //return data[0].map((_, i) => data.map(row => row[i]));
    return data;
  } catch (error) {
    console.error('Error loading CSV from URL:', error);
    return []; // Return an empty array on error
  }
}

function chart(csvFile, element) {
  if (element.startsWith('#')) {
    element = element.substring(1);
  }
  loadCSVFromURL(csvFile).then(data => {
    const container = document.getElementById(element)
    var width = container.offsetWidth;
    if (width === 0) {
      width = container.parentElement.parentElement.offsetWidth;
    }
    var height = container.offsetHeight;
    if (height === 0) {
      height = Math.round(window.innerHeight / 100) * defaultHeightVH;
    }
    var myChart = echarts.init(container, null, { renderer: "svg", width: width, height: height});

    var option = {
      dataset:{
        source:data,
        dimensions: ['date', 'blog', 'title'],
      },
      series: [
        {
          name: 'blog',
          type: 'line',
          encode: {
            x: 'timestamp',
            y: 'blog'
          }
        }
      ],
      title: {
      },
      tooltip: {},
      /*
      legend: {
        data: ['sales']
      },
      */
      xAxis: {
      },
      yAxis: {},

    };
    myChart.setOption(option);

  });
}

window.chart = chart;
