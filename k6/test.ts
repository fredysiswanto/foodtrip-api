import http from 'k6/http'
import { sleep } from 'k6'

export const options = {
  vus: 100,
  duration: '60s',
  iterations: 1000
}

export default function () {
  http.get('http://192.168.100.98:3000/api/v1/home/restaurants')
  sleep(1)
}
