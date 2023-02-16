module.exports = {
	env: {
		node: true
	},
	extends: [
		'@vue/airbnb',
		'prettier'
	],
	rules: {
		'no-console': process.env.NODE_ENV === 'production' ? 'off' : 'warn',
		'no-debugger': process.env.NODE_ENV === 'production' ? 'off' : 'warn',
		'vue/no-deprecated-slot-attribute': 'off',
		'import/extensions': [
			2,
			{
				js: 'always',
				vue: 'always'
			}
		],
		'vue/multi-word-component-names': [
			'error',
			{
				ignores: ['Index', 'Home', 'About']
			}
		]
	},
	settings: {
		
	}
};
