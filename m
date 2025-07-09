Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047A28DB7B
	for <linux-hardening@vger.kernel.org>; Wed,  9 Jul 2025 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060993; cv=none; b=W4UdkJZD7dsJwE4REoWP/ld8eL7E1xdabQqBE3ATqpfndzPMHulwx+DTl+Qeawn9Yl7yZyUTBndArNGYCNYII7gwSmJHHXYV9aFKHVz/3SOhOjmszoLdCcnMfFm4kO4vUIpISd3iGuBxY5FpjeGZXcwFOveAS6r1AcSfZI1AXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060993; c=relaxed/simple;
	bh=Te1IPXBoue59uUt5g0EYKUJvvijgYFF+a+wi3QS/dwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5NreEqoJs0Vaf6dYvObW0SF1X7+fM+AX0KxTdW8w24Ol15ZNBXO4bqSS55p6odLz7+VbCG+BaKxdQ1C7c9W4NInQND9IwO4hQJDPHDtWSc1Xo4p83KFSKu4x4ybssqCga05hp6ujfI+goxYMxWOKqSRWgGOxeC8fMe4GbDxtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JgeTl/R0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JgeTl/R0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a575a988f9so3533242f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Jul 2025 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752060989; x=1752665789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5v0QxB8CIIx8d0eXl2mG60S2HOst+7j31JI2TOZXUA=;
        b=JgeTl/R0AHseS5L0ilT5YC1mPJ7Z5nwXxLKeWM1d+CEdYLP53l8wN5eFa3OEYCR/b5
         JvrYOb4m7vDpmiU45zoKw0mDAKwpvXnTwziKu0Sik/G3J2wTqjXXTHFQDH6jP++U78GK
         9d8W0VdPBMlW2nKw0ihPEraOAKyZEf0e28z0SSMxsIwkifMTcI7xg4YcAA0dmup3nV6G
         NzxzkjsPzf64fAp+hXJlkAVito56XHGJrnVdKDvzMbAWb5eXAe/+n5bh1vLX5+J6flRg
         FkZTMm5mJa+71e3F3/UVf9n3V4jU9eaVHxlnjtTrQWhvBi6ZEbbkwpLkHeAa377ThKZG
         g7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060989; x=1752665789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5v0QxB8CIIx8d0eXl2mG60S2HOst+7j31JI2TOZXUA=;
        b=R25mM6MTZqy+6AstfYt1UWKciGQ9/TMkPsAiENw/cjzYkFx83CQ2Tygpgx7Y0PuKKv
         nmcvLkoaqWT9OEqB3lfLT8g+Q5bmRVKil3/MeYi8gZsJuPYcodbRKcK3ec20cF8NE1DN
         N8pE/XsZ7gRZc8lTL8hqD90EEziHKSflB/WSMeLDZlLeS2O8+nh/Fq6i9NCttDhYASb5
         uTjbNWwtYsZwQEFfaRil3n+oSYTkQ0oROmBwgt/az0rLoHJT3p6OSE9anb9cs1qay5ur
         kQFC+MRe/vyQWY8iyj+dkput44kNnVK7nd0CN1aiIZf/XNr4DCCLePMJiYV96ymnDJcD
         UwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTYNuo812mEGt31LFqJV6OtgzqTLDw/2RykEfKBmcqRYqxMFbZIe/3M0up5Q9MN7YgJ9CY52wsNjrkbYbOOOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUgFCWROydw3mTE/3qbr7LUq+BliIzf4ThBK77xlNsZ5/adWr
	yEBgkRhaO3TruPni+JPX0IIvyVHCJ03qaowmLp0K++yLmuoJK8RCfl2vempZTnBG0hk=
X-Gm-Gg: ASbGnctrbHi79+TOSM/azoa7YO/MTYTASBuEHwTko/+PkMSlW/kz1xy8/BaezFcoIT1
	dl5H7pjjL42tRbLyUKAswIryJ19tpTV6/+uUQcTf4kascb/0Yf6gtJXDNogZPc8Z4g1JiDgzdaD
	G4tROmOPtjfai93RtMZmtseOqE4MLTentwgWUZJrIGfTFRg72sLiLU6nFt8cg3E6aZFdrXM0JcQ
	lfZDtKdI5Wh4C1DQHxKBFAaCowsJaF1R+Ff8bJW0JptGqGw6tRqUeqE2c2J9+Kd7LgD148fZoms
	ueLpdffaG8zlINGoh0gDDxT+KIRFPXoEte0Cs4YzqeG24wAb+ybttBJTyF3tHhes
X-Google-Smtp-Source: AGHT+IFYgPdJtytP0Bie/T18+BQCpRFEtATg+ARsvJbawMPOEJGXTooNKNm0SSEKnpF1xDSDGl86+A==
X-Received: by 2002:a05:6000:2906:b0:3b5:def6:4e4 with SMTP id ffacd0b85a97d-3b5e450fb3bmr1632999f8f.46.1752060989285;
        Wed, 09 Jul 2025 04:36:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003d2e8sm1935952a91.8.2025.07.09.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:36:28 -0700 (PDT)
Date: Wed, 9 Jul 2025 13:36:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <aG5ULpdSoAR6nF5R@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com>
 <20250702202835.GA593751@ax162>
 <aG0qLaeAoTGaRs0n@pathway.suse.cz>
 <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>

On Tue 2025-07-08 16:48:47, Arnd Bergmann wrote:
> On Tue, Jul 8, 2025, at 16:24, Petr Mladek wrote:
> > On Wed 2025-07-02 13:28:35, Nathan Chancellor wrote:
> >> On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
> >
> > Thanks a lot for the nice report.
> >
> > The problem is how cpumask_var_t is defined in include/linux/cpumask_types.h:
> >
> > #ifdef CONFIG_CPUMASK_OFFSTACK
> > typedef struct cpumask *cpumask_var_t;
> > #else
> > typedef struct cpumask cpumask_var_t[1];
> > #endif /* CONFIG_CPUMASK_OFFSTACK */
> >
> > And KUNIT_DEFINE_ACTION_WRAPPER() expect that the 3rd parameter
> > is a pointer.
> >
> > I am going to solve this by adding a wrapper over free_cpumask_var()
> > which would work with a pointer to cpumask_var_t.
> 
> I'm not familiar enough with the cleanup mechanism of kunit,
> but can't you just move the mask allocation outside of
> test_readerwriter()?

The only solution would be global variable.

test_readerwriter() is the top-level function passed
to KUnit framework via:

	KUNIT_CASE_SLOW(test_readerwriter),

And it seems that the clean is even done in a separate process.

I see the following:

   KUNIT_CASE_SLOW() sets .run_case()

The callback is called via via:

  + kunit_try_run_case()
   +  kunit_run_case_internal()
     + test_case->run_case()

And kunit_try_run_case() is called via:

    + kunit_run_case_catch_errors()
      + kunit_try_catch_run()
	+ kthread_create()
	     -> kunit_try_run_case() in the new thread

The clean up is called from the same kunit_run_case_catch_errors()
in another thread

      + kunit_try_catch_run()
	+ kthread_create()
	    -> kunit_try_run_case_cleanup() in another new thread

> > + */
> > +static void prbtest_free_cpumask_var(cpumask_var_t *mask)
> > +{
> > +	free_cpumask_var(*mask);
> > +}
> 
> Or you could pass this as a cpumask_t pointer instead,
> which should do the right thing without the indirection.

Nice trick. I am going to try it.

> >  	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(&test_cpus, GFP_KERNEL));
> > -	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
> > +	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, &test_cpus);
> 
> In my original version, I did not have the
> KUNIT_ASSERT_TRUE() here, which seems sufficient since this
> is not what you are testing at all, and in normal systems
> this would just be a stack variable.

I think that KUNIT_ASSERT is standard handling of any problem in the
test. At least, I see KUNIT_ASSERT*() after any *malloc*() in
the code samples in Documentation/dev-tools/kunit/usage.rst

Best Regards,
Petr
