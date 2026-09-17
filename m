Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B548F83A
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680096; cv=none; b=JR2hPM51svCZA+1FxMlVZmeqqTrmyvKWFaPl5xzW3Fvc+YcJO2XozdDAuTQSc1wTZ1e786L6weSiwi1QFySIIflZup340ZraMB4RFo7EVHK2x6qptNFWJ9uc06CK72ptVpPiSAvBQqg++VhGCJV/eIieJfjqUj0Oai/soHZrzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680096; c=relaxed/simple;
	bh=CXfWvz6o+0oRGbg8ZpoJBVTbeepUo6o1HOawvvUW5BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTVRLOMHkShTFdspsYnq+Z2ikcIJBtOX7V225wmq7IC11nHyzGEG0eoeSXwZ8TaMCGkdahhJoKOIUUm6aJcATLC7624SI2SocEA85rnUDDMNaxhlOpXPwWzp/EEtTI+fJ7pl+pt/UTktQS+44OslEF0fReg7V8pYS+WVRcjszp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3VRTevn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3VRTevn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383BB1F000FF;
	Thu, 17 Sep 2026 21:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680095;
	bh=YHiSHY4uAbGQp2FDWLDiB4KTZwVRiYV9i8hglFa8AuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3VRTevnAuMFFohZUhzBjSCCK4efdL0P73mHf13h4Z8DomdxcD6EUdxdhC6Qp5e1e
	 h075pzCYRmmRIske5D9mym4Kh/Eft0Jfd8sgipSwe/GWtGtEJG1Ge3DXYWPVpGTTAm
	 aA/KA5MdaSa3u3tRoRhfDcENqusHjC8JVnwP9hGHHFC1nsydrVoibzfO7ETOPRaLLg
	 +aMM7X60bVMoyg0F5u8Qodw4F1z1iBbl+CpRkQQZ9CXa8Xp8m1aF0ZPuU+sys1Efiv
	 nXZfLUGpvJywzJh+Q0wrPZ4m3Tzo488EjnAtSnQJosRlSjqQrWshFJ9czilW+Z2fPl
	 GP0Qq+aD6BOUA==
Date: Thu, 17 Sep 2026 14:21:34 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/7] seq_buf: Add seq_buf_strlen()
Message-ID: <202609171419.F929921@keescook>
References: <20260917002312.i.923-kees@kernel.org>
 <aqviXSO0qnCoioWG@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqviXSO0qnCoioWG@ashevche-desk.local>

On Thu, Sep 17, 2026 at 03:51:41PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 05:23:12PM -0700, Kees Cook wrote:
> 
> > While working on seq_buf conversions, we found there was a need for
> > seq_buf_strlen() (since calling strlen(seq_buf_str()) would be a waste
> > of time: seq_buf already knows the length). And while implementing that,
> > I found a bunch of other related things that needed fixing. This is that
> > series, with tests for each fix.
> 
> I like the series, especially the trick on how to capture printk() messages.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks! I'm going to spin a v2 with Bill's seq_buf_init_append()[1] (though
I think I want to call it seq_buf_init_existing()? I'm open to ideas
here...)

-Kees

[1] https://lore.kernel.org/lkml/20260916221528.1256283-1-morbo@google.com/

-- 
Kees Cook
