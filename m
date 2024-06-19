Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF81433B9;
	Wed, 19 Jun 2024 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718831865; cv=none; b=lXLPG0rGhD70joEDRIrlrhHqQFY+/+icLHLUDlTeIvSj/JCZd2xXzlfCQz3LZE48W0+wY2D09UFy/mHmBNNVzwKoPUVO/SuiRW+e4yggfTEMfvvFMJ+N9C3OBKChR8g3deK+VR4pZSBV4epkGVKZdsu/WMeegf1S/JXqOuT1l4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718831865; c=relaxed/simple;
	bh=iRETBpfwtwAK5g7polO8QWzB5wBcNxu9v3DHjML7TRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoExR1q9k0i/+BBktdkZy2CgMqjHDyPBK9Joq7I4ftEnBRACRbS0heuXLz+YdWJ5k42ChYPC9GzGWpTFIO0j6ua9xWtux44qzvcwxGmEuh85sZXIlieAXJ9PUwJwki6iYHi2xIgqz9eBGPpEWOUG2WdAav9eTnHnI7NkAN5X7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCUpjWrP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCUpjWrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F124C2BBFC;
	Wed, 19 Jun 2024 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718831865;
	bh=iRETBpfwtwAK5g7polO8QWzB5wBcNxu9v3DHjML7TRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCUpjWrPPxU8rhsXuAiXYzpWLnmeRrHp+sMIKVKOIPUPnycCDH16v57EXrEkGQXDt
	 RcOHYM+VMviMcbO3hjCfrXwgNA+mSDHvwPPS/UX84TdFpFpq0/KY64LdIeSafmqEoQ
	 SDbrHluPjY7fVer3OSDkbKfa2SXkBZUi7CW7NuXbiZQ0zWj4wl8V2tQyHqmIZBbO0k
	 2/0r0jA3QfqGvsFr74eEceLsKQkODIXyn4FUflC+v4sPtyETm0ze3BuUdlGwAKgATc
	 MpOqgWruVhCMvFSMwOgwG9MgyWdbbkXrgBpaY8GiaqKfa1GZnePOZOet+KO0c1d9Og
	 4oDaufEYCfg1w==
Date: Wed, 19 Jun 2024 14:17:44 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-hardening@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: mips gcc plugin issues
Message-ID: <202406191414.67C589A@keescook>
References: <563b8f82-9865-40ae-85d3-055b3bcda7d6@quicinc.com>
 <202406191343.D361BC137@keescook>
 <f1f08297-e8c7-4673-88b5-e9b6bff69371@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f08297-e8c7-4673-88b5-e9b6bff69371@app.fastmail.com>

On Wed, Jun 19, 2024 at 11:12:25PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 19, 2024, at 22:50, Kees Cook wrote:
> > On Tue, Jun 18, 2024 at 04:41:01PM -0700, Jeff Johnson wrote:
> >> I see the following in my .config:
> >> CONFIG_HAVE_GCC_PLUGINS=y
> >> CONFIG_GCC_PLUGINS=y
> >> CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
> >> CONFIG_GCC_PLUGIN_RANDSTRUCT=y
> >> 
> >> So I'll turn those off, but just want to flag that this issue exists.
> >> Seems either the plugins should work or the allmodconfig should turn them off.
> >
> > Well, the plugins work with all the other compiler versions all the
> > various CI systems use. :) For example, I don't see this with distro
> > cross compilers:
> >
> > $ mipsel-linux-gnu-gcc --version
> > mipsel-linux-gnu-gcc (Ubuntu 12.3.0-1ubuntu1) 12.3.0
> >
> > I suspect this is a problem with the kernel.org crosstool builds? I'm
> > CCing Arnd, who might know more about this.
> 
> Yes, this is a known problem, and I don't think there is a good
> solution for it, compiler plugins on cross-compilers are inherently
> fragile.
> 
> The problem here is that a gcc plugin links against the
> compiler, not against code produced by it. I'm linking the
> crosstool compilers statically against libraries as much as
> possible in order to make them more portable between distros,
> but the downside of that is that plugins will only work in
> the environment that I was using to build these toolchains.
> 
> My build environment is an older Debian (in order to be
> portable to old glibc versions), but with the system compiler
> updated to gcc-13 (since x86 libgcc cannot be cross-compiled
> with an older compiler).

Can the crosstools remove the plugin support? That seems like the best
solution. Kconfig test for plugin availability with:

	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)

> The long-term solution of course is to replace all the
> gcc plugins with some other way of getting the same
> features, but that will still take some time.

Agreed. There's not much motion on the GCC side of this, though.

-- 
Kees Cook
