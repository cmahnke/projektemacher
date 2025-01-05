// See https://observablehq.com/@d3/stacked-to-grouped-bars
//import { bb, bar } from 'billboard.js';
import * as echarts from 'echarts';

const defaultHeightVH = 50;

const colors = [
    '#c23531',
    '#2f4554',
    '#61a0a8',
    '#d48265',
    '#91c7ae',
    '#749f83',
    '#ca8622',
    '#bda29a',
    '#6e7074',
    '#546570',
    '#c4ccd3'
  ];

async function loadCSVFromURL(url) {
  try {
    const response = await fetch(url);
    const text = await response.text();
    const lines = text.split('\n');
    const headers = lines[0].split(',');
    const data = [];

    for (let i = 1; i < lines.length; i++) {
      const row = lines[i].split(',');
      const obj = {};
      headers.forEach((header, j) => {
        obj[header] = row[j];
      });
      if (row[1] !== undefined) {
        data.push(obj);
      } else {
        //console.warn('Blog is empty: ', row);
      }
    }

    const groupedData = {};
    data.forEach(row => {
      const date = new Date(row['Date']);
      const month = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}`;
      if (!groupedData[month]) {
        groupedData[month] = {};
      }
      const category = row['Blog'];
      groupedData[month][category] = (groupedData[month][category] || 0) + 1;
    });

    //return data[0].map((_, i) => data.map(row => row[i]));
    return groupedData;
  } catch (error) {
    console.error('Error loading CSV from URL:', error);
    return [];
  }
}

function chart(csvFile, element, options) {
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

    const xAxisData = Object.keys(data);
    const seriesData = [];
    let colorIndex = 0;
    const blogs = new Set(Object.keys(data).map((key) => { return Object.keys(data[key])[0] }));
    //WTF: `for in` won't work with Sets and only itereates over array index, JS is stupid as shit
    for (const blog of [...blogs]) {
      seriesData.push({
        name: blog,
        type: 'bar',
        stack: 'total',
        data: xAxisData.map(month => data[month][blog] || 0),
        itemStyle: {
          color: colors[colorIndex % colors.length]
        },
        emphasis: {
          focus: 'series'
        }
      });
      colorIndex++;
    }

    var chartOptions = {
      color: colors,
      legend: {
        right: '15%',
        left: '15%',
        top: 5,
        data: seriesData.map(series => series.name)
      },
      tooltip: {
        trigger: 'item',
        formatter: '{a} <br/>{b}: <b>{c}</b>'
      },
      grid: {
        left: 56,
        right: 0,
        top: 20,
        bottom: '10%'
      },
      xAxis: {
        type: 'category',
        data: xAxisData,
        label: "Date",
        axisLabel: {
          formatter: value => {
            return new Date('2001-4').toLocaleString('default', { year: "numeric", month: "short"});
          },
          align: 'center'
        }
      },
      yAxis: {
        type: 'value',
        width: 54,
        label: "Posts",
        scale: true,
        axisLabel: {
          formatter: '{value} Posts',
          align: 'center'
        }
      },
      series: seriesData,
      dataZoom: []
    };

    if (options !== undefined && options != null) {
      chartOptions = {...chartOptions, ...options};
    }

    var chart = echarts.init(container, null, { renderer: "svg", width: width, height: height});
    chart.setOption(chartOptions);
  });
}

window.chart = chart;
