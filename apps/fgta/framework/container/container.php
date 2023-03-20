<?php namespace FGTA4\module; if (!defined('FGTA4')) { die('Forbiden'); } 


class Container extends WebModule {
	
	public function LoadPage() {
		$this->incontainer = true;
		try {
			$userdata = $this->auth->session_get_user();
			if (\property_exists($userdata, 'dash_module')) {
				$this->dash_module = $userdata->dash_module;
			} else {
				$this->dash_module = null;
			}

		} catch (\Exception $ex) {
		}
	}
}

$MODULE = new Container();