async function processMessage (messageData) {
  try {
    // if (messageData.url && messageData.method) {
    //   return await checkApi(messageData);
    // }

    const ollamaUrl = process.env.OLLAMA_URL || 'http://192.168.100.22:11434'
    const response = await fetch(`${ollamaUrl}/api/chat`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        model: 'deepseek-r1:1.5b',
        messages: [{ role: 'user', content: messageData.message }]
      })
    })

    console.log(response)
    const data = await response.json()

    return data.message?.content || 'No response from Ollama.'
  } catch (error) {
    console.error('Error processing message:', error)

    return 'Terjadi kesalahan saat memproses pesan.'
  }
}

async function checkApi ({
  url,
  method,
  headers = {},
  query_params = {},
  payload = {},
  validate = {}
}) {
  try {
    const baseUrl = `http://localhost:${process.env.PORT || 5000}`

    // Menyusun URL dengan query params jika ada
    const queryString = new URLSearchParams(query_params).toString()
    const fullUrl = `${baseUrl}${url}${queryString ? `?${queryString}` : ''}`

    const options = {
      method: method.toUpperCase(),
      headers
    }

    // Tambahkan body untuk method yang mendukung payload
    if (['POST', 'PUT', 'PATCH'].includes(method.toUpperCase())) {
      options.body = JSON.stringify(payload)
    }

    const response = await fetch(fullUrl, options)
    const responseData = await response.json()

    // Validasi response jika ada aturan validasi
    const validationResults = validateResponse(
      responseData,
      response.status,
      validate
    )

    return {
      status: response.status,
      response: responseData,
      validation: validationResults
    }
  } catch (error) {
    console.error('Error calling API:', error)

    return { error: 'Gagal menghubungi API.' }
  }
}

// Fungsi validasi response berdasarkan aturan yang diberikan
function validateResponse (response, status, validateRules) {
  const result = { status: 'passed', errors: [] }

  // Validasi status HTTP
  if (validateRules.status && validateRules.status !== status) {
    result.status = 'failed'
    result.errors.push(
      `Expected status ${validateRules.status}, but got ${status}`
    )
  }

  // Validasi field yang diharapkan
  // if (validateRules.fields) {
  //   for (const key in validateRules.fields) {
  //     const expectedValue = validateRules.fields[key];
  //     const actualValue = getNestedValue(response, key);

  //     if (actualValue === undefined) {
  //       result.status = "failed";
  //       result.errors.push(`Missing field: ${key}`);
  //     } else if (typeof expectedValue === "string" || typeof expectedValue === "number" || typeof expectedValue === "boolean") {
  //       // Cek apakah nilai sama persis
  //       if (actualValue !== expectedValue) {
  //         result.status = "failed";
  //         result.errors.push(`Field ${key} expected value "${expectedValue}", but got "${actualValue}"`);
  //       }
  //     } else if (typeof actualValue !== expectedValue) {
  //       // Cek apakah tipe data sesuai jika expectedValue adalah tipe data (string, number, boolean)
  //       result.status = "failed";
  //       result.errors.push(`Field ${key} expected type ${expectedValue}, but got ${typeof actualValue}`);
  //     }
  //   }
  // }
  if (validateRules.fields) {
    for (const key in validateRules.fields) {
      const expected = validateRules.fields[key]
      const actualValue = getNestedValue(response, key)

      if (actualValue === undefined) {
        result.status = 'failed'
        result.errors.push(`Missing field: ${key}`)
      } else if (typeof expected === 'string') {
        // ✅ Validasi tipe data (tanpa schema JSON)
        if (typeof actualValue !== expected) {
          result.status = 'failed'
          result.errors.push(
            `Field ${key} expected type "${expected}", but got "${typeof actualValue}"`
          )
        }
      } else if (typeof expected === 'object' && expected.type === 'equal') {
        // ✅ Validasi Equal
        if (actualValue !== expected.value) {
          result.status = 'failed'
          result.errors.push(
            `Field ${key} expected value "${expected.value}", but got "${actualValue}"`
          )
        }
      }
    }
  }

  return result
}

// Fungsi untuk mengambil nilai nested dengan aman
function getNestedValue (obj, path) {
  return path
    .split('.')
    .reduce(
      (acc, key) => (acc && acc[key] !== undefined ? acc[key] : undefined),
      obj
    )
}

module.exports = { processMessage, checkApi }
