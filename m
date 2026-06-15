Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8479CD;
	Mon, 15 Jun 2026 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781563684; cv=none; b=uSPtXSnynLFhCVchw8hZxvfYxJDUBGkuOXDWgAVlTHZZwxED3nAfeKMNdNXGP9r4wOCan/HQmwT2Wt45B/v4Lg0IO37XLa9rx/Dxc3OdvZXJrWbWs0jYkpsc2RYrQX90RihBJFnhwsTizy3Oa9sLhoVJfLM6I8tNeXqtYC4H7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781563684; c=relaxed/simple;
	bh=CqpDulu3Uclnc4tI7DX6e5r2qCyKXkorUrUszaTc7X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDzOALIxiqG875BbGBXU8AR9O0nbu/jXjUpjz/P29wYz0cBnp1xk74IjwN8BY2A/g1BIPnTLtylfSrTAKXGbj/hdBqgJxipmHneQjwxOenIkfEOO7Odzw/mBCkZ362uhKTc3bruZsWuZqksZem7wfKQavftSWeBh5IetoYxQB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHSE3ZKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHSE3ZKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347071F000E9;
	Mon, 15 Jun 2026 22:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781563683;
	bh=Zs8KpH+uagfCKB2jn26tTEhh3LE6JVismookwgsfOjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BHSE3ZKGn9vS2hG6yEsEpDp+9fUGDwaM0QlmAA2tM07RZP50NM5n+N6KK9VWPcrPP
	 1AJR8dWI2X/GXtcn5lyyVz9MhgsEW8+CXNl/tSIU1BDPTlJ2Ou5gY3sJNpfP4baUvr
	 TR+Ri0ngWIpxdJMO3OiyOzINzmVZ/da3ItGzm0hSpEB7VeNa4covlAJCHY/DmKhpCI
	 vCR2sOMrN/hu/NkTcc9AJnMk1dDOqIbB8FCoEni3dCxcFu8MqhuPFupwo4Ox5yggUG
	 aXDghIv9aELmmLWD4TDYOxcoUT668/zno593CgiTe8prKjxCjabWnIc3aRDvQUaqE2
	 WDrtlnJhenpOA==
Date: Mon, 15 Jun 2026 15:48:02 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dan Carpenter <error27@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefano Zacchiroli <zack@upsilon.cc>,
	Steven Rostedt <rostedt@goodmis.org>,
	Laura Abbott <labbott@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Wenwen Wang <wenwen@cs.uga.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org, Dawei Feng <dawei.feng@seu.edu.cn>
Subject: Re: [PATCH v3] Documentation/process: Add Researcher Guidelines
Message-ID: <202606151547.DB4095584@keescook>
References: <20220304181418.1692016-1-keescook@chromium.org>
 <ahgaOigklcDCYvRp@stanley.mountain>
 <ajACprp9UJp2JSJM@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajACprp9UJp2JSJM@black.igk.intel.com>

On Mon, Jun 15, 2026 at 03:48:22PM +0200, Andy Shevchenko wrote:
> On Thu, May 28, 2026 at 01:34:34PM +0300, Dan Carpenter wrote:
> > On Fri, Mar 04, 2022 at 10:14:18AM -0800, Kees Cook wrote:
> 
> ...
> 
> > > +  x86_64 and arm64 defconfig builds with CONFIG_FOO_BAR=y using GCC
> > > +  11.2 show no new warnings, and LeakMagic no longer warns about this
> > > +  code path. As we don't have a FooBar device to test with, no runtime
> > > +  testing was able to be performed.
> > 
> > People have started sending commit messages in this exact template and
> > normally I would ask them resend with the meta commentary from this
> > paragraph below the --- cut off line.
> > 
> > Do we really want this "Compile tested only" stuff in the permanent git
> > log?
> 
> +1 here, can we rather avoid flooding commit messages with the meta, that
> anyways is available in lore.kernel.org archives?

Hm, I have gotten a lot of push-back from maintainers (reasonablly)
wanting to know the specific level of testing patches get. In the case
of lacking hardware, this seems like useful information still.

-- 
Kees Cook
