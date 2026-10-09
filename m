Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AB246783;
	Fri,  9 Oct 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561165; cv=none; b=n8HsYHEkaZovRap78g6MrkUxY93zqRjkJSEbKVZOw3SQ9/Qk+Z2/tthjhk3RKNrtDbquWApgOKPzNGEoQcoDqAw8vcsfp/nYXuZ9aR2PhtoyDc4tXLXnuWQdJw4FnsNmZv38gnoODsU3ntjcNe/keCKBY1dkXwA40Vvltzj5qMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561165; c=relaxed/simple;
	bh=+632BxfAIPKPTC4nLf/PZ9on1zah9Og/rWyomBJqmRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML7OOUv1aHLiReic4wWdeaClQU2lUoHBtwF/R29ffZ4y/A361HZbJUFAmWPYadbjM2adapQ4i1+gsZz1YtIyBt3ybH1W0mtaItR2bEGqiUKdj/0MEyS49AQd2zU9JH36eW2o3Vsd/GwnM7R/gq0exBf5u7D5mVXGbAUZg+WEJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHDMwhBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHDMwhBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848AD1F00893;
	Fri,  9 Oct 2026 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791561164;
	bh=0DXjYMvRmEg6F57An+CASAoisofDrEv/t1VR5wLbgNM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KHDMwhBwPbggKTF8TXjDAZxIfe8YpIevivj37SAKBd5qpesQeolLpZOtNZfk8rcLB
	 1RA14HatE9GfBdKrFzYqi73t3N6QSY+kudDXEado/f8LqDqKTBktISyWU+RkXJk6F5
	 o4DCpcNVdtpc3Vczmb70fmBkMXdYH7ITJ54yVsLSgqjMMvRTaMfA2dWtL3tW7dEz78
	 QAPVZKzNGYE1w/jkyzuqmGXRyU5Dyl50CT3LjCADdr43NygFUUdUYR3iPs2t+59tLR
	 i/WXvDUORW0aNok2clYBGybCtx+RNxJLI2mjaE2Q+5hHS+e9m94QJVaSDwJv+l60rw
	 RO9k/xL1i5HXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C2F0CE0B28; Fri,  9 Oct 2026 08:52:44 -0700 (PDT)
Date: Fri, 9 Oct 2026 08:52:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <c160b8c3-7bbf-46f3-bd3f-e0fcf0fcf673@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
 <asjYDiBaS1V5CymE@gremlin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asjYDiBaS1V5CymE@gremlin>

On Fri, Oct 09, 2026 at 01:05:00PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Oct 08, 2026 at 11:27:30PM -0700, Kees Cook wrote:
> > Since commit 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if
> > available"), cmd_gzip runs pigz through scripts/jobserver-exec, which
> > takes the job slots make has free. GNU Make passes the jobserver pipe
> > only to recipes it treats as recursive, but leaves --jobserver-auth in
> > MAKEFLAGS for all of them. The make 4.3 in CentOS Stream 9 also hides
> > the pipe in sub-makes (a backport of the fix for GNU Make bug 58232), so
> > jobserver-exec cannot open it, runs pigz on one thread, and prints:
> >
> >   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> >
> > Mark the gzip recipes as recursive with "+", as commit ecab4115c44cc
> > ("kbuild: mark `rustc` (and others) invocations as recursive") did for
> > rustc. As with those, "make -n" now runs them.
> >
> > Tested ARCH=x86_64 and ARCH=arm64 defconfig with GNU Make 4.3 plus
> > CentOS Stream 9's make-4.3-cloexec.patch, GCC 16.2.0, and -j64: without
> > this change the warning appears and pigz runs with "-p 1"; with it there
> > is no warning, and pigz runs with "-p 54" and "-p 64".
> >
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Closes: https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
> > Fixes: 48ebe1cbbeb51 ("kbuild: compress the kernel with pigz if available")
> > Assisted-by: LLM
> > Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Nice find!
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
> Sorry for breaking your build Paul ;)

Hey, this was the fastest bisection that I have ever done by far!

Normally it takes hours per step, but this was about 40 seconds per
step.  ;-)

							Thanx, Paul
