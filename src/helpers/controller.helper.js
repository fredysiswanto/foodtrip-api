exports.checkAuthorization = (req, res, user_type) => {
  if (user_type === null) {
    res.status(500).send('`user_type` parameter is required')
    return false
  }

  const validuser_type = ['Customer', 'Resto_Admin', 'Admin'].some(
    role => role === user_type
  )

  if (!validuser_type) {
    res.status(500).send('The value for `user_type` parameter is invalid')
    return false
  }

  if (!(req.user !== null && req.user.user_type === user_type)) {
    res.status(401).send('Oops! You are unauthorized to view your request')
    return false
  }
  return true
}

exports.errResponse = (res, err) => {
  let errorMessage = `${err}`

  // Remove error type prefix (e.g., "SequelizeUniqueConstraintError: Message" → "Message")
  if (errorMessage.includes(': ')) {
    errorMessage = errorMessage.split(': ').slice(1).join(': ')
  }

  // Handle foreign key constraint errors
  if (errorMessage.includes('foreign key constraint fails')) {
    // Extract the field name from error message
    const fieldMatch = errorMessage.match(/FOREIGN KEY \(`(\w+)`\)/)
    const fieldName = fieldMatch ? fieldMatch[1] : 'related record'
    errorMessage = `The ${fieldName} provided does not exist or is invalid. Please check and try again.`
  }

  return res.status(500).send({
    error: true,
    message: errorMessage
  })
}

exports.dataResponse = (res, data, withDataMsg, nullDataMsg) => {
  if (data.length === 0 || data === null) {
    return res.send({
      error: false,
      data: [],
      message: nullDataMsg
    })
  }

  return res.send({
    error: false,
    data,
    message: withDataMsg
  })
}

exports.emptyDataResponse = (res, message) => {
  return res.send({
    error: false,
    message
  })
}
