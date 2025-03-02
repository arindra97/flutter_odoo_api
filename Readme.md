# Integration API Odoo res.partner into Flutter CRUD

This document outlines the integration of an Odoo 14 `res.partner` API with a Flutter CRUD (Create, Read, Update, Delete) application. The project encompasses the development of a REST API in Odoo and its subsequent implementation in a Flutter mobile application.

## A. REST API Odoo

The REST API for the `res.partner` table in Odoo 14 has been developed to enable CRUD operations. The API supports the following methods:

* **GET:** Retrieve partner records.
* **POST:** Create new partner records.
* **PUT:** Update existing partner records.
* **DELETE:** Delete partner records.

For detailed documentation of the Odoo REST API, please refer to the following link:

[Open here](https://github.com/arindra97/flutter_odoo_api/blob/main/api_res_partner/Readme.md)

This documentation provides information on the API endpoints, request/response formats, and usage instructions.

## B. Flutter CRUD

A Flutter application has been developed to demonstrate the consumption of the Odoo `res.partner` API. This application provides a user interface for performing CRUD operations on partner records.

The Flutter application is implemented in the following file:

[Open here](https://github.com/arindra97/flutter_odoo_api/blob/main/flutter_crud/lib/main.dart)

This file contains the Flutter code for:

* Fetching partner data from the Odoo API.
* Displaying partner data in a list view.
* Creating new partner records through a form.
* Updating existing partner records.
* Deleting partner records.

This project showcases the integration of Odoo 14 with a Flutter mobile application, demonstrating the ability to perform CRUD operations on Odoo data through a REST API.
