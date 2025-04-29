Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328D78F58;
	Tue, 29 Apr 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947742; cv=none; b=JxtcfOmgmV8wY3CHM+ZvKkfGNG2KjkTeuqIkCUjl5yYWd6v7ofCpx+rxwyiDYn2qQFBvuR7UxYbpS1pOtZQUfR/jdV4a0P+j5cZadAzU+IbrR2cU192AraO6FHqVs2yFfIsNVcWw0TDQxqOm9Se6jQB0+FhVOrxOqkwgc1H4eeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947742; c=relaxed/simple;
	bh=8xfiJRm4IrwupfThxxvWEdxfv+b8w/tb3J7jTDqosac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLqh/Or7FDDWdSdXfWGAWcFCVAxK4NQZHA7E6JI9vDUfBvn9La44wF6lzQQde6wSPl+DyosbmihWgmLgzAC7YITDTdcr4RPlkMLSzjXVnC6UYkxaDmxyCnies48icG4ribwrxegYGKP4Wbs953OYHNjhvmZ5zQayLFGW9Evo4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER/9RRUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER/9RRUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4079C4CEE9;
	Tue, 29 Apr 2025 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745947741;
	bh=8xfiJRm4IrwupfThxxvWEdxfv+b8w/tb3J7jTDqosac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ER/9RRUSbbvw04ZwEowWxEX5SqfJ7eX7rKJnItQ1hn4vAx68iDSMCTU44Gm+Pk0Vn
	 zDMoAZCkt/+sBqbHwDKOXMwb23EnSLvU51CY6dW16/30bb/twBuZK98mJYdDfBnuq3
	 qijuhrUNllvkFw7wycTEN7Iizunamz/JyZb8jOCAachSVdTJ+3+Wz4AmC8j1X3J24v
	 SZtkVLYvipdhCaeI/1IVJH2SzDaCxf89WetmkTgcY/wSm3lnxqLiIP1q5Aoj0AJtwx
	 Q8xsHkZa58wqJfr9UcO6HRWKr7rw2fS6kQLNhJ1uATRyTN7hL5NTeyOdS9x8/+lrJI
	 p8X3Jpgyxd+6Q==
Date: Tue, 29 Apr 2025 10:28:58 -0700
From: Kees Cook <kees@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>, Xavier <xavier_qy@163.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: Add initial binfmt docs
Message-ID: <202504291028.523CF77C@keescook>
References: <20250426000704.work.637-kees@kernel.org>
 <87selrrhnw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87selrrhnw.fsf@trenco.lwn.net>

On Mon, Apr 28, 2025 at 05:27:15PM -0600, Jonathan Corbet wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > Adds a framework to hold the initial exec.c and binfmt_elf.c
> > kernel-docs. Updates scripts/kernel-doc to allow leading whitespace so
> > that embedded "DOC:" tags can be found that aren't at the start of a
> > line so that in-function documentation can be found, like that recently
> > marked up in binfmt_elf.c[1].
> 
> Just one tiny little problem ... when you weren't looking, Mauro snuck
> in and replaced scripts/kernel-doc with a shiny new Python
> implementation.  So that part of the patch won't apply to docs-next; if
> you apply it somewhere else, the change will get lost.
> 
> I figured we were going to run into at least one of these ... sorry ...

Oh duh, yeah, I will go re-do this with -next.

-Kees

-- 
Kees Cook
