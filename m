Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBE53D6664;
	Sun, 20 Sep 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882591; cv=none; b=guXykLYlrokEZ5WdH7Q3sYkgQW8uidE0SWf2CKW0qFeHlQRuf5EQBNEUko6IjQLdPqgugba/95+sy4jCI3JatSlvOqmmphLC3WK6sgsRbjm3kGDz5b2iNIiGK39rFdbTxxc3Sy/XHbaFzPv9gODg6oGmFU0ALK5uxsq8vzf3wKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882591; c=relaxed/simple;
	bh=J+1Jh9o2qiwvJqeTp9hdZcVFdwLvu3larl5CMX2B+XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUGmS9TsVA3GTq8uOdyw5AXLgAlb6//NHdLAktGe3L1hZ59p71F9exzM8GjXOECjLeR1fHlrDGr9VBqALca3VFagbEAdechUo0OYc3qHnPMu6FIzMPn1oBOlKpbEN/e4gJJmdYEZNQR5KiUbWS0zcGH/N9o9b67n+Ame6hKA8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/p/9p5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/p/9p5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247921F000FF;
	Sun, 20 Sep 2026 05:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789882589;
	bh=fWrBhysyw42qClS8B0lj8HQDSpNC/Rg4f42Pu01QRGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T/p/9p5tBuONOoT6lEvlMdvfLEGSyib15uOjmzJCmkkLfRH0cc25qDKzFs+OPRFXZ
	 ROO+aooJUNP+TK03UirR1qFfHzHBB+LEucngpM7OoPMH+a20MbR4LTpxidC85eOumT
	 KYCXdJc/qMayspfjlY2zHdN+IA9U/oR7YUNWfQHM=
Date: Sun, 20 Sep 2026 06:34:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>, Petr Mladek <pmladek@suse.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 5/9] seq_buf: Add seq_buf_strlen()
Message-ID: <2026092037-antsy-shrapnel-6139@gregkh>
References: <20260919002658.stay.929-kees@kernel.org>
 <20260919002714.4060307-5-kees@kernel.org>
 <2026091953-cherub-empty-ef35@gregkh>
 <202609191326.4042FC4@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202609191326.4042FC4@keescook>

On Sat, Sep 19, 2026 at 02:15:58PM -0700, Kees Cook wrote:
> On Sat, Sep 19, 2026 at 08:38:37AM +0100, Greg KH wrote:
> > On Fri, Sep 18, 2026 at 05:27:03PM -0700, Kees Cook wrote:
> > > +static inline size_t seq_buf_strlen(struct seq_buf *s)
> > > +{
> > > +	if (WARN_ON(s->size == 0))
> > > +		return 0;
> > 
> > Why WARN_ON()?  Are you wanting to just mint new CVEs with this code
> > path, do we not give out enough already?  :)
> > 
> > I can see returning 0, if it's empty, but isn't that a valid check for
> > people to wish to know at times?  Why crash the box?  (remember about
> > panic-on-warn being enabled in a few billion Linux instances...)
> 
> We have to figure out a line somewhere. :P Making a seq_buf with size 0
> is a nonsense construction, but seq_buf_init is non-allocating, so
> there's no feedback about setting it to size 0. We could move the WARN
> to the init? I was just following the existing style here.

WARN on the init makes more sense, but even then it feels odd as if we
wanted to make a seq_buf with data from a device or userspace, we would
have to verify the size is non-zero _before_ creating the seq_buf or we
would crash.  So someone has to check the "untrusted" data somewhere,
right?

And why can't we have buffers of 0 size work just fine?  What prevents
that?  People have "empty" strings for lots of things.

thanks,

greg k-h
