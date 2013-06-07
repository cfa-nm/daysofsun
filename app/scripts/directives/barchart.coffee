'use strict'

angular.module('daysOfSun').directive 'barchart', ->
  months = [
    'jan', 'feb', 'mar', 'apr'
    'may', 'jun', 'jul', 'aug'
    'sep', 'oct', 'nov', 'dec'
  ]

  restrict: 'E'
  scope: { data: '=' }
  link: (scope, element, attrs) ->
    width = 420
    height = 240

    svg = d3.select(element[0])
      .append('svg')
        .attr('class', 'barchart')
        .attr('width', width + 25)
        .attr('height', height + 15)

    chart = svg.append('g')
        .attr("transform", "translate(25,0)")

    y = d3.scale.linear()
      .domain([0, 31])
      .rangeRound([0, height - 15])

    scope.$watch 'data', ->
      return unless scope.data?

      data = months.map( (month) ->
        scope.data[month]
      ).map (month) ->
        month.clear + month.partlyCloudy

      columnWidth = width / data.length

      # horizontal labels
      chart.selectAll("text")
          .data(months)
        .enter().append("text")
          .attr("x", (d, i) -> (i + 0.5) * columnWidth)
          .attr("y", height)
          .attr("dy", "1em")
          .attr("text-anchor", "middle")
          .text( (d, i) -> months[i].toUpperCase() )

      # vertical lines
      chart.selectAll("line")
          .data(y.ticks(10))
        .enter().append("line")
          .attr("x1", 0)
          .attr("x2", width)
          .attr("y1", (d) -> height - y(d) )
          .attr("y2", (d) -> height - y(d) )
          .style("stroke", "#ccc")

      # vertical labels
      chart.selectAll(".rule")
          .data(y.ticks(10))
        .enter().append("text")
          .attr("class", "rule")
          .attr("x", -5)
          .attr("y", (d) -> height - y(d) )
          .attr("dy", "0.35em")
          .attr("text-anchor", "end")
          .text(String)

      # bars
      chart.selectAll("rect")
          .data(data)
        .enter().append("rect")
          .attr("x", (d, i) -> i * columnWidth)
          .attr("y", (d) -> height - y(d) + 0.5 )
          .attr("width", columnWidth)
          .attr("height", y)

      # x origin line
      chart.append("line")
          .attr("x1", 0)
          .attr("x2", width)
          .attr("y1", height)
          .attr("y2", height)
          .style("stroke", "#000")

      # y origin line
      chart.append("line")
          .attr("y1", 0)
          .attr("y2", height)
          .style("stroke", "#000")
