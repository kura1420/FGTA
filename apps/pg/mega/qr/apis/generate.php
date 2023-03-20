<?php namespace FGTA4\apis;

if (!defined('FGTA4')) {
	die('Forbiden');
}


require_once __ROOT_DIR.'/core/sqlutil.php';


use \FGTA4\exceptions\WebException;


$API = new class extends WebAPI {
	function __construct() {
	}
	
	public function execute($mid, $tid, $amount, $payment_type) {


		try {
			$genQrAddress = "http://qris.transfashion.id/megapg/insqr.php?tid=$tid&mid=$mid&amount=$amount&payment_type=$payment_type";
			$this->log($genQrAddress);

			$ch = curl_init(); 
			curl_setopt($ch, CURLOPT_URL, $genQrAddress);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
			$output = curl_exec($ch); 


			// $this->log($output);


			return (object)[
				'pgmessage' => $output 
			];

		} catch (\Exception $ex) {
			throw $ex;
		}
	}

};

