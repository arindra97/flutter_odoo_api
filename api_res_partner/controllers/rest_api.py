# -*- coding: utf-8 -*-
from odoo import http
from odoo.http import request, Response

import json
import re

class resPartnerAPI(http.Controller):
    
    @http.route('/api/res_partner', type='http', auth='public', methods=['GET'])
    def get_partners(self, **kwargs):
        """
        The function `get_partners` retrieves a list of partner records with specific fields and returns
        them in JSON format.
        :return: A JSON response containing data of all partners with their id, name, email, phone,
        street, city, and zip fields is being returned. If an error occurs during the process, a JSON
        response with the error message is returned with a status code of 400.
        """
        try:
            # Fetch All record
            partners = request.env['res.partner'].sudo().search([], order='id desc')

            result = [{
                'id': partner.id,
                'name': partner.name,
                'email': partner.email if partner.email else '',
                'phone': partner.phone if partner.phone else '',
                'street': partner.street if partner.street else '',
                'city': partner.city if partner.city else '',
                'zip': partner.zip if partner.zip else '',
            } for partner in partners]

            return Response(
                json.dumps({
                    'data': result
                }),
                content_type='application/json',
                status=200
            )
        except Exception as e:
            return Response(
                json.dumps({'error': str(e)}),
                content_type='application/json',
                status=400
            )
        
    @http.route('/api/res_partner/<int:partner_id>', type='http', auth='public', methods=['GET'])
    def get_partner(self, partner_id):
        """
        The function `get_partner` retrieves information about a specific partner by their ID and
        returns it in a JSON response.
        
        :param partner_id: The `partner_id` parameter in the code snippet represents the unique
        identifier of a specific partner in the system. This endpoint is designed to retrieve
        information about a partner with the given `partner_id`. The code fetches the partner details
        from the database using the provided `partner_id` and returns a JSON
        :return: A JSON response containing the partner's information such as id, name, email, phone,
        street, zip, and city is being returned. If the partner with the specified partner_id does not
        exist, an error message 'Partner not found' is returned with a status code of 400.
        """
        partner = request.env['res.partner'].sudo().browse(partner_id)
        if not partner.exists():
            return Response(
                json.dumps({'error': 'Partner not found'}),
                content_type='application/json',
                status=400
            )
        return Response(
                json.dumps({
                    'data': {
                        'id': partner.id,
                        'name': partner.name,
                        'email': partner.email,
                        'phone': partner.phone,
                        'street': partner.street,
                        'zip': partner.zip,
                        'city': partner.city,
                    }
                }),
                content_type='application/json',
                status=200
            )
        
    @http.route('/api/res_partner', type='json', auth='public', methods=['POST'])
    def create_partner(self, **kwargs):
        """
        The function `create_partner` creates a new partner record with specified fields if name and
        email are provided and valid.
        :return: The code snippet defines a route '/api/res_partner' that accepts JSON data via a POST
        request to create a new partner record. The function 'create_partner' checks if the required
        fields 'name' and 'email' are present in the request data. If any of these fields are missing or
        empty, it returns an error message.
        """

        if 'name' not in kwargs or 'email' not in kwargs:
            return {'error': 'Missing required fields'}

        if not kwargs['name'] or not kwargs['email']:
            return {'error': 'This fields is required'}
        
        # Validate Post Data
        if not re.match(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$", kwargs['email']):
            return {'error':'Email not valid'}

        partner = request.env['res.partner'].sudo().create({
            'name': kwargs['name'],
            'email': kwargs['email'],
            'phone': kwargs.get('phone', ''),
            'street': kwargs.get('street', ''),
            'zip': kwargs.get('zip', ''),
            'city': kwargs.get('city', ''),
            'tz': 'Asia/Jakarta',
        })
        return {'id': partner.id, 'message': 'Partner created successfully'}

    @http.route('/api/res_partner/<int:partner_id>', type='json', auth='public', methods=['PUT'])
    def update_partner(self, partner_id, **kwargs):
        """
        This Python function updates a partner record with specified fields and validates the name and
        email inputs.
        
        :param partner_id: The `partner_id` parameter in the code snippet represents the unique
        identifier of the partner record that you want to update. It is expected to be an integer value
        that corresponds to the ID of the partner record in the `res.partner` model
        :return: The code snippet provided is a Python function that defines an API endpoint for
        updating a partner record in a system.
        """
        partner = request.env['res.partner'].sudo().browse(partner_id)
        if not partner.exists():
            return {'error': 'Partner not found'}

        if 'name' in kwargs or 'email' in kwargs:
            if not kwargs['name'] or not kwargs['email']:
                return {'error': 'This fields is required'}
        
            if not re.match(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$", kwargs['email']):
                return {'error':'Email not valid'}
        
        partner.write(kwargs)
        return {'message': 'Partner updated successfully'}

    @http.route('/api/res_partner/<int:partner_id>', type='json', auth='public', methods=['DELETE'])
    def delete_partner(self, partner_id):
        """
        This Python function deletes a partner record by ID if it exists.
        
        :param partner_id: The `partner_id` parameter in the route `/api/res_partner/<int:partner_id>`
        refers to the unique identifier of the partner record that you want to delete. This identifier
        is expected to be an integer value. When a DELETE request is made to this route with a specific
        `partner_id`,
        :return: The delete_partner function returns a JSON response. If the partner with the specified
        partner_id exists, it will delete the partner record and return a JSON response {'message':
        'Partner deleted successfully'}. If the partner does not exist, it will return a JSON response
        {'error': 'Partner not found'}.
        """
        partner = request.env['res.partner'].sudo().browse(partner_id)
        if not partner.exists():
            return {'error': 'Partner not found'}
        
        partner.unlink()
        return {'message': 'Partner deleted successfully'}


