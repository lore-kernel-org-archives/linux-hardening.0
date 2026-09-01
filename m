Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715524279F9
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247427; cv=none; b=FudZ32ev9VXvHC/A7dVwRAthfiZcw/tk1DEPRejo1WEPlp1oc4NxwWcBze5sPQfqVagRTtvdMzPw+d8oUK0vtj9QV0F2KGQEykUDpDHXiMHR2bQyojqGD+6XLgM0R/hnQhMM2FBfXVeU5YHAw+flbO6Ncy4iITAlxxfD8t9Okas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247427; c=relaxed/simple;
	bh=mp7eLHaZfmsO81+U9L/zIi9lOQ3CvFosn62SO4Eqx6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFNrHURabP9IdEkAGC7uOYEGzBVhvt5up5G16T6067BmxSiYhsePr7q2651Ki6XOfFWZlfvxmY1LenIccv447eXHhVQs5V9UxB8SlMh2RkX4iKfxmEnNZeSoSNzokdVSu2uZAQ3ykEUP0MjrRq28hYbc6AzLle5PO72JLcTiHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BV0YDgs7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BV0YDgs7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso62282505e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 01 Sep 2026 00:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788247424; x=1788852224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0niSXQECJMFZw0+rxqv4zMkA2WGEXmXqxfDeDBlDBZ4=;
        b=BV0YDgs7HFXKsJNwwfMWLV0KQDEQ+fQz8xt9/chXybd87/a9nclqSH1Rb7yhF6tKYu
         +QVuU/UzTo1UzvNXYkvtzUgkMelOnCa3NXBNR43UhgiLdBHW+rrbqp+RnsoSq1/2E+mi
         0pLhwhm64rmHFvR+zyZFflrEjqm/uSWeDF2rwPptj53rJFbDLXRsXWfY8YrAGDnvH/dI
         1cdSHoxMmupaz8I9Pd/RzxF3b2vXmu89XY4NYDD63PQHQnu7i3rH6U6a+0gue5/bCyj3
         0ow4YUvyri+4k1w4JXBzpPJxF64xhN6pxuQ/EvuGhqUXzDLHeCsf5L0RkfFYDw+OKwxr
         xdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247424; x=1788852224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0niSXQECJMFZw0+rxqv4zMkA2WGEXmXqxfDeDBlDBZ4=;
        b=L4LKxmAyLxrf4l80LIDqyXoMnlC6gP/55jyiZs7tIm9E61U/maVjEaq0ohYVydR7gi
         FQnxLbuC+ejbGcA7HIUfdvv56C96kLxoK2gRbb7fHQyMw/01LLG2d2zBY91gDafL4IKo
         daBYwUIkC5NuGsFy5pE224X1sUgKkry7t+tVFb1x0ojTuKEiPRuvCrWY3Sq6AwE7R9AW
         QvPw9I4YAKgPjcu7fFKliHS6WuaPvWPA2GvVfeDDHN8DjuKoZARqdXIuaH/oKL6h1RoD
         M2T0AMh2PNbsEU0Iyvlff0P7310NvloTmEiDxFUiOO4IeDIATbLb6oMjqk57hD6nZozB
         ba6A==
X-Forwarded-Encrypted: i=1; AHgh+RpjSKxiZ/qLWWr45IkDg5BIgXQPs8Ik0YgJH+akvShZJKWndo445AFe9sPVkKKQ5NgUGoeDvv3Yvwj0JI4bWAE=@vger.kernel.org
X-Gm-Message-State: AFuF++lY03vPiQsayGejGUNbI75umBxVb9r7ysHnvGDdFBLyw1nKBnmp
	AVxkXjWhIZYcnRKdBHmOWmDh+juH3jAxOYMyvvzDVp4PBUvB4j/tc0KbRM9wVZlZ0Bc=
X-Gm-Gg: AR+sD11mKCG8v4spi80w09T/3pXhnJnWaZneJeuhj8QULOxYEgYMWYRF94zO4/jdLUp
	00NQSufzPR//Za225ht/gjdbY+PWjJeioasVCDsmCxxyqD/wwWUzvq5CyfXtVA3yWKM93MrI2H6
	vd5Fyax1UmSbZsplxAazCTYIDopZIbw0BV7/wGeTUgBZ3FA65Jw1RdF+WnH6REJOceeq92aUKng
	TL0zQgjiB7bH/EaE2rPuLLI3nrViTm1viffGoOd9wPpLXPMyZhDpi/kEFYkGwzobc2u45sKRNkU
	gl8b4PPCi6PZoezqomnhzuXjf4sONCCPh8IyozHH5frL1cjxf71+5eDi0RoKRX1uGgw1SrFqgy9
	e9GuQmCsuJ88NKmLDeBdJ3t4RhHlCNislCZqb/ooUDcBNcEfjelyAWY2Qn/C+oYJ90ZIrjFJ34T
	UUfoDRwKaw+R31j9cMGTnxVFhku28qY+DItdW5Qza882h1g0h6M2Juvfnk1vBHkQ==
X-Received: by 2002:a05:600c:45d4:b0:499:7219:122f with SMTP id 5b1f17b1804b1-49b91c1ebd7mr438451325e9.4.1788247423615;
        Tue, 01 Sep 2026 00:23:43 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c52fdbsm254947765e9.0.2026.09.01.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:23:41 -0700 (PDT)
Date: Tue, 1 Sep 2026 09:23:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tycho Andersen <tycho@tycho.pizza>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v2 2/2] kallsyms: Document why unresolved symbols are
 revealed
Message-ID: <apZ9ea1on8A7o6kk@pathway.suse.cz>
References: <20260821152614.2202196-1-bigeasy@linutronix.de>
 <20260821152614.2202196-3-bigeasy@linutronix.de>
 <ao8SeCCG65uwH-Tk@pathway.suse.cz>
 <20260827102411.NsziRXyJ@linutronix.de>
 <20260831133729.p5ylO7O6@linutronix.de>
 <20260831124928.22e163ab@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831124928.22e163ab@gandalf.local.home>

On Mon 2026-08-31 12:49:28, Steven Rostedt wrote:
> On Mon, 31 Aug 2026 15:37:29 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > Could someone yell here, please? I convinced myself that hiding
> > unresolved pointers is the good thing to do here since a "wrong" pointer
> > would be seen in backtrace anyway.
> > 
> > Thread starts at
> > 	https://lore.kernel.org/all/20260821152614.2202196-1-bigeasy@linutronix.de/
> 
> I wonder if we should just tagged hash values as such:
> 
> | [    1.498171]  <TASK>
> | [    1.498172]  00000000cb9bc262 [hash]
> | [    1.498174]  ? 00000000eb5021dd [hash]
> | [    1.498176]  00000000ed1a9938 [hash]
> | [    1.498178]  </TASK>
> 
> So that people will know that the value is just some random hash value and
> not a real address.
> 
> Although rather useless in call stacks, I like hash values because the same
> address will show up the same.
> 
> Having '[unknown]' may also be confusing because it doesn't really say
> "why" it was unknown. But having a number goes back to what it always did.
> Hashing it with a "[hash]" marker will also let people know the value was
> hashed.

I like this idea. I just wonder whether it might confuse some parsers
who expect that symbol name is one string. %ps, %pS, %pB are used
in various context.

I think about adding the hint into the hashed value, e.g. by using
'h' instead of the highest number, something like:

 [    1.498171]  <TASK>
 [    1.498172]  h0000000cb9bc262
 [    1.498174]  ? h0000000eb5021dd
 [    1.498176]  h0000000ed1a9938
 [    1.498178]  </TASK>

But 'h' is not a valid number number so it might confuse parsers as
well. And it is not that user friedly either.

So, I still like more Steven's variant with [hash].

Best Regards,
Petr
