/**
 * Test Run Report Generator
 * Generate comprehensive report from K6 test results
 *
 * Usage: k6 run k6/02_browse_test.js -o json=results.json
 *        Node.js utils/generate-report.js results.json
 */

const fs = require('fs')
const path = require('path')

// Colors for terminal output
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[36m',
  bold: '\x1b[1m'
}

function readJsonFile(filePath) {
  try {
    const data = fs.readFileSync(filePath, 'utf8')
    // K6 outputs JSON lines, parse each line
    const lines = data.split('\n').filter(line => line.trim())
    return lines.map(line => JSON.parse(line))
  } catch (error) {
    console.error(`Error reading file: ${error.message}`)
    process.exit(1)
  }
}

function extractMetrics(jsonLines) {
  const metrics = {}

  jsonLines.forEach(line => {
    if (line.type === 'Metric') {
      const metricName = line.metric
      if (!metrics[metricName]) {
        metrics[metricName] = []
      }
      metrics[metricName].push(line.data)
    } else if (line.type === 'Point') {
      const metricName = line.metric
      if (!metrics[metricName]) {
        metrics[metricName] = []
      }
      metrics[metricName].push(line.data)
    }
  })

  return metrics
}

function analyzeMetrics(metrics) {
  const analysis = {}

  // Extract key metrics
  if (metrics['http_req_duration']) {
    const durations = metrics['http_req_duration']
      .filter(d => d && d.value !== undefined)
      .map(d => d.value)

    if (durations.length > 0) {
      analysis.responseTime = {
        min: Math.min(...durations),
        max: Math.max(...durations),
        avg: durations.reduce((a, b) => a + b, 0) / durations.length,
        count: durations.length
      }
    }
  }

  if (metrics['http_req_failed']) {
    const failures = metrics['http_req_failed']
      .filter(d => d && d.value !== undefined)
      .map(d => d.value)

    if (failures.length > 0) {
      const failureRate = failures.filter(v => v === 1).length / failures.length
      analysis.failureRate = (failureRate * 100).toFixed(2) + '%'
    }
  }

  if (metrics['http_reqs']) {
    const requests = metrics['http_reqs'].filter(
      d => d && d.value !== undefined
    )

    if (requests.length > 0) {
      analysis.totalRequests = requests[requests.length - 1].value
    }
  }

  return analysis
}

function generateReport(filePath) {
  console.log(
    `\n${colors.bold}${colors.blue}K6 Load Test Report Generator${colors.reset}\n`
  )

  if (!fs.existsSync(filePath)) {
    console.error(`${colors.red}File not found: ${filePath}${colors.reset}`)
    process.exit(1)
  }

  console.log(
    `Reading test results from: ${colors.blue}${filePath}${colors.reset}`
  )

  const jsonLines = readJsonFile(filePath)
  console.log(
    `${colors.green}✓${colors.reset} Loaded ${jsonLines.length} data points\n`
  )

  const metrics = extractMetrics(jsonLines)
  console.log(
    `${colors.green}✓${colors.reset} Extracted ${Object.keys(metrics).length} metrics\n`
  )

  const analysis = analyzeMetrics(metrics)

  // Generate report
  console.log(`${colors.bold}=== TEST RESULTS SUMMARY ===${colors.reset}\n`)

  if (analysis.responseTime) {
    console.log(`${colors.blue}Response Time:${colors.reset}`)
    console.log(
      `  Min:     ${colors.green}${analysis.responseTime.min.toFixed(2)}ms${colors.reset}`
    )
    console.log(`  Max:     ${analysis.responseTime.max.toFixed(2)}ms`)
    console.log(`  Average: ${analysis.responseTime.avg.toFixed(2)}ms`)
    console.log()
  }

  if (analysis.failureRate) {
    const failRate = parseFloat(analysis.failureRate)
    const failColor =
      failRate > 1 ? colors.red : failRate > 0.1 ? colors.yellow : colors.green
    console.log(
      `${colors.blue}Failure Rate:${colors.reset} ${failColor}${analysis.failureRate}${colors.reset}\n`
    )
  }

  if (analysis.totalRequests) {
    console.log(
      `${colors.blue}Total Requests:${colors.reset} ${colors.green}${analysis.totalRequests}${colors.reset}\n`
    )
  }

  // Print all available metrics
  console.log(`${colors.bold}=== ALL METRICS ===${colors.reset}\n`)
  Object.keys(metrics).forEach(metric => {
    const count = metrics[metric].filter(d => d && d.value !== undefined).length
    console.log(`  • ${metric}: ${count} data points`)
  })

  console.log(
    `\n${colors.bold}${colors.green}Report generation complete!${colors.reset}\n`
  )
}

// Run report generator
if (process.argv.length < 3) {
  console.error(
    `${colors.red}Usage: node generate-report.js <results.json>${colors.reset}`
  )
  console.error(`\nExample:`)
  console.error(`  k6 run k6/02_browse_test.js -o json=results.json`)
  console.error(`  node generate-report.js results.json`)
  process.exit(1)
}

const resultsFile = process.argv[2]
generateReport(resultsFile)
