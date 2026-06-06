Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627530FF1E
	for <linux-hardening@vger.kernel.org>; Sat,  6 Jun 2026 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780740776; cv=none; b=nGQ7UDZPAo+IFRpY9FChtF6DnNDMX2sOo6bRQz4oHq4eHAskshhnio94tkSacD0zM4VY6vS+mwRVcad4qmz4lWDPRepZFVaQi6ABKc4zM08Aqu0eLsy60ASBiDVYKncwE/PhFEdL/ArsevoJ4mBE1Cso2gd2O5VtGciLkIUnvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780740776; c=relaxed/simple;
	bh=RZ5jZ8/r29NaVZ+MqReN4turJ33LIEJ2EMlBt5NOauA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osQGMlBFxyhx9JMCiU5eZwnaxzx8Xg/l+2mTcpiowuww7+CqId2dqiUCuQ5zaQicTnCmlA35J2zI919yC8NJ47AbvAyFiK4ESP1mUPRoYU9QpDHp2ESJJ2O7wWObS54g8qFcrqv2vAD1c2orziEt+0vgNVec8iRS8YBv8rJemQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYNB1niu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYNB1niu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso1928487f8f.0
        for <linux-hardening@vger.kernel.org>; Sat, 06 Jun 2026 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780740774; x=1781345574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnKjAdZh6PuntRLAdopjXw2zCzWwWtYyRadGl65Qvn8=;
        b=qYNB1niuDTmrRYLGkj58DD1C+A/TJizZORUZhySMCOy06lTMiuQ10GefC5X/c8tni0
         IcL8gsS6JZvUUD/hOFEAJXy146cs3PybcR/1vde08fCITlos47tv4Z6eDoXx7gK62YPU
         /B1qwb1R8LreLIkEmeeiXUBPvrMuwJJYXFQud/FiAAMP5Q672MMxgf2X1Ws80QaAtNhQ
         HE/fQuD8loCQO/cOHn+J3SuvfytOl4Bab8RP5qPCI2VoLdutRZagHAwBgm9YfUspxvwv
         k0JWVC/bii5/5bfkc6qyHNrUf5Xm1v14jnx3mXxSe4nUL1PUY1LFHj1PO4U78uf3wpa7
         Fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780740774; x=1781345574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnKjAdZh6PuntRLAdopjXw2zCzWwWtYyRadGl65Qvn8=;
        b=mPETthfvVn+fIVUke8Sihc4D40KgJqnrepf9Yj6xo1DxVdlC9xDX/TnZdnIHAgMou/
         yooLJHV8wySIXTI2+SBF4PaCpJGoaGh9HsK8N/mjyA+gO7Uy5eU9BfqWhm0wr0hT2nLq
         O0/1DEmZ5c0n2vSRdhUqC3EVf9q6OKvRnjrgR8ZNry7R1sEBVylZDQXT42oyVR/HTQOn
         cqdB58JJS4NTi5H8062fn7dIqd7X5yEINcrth8BL2HEs9+XtfXu4ysY1SI9+npH1G9aZ
         oBZkg86GVSy8SvyQ7DSkfbDimaBdCkJkLYRd8XeC5G/5kwQ80OErXzI/bUVrbP4zLgnT
         EbQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CaNKdUTE+HM7QnhMiKw9J9GBCzJDJ+my1lxDybnz5h+gN2smQWdRhxpoKmvDpI+PA+Fjn9hkag4kxrjS1b7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLxcnJvdyGs0boVdAINYyVlx7Ld1Q399pXIHxGUPyRVxzGAC4
	fWrK1JkPDcYkHTX8DUtawtC15gyFdLOBw4raP4PlzTkLdvXv/X6p8Q52
X-Gm-Gg: Acq92OHRrPZxsTUQj0oumdDlLp9uL80BeEHJiZRUWrzudw/o68z370SC6za6lT1Dd79
	GkT3y4zG1l9zPZrZdygmaYtK32Jbm30mjNsWjed6OZCHaSRX70Fb63Z0MPbh2t439wlgzZW37t6
	bJVN8YemnqTr0MlVXvU8GlWthAd9fpu6w3IbjTfRsQ/T2pi/rmZPJQpxgmoktBLIDqCMErMQd7q
	BGAMqT7gENsCpRdU2nzCRQVYv0wCqH+pmTzBbA6giObvfbl8EDEcEHp7qJzGJGXUtjDSGoXA2aY
	CF30ga6Yb2t+H47ry+zZc/bv4sNzaS1j2xWqyCDd1b3W26Xt9U+NaARAjYSKxGLnhbewqyJ4b28
	Q3pkiOLFp+cHnyqcxInKfY7TPud4tTu2oLlLk1ramtIhJqnLAuafxZFxbf9O0Dy3HjqBaXoSLIe
	HD4QjiCI1aXKPJfWz7x3TjosaZmeXylSfxMJJvw/7JFcymToYevuz6JJsfN1/AI07F0L6naV8=
X-Received: by 2002:a05:6000:298d:20b0:460:2eee:4e2b with SMTP id ffacd0b85a97d-46030652f1fmr8303047f8f.28.1780740773677;
        Sat, 06 Jun 2026 03:12:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm33894286f8f.9.2026.06.06.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:12:53 -0700 (PDT)
Date: Sat, 6 Jun 2026 11:12:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>, Jiri Bohac
 <jbohac@suse.cz>, Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/setup: replace strlcat() with snprintf() in
 setup_arch()
Message-ID: <20260606111251.008f3a0e@pumpkin>
In-Reply-To: <aiMVYiG8oe4JTwB4@ashevche-desk.local>
References: <20260604131752.1327556-3-thorsten.blum@linux.dev>
	<aiJTZ9P7_bvRWlqw@ashevche-desk.local>
	<aiLueGQiArrWeUJv@linux.dev>
	<aiLxc-IJBoU2tx9i@ashevche-desk.local>
	<aiMP4eRHwVQXvGrG@linux.dev>
	<aiMVYiG8oe4JTwB4@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 21:28:50 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Jun 05, 2026 at 08:05:21PM +0200, Thorsten Blum wrote:
> > On Fri, Jun 05, 2026 at 06:55:31PM +0300, Andy Shevchenko wrote:  
> > > On Fri, Jun 05, 2026 at 05:42:48PM +0200, Thorsten Blum wrote:  
> > > > On Fri, Jun 05, 2026 at 07:41:11AM +0300, Andy Shevchenko wrote:  
> > > > > On Thu, Jun 04, 2026 at 03:17:53PM +0200, Thorsten Blum wrote:  
> 
> ...
> 
> > > > > >  	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);  
> > > > > 
> > > > > This also has third argument fixed. Don't you want to change that?  
> > > > 
> > > > That doesn't work because boot_command_line, at least the declaration in
> > > > linux/init.h, doesn't have a fixed size.  
> > > 
> > > Ah, okay.
> > >   
> > > > > >  #else
> > > > > >  	if (builtin_cmdline[0]) {
> > > > > > +		size_t len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
> > > > > > +
> > > > > >  		/* append boot loader cmdline to builtin */
> > > > > > -		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
> > > > > > -		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > > > > > +		snprintf(builtin_cmdline + len, COMMAND_LINE_SIZE - len, " %s",
> > > > > > +			 boot_command_line);  
> > > > > 
> > > > > Hmm... Wouldn't GCC complain on this? (Build with `make W=1`.)  
> > > > 
> > > > No warnings with W=1. Why would GCC warn here?  
> > > 
> > > Sometimes it complains if it can't prove the size of the string to fit the
> > > destination. You said that there is no size for boot_command_line, I'm not
> > > sure I understand how GCC proves that the above snprintf() won't ever truncate
> > > the input.  
> > 
> > The compiler doesn't prove that this cannot truncate. It only knows the
> > buffer sizes, but not the runtime string lengths.
> > 
> > snprintf() can truncate, and its return value could be used to detect
> > that. However, the previous version also ignored possible truncation by
> > strlcat(), so I didn't add new truncation handling.  
> 
> I understand that, but AFAIK strlcat() doesn't induce a warning in such a case,
> while GCC does (or at least should).
> 

gcc only complains about snprintf() when it knows the the sizes
(including taking strings from arrays).
So I suspect the warnings are mostly false-positives.

But I'm not really sure using snprintf() to avoid strlcat() is a gain.
This could be:
	len = strnlen(builtin_cmdline, COMMAND_LINE_SIZE);
	if (strscpy(builtin_cmdline + len + 1, boot_command_line,
			COMMAND_LINE_SIZE - len - 1) >= 0)
		builtin_cmdline[len] = ' ';
but I suspect that doesn't return a useful string on overflow.

I've been trying to remove strcpy(), a lot of code has already
done strlen() for a bound check - so memcpy() can be used instead.

-- David

