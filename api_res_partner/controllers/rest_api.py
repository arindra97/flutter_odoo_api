# -*- coding: utf-8 -*-
from odoo import http
from odoo.http import request, Response

import json
import re

class resPartnerAPI(http.Controller):
    
    @http.route('/api/res_partner', type='http', auth='public', methods=['GET'])
    def get_partners(self, **kwargs):
        """
        Fetch all records res.partner
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
        """Fetch a specific res.partner record"""
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
        """Create a new res.partner record"""

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
        """Update an existing res.partner record"""
        partner = request.env['res.partner'].sudo().browse(partner_id)
        if not partner.exists():
            return {'error': 'Partner not found'}

        if not kwargs['name'] or not kwargs['email']:
            return {'error': 'This fields is required'}
        
        if not re.match(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$", kwargs['email']):
            return {'error':'Email not valid'}
        
        partner.write(kwargs)
        return {'message': 'Partner updated successfully'}

    @http.route('/api/res_partner/<int:partner_id>', type='json', auth='public', methods=['DELETE'])
    def delete_partner(self, partner_id):
        """Delete a res.partner record"""
        partner = request.env['res.partner'].sudo().browse(partner_id)
        if not partner.exists():
            return {'error': 'Partner not found'}
        
        partner.unlink()
        return {'message': 'Partner deleted successfully'}


