Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA049EC4F;
	Tue,  1 Sep 2026 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288171; cv=none; b=skyejH7eJxvUDthEIuOyTzI49sfgU6ppP/TNaS36rLSe0pxUSWLBD3gqHA7loJ0BTlwE+0l3Kdiex7v8R/gxRO1F74KfMlN9ejglT2qzUDfCxP7XRt3hb30nHMLoLriZ7lyhA85aUa32yR9/QviFnUPN+Nr+ncX3WLYMcv5LpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288171; c=relaxed/simple;
	bh=RVP5qBPFI0tRi3WvK2Bu3xa5iHCQDbRNmZXtW6FoTeY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/7hXInlSCQ170w/iigwoXL4F2ThzXu64qtouSqNaDY4szryMh7ou4OkpV6wsAytst+zk63V0hMzXjnfhi1H9n3VMCzSANRXpeOuZ3vk6ANY5Jx5Umski8RyB8/9dGe/Nyjk7qjoLvAQZ0MeQpr5rJP8l7if8vw7TW0wSEioIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXESltqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXESltqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071041F000E9;
	Tue,  1 Sep 2026 18:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788288167;
	bh=eDGEZQZIBXS92OA/xO1G3mmdv51Q3ex53I8UxL51AZA=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=UXESltqMEaJ3gr6E4vBQNLJRll4iBfIB/7kIg46eIYmcLYeT/9jSSf68AcYpsndqV
	 jWr4ISonRB+SzakTM6zJSlYWynkDgeJJVc0f4cxN/hCJ1DIBFbQ7iDp8/kLRT6ari2
	 83zZpnDMANia9bqe/lBJ7684+tn3z112Mkx7GpjIrwoVN7F98aUx/2qc4fV7yU9y5w
	 AmUKgKjD+2BbWLLlE2IcCfHhWYdHz3162NfFvuHhTUOHzYzIcjpLbeA+QZSy3mmBF5
	 3j6jtEzpbK102EGVbqGql8g9ZlCJLhSLQRIOTuqE2N5HjPW7tIEsys937sBJBHCf7u
	 wQaA7ztkkVdxw==
Date: Tue, 1 Sep 2026 11:42:46 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Ferran Duarri <ferran.duarri@me.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kbuild: ubsan: skip UBSAN for external modules by default
Message-ID: <202609011138.9FE4254@keescook>
References: <20260820190200.203185-1-ferran.duarri@me.com>
 <20260821190701.GA3030879@ax162>
 <aoisfLPgD33M0sRt@levanger>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoisfLPgD33M0sRt@levanger>

On Fri, Aug 21, 2026 at 09:52:28PM +0200, Nicolas Schier wrote:
> On Fri, Aug 21, 2026 at 12:07:01PM -0700, Nathan Chancellor wrote:
> > + Kees and linux-hardening@ for visibility
> > 
> > On Thu, Aug 20, 2026 at 09:01:58PM +0200, Ferran Duarri wrote:
> > > External modules built with KBUILD_EXTMOD set inherit UBSAN sanitizer
> > > flags from the kernel's KBUILD_CFLAGS because is-kernel-object is 'y'
> > > for any obj-m object. This silently breaks third-party modules whose
> > > source code (e.g. VMware vmnet/vmmon) triggers UBSAN UB checks at
> > > runtime, causing packet-forwarding failures and VM instability while
> > > the module itself loads successfully.
> > > 
> > > Make UBSAN opt-in for external modules: skip the is-kernel-object 'y'
> > > fallback when KBUILD_EXTMOD is set. External modules that explicitly
> > > need UBSAN can still opt in by setting UBSAN_SANITIZE := y.
> > > 
> > > In-kernel module builds are not affected.
> > > Signed-off-by: Ferran Duarri <ferran.duarri@me.com>
> > 
> > I am open to other opinions but I am not inclined to apply this change.
> > If an external module has issues with these checks, it should either be
> > fixed or 'UBSAN_SANITIZE := n' can be added to the module's Makefile,
> > rather than making the default worse for everyone else, especially given
> > the importance of UBSAN_BOUNDS for avoiding out of bounds accesses and
> > writes.
> 
> Yes, I second that.

Correct. And (unsurprisingly) I take an even harder line: the
external module source should be fixed, full stop. Disabling it with
"UBSAN_SANITIZE := n" is just a localized version of the proposed patch.
The whole point of these defense in the kernel is to stop bad code
from operating.

The out-of-tree code needs to be fixed. If it can't run with these
features enabled, it is an active threat to the safety of the users of
systems with that code running in their kernels. If VMware can't fix
this, no one should be using that code.

-Kees

-- 
Kees Cook
