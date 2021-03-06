tests
testFixEmptyUserMailAndResumeDoesCommit
	| before after |
	(self repository getConfigurationGlobal: false) email: ''.
	self repository workingCopy addPackageNamed: 'AnotherPackage'.
	before := self repository headCommit.
	[ after := self repository commitWithMessage: 'Another commit message'.
	self assert: after notNil.
	self deny: before equals: after.
	^ self ]
		on: IceGitUsernameOrEmailNotFound
		do: [ :error | 
			(self repository getConfigurationGlobal: false) email: 'mock'.
			error resume ].
	self fail