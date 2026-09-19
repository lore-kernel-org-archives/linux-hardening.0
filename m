Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD72F691D;
	Sat, 19 Sep 2026 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824698; cv=none; b=ZMg5nGvYAeUljODDPXcXwBpKpHtPVWQsfcPqsdbZIJHISjWgVDie2JeQ1yuMjoOQaDBkJaUHgogqofnJ+hAwSwtQ93J6edcFY7HirY5VQmRlN9c4CjU2Wp4TvMdP1VG8F9GQjtq/v2TaFmkS1PFgUdjj9z/5Febz8i23j5OWkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824698; c=relaxed/simple;
	bh=uiuuTERZGcy4ko3mNXucZBk1RKFtye2kgYm6hagJsng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRosL8MjMC6JnqqlykKShizTz0Dmmjfj18wkTFWXmFCbWEJkF+WcmlZi1FfaF0eQQQSPmF+PirbmZD/H6Spufr2QxViEQwcaF0MXsqDla63ET+8ytl9UjM3pojoBqqUr4yI34/PvLXrTt3d1tXSD74ty6LTgaRj06bRuz1osMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO3Y2XsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO3Y2XsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CF41F000FF;
	Sat, 19 Sep 2026 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789824697;
	bh=LRxkL+FNxgiZNVxZ1edJUWhUkP0aSqg5kr3XlruhiC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QO3Y2XsEPGiSzCvLFdPBPK4Z3MfogKpXSSlnRO/Y7+i4SIEzJAhRAK1FEt8aS4wuW
	 NVcbTYOmIxXOPI09HqJiLNEjwv1U362YGxd+T0qDY30SYcNfjz7rN3r/O1bvNtNfAh
	 49ebuXswm4/ol9whV47iYP+7DPtAmDX2MIRPaDjhC+5Xva64V57DKQf6IRoQka0Rh6
	 QibKjBxAkVoX90Am6LsWqxITR1nzhv7V5KAEjfLkAT+sPVPZXftHkAoKEojaYaMNHr
	 nOKorKOhVpPBljLVdYLIQrY08YumNrqRnpSbxGNay9ZsBWK/jOEmIglNsqBFxFu+xs
	 3EeTtBNRaHaxg==
Date: Sat, 19 Sep 2026 14:31:28 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Julian Braha <julianbraha@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Nauman Sabir <officialnaumansabir@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Nicolas Pitre <nico@fluxnic.net>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Matthew Maurer <mmaurer@google.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Jones <andrew.jones@linux.dev>, 
	Graham Roff <grahamr@qti.qualcomm.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kconfig: Introduce cc-option-str
Message-ID: <aq6OPchSSrgXhicS@gremlin>
References: <20260919005923.i.879-kees@kernel.org>
 <20260919012508.GA3573999@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919012508.GA3573999@ax162>

On Fri, Sep 18, 2026 at 06:25:08PM -0700, Nathan Chancellor wrote:
> On Fri, Sep 18, 2026 at 05:59:24PM -0700, Kees Cook wrote:
> > Hi,
> >
> > While reviewing the recent build speedup series[1], it became clear
> > that we needed a general solution in kconfig to avoid repeating detected
> > toolchain options. Implement cc-option-str and ld-option-str, and while
> > at it, create "def_string" and friends to match "def_bool".
> >
> > -Kees
> >
> > [1] https://lore.kernel.org/all/20260918054058.GA384222@ax162/
> >
> > Kees Cook (3):
> >   kconfig: Add "def_string", "def_int" and "def_hex"
> >   kconfig: Replace "cc-option-bit" with "cc-option-str"
> >   kconfig: Add "ld-option-str"
>
> Thanks, exactly what I had in mind. This seems reasonable to me and
> passes my basic testing. I will let folks chime in for a few days then
> apply this to kbuild-next so that Lorenzo can use it as part of the
> speed up series.

Agreed, I will base my local v4 on it and send that (obviously once I've
gone through review commentary etc.) once things have settled and rebase
the series on kbuild-next!

since I sent v3 on thurs I'll likely aim for weds/thurs next week for v4
but I'll wait until this series is in place before I do it obviously! :)

>
> --
> Cheers,
> Nathan

--
Cheers, Lorenzo
