Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359883B6BE3;
	Fri, 19 Jun 2026 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902477; cv=none; b=FywzEhqPJRrO5qgwsOL7RSe84nWpWF5YrrflGSw4t7AejXuHBlIsw154f7cmdugFgXJDPVgLiEGFTxcXSzDCbsHpd9iXzPAFXjybMMearNWMWNhVZvE303Ka4CVltGvKLiODp4HY2cpa6uObGFwugp4cu54G61hbdUDrqH0QOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902477; c=relaxed/simple;
	bh=8v2sbGPSJP/F5tEQcP433hg21LWdAo1xiInzzDG/P4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps54oKYhXPYUEoXif8lSg0aUcbI5bnmF+nYLw6YoOVDWHuvOdDcOonQHLqTDbS0okfd8z/YGUiviqbhzqtr3pA2bO30d1FoknnroDy/FXqekuoiaWlxxWYup6nf+p4KvFrpCX5j+q3CGiHMPyV5dTlvrKgMImP36r9YI39Eygvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMBEOwN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMBEOwN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844DD1F000E9;
	Fri, 19 Jun 2026 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781902471;
	bh=Q2WR5/KQ3zs2djEIm1G4QoyIcqU8kSaVM8W7n8BI84g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cMBEOwN3yEpzXMd0XYkxzavY+2UfoQFHxO0xN1R6VM1cAyVZp6+HEhkDN7SRiz2Ws
	 RBTUJkcXP1q43YMzG4HpCBHblVNZIen2RaoQyki3EoHnwEKpEodyHSu2IoKOgnl0q4
	 XzEpiD/wpY6GuyompRLfVXu9uVrM2BD3kFA8Y9RJ24KOMdJtn3Yrg4EhIYNo3YIy2G
	 6QR/hoLspbr7nS/YYsIPl0e7tibqxy4xvNkUKbY1clh+OVev0+sTqIMATZIQSqvCYW
	 nS6kVjnCBu325nk9Bn+LuHQE+nz7slb1x4byO32KWxGLxt1NAL+RvR91vwL+nj6kL6
	 cMkfQxkQhK/CA==
Date: Fri, 19 Jun 2026 13:54:31 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	llvm@lists.linux.dev, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kunit: cfi: Add test for kCFI indirect-call type
 checks
Message-ID: <202606191351.0B1AC6650@keescook>
References: <20260618210946.it.538-kees@kernel.org>
 <20260619093708.GT49951@noisy.programming.kicks-ass.net>
 <20260619095129.GE49529@noisy.programming.kicks-ass.net>
 <202606191342.E2B47A5@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606191342.E2B47A5@keescook>

On Fri, Jun 19, 2026 at 01:44:43PM -0700, Kees Cook wrote:
> On Fri, Jun 19, 2026 at 11:51:29AM +0200, Peter Zijlstra wrote:
> > > This is really rather horrible. Also, now all an attacker needs to do is
> > > ensure cfi_kunit_handled() unconditionally returns true. IOW, no distro
> > > must ever have this KUNIT crap enabled.
> > 
> > Also, if this lives, the check should at least trip the cfi_warn path,
> > being completely silent is terrible.
> 
> If anyone actually ships kunit in production, then no, I will NAK my own
> patch. ;) In that case I will go back to a version I never sent, which
> uses Kunit's try/catch Oops checker (which doesn't work on riscv). I
> only did it this way (similar to the fortify kunit testing) so I could
> get riscv coverage.

Fedora and Android do appear to ship with CONFIG_KUNIT=m. Debian
and Ubuntu don't from what I can see.

So, yeah, NAK.

I'll send v3 (really v0)...

-- 
Kees Cook
