function getDate(string) {
	let d = new Date(string);
	return d.toLocaleDateString('en-GB');
}
function getTime(string) {
	let d = new Date(string);
	return d.toLocaleTimeString('en-US');
}

function getIcon(value) {
	if (value === 'Solar Energy') {
		return 'sun';
	}
	if (value === 'Energy Demand') {
		return 'energy';
	}
}

function getCountry(value) {
	const regionNames = new Intl.DisplayNames(['en'], { type: 'region' });
	return regionNames.of(value);
}

function getFunds(steps) {
	return steps.map(x => x.prefunding).reduce((s, v) => s + (v || 0), 0);
}

export { 
    getDate,
    getTime,
	getIcon,
	getCountry,
	getFunds
};