const multer = require('multer')
const path = require('path')
const helpers = require('../helpers/imageHelper')

const restoStorage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, '../../public/uploads/restaurants/'))
  },

  filename: function (req, file, cb) {
    cb(
      null,
      `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`
    )
  }
})

const dishStorage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, '../../public/uploads/dishes/'))
  },

  filename: function (req, file, cb) {
    cb(
      null,
      `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`
    )
  }
})

exports.uploadDishImage = (req, res, next) => {
  const restoUpload = multer({
    storage: dishStorage,
    fileFilter: helpers.imageFilter
  }).single('dish_img')

  restoUpload(req, res, err => {
    if (req.fileValidationError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [req.fileValidationError]
      })
    } else if (!req.file) {
      return res.status(500).send({
        error: true,
        data: [],
        message: ['Please select an image to upload']
      })
    } else if (err instanceof multer.MulterError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    } else if (err) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    }

    next()
  })
}

exports.updateRestoImage = (req, res, next) => {
  const restoUpload = multer({
    storage: restoStorage,
    fileFilter: helpers.imageFilter
  }).single('resto_img')

  restoUpload(req, res, err => {
    if (req.fileValidationError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [req.fileValidationError]
      })
    } else if (err instanceof multer.MulterError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    } else if (err) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    }

    next()
  })
}

exports.updateDishImage = (req, res, next) => {
  const restoUpload = multer({
    storage: dishStorage,
    fileFilter: helpers.imageFilter
  }).single('dish_img')

  restoUpload(req, res, err => {
    if (req.fileValidationError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [req.fileValidationError]
      })
    } else if (err instanceof multer.MulterError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    } else if (err) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    }

    next()
  })
}

exports.uploadRestoImage = (req, res, next) => {
  const restoUpload = multer({
    storage: restoStorage,
    fileFilter: helpers.imageFilter
  }).single('resto_img')

  restoUpload(req, res, err => {
    if (req.fileValidationError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [req.fileValidationError]
      })
    } else if (!req.file) {
      return res.status(500).send({
        error: true,
        data: [],
        message: ['Please select an image to upload']
      })
    } else if (err instanceof multer.MulterError) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    } else if (err) {
      return res.status(500).send({
        error: true,
        data: [],
        message: [err]
      })
    }

    next()
  })
}
