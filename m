Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7749AA26
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679967; cv=none; b=ZZSUfEwgfsqB/Yih4RZNr4HaOg2OyDHxOB8rXm26bseg6PJUVD5eQOU6EGJeXCZaehuVvXS+EgQeVScHEfxDEHYrkJ9pyhtUx0Fkk8MHWZsYalgM2Zxw8of7ooeN6nt9Tacqzl6XB2LDf67NGQ52mgT+F45b73+stUOAlkL2bXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679967; c=relaxed/simple;
	bh=GtvbA8nwyksQCMm48T8oRTiAjbFJHC6B9uz1DPmIiPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0BU5TPwK53EUnYL0nxT/74PJ8f2W+kz5ht/faS0w9RfzsQ6lNNV2LCgQ2OHN9UEo56bR5uyUeXWyslt8zM5PDi5Rf9606GwXoEBqsqzvHlQ7ykto8I9gkJya/i5xdVinjOJ0iexVYK1WYuw5ww7et3iBkWKxoXqvWE1pkmxk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoTRN8Wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoTRN8Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD1A1F000FF;
	Thu, 17 Sep 2026 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679966;
	bh=ktGRo/YBeSz9wnbKkMSYDEjE6CYr2/sUae67RlWGYCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OoTRN8WvofN1ZqcIxnZDhzVu1PGAzsxkj0+OvfEzxqCzZmJIykHIrzUYIRP1hWAGN
	 sMN/CTZave2L6uLPnxHu5g4HMzLZXeQqnpzLNMB8trCj4FGmJSCnQZ6mACwTV757Op
	 qkgnnL9ZAallQaqc/VkTf5xvXzltJNkt6TDo/ottlqtRE1jLXreDLVAQdqUY8n/MQr
	 BidJoDjJ04W4SRmRXwrH4FrgpxCjYJjXGwOh+Var1PWPDNWoBP9rRmGs/Lg9MnWM5s
	 zh6rwx/GiTr8OEnuu0DIo7L4oyRHzj4M2UKrqrN0slMzgBKbtIv5ifdygWyaJliMXV
	 BF85dpPODNa6w==
Date: Thu, 17 Sep 2026 14:19:25 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bill Wendling <morbo@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Thorsten Blum <blum@kernel.org>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/7] powerpc/papr_scm: Return the string length from the
 sysfs show functions
Message-ID: <202609171419.F084401E5@keescook>
References: <20260917002312.i.923-kees@kernel.org>
 <20260917002333.2306346-6-kees@kernel.org>
 <aqviD9ow5HLGcLTK@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqviD9ow5HLGcLTK@ashevche-desk.local>

On Thu, Sep 17, 2026 at 03:50:23PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 16, 2026 at 05:23:18PM -0700, Kees Cook wrote:
> > perf_stats_show() and flags_show() build their output with a seq_buf
> > and return seq_buf_used(), which may include the trailing NUL byte
> > when the seq_buf has overflowed. Use seq_buf_strlen() instead.
> > 
> > Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> > 16.1.0:
> > arch/powerpc/platforms/pseries/papr_scm.o
> 
> ...
> 
> >  free_stats:
> >  	kfree(stats);
> > -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> > +	return rc ? rc : (ssize_t)seq_buf_strlen(&s);
> >  }
> 
> On a brief look it's a single ternary like this in the file, perhaps while at
> it move to Elvis op?
> 
> 	return rc ?: (ssize_t)seq_buf_strlen(&s);

Sure! I've updated this for v2.

-- 
Kees Cook
