Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5A1B6D08;
	Fri,  5 Jun 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684138; cv=none; b=tUA9cdKlP3g6nUAYGGZ4ZBTJFM23hAqTQOo8ipwOjnAqk6ymYv6C1sYJWagcpA0MJa9gyhxy3HgasOs+JXb962WxrCtH9aZ0mIcExdonGp+gqN8Cc7YPoroi3y3Gc3YYfgUVVPE3+tw2G1En3o1Eyu6QvpuQ0PBjEeReyEWQs1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684138; c=relaxed/simple;
	bh=ZK3IZLboDeQni+5NEDW1bjBw3Xonw3ZAR5G79/rfUns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnc4d302NC8oP6rU1nL7qrUwPacaZ2J7BOuHE4nhclbZ4pT1+NzdgiOd7pDnBlBn/T6Lyu95Wrby8QhW7PHHFxdB7pKwkXn/RyFt1sThbu3C1wyGAMeuT44tfeAB2X1SB/ceUaN9cha6OlOJQtVhifC57GixohiqYQrDljZXxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAoGXUXI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAoGXUXI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780684136; x=1812220136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZK3IZLboDeQni+5NEDW1bjBw3Xonw3ZAR5G79/rfUns=;
  b=HAoGXUXIph6UQzjV++5EO5hXM6kcpgWvkD85TG3rRPXPuALLJLuyIyr8
   8VARSVHtq7kWIhd6At+AJhUdpo+1UcEMZge097A/hOAKspd/fliFR+l7L
   JTp+KyVZ5BIsnBMGr7z6uAMlj/Zhbf0ylkimQI8T4/EpCOq1wCYXH20ed
   cpUiC3yfOL8zORQdr5oAMXsR1by10KpIzL2X1YLs/ovgO3LLrVkOPHemJ
   9+UoIOeOQiHGGhPpU9rAT4l9lv6u726yiyNoWuVonU/WBOhnSjxKsYJD+
   /tmsN1u5MZbjK6REzrxYIZhAvFJ0l4hUJdU3WKAkXfc5g0DtQjcu1wsK+
   w==;
X-CSE-ConnectionGUID: SRenmYpMRo6MMWTa7MeuEw==
X-CSE-MsgGUID: idfj1k1kQ4K/Kj18YqfvdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81707928"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81707928"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:28:56 -0700
X-CSE-ConnectionGUID: wuezAka5SHuJKVYQpunMlw==
X-CSE-MsgGUID: ZgdrVtlvRDW+hxjvAVFywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="241931352"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:28:52 -0700
Date: Fri, 5 Jun 2026 21:28:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
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
Message-ID: <aiMVYiG8oe4JTwB4@ashevche-desk.local>
References: <20260604131752.1327556-3-thorsten.blum@linux.dev>
 <aiJTZ9P7_bvRWlqw@ashevche-desk.local>
 <aiLueGQiArrWeUJv@linux.dev>
 <aiLxc-IJBoU2tx9i@ashevche-desk.local>
 <aiMP4eRHwVQXvGrG@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiMP4eRHwVQXvGrG@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 08:05:21PM +0200, Thorsten Blum wrote:
> On Fri, Jun 05, 2026 at 06:55:31PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2026 at 05:42:48PM +0200, Thorsten Blum wrote:
> > > On Fri, Jun 05, 2026 at 07:41:11AM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jun 04, 2026 at 03:17:53PM +0200, Thorsten Blum wrote:

...

> > > > >  	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > > > 
> > > > This also has third argument fixed. Don't you want to change that?
> > > 
> > > That doesn't work because boot_command_line, at least the declaration in
> > > linux/init.h, doesn't have a fixed size.
> > 
> > Ah, okay.
> > 
> > > > >  #else
> > > > >  	if (builtin_cmdline[0]) {
> > > > > +		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
> > > > > +
> > > > >  		/* append boot loader cmdline to builtin */
> > > > > -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> > > > > -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > > > > +		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
> > > > > +			 boot_command_line);
> > > > 
> > > > Hmm... Wouldn't GCC complain on this? (Build with `make W=1`.)
> > > 
> > > No warnings with W=1. Why would GCC warn here?
> > 
> > Sometimes it complains if it can't prove the size of the string to fit the
> > destination. You said that there is no size for boot_command_line, I'm not
> > sure I understand how GCC proves that the above snprintf() won't ever truncate
> > the input.
> 
> The compiler doesn't prove that this cannot truncate. It only knows the
> buffer sizes, but not the runtime string lengths.
> 
> snprintf() can truncate, and its return value could be used to detect
> that. However, the previous version also ignored possible truncation by
> strlcat(), so I didn't add new truncation handling.

I understand that, but AFAIK strlcat() doesn't induce a warning in such a case,
while GCC does (or at least should).

-- 
With Best Regards,
Andy Shevchenko


