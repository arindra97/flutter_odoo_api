# Documentation Flutter CRUD - API Odoo ResPartner

## HomePage for Odoo res.partner CRUD

This document describes the `HomePage` widget in a Flutter application designed to perform CRUD (Create, Read, Update, Delete) operations on Odoo `res.partner` records through a REST API.

### Overview

The `HomePage` widget displays a list of `res.partner` records fetched from an Odoo API. It allows users to:

-   View a list of partners.
-   Add new partners.
-   Update existing partner information.
-   Delete partners.

### Code Structure

The `HomePage` widget is implemented as a `StatefulWidget` with the following key components:

-   **State:** `_HomePageState` manages the widget's state, including the list of partners, loading state, and form controllers.
-   **Data Model:** `ResPartner` model represents the partner data.
-   **Service:** `ResPartnerService` handles the API interactions.

### Key Components

#### 1. State Variables

-   `_formKey`: `GlobalKey<FormState>` for form validation.
-   `nameController`, `emailController`, `phoneController`, `streetController`, `cityController`, `zipController`: `TextEditingController` instances for form input.
-   `resPartners`: `List<ResPartner>` to store the fetched partner data.
-   `isLoading`: `bool` to indicate the loading state.

#### 2. `refreshData()` Method

-   Fetches the `res.partner` data from the Odoo API using `ResPartnerService.fetchResPartner()`.
-   Updates the `resPartners` list and sets the `isLoading` state.
-   This method is called during `initState()` and after CRUD operations.

## ResPartnerService - Flutter API Interactions

This document describes the `ResPartnerService` class, which handles interactions with the Odoo `res.partner` API from a Flutter application. It provides methods to fetch, create, update, and delete `res.partner` records.

The `ResPartnerService` class encapsulates the HTTP requests to the Odoo API, handling data serialization and deserialization using JSON. It uses the `http` package for making network requests.

### Base URL

-   `baseUrl`: The base URL for the Odoo API endpoints. Replace `192.168.18.15` with your Odoo server's IP address or hostname.

    ```dart
    static const String baseUrl = '[http://192.168.18.15:8069/api](http://192.168.18.15:8069/api)';
    ```

### Methods

#### 1. `fetchResPartner()`

-   **Description:** Fetches a list of `ResPartner` objects from the Odoo API.
-   **Method:** `GET`
-   **Endpoint:** `/res_partner`
-   **Returns:** `Future<List<ResPartner>>` - A list of `ResPartner` objects.
-   **Error Handling:** Throws an `Exception` if the request fails.

#### 2. `createResPatner(ResPartner request)`

-   **Description:** Creates a new `ResPartner` record in Odoo.
-   **Method:** `POST`
-   **Endpoint:** `/res_partner`
-   **Parameters:**
    -   `request`: `ResPartner` object containing the data to be created.
-   **Request Body (JSON):** Data is nested under the `"params"` key.
-   **Error Handling:** Throws an `Exception` if the request fails.

#### 3. `updateResPartner(int? id, ResPartner request)`

-   **Description:** Updates an existing `ResPartner` record in Odoo.
-   **Method:** `PUT`
-   **Endpoint:** `/res_partner/{id}` (replace {id} with the partner's ID)
-   **Parameters:**
    -   `id`: The ID of the `ResPartner` record to update
    -   `request`: `ResPartner` object containing the updated data.
-   **Request Body (JSON):** Data is nested under the `"params"` key.
-   **Error Handling:** Throws an `Exception` if the request fails.

#### 4. `deleteResPartner(int? id)`

-   **Description:** Deletes a `ResPartner` record in Odoo.
-   **Method:** `DELETE`
-   **Endpoint:** `/res_partner/{id}` (replace {id} with the partner's ID)
-   **Parameters:**
    -   `id`: The ID of the `ResPartner` record to delete.
-   **Error Handling:** Throws an `Exception` if the request fails.
