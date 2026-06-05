Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572563CC30F
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674181; cv=none; b=c0Pxfl7UgCE6k6Uvo/8M/tf9lkWjWGC208Tt2Wu0sgR0u3UKnYr6vQKHwcwhfS9yYQvnSJbvd5BtmM0L8gRkZ/iPofiSAEfKDbZVMFPaiq7P/foTuJ6K6Pz+aDh64IZGyBrBHjTkpnkKdD6mQKyMIL7LehYrrzizBdhWrTrbFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674181; c=relaxed/simple;
	bh=W0T1PdxEeazJB39myKEC6Gyv+Q03z/ZE2lWQYDf0YsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Vr9o7Mxa7kdZtSMpiGdrMr9nSV53AOVXtb2U0sk/ETNOAIwap8Tobt4yAwbbwRgIMgVYVHRt/VOSI+JRzbcPCkq817oCsND+IzZB4FvAa036aJtccDlK6hzYvEsS2O/TGL37rX1i0dTTsFeb7cAZCA3yMqLAtqSD7N26C70Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1ItKQyo; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1ItKQyo"
Date: Fri, 5 Jun 2026 17:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780674177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQgVyWp04mcZVdhb3g8zIcRkJh1GFKcwmd+VtYZJv70=;
	b=C1ItKQyo8NUnZtDAlfGP2fSAq+fw9/aXPmD8aCXBY0SBnOSLuPvsQQoTXGwr1m8I9+r0A6
	rfosn1KNlE8qVqNSU/121xEw+G1LV+qKFBaWk0N75xpThiG/QONUexZ6vymt5hQ3tuQg7T
	tZkfK0O+tRD8TIQBrPoHn8uWRcoIQAg=
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
Message-ID: <aiLueGQiArrWeUJv@linux.dev>
References: <20260604131752.1327556-3-thorsten.blum@linux.dev>
 <aiJTZ9P7_bvRWlqw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiJTZ9P7_bvRWlqw@ashevche-desk.local>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 05, 2026 at 07:41:11AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 03:17:53PM +0200, Thorsten Blum wrote:
> > In preparation to remove strlcat() from the kernel [1], replace two
> > strlcat() calls with one snprintf() call in setup_arch().
> > 
> > Also drop the explicit size argument of strscpy() to further simplify
> > the code since strscpy() can determine the size automatically when the
> > destination buffer has a fixed length.
> 
> > [1] https://github.com/KSPP/linux/issues/370
> 
> Make it Link tag?
> 
> ...
> 
> >  	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> 
> This also has third argument fixed. Don't you want to change that?

That doesn't work because boot_command_line, at least the declaration in
linux/init.h, doesn't have a fixed size.

> >  #else
> >  	if (builtin_cmdline[0]) {
> > +		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
> > +
> >  		/* append boot loader cmdline to builtin */
> > -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> > -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > +		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
> > +			 boot_command_line);
> 
> Hmm... Wouldn't GCC complain on this? (Build with `make W=1`.)

No warnings with W=1. Why would GCC warn here?

> >  		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> 
> And this has also third argument.

Same reason as above.

Thanks,
Thorsten
