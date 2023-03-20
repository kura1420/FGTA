export async function alert(options) {
	options.dismissible = false;
	options.endingTop = '50%'
	await create_modal(options);
}

export async function confirm(options) {
	options.dismissible = false;
	options.endingTop = '50%'

	if (options.buttons===undefined) {
		options.buttons = {
			yes: {
				text: 'Yes',
				action: (modal) => {
					modal.close();
					return 'yes';
				}
			},

			no: {
				text: 'No',
				action: (modal) => {
					modal.close();
					return 'no';
				}
			}
		}
	}

	return await create_modal(options);
}



async function create_modal(options) {
	return new Promise((resolve, reject)=>{

		var id = options.id ?? window.uniqid();
		var text = options.text ?? "";
		var buttons = options.buttons ?? {ok: {text:'<b>Ok</b>', action: (modal)=>{ modal.close(); }}}
		
		var elmc = document.getElementById('modal-container');
		var elmo = document.createElement('div'); // our modal frame
	
		elmo.id = id;
		elmo.classList.add('modal'); // class from materialize css
		elmo.classList.add('modal-center');
	
		var elco = document.createElement('div'); //modal content
		elco.classList.add('modal-content');
	
		if (options.title!=null) {
			var elti = document.createElement('h4');
			elti.innerHTML = options.title;
			elco.appendChild(elti);
		}
	
		var eltx = document.createElement('p'); // modal text
		eltx.innerHTML = text;
		elco.appendChild(eltx);
		elmo.appendChild(elco);
	
	
		var elfo = document.createElement('p');
		elfo.classList.add('modal-footer');
		elfo.classList.add('modal-button-container');
	
		var modalbuttons = [];
		for (var buttonname in buttons) {
			var buttontext = buttons[buttonname].text ?? buttonname;
		
			var elbt = document.createElement('a');
			elbt.classList.add('waves-effect');
			elbt.classList.add('waves-green');
			elbt.classList.add('btn-flat');
			elbt.action = buttons[buttonname].action;
			elbt.innerHTML = buttontext;
			modalbuttons.push(elbt);
			elfo.appendChild(elbt);
		}
		elmo.appendChild(elfo);
	
		// masukkan modal ke dalam modal container utama;
		elmc.appendChild(elmo);
	

		if (typeof options.onCloseEnd !== 'function') {
			options.onCloseEnd = () => {
				elmo.parentNode.removeChild(elmo);
			}
		}

		var modal = M.Modal.init(elmo, options);
	
		modal.result = null;
		for (let btn of modalbuttons) {
			btn.addEventListener('click', (obj, evt)=>{
				if (typeof btn.action === 'function') {
					modal.result = btn.action(modal);
					resolve(modal.result);
				}
			});
		}
	
		modal.open();
	});
	
}


export async function initPages(opt, pages) {
	let pg = {
		activePage: null,
		items: {}
	}


	var firstelement = null;
	for (let pagename in pages) {
		pg.items[pagename] = {
			element: pages[pagename].element,
			handler: pages[pagename].handler,
		}
		
		if (firstelement==null) {
			firstelement = pages[pagename].element;
			pg.activePage = pg.items[pagename];
		} else {
			pg.items[pagename].element.classList.add('page-hidden');
		}

		pg.items[pagename].getName = () => { return pagename; }
		pg.items[pagename].Show = (fn_callback) => {
			pospage_show(pg, pagename, fn_callback);
		};
	}

	pg.getPage = (pagename) => {
		return pospage_getPage(pg, pagename);
	}

	pg.getActivePage = () => {
		return postpage_getActivePage(pg);
	}

	if (firstelement!=null) {
		firstelement.classList.remove('page-hidden');
	}

	// init pages
	for (let pagename in pg.items) {
		if (typeof pg.items[pagename].handler.init === 'function') {
			await pg.items[pagename].handler.init(opt);
		}
	}


	return pg;
}


function pospage_show(pg, pagename, fn_callback) {
	if (pagename==pg.activePage.getName()) {
		return;
	}

	// let previousPage = pg.activePage;
	pg.activePage = pg.items[pagename];
	for (let pname in pg.items) {
		if (pname!=pagename) {
			pg.items[pname].element.classList.add('page-hidden');
		}
	}

	pg.activePage.element.classList.remove('page-hidden');
	if (typeof fn_callback==='function') {
		fn_callback(pg.activePage);
	}
}

function pospage_getPage(pg, pagename) {
	return pg.items[pagename];
}

function postpage_getActivePage(pg) {
	return pg.activePage;
}