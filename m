Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897438;
	b=V6CyyDhvaYWYrT0UW21KbBl0Y3xOON+39PvINZif3rqBsx5h9u5VbWfglRd+NpRo2nZZ
	 /7pO+240hHTkJYSvrIcLYpdnKEb0tifxd+Hvhe983pCX2n/wPi4oO2lumX1tlWxvBSsSP
	 CU285vX9daXp6pw0Q8ZRRBzlUWJoOiC7OinnPZJdvrBFEB4rcDgms+zYuTu6eauIL9qkD
	 AQSqgzAED523ulTr+FD0mqTJ5YOi/lgEOCOC1zQs0VXYvzCe42zfuquUu4MIqri8KgY+m
	 wi05ce15MzEBd2AlcMnfONl2qezJ89wJMsTU8HMrVsCkDe1IDtxny9wWX0YFAxbM61w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897438;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=5Zwkee7Eda/oQ5obU9MTZY8ne/gaSD2tfbbvFVf8sL4=;
	b=cl2/lKZfdhLxLgHz+/o+QqHnEbr4tgFTD4HbuoJHhfdzb4WMSEF6BcBugJSD6iJsa0xK
	 a5JxLFaRgCtAVFs9T3B6BKsJG/hdjR+lHYMHGEmXZ7/rJ7ffy0xfAvbhFluHllw65uDvC
	 EIOWHaphmXElaMrEosYdRC1/9v6Zps5Xt3adqyg54AgnSGmIJw1ELOYXKxv4tmRedgEG8
	 tBG5Ba6Xsj+ZRZkY/DJWWbxGaWDIXLUlRpCfD/5+6etrjkKEei2MvlDC0nSphsqlIBUst
	 HF5yGIIotkmZk/DrDrfoCM+HCpBhZQodkhxU0NJqMxH9kfaa6++b+W9tBW+hrdXG2Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bIOcdG4J;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B94606D807;
	Thu,  5 Nov 2026 16:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B94606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bIOcdG4J
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id DCFD8A8A1E;
	Thu,  5 Nov 2026 16:50:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E64E280014;
	Thu,  5 Nov 2026 16:50:20 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:50:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches
 <joe@perches.com>, Johan Hovold <johan@kernel.org>, Kees Cook
 <kees@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Len Brown <lenb@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <20261105115019.2fe7c91b@gandalf.local.home>
In-Reply-To: <auyuINXEJKc1KoG7@devuan>
References: <cover.1793876837.git.alx@kernel.org>
	<9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
	<20261105111423.360f4ba8@gandalf.local.home>
	<auyuINXEJKc1KoG7@devuan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E64E280014
X-Stat-Signature: jt6ge55y663npwc3oayseghzdtk7e3df
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cl3Y/smj00nYIJMgPA2EZab7rnczjCaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5Zwkee7Eda/oQ5obU9MTZY8ne/gaSD2tfbbvFVf8sL4=; b=bIOcdG4J9j+16rixy1pyX/3+Km8E1J+gNaFcVTjGgYdWeCpzwVrKDrvCmTjHXmV1SmxYCuxDHAhfGHCafk0sO2et1SokUSAKCU4zUkjQyOJgaW8I+27HNX/DYqiiYYumoaJgQMC2uZsXGqgQ+2hUaPJmPrYo6p2L7tfHwgBcu54=
X-HE-Tag: 1793897420-811383
X-HE-Meta: U2FsdGVkX19bCecB5jioIhguq6rRgMe3rxF4TgEhqk9KP9NeKNMkUT+69RNNihc+daKgEKTqOXJQTs0rHkp15vWrQ3K+pvCwXnEYcFTSvqifAYR+m+FPHWu1d9zP7kvFElFCpDT8P78g6KnZxNm0r9p6JjBd+ViGmA1lo5/duRsnCadbZBGHHKc5/rqGhfV0FYIUh/TjJ1Tvz52bXk8eQ1YbHfPmZ6c8MyebafoN+YsfZYmzGr6UepNjTBEFsFDp4cZJfNtCcJsBaGpaCqaxKqUnFQPBIWjCJKjwkRi/gm8svcFm2yP2sU5oW/su03ZZRY6GYvn+nVCG3z+IsIxo6PgDUoCAwbrpo1jPUQAyX/DtL47Kb0zipc6wlaas3hUUdw8ZQTTtQ4x9zX17ar2qbz4fkpASG2qccBseCBJGprc=

On Thu, 5 Nov 2026 17:33:02 +0100
Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:

> Hi Steve,
> 
> > Date: 2026-11-05 11:14:23-0500
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > On Thu, 5 Nov 2026 12:13:03 +0100
> > Alejandro Colomar <alx@kernel.org> wrote:
> >   
> > > As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> > > between an empty prefix matching an empty string from a non-matching
> > > prefix.  This is a fundamental design flaw in this API, and not
> > > something that can be fixed.
> > > 
> > > As always, this is a consequence of choosing sizes instead of pointers.
> > > Sizes are often the wrong choice.  In this specific case, pointers are
> > > more capable of differentiating these cases, as NULL is a special
> > > sentinel value that doesn't need to overload a valid value.
> > > 
> > > Let's implement strprefix(), a function that returns a pointer
> > > right after the prefix if found, and a null pointer if not found.
> > > 
> > > We'll slowly migrate existing code from str_has_prefix() to strprefix().
> > > 
> > > Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>  
> > 
> > Is there a link to the report? Please add that.  
> 
> Message-Id: <20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com>
> 
> or in link format,
> 
> Link: <https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/>
> 
> Which one do you prefer?

The correct method is:

 Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/



> 
> >   
> > >  
> > > +/**
> > > + * strprefix - string prefix
> > > + * @s: The string to be tested
> > > + * @prefix: The string to see if @s starts with
> > > + *  
> > 
> > Needs a better description. Feel free to use the one for str_has_prefix().  
> 
> Ok.
> 
> > > + * Returns:
> > > + * *  @s+strlen(@prefix) if @s starts with @prefix
> > > + * *  NULL if @s does not start with @prefix
> > > + */
> > > +static __always_inline char *strprefix(const char *s, const char *prefix)
> > > +{
> > > +	size_t len = strlen(prefix);
> > > +	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;
> > > +}
> > > +
> > >  /**
> > >   * str_has_prefix - Test if a string has a given prefix
> > >   * @str: The string to test
> > >   * @prefix: The string to see if @str starts with
> > >   *
> > > + * DEPRECATED: Use strprefix()  
> > 
> > No, it is still useful. Converting trace_event_filter() to strprefix()
> > would be very painful, and likely error prone.  
> 
> What is trace_event_filter()?

Oops, typo, I meant trace_event_filter.c

> 
> 	alx@devuan:~/src/linux/linux/master$ grep -rn '\<trace_event_filter\>'
> 	alx@devuan:~/src/linux/linux/master$ grepc trace_event_filter .
> 	alx@devuan:~/src/linux/linux/master$ grep -rn trace_event_filter
> 	kernel/trace/trace_events.c:2833:static const struct file_operations ftrace_event_filter_fops = {
> 	kernel/trace/trace_events.c:3222:			*fops = &ftrace_event_filter_fops;
> 
> If you point me to a specific line of code, I can attempt a rewrite.

I rather not touch that code.

> 
> > > + *
> > >   * A common way to test a prefix of a string is to do:
> > >   *  strncmp(str, prefix, sizeof(prefix) - 1)
> > >   *
> > >   * But this can lead to bugs due to typos, or if prefix is a pointer
> > > - * and not a constant. Instead use str_has_prefix().
> > > + * and not a constant. Instead use strprefix().  
> > 
> > The above can be replaced with:
> > 
> >  * This is useful for testing for a prefix and returning the length.
> >  * If you only need to test the prefix and perhaps get the pointer to the
> >  * position of the string after the prefix, then use strprefix().  
> 
> Ok, conditional to being convinced that str_has_prefix() is
> actually useful in some case.

Note, the only "bug" is that it can't handle an empty prefix case, which
was never what it was designed to do. The place that the above fixes, was a
helper function that used this inappropriately.

Hence, the use of str_has_prefix() was never meant for an empty string. I
should have added (and can still add)

	/* Empty prefix is undefined */
	WARN_ON_ONCE(!prefix[0]);

The fwnode_name_eq() could have done:

	/* Empty prefix always matches */
	return name[0] || str_has_prefix(node_name, name) == len;

Instead.

-- Steve



