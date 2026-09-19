Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78654547041;
	Sat, 19 Sep 2026 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789852560; cv=none; b=i7Qd9d6HgSe+yoh2aOHUoyf2wQiJ1mZCJ7iSIsmcS2FDloyaWjf7Eis/6QOcWPaH+yC6vgEMvCwo8KXQk5xJTVLcPPPkgbVu2slYF3DPoI2SIgvqunjV1YxALszAhnw888NYLVnlmgxjjti0OcgiaCViKVb0m8r4YwSPP2l3nTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789852560; c=relaxed/simple;
	bh=cEdSOf1pN9s3a5nXY6SQmc4jltxGf8gEPjI7mYGpqMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjxHv8OEft/BBu3XjE0cVCJ0FF/Mn+TTo2l6Zo1mYvzo8rzI6HQRRtXPFsNWoou+WN0OyQxaMJSnA2kmHI8W009FiTL0ECk3BU6xH9PIYuqVMWXtnSb2LBzdDmUhqP8LVfxVK0moQ/FTc6odezqA2Ja65aZLJ7mkieP/eMMJUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWuU2MHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWuU2MHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2416F1F000FF;
	Sat, 19 Sep 2026 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789852559;
	bh=gOO2tP8ftUjE3x4/lc4Otb+Klg9G3L1qMfx0A48x1M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CWuU2MHCZejlhWrsLLxrqJKBoSJQE8GYDnLNaTwLEChUmjlCUaHzHjsoAIhfeuSc6
	 SgMx0mNJifJYLUo1mSIrBDg1GsTByuH6kQ3Zw4ljj8vkb4UMVAlIAfCOs7FFhXlf01
	 mkXISTx/r7mI6FkFG+Ph7RIEXu1vrUqUjyblenbXSNAwTF/54Jnj4IhnrpW3EWvdlP
	 7wsLZznscO7DmjAqE7+b0V1oS7e25Bshuck9rxl6IiWhQUlrlgma3umvEOchy9r1Ve
	 0mPE/C76HF1ez5o3dkYwWDpjmLg9P7NVmybW+vokhbLxy+6d2B6x8eYsJ6VOe5xiCA
	 U/zNdFa70tMhw==
Date: Sat, 19 Sep 2026 14:15:58 -0700
From: Kees Cook <kees@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bill Wendling <morbo@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <202609191326.4042FC4@keescook>
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-5-kees@kernel.org>
 <2026091953-cherub-empty-ef35@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026091953-cherub-empty-ef35@gregkh>

On Sat, Sep 19, 2026 at 08:38:37AM +0100, Greg KH wrote:
> On Fri, Sep 18, 2026 at 05:27:03PM -0700, Kees Cook wrote:
> > +static inline size_t seq_buf_strlen(struct seq_buf *s)
> > +{
> > +	if (WARN_ON(s->size == 0))
> > +		return 0;
> 
> Why WARN_ON()?  Are you wanting to just mint new CVEs with this code
> path, do we not give out enough already?  :)
> 
> I can see returning 0, if it's empty, but isn't that a valid check for
> people to wish to know at times?  Why crash the box?  (remember about
> panic-on-warn being enabled in a few billion Linux instances...)

We have to figure out a line somewhere. :P Making a seq_buf with size 0
is a nonsense construction, but seq_buf_init is non-allocating, so
there's no feedback about setting it to size 0. We could move the WARN
to the init? I was just following the existing style here.

I'm happy to remove it.

-- 
Kees Cook
