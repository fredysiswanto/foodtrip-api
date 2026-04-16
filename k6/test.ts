import http from 'k6/http'
import { check, sleep } from 'k6'

export const options = {
  stages: [
    { duration: '1m', target: 200 }, // Naikkan ke 20 pengguna dalam 1 menit
    { duration: '3m', target: 200 }, // Pertahankan 20 pengguna selama 3 menit
    { duration: '1m', target: 100 } // Turunkan kembali ke 0 pengguna
  ]
}

export default function () {
  // const res = http.get('http://192.168.100.98:3000/api/v1/home/restaurants')
  // check(res, { 'status is 200': r => r.status === 200 })

  // buat testing untuk api login dengan method post, endpoint /api/v1/home/login, dengan payload email dan password, lalu cek apakah statusnya 200 dan apakah tokennya ada
  const payload = JSON.stringify({
    email_address: 'paultulod@pm.me',
    password: 'Admin@123'
  })

  const res = http.post(
    'http://192.168.100.98:3000/api/v1/home/login',
    payload,
    {
      headers: { 'Content-Type': 'application/json' }
    }
  )
  check(res, {
    'status is 200': r => r.status === 200,
    'token exists': r => !!r.json().token
  })

  sleep(1)
}
