Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6C397AEF
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682750; cv=none; b=Yt1++8pUhk3tKP8B5uqKxMvNr4IXzIzHNr++HvjuFYU9ObJ/NZqAcl+07fq18O7+w6R0ss1gi2istMj0ECdaWyAWpwBoKSc0JDtifUae+bqdZG+6DzpXdBo6R+sU831jnmIAPP3X0GeSB2WgtyA5qkaEc346aOeTmkWHKUfzjPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682750; c=relaxed/simple;
	bh=bx0CZ2/tporA/FGr+T9sg2lJxd4nYIKq9LZuxW9m+zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1E1pZ260WoA3VrO31F3vjJn7ULuzw71b+nM9Vbj8lipBbojH37vBBIvo6RNqyCVz2B/2Cj2y8C+jRCwWj4AK0r48j5qhkFCcWbiUxxJMM8CcA4ZWglZqdBlogROg59o9Vj3PeK+Qi/jTpTV+T7xee0Fwx3Xw88M9zrSWDTg82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m7vuGT32; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m7vuGT32"
Date: Fri, 5 Jun 2026 20:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780682730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfEnkanNcmIPxmtwM6iblEvOkBjR21xtuMklEN03QIQ=;
	b=m7vuGT32HNPfqMnWYhm+E3myac5Sk+Gcd20bNgDtKWV7bdQyEFq6eKPKEMGuf9i4HcsKpj
	TmyBb3QvmJgRkNgsLyWJ4uoGFSPRzD56DqY+t0SciuRTXWJdMUeA4EVuGaD1WyR/ZBOn+H
	Jx/lph4aqcvKgsYj9R7hg4TcArfrPZo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>, Jiri Bohac <jbohac@suse.cz>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/setup: replace strlcat() with snprintf() in
 setup_arch()
Message-ID: <aiMP4eRHwVQXvGrG@linux.dev>
References: <20260604131752.1327556-3-thorsten.blum@linux.dev>
 <aiJTZ9P7_bvRWlqw@ashevche-desk.local>
 <aiLueGQiArrWeUJv@linux.dev>
 <aiLxc-IJBoU2tx9i@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLxc-IJBoU2tx9i@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 05, 2026 at 06:55:31PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 05:42:48PM +0200, Thorsten Blum wrote:
> > On Fri, Jun 05, 2026 at 07:41:11AM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 03:17:53PM +0200, Thorsten Blum wrote:
> 
> ...
> 
> > > >  	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > > 
> > > This also has third argument fixed. Don't you want to change that?
> > 
> > That doesn't work because boot_command_line, at least the declaration in
> > linux/init.h, doesn't have a fixed size.
> 
> Ah, okay.
> 
> > > >  #else
> > > >  	if (builtin_cmdline[0]) {
> > > > +		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
> > > > +
> > > >  		/* append boot loader cmdline to builtin */
> > > > -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> > > > -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > > > +		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
> > > > +			 boot_command_line);
> > > 
> > > Hmm... Wouldn't GCC complain on this? (Build with `make W=1`.)
> > 
> > No warnings with W=1. Why would GCC warn here?
> 
> Sometimes it complains if it can't prove the size of the string to fit the
> destination. You said that there is no size for boot_command_line, I'm not
> sure I understand how GCC proves that the above snprintf() won't ever truncate
> the input.

The compiler doesn't prove that this cannot truncate. It only knows the
buffer sizes, but not the runtime string lengths.

snprintf() can truncate, and its return value could be used to detect
that. However, the previous version also ignored possible truncation by
strlcat(), so I didn't add new truncation handling.
