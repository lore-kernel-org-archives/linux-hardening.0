Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E128373
	for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155523; cv=none; b=sbiu4ZeNaGDJTsSOlKKQlAWnM5O7RJTumZc9ig6TL8erFeqd4cpwkfuITfdM1Le/S4h7md1irqlnySeEOV+iZ1ugz7O+hn09yISihxViqT4zwSV+e4ZXwBFcEDKOpooFaJtXsBbMLYghqU8sovz7Tq9F2yjIp0ym/0+dtIEWTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155523; c=relaxed/simple;
	bh=4o+tdB7cklkSxC/hfjxh0/tbd7gjYPd75YG8OscSKKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7x/dAEzUoCNEgdLMpCXj8EptTmUlDTn/rnVQDlesFiWtZRYHItDppfPJaqmp4acp5rrbVAIp7wN6chuKynZ0v3SmC5TJkchMu13+Jh45sS671TEYzLfL5LvU7W/uj0RtoCHUaBmriXChPLb/zN4esmunlTb0Q8nTPaBGyH02cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2glFDzC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2glFDzC"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453066fad06so6146485e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752155520; x=1752760320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JdcbZs6V7ddRaYlf8/I0C8uUnZMs6k8cdxqWoa96xcA=;
        b=Q2glFDzCQA627Wp222aUMQX6MOZk657jpBgOGaxZ1ju5GSJkNrWMrVPKaXSzItNKEU
         aKwyc2T6KO/OFLTubAwDev8jlZ1EWtNZdMj7ZvcIhbNfQSr9019jHQRKAv0qXlpIC2Pq
         j7wsT5bGtFFGgoqocTD7yxMvBM5s21nsF2YdLzS2ffEk43RWLDDbolzrx+ctSXhKSMwr
         yQg5So2SCFjpm7Pz+iZuHZHa4HzBYGfgGSXdiZOnmGN11t2wBkehrLBG1hTp9Ye1gPvH
         sGoiEzzmeTB9xIBbEjm1YVxfmbBla3ZG6XrO4SHQnQBvoeOwvogEdtJhm/dRPFPUM1Yr
         Hxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752155520; x=1752760320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdcbZs6V7ddRaYlf8/I0C8uUnZMs6k8cdxqWoa96xcA=;
        b=HrN+wlx5VZs9Y2y0oBkoHm89CSfJ4ju3uktKPlSOfM3Y5v8Tta854SNLBnbmlzxt3d
         s7wTCbJQh0DSm6wE5ZKdetJ4QHL/idxaX/j1J1Oy2a+tulbZ22T/o8vi9902SrPmLt8k
         dC+QSH0KuK2ikKWw0dZKZblUbbuxIIkPj0kxMMBmEOjyAXnkGqNB4WR4wJeNKChL+DKH
         ickNTOBq/IcN0XdehZfYlBjNnkud7brafrourliUL0rEJbjrG0PbbOGjKYxsEFsrGq7q
         rdscAXEdc7XB3dwyTgOA1mvZ8l1OF9jCy1JQDvBzuiTXLy8kgMo+s7ibjYnt6w5ztjkk
         2sng==
X-Forwarded-Encrypted: i=1; AJvYcCVeV/qXctKnII1Q29R+j/ihPblvrA8Oaqo4IAQc6eav4a+B2jsePOn9gbM6cXoXG+2nBp8NKcMww2qmazcLu18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Zvmu4HCBJtb/k+rkd1uWyYCjWFnCJltL99OsWFu4K2wNC/JC
	2sIDAIRoJJUcvex8LxQ3g5J5oR/BJq4RJ29u1nPiyEzlAKgCXAIHkjc5sVWs7yNszWs=
X-Gm-Gg: ASbGncuswP21pydWt3EqgGUG39yPxR2jmo5kzidGOXW7/tDZX0qXYI1vLHnQpTT2qMv
	/fXpqprCb0K5gIghW0cvVxOKqHfdQBsS+ud3xVOrXtI+jyVvYvEH41a6I7WKRkswroO8fg41err
	/XRyP/PFgzpbfvNoKXNkwVZOg8YxLaTzy66kqmlToNOrdfWgy9Dv3b5k8xZHk92+dMOtcAWs4S4
	OjqGdBBbRgqMDfc/RkFpkuNLXPhM4/DoZMEK9zudL9D6dJPYDo+iAeV/hu8a1p/tUbegPbMEAVm
	7MDnEDNwZyKfAvmwYTsisn7xG+KgXWwrU4Z5wAi9TA5/os69tci3kfW4MZEaf1KBGobkyqmrLJc
	=
X-Google-Smtp-Source: AGHT+IEnDnDlAY/nEDydSE+HmUW8vhMPvloqxrNBzJrbeQnbGugZ4ojCvuJ28v9EgsZ7qBuirSOdBw==
X-Received: by 2002:a05:6000:144a:b0:3a4:eecf:b8cb with SMTP id ffacd0b85a97d-3b5e4526c0dmr6246897f8f.28.1752155519569;
        Thu, 10 Jul 2025 06:51:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3019e934sm5255335a91.33.2025.07.10.06.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 06:51:58 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:51:43 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/3] printk: kunit: support offstack cpumask
Message-ID: <aG_FbyF2HujeHfcw@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
 <20250702095157.110916-3-pmladek@suse.com>
 <20250702202835.GA593751@ax162>
 <aG0qLaeAoTGaRs0n@pathway.suse.cz>
 <1217f48f-a12a-4ba1-8de5-bda4b2ad6107@app.fastmail.com>
 <aG5ULpdSoAR6nF5R@pathway.suse.cz>
 <20250709144706-efda2e7c-c3e4-4905-91ad-7553c46ed2e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250709144706-efda2e7c-c3e4-4905-91ad-7553c46ed2e2@linutronix.de>

On Wed 2025-07-09 14:53:29, Thomas Weißschuh wrote:
> On Wed, Jul 09, 2025 at 01:36:14PM +0200, Petr Mladek wrote:
> > On Tue 2025-07-08 16:48:47, Arnd Bergmann wrote:
> > > On Tue, Jul 8, 2025, at 16:24, Petr Mladek wrote:
> > > > On Wed 2025-07-02 13:28:35, Nathan Chancellor wrote:
> > > >> On Wed, Jul 02, 2025 at 11:51:56AM +0200, Petr Mladek wrote:
> > > >
> > > > Thanks a lot for the nice report.
> > > >
> > > > The problem is how cpumask_var_t is defined in include/linux/cpumask_types.h:
> > > >
> > > > #ifdef CONFIG_CPUMASK_OFFSTACK
> > > > typedef struct cpumask *cpumask_var_t;
> > > > #else
> > > > typedef struct cpumask cpumask_var_t[1];
> > > > #endif /* CONFIG_CPUMASK_OFFSTACK */
> > > >
> > > > And KUNIT_DEFINE_ACTION_WRAPPER() expect that the 3rd parameter
> > > > is a pointer.
> > > >
> > > > I am going to solve this by adding a wrapper over free_cpumask_var()
> > > > which would work with a pointer to cpumask_var_t.
> > > 
> > > I'm not familiar enough with the cleanup mechanism of kunit,
> > > but can't you just move the mask allocation outside of
> > > test_readerwriter()?
> > 
> > The only solution would be global variable.
> 
> When the cpumask is allocated on the stack, free_cpumask_var() is a no-op.
> So while the stack address would be leaked to another thread,
> it should be fine as nothing is ever done with it.
> For more clarity it could also be gated explicitly:
> 
> if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK)) {
> 	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, test_cpus);
> 	KUNIT_ASSERT_EQ(test, err, 0);
> }

It is likely a matter of taste but I like this idea. It looks better
than passing an invalid pointer and hope nobody would do anything
with it.

The only problem is that

    if (IS_ENABLED(CONFIG_CPUMASK_OFFSTACK)) {

did not prevented the compiler warning. I guess that the code was still
compiled and later just optimized out.

So, I am going to use #ifdef instead. I create a function:

/*
 * A cast would be needed for the clean up action when the cpumask was on stack.
 * Also it would leak the stack address to the cleanup thread.
 * And alloc_cpu_mask() and free_cpumask_var() would do nothing anyway.
 */
#ifdef CONFIG_CPUMASK_OFFSTACK
KUNIT_DEFINE_ACTION_WRAPPER(prbtest_cpumask_cleanup, free_cpumask_var, cpumask_var_t);

static void prbtest_alloc_cpumask(struct kunit *test, cpumask_var_t *mask)
{
	int err;

	KUNIT_ASSERT_TRUE(test, alloc_cpumask_var(mask, GFP_KERNEL));
	err = kunit_add_action_or_reset(test, prbtest_cpumask_cleanup, *mask);
	KUNIT_ASSERT_EQ(test, err, 0);
}
#else
static inline
void prbtest_alloc_cpumask(struct kunit *test, cpumask_var_t *mask) {}
#endif

which will be called in test_readerwriter().

It seems to work, ..., sigh. I did not expect so many troubles with
a tiny detail.

Best Regards,
Petr
