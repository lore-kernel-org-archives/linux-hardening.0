Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938F30EF9B;
	Fri,  5 Jun 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674939; cv=none; b=UN6OefZdXqvACYOhWnlTrcDCKOzTP6S0lk9Z0o4eqPRE/nrs516IfPq+RdFzaGpoeL7YZi53VSle/UDwSouLcYgsYeSa9qBcIiKLSXYwb9kp6OjImJV7vY3uen1+VjcPbD+JnrihWcRt684g5+5ET14+A/GZ4mYWb/bL+5+jbgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674939; c=relaxed/simple;
	bh=La7I8EHXNk9p9xsuKtu/m341LnDw1qHkJwlekM3EAhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPzN66RLOWlw7TrcKhDUI2pzsmSzHtH4EsQ+0hrkPjs/XI6LNFpg6rodH12btEXCdPx95WXshi6thvFK+4E0U/Kb9SiT20uJ0rwYoRJoX7Xw4amj8n2+IatM/Lqdf9vetEyOXDLV8TzZQh4iiBwNflIGDlq+EvNLysyL39Mln+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1YdUe96; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1YdUe96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780674938; x=1812210938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=La7I8EHXNk9p9xsuKtu/m341LnDw1qHkJwlekM3EAhQ=;
  b=e1YdUe96REw5t3Xk/JrV3ZgvOkgMgncLaWTql93c3vrRDEvZXnCJzi/q
   WFNi69XWVg2H0e1Z5ec7GqJbAkXQPrpj9aOCaUbPOI0BviYvIyfQK5Ebm
   hKbAXKjcZpeaD9TrYvI8+j6btkfE6NeaAEdojY7KnN826bOybKlAT9laP
   j7H020m4CXUnVS80B5hSugG+3u/Fa35i9lZMopMidiii9bHnaMSves6CT
   Z9aUOHDX/jrteKL+etZqHbJsdhp722QwDIBsxkmg5gT86zPo1iww7Wf0r
   54zl4rdRfpj2wxoIzgyt0WtT55Ssd4OLn0BTxgchu/Dlu68CyS6NLjGGV
   g==;
X-CSE-ConnectionGUID: lj+2TbvtSECZD5tJnsY7sA==
X-CSE-MsgGUID: 1wOqksCKQ2yx33tazzwyUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81545563"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81545563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:55:38 -0700
X-CSE-ConnectionGUID: HPVG77fYTwWy/joV0OC+2w==
X-CSE-MsgGUID: YlM3JJIHQAyGw/qZ5Ok3KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="243783171"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:55:34 -0700
Date: Fri, 5 Jun 2026 18:55:31 +0300
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
Message-ID: <aiLxc-IJBoU2tx9i@ashevche-desk.local>
References: <20260604131752.1327556-3-thorsten.blum@linux.dev>
 <aiJTZ9P7_bvRWlqw@ashevche-desk.local>
 <aiLueGQiArrWeUJv@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLueGQiArrWeUJv@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 05:42:48PM +0200, Thorsten Blum wrote:
> On Fri, Jun 05, 2026 at 07:41:11AM +0300, Andy Shevchenko wrote:
> > On Thu, Jun 04, 2026 at 03:17:53PM +0200, Thorsten Blum wrote:

...

> > >  	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > 
> > This also has third argument fixed. Don't you want to change that?
> 
> That doesn't work because boot_command_line, at least the declaration in
> linux/init.h, doesn't have a fixed size.

Ah, okay.

> > >  #else
> > >  	if (builtin_cmdline[0]) {
> > > +		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
> > > +
> > >  		/* append boot loader cmdline to builtin */
> > > -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> > > -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > > +		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
> > > +			 boot_command_line);
> > 
> > Hmm... Wouldn't GCC complain on this? (Build with `make W=1`.)
> 
> No warnings with W=1. Why would GCC warn here?

Sometimes it complains if it can't prove the size of the string to fit the
destination. You said that there is no size for boot_command_line, I'm not
sure I understand how GCC proves that the above snprintf() won't ever truncate
the input.

> > >  		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > 
> > And this has also third argument.
> 
> Same reason as above.

-- 
With Best Regards,
Andy Shevchenko


