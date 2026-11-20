Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191219;
	b=b5AXm4+UYV8WV8jkiPR0X3R2Jux5Vw81Jh/m1UHSSTlql+OnTqd92J2pH+TD/drwBkDn
	 4i3ketGgVMI+PAx8OdAyuIuVeENX3LnOMM5kRxd6ttau36Zys9Z+hSg5hPkFyE+gSBTs5
	 EOnDQMehkVbGPBboTsYLtH5/DXj/IOnZR0DfLQU3pypPfbSqzMJGgilYiJ6WB59EpF/2g
	 +Cfb6GHrhHaoGkC8p4jNxB1m+nQSGsA2WrBq0W2A3GKmhXKEeqenhQt+6N0LYuRi5E1KZ
	 7FqpqXMGQqv7hXFhsGCZucyMV1fA1owdmNleZfUAVXE9HHJqbC+Fa6SYhXEb8pi7XdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ske43Fh9A8yW85CHf4qvTL9iEMX6C/Nlv/vlJ5RihTM=;
	b=yVA/pPiv35bUXj5KYjbS8uy41e6fsL4DCIuWpflh0PpPEO68+nSU7gl7Glp75o3Kb+aG
	 JzNPgPvqpPzFph4F3hlgowLd21+y6/W9Jvv7JK/NKUb+/Him5wKE8RkfVin6TJQ8KJ+r9
	 5vuh2E0Te9k31TCgcMNBGiaSHHuPveKndMTjfDsiSbnBltGN230/tPO59mh9CB++vQncG
	 VotwvYrOXf5FKU+EMy+r6eUJH6FMxLpQejusa/A1FEjlWdGI4HFljcG9SPgcwSbHIOOTD
	 BJgY/uxVROvUFhs0DMY6bOFD0HyiED9V0BCFSmlqV/6wOKlF1cwoEh9cMDpuDq6Aw2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=DVTGNfn0;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CD60A2607
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 16:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59CD60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=DVTGNfn0
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9495e8ae23aso92122685a.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795191218; x=1795796018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ske43Fh9A8yW85CHf4qvTL9iEMX6C/Nlv/vlJ5RihTM=;
        b=DVTGNfn0RcRD8xfB+MwwKXCzdG/2IJTQQR9aTVOkOmsK3ahaMAX0zhRCFOIygzDqw9
         f3lz3ZzXi8QI3ehzyGCslUcbAG/gxV+tGhZ2KFcrn0+zcIopkJ4NNcm7Xoo7X9OmJfoL
         jVuQ3eimiXdBh2Ma/je3e2nCkdrkPLU8V5x5rwXabvZ+6TiAfOX0/74y3dTxKkn4KPzE
         bktoH0I6MrCWADpcafmc+zr6zdmWr0G6JB/wYAQMl08Glz5W8nAdMN0os9EN4/U0JaEn
         AYvjOMByY49vLrNOZiK51nREyf43nfkrxaHvZc8Iyd00OjdfpqYCqcwhg+MuZvgqpiLy
         KIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795191218; x=1795796018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ske43Fh9A8yW85CHf4qvTL9iEMX6C/Nlv/vlJ5RihTM=;
        b=pn2LjPNtVIgwn+0cAAuGNJ3eSwohA+BEkmxjzn2biuXS9ob1HGCxy8gqdtBaa2AMgi
         aNsiRw2l8TgJO5Gt6drAcx6LtXSiXZlJxWljj5I1E5wmUgBhj1ikOODEOVO2uzvb32C3
         JhdtZ2XGvQDDr+iepAW5e8xU01++khIIB5mi+F9QiOliwHYwy8z3oLkrfu55ettNSyZ4
         a8q4DgpkK8duq7gvds9VdZzK8DhPxGsqmgB30WwejobVwgyC66uUJ3bj68RfgTYHp4d7
         mvEJVORNZBHWLNSBx6qEqtvcqhbFmveX4iRtM3kTttB2lIfUc6vwW+MjpvA5fNEqgDyV
         1tZw==
X-Forwarded-Encrypted: i=1; AL+hErEbG5a3syq+o/oRExnPgA8nYD2CEHZUEdb6hkKz6/cERtmcGdDJEsPWLnmiz6zHgTTzUf4Rlb909emfpBzMPYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/trzvpYOJl4ASzBucbRm4S4R1rAOdFH6Mx3xR8mCKN3dT5U8mN
	d4QkPuMuzk2GvHoPexjSDeuxJJtXuWC1lVp0jIrutUIh7AYpLYTbkB76kTAGV6eJOA==
X-Gm-Gg: AYBFou21O0e2Pk4N2IlikJADWH3f65n56AlBXnNUQhv1k+nNqgKeaJmey0WJsaMBgZJ
	G4arVHHd9ZLHULdPGsx3Zor+F4Yh1yLj+SWebRn8jtV9STC/ICu8cb24CcPcui0w9tVCC9vW4dz
	cDVnhbNtC4wEfInWnQbn2xVW3pS/UjPeZMc0XcSz4qzJSOIkYx3kKagHXERAZHnF5sjBrNqMUOi
	WctnIWIn2aEczk7zulyQF6UYB/JrGghPNO9r/wGw5C47VBh9O0Yyg8z6v0Pd7W/jPsOeJ7Y+1Lc
	H7emADOPgw6GUaUnP4qabU/+iU8A47od/DO8WZPLk7CDm7W06m5VLrhPJluiGHUXQ7GQ4VGH0p7
	4AgrwzLnoDcboPsoQo1ltsJBmHsZDAbypP5Mo16M2den3Bk4iqIulPjF0Lh5JUNXYpbRVN2vRGg
	G5FP7f7uRd20uQV6YekNGZRE4vJJTzJv/JKCvX8PNaev4wEh29ohFw5yGKbSRVy8cfsqDQtnIdA
	WRnh4HGawh4BTCJFoft5RzrzJlbFR+ehezMrK+lal+8F8wUl7w6723hmZtlAeBhAulXwwIy/JzE
	2ahsBhq4+KNdYClJlcw+IeDg9Kz7CQ==
X-Received: by 2002:a05:620a:4488:b0:949:91c6:973e with SMTP id af79cd13be357-949bab66f99mr562619185a.65.1795191217744;
        Fri, 20 Nov 2026 08:13:37 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41c105sm217536885a.39.2026.11.20.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:13:37 -0800 (PST)
Date: Fri, 20 Nov 2026 11:13:34 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ville Syrjala <syrjala@sci.fi>,
	Henk Vergonet <Henk.Vergonet@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Alejandro Colomar <alx+linux-hardening@kernel.org>
Subject: Re: [PATCH v2 RESEND 1/6] USB: add usb_make_subpath() for formatted
 device subpaths
Message-ID: <c3579747-1dce-4444-8635-5c3e836afb6b@rowland.harvard.edu>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261022070929.20820-1-shlomojune6@gmail.com>
 <20261022070929.20820-2-shlomojune6@gmail.com>
 <2026112032-pecan-knoll-4f4c@gregkh>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026112032-pecan-knoll-4f4c@gregkh>

On Fri, Nov 20, 2026 at 02:13:53PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Oct 22, 2026 at 03:09:24PM +0800, Shihuang Liu wrote:
> > USB drivers often build device paths by calling usb_make_path() :and
> > then appending a subpath. Several callers use the deprecated strlcat()
> > API for this.
> > 
> > In preparation for removing the deprecated strlcat() API[1], add
> > usb_make_subpath() to format the USB device path.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index 1da4ad1610bca..c90ccea0cdbf6 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>        /* for -ENODEV */
> >  #include <linux/delay.h>	/* for mdelay() */
> >  #include <linux/interrupt.h>	/* for in_interrupt() */
> > +#include <linux/stdarg.h>	/* for va_list */
> >  #include <linux/list.h>		/* for struct list_head */
> >  #include <linux/kref.h>		/* for struct kref */
> >  #include <linux/device.h>	/* for struct device */
> > @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
> >  	return (actual >= (int)size) ? -1 : actual;
> >  }
> >  
> > +/**
> > + * usb_make_subpath - returns a stable device path and formatted subpath
> > + * @dev: the device whose path is being constructed
> > + * @buf: where to put the string
> > + * @size: how big is "buf"?
> > + * @fmt: format string for the subpath, without the leading slash
> > + * @...: arguments for @fmt
> > + *
> > + * Return: Length of the string (> 0) or negative if size was too small.
> > + */
> > +static inline __printf(4, 5)
> > +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > +		     const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +	int actual;
> > +
> > +	va_start(args, fmt);
> > +	vaf.fmt = fmt;
> > +	vaf.va = &args;
> > +	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> > +			  dev->devpath, &vaf);
> > +	va_end(args);
> > +
> > +	return (actual >= (int)size) ? -1 : actual;
> 
> -1 is not a valid error number.  Please use a real error code, AND spell
> this if statement out.

Also, why is this an inline routine?  Why not just make it a normal 
subroutine, and put it close to where it gets used?

Alan Stern
