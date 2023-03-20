'use strict'

const dbtype = global.dbtype;
const comp = global.comp;

module.exports = {
	title: "Users",
	autoid: true,

	persistent: {
		'fgt_user' : {
			primarykeys: ['user_id'],
			comment: 'Daftar User',
			data: {
				user_id: {text:'ID', type: dbtype.varchar(14), suppresslist: true, null:false},
				user_name: {text: 'Username', type: dbtype.varchar(30), lowercase: true, options: {required:true, invalidMessage:'Username harus diisi'}  },
				user_fullname: {text: 'User Fullname', type: dbtype.varchar(90), uppercase: true, options: {required:true, invalidMessage:'Fullname harus diisi'}  },
				user_email: {text: 'Email', type: dbtype.varchar(150), lowercase: true, suppresslist: true, options: {required:true, validType:['email'], invalidMessage:'Email harus diisi dengan benar'}  },
				user_password: {
					text: 'Password', type: dbtype.varchar(255),
					suppresslist: true, 
					options: {},
					after: `
					<div class="form_row">
						<div class="form_label_col">&nbsp;</div>
						<div class="form_input_col" style="border: 0px solid black">
							<a id="pnl_edit-btn_changepassword" class="easyui-linkbutton" href="javascript:void(0)">Change</a>
						</div>
					</div>
					`
				},
				group_id: {
					text:'Main Group', type: dbtype.varchar(13), null:false, 
					options:{required:true,invalidMessage:'Group harus diisi', prompt:'-- PILIH --'},
					comp: comp.Combo({
						table: 'fgt_group', 
						field_value: 'group_id', field_display: 'group_name', 
						api: 'fgta/framework/fggroup/list'})
				
				},
				user_disabled: {
					text: 'Disabled', type: dbtype.boolean, null:false, default:'0',
					// suppresslist: true, 
					options: {}
				},
			}
		},

		'fgt_usergroups' : {
			primarykeys: ['usergroups_id'],
			comment: 'Group yang dipunyai user, selain group utamanya',
			data: {
				usergroups_id: {text:'ID', type: dbtype.varchar(14), null:false},
				usergroups_isdisabled: {text: 'Disabled', type: dbtype.boolean, null:false, default:'0'},
				group_id: {
					text:'Group', type: dbtype.varchar(13), null:false, 
					options:{required:true,invalidMessage:'Group harus diisi', prompt:'-- PILIH --'},
					comp: comp.Combo({
						table: 'fgt_group', 
						field_value: 'group_id', field_display: 'group_name', 
						api: 'fgta/framework/fggroup/list'})
				},	
				user_id: {text:'User', type: dbtype.varchar(14), null:false},			
			}
		}
	},

	schema: {
		title: 'User',
		header: 'fgt_user',
		detils: {
			'groups' : {title: 'Owned Groups', table:'fgt_usergroups', form: true, headerview:'user_name'},  //headerview:'city_name'
		}
	}
}



