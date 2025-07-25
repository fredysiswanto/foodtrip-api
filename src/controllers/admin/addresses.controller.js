const db = require('../../models')
const {
  // dataResponse,
  errResponse,
  // emptyDataResponse,
  checkAuthorization
} = require('../../helpers/controller.helper')
const dataTable = require('sequelize-datatables')

// * Retrieve all Address
exports.getAllAddress = async (req, res) => {
  if (!checkAuthorization(req, res, 'Admin')) {
    return
  }

  req.body = {
    draw: 1,
    columns: [
      {
        data: 'address_id',
        name: '',
        searchable: true,
        orderable: true,
        search: {
          value: '',
          regex: false
        }
      }
    ],
    order: [
      {
        column: 0,
        dir: 'asc'
      }
    ],
    start: 0,
    length: 100,
    search: {
      value: '',
      regex: false
    }
  }

  try {
    const data = await dataTable(db.Address, req.body, {})
    res.send(data)
  } catch (err) {
    errResponse(res, err)
  }
}

// * Retrieve single Address
exports.getAddress = async (req, res) => {
  if (!checkAuthorization(req, res, 'Admin')) {
    return
  }

  const id = req.params.addressID

  req.body = {
    draw: 1,
    columns: [
      {
        data: 'address_id',
        name: '',
        searchable: true,
        orderable: true,
        search: {
          value: '',
          regex: false
        }
      }
    ],
    order: [
      {
        column: 0,
        dir: 'asc'
      }
    ],
    start: 0,
    length: 100,
    search: {
      value: '',
      regex: false
    }
  }

  try {
    const data = await dataTable(db.Address, req.body, {
      where: { address_id: id }
    })
    res.send(data)
  } catch (err) {
    errResponse(res, err)
  }
}
