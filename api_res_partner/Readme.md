# Documentation: Odoo res.partner API

## Introduction

This document describes the API for managing `res.partner` records within Odoo. This API allows external applications to retrieve, create, update, and delete partner information.

**Base URL:**

The base URL for all API endpoints is `[odoo_base_url]/api/res_partner`. Replace `[odoo_base_url]` with the actual URL of Odoo instance.

**Authentication:**

All endpoints are configured with `auth='public'`. This means they are accessible without any authentication. However, if you need to restrict access, you can change the `auth` parameter in the route definition.

## Endpoints

### 1. Get All Partners (GET /api/res_partner)

-   **Description:** Retrieves a list of all `res.partner` records.
-   **Method:** `GET`
-   **URL:** `/api/res_partner`
-   **Parameters:** None
-   **Response:**

    -   **Success (Status 200):**

        ```json
        {
            "data": [
                {
                    "id": 1,
                    "name": "Partner Name",
                    "email": "partner@example.com",
                    "phone": "123-456-7890",
                    "street": "123 Main St",
                    "city": "Anytown",
                    "zip": "12345"
                }
                // ... more partners ...
            ]
        }
        ```

    -   **Error (Status 400):**

        ```json
        {
            "error": "Error message"
        }
        ```

### 2. Get a Specific Partner (GET /api/res_partner/{partner_id})

-   **Description:** Retrieves a specific `res.partner` record by its ID.
-   **Method:** `GET`
-   **URL:** `/api/res_partner/{partner_id}` (replace `{partner_id}` with the actual partner ID)
-   **Parameters:**
    -   `partner_id` (integer): The ID of the partner to retrieve.
-   **Response:**

    -   **Success (Status 200):**

        ```json
        {
            "data": {
                "id": 1,
                "name": "Partner Name",
                "email": "partner@example.com",
                "phone": "123-456-7890",
                "street": "123 Main St",
                "city": "Anytown",
                "zip": "12345"
            }
        }
        ```

    -   **Error (Status 400):**

        ```json
        {
            "error": "Partner not found"
        }
        ```

### 3. Create a New Partner (POST /api/res_partner)

-   **Description:** Creates a new `res.partner` record.
-   **Method:** `POST`
-   **URL:** `/api/res_partner`
-   **Request Body (JSON):**

    ```json
    {
        "name": "New Partner Name",
        "email": "newpartner@example.com",
        "phone": "987-654-3210",
        "street": "456 Oak Ave",
        "city": "Othertown",
        "zip": "67890"
    }
    ```

-   **Required Fields:**
    -   `name` (string): The name of the partner.
    -   `email` (string): The email address of the partner.
-   **Optional Fields:**
    -   `phone` (string)
    -   `street` (string)
    -   `city` (string)
    -   `zip` (string)
-   **Response:**

    -   **Success (Status 200):**

        ```json
        {
            "id": 2,
            "message": "Partner created successfully"
        }
        ```

    -   **Error (Status 200):**

        ```json
        {
            "error": "Error message"
        }
        ```

### 4. Update a Partner (PUT /api/res_partner/{partner_id})

-   **Description:** Updates an existing `res.partner` record.
-   **Method:** `PUT`
-   **URL:** `/api/res_partner/{partner_id}` (replace `{partner_id}` with the actual partner ID)
-   **Request Body (JSON):**

    ```json
    {
        "name": "Updated Partner Name",
        "email": "updatedpartner@example.com",
        "phone": "555-123-4567"
    }
    ```

-   **Required Fields:**
    -   `name` (string): The name of the partner.
    -   `email` (string): The email address of the partner.
-   **Optional Fields:**
    -   `phone` (string)
    -   `street` (string)
    -   `city` (string)
    -   `zip` (string)
-   **Response:**

    -   **Success (Status 200):**

        ```json
        {
            "message": "Partner updated successfully"
        }
        ```

    -   **Error (Status 200):**

        ```json
        {
            "error": "Partner not found"
        }
        ```

### 5. Delete a Partner (DELETE /api/res_partner/{partner_id})

-   **Description:** Deletes a `res.partner` record.
-   **Method:** `DELETE`
-   **URL:** `/api/res_partner/{partner_id}` (replace `{partner_id}` with the actual partner ID)
-   **Parameters:**
    -   `partner_id` (integer): The ID of the partner to delete.
-   **Response:**

    -   **Success (Status 200):**

        ```json
        {
            "message": "Partner deleted successfully"
        }
        ```

    -   **Error (Status 200):**

        ```json
        {
            "error": "Partner not found"
        }
        ```

## Error Handling

-   All error responses are returned as JSON objects with an "error" key.
-   Common error codes include 400 (Bad Request) and 200 with an error response in the json body.

## Notes

-   Ensure that Odoo instance is running and accessible.
-   Replace placeholders like `[odoo_base_url]` with actual values.
-   This documentation is designed for developers who need to integrate with Odoo API.
