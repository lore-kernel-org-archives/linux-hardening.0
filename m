Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A166BE6C
	for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161397; cv=none; b=TPKFKrlYKpIkPfAyH951O1sRALEOOnj7bfxjxbE5KryMlleadltM/zZe+Rf1k5yuA3fFLxWaUhSVR8CsMNLnsF2hSoIfu/CHppuZvhX7pyC4F8iabiqhnsMXyZOb/qBDKJNQTAjaa3FDFeukx+OfZyS91w6w2GjLeEBz+vCdr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161397; c=relaxed/simple;
	bh=uXJ+Su3o1PPVQEWJgsrtc7LhMk7UVVMuONL6hP2mVEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdd4fWgM0Xnl6kTI0VqS1E/7v/QDDaQFrDldZDGcZmobB2UDcCCoMUuBe5va5Wx0ZP2ERgJPEyCbfZ6GUCHz4O7BJTPEMtAHYD+T5yW3sbWONP05/mHqip5VvKO0pDn62Tt+8ZLhP638/Z2equF7ZDOf1mDeoXJuU8VpsS3Rsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TghXF2Vp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TghXF2Vp"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-454ac069223so12312245e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752161393; x=1752766193; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lSMS5g0FtH2qkHkZ1jt4pZS7KJcBgB7lox3WtRiFnhw=;
        b=TghXF2VpNrDmLhksrMjT1MBzMUWYHez4Nx2SFdab9OTP0Dk7QBwVTJ+DwO3Suvn7d5
         jZd3PFzoPLKeHKpeX+jnvfMDcbJTF/Y3DK+hE+A7FiBX0roZbRFrQOhnYYrNUbBNDo6P
         kg8uITPqaIPsepc9/6OAfHI9THkxH0ajKjabWr+RV9wa5WZwW9pWDxLSrZXNEfcGjy5F
         PPo43ZZ/9AEcAF34q9tkSmMNrnZYRMPnlRfVsj+lBy+hVzmiG0EKl3Rz0ZP0ykiL3cm/
         h2J5qoIWr3WdorgNfVlJCVTdOsB+o3jXrwvxV3Do4PaLv2gz8aPy3aMCugfMJ7lTv/Ah
         EccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161393; x=1752766193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSMS5g0FtH2qkHkZ1jt4pZS7KJcBgB7lox3WtRiFnhw=;
        b=L29JzK8pH7LgYn4yzhxbvl0FLhK54Xxt0LrgAbWX5YNkILBxFJLBgNEvo0H6FzZT8C
         0IJAuvKgRyQnCr/v9f3kokvhpCrxqBrrQ/v9pKhUzr2mkJDOnXLf2d7gcwA8iAOOtZh9
         Ba+jEXYhuGXfvvFMXqJggNvdBCHmPGU5HJNRk6mE+WWoZz/7ojaszUxlZXisWIHIfctK
         sH5ZcNxKTPCPiiBr0WL8TzYYWXqsN4+0n6AU5Y8Cx65Ql9+X+CSPNPtl6tCNxr0AL6w1
         SykOEGv1WM32PU0Hr7jt6Cqu6ewNFCEV7nT2sfBqMVGNvVlWjk1X3cX1CEvfgg4VO7pR
         8Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCWxCWuW1h9CyNajU4UdNOEJYhlWRyYjv+EIB/6YI+SLuJDQwW8Wdy+HW7TWOPb5v0mKSlraXlwdEuMDTxivSlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCxDH64n3m4FmYzY0hgjWzZCJuzzn3Ji3dmBGykP0EoKO2Zls
	ZMzLeY1KX30/KDHZmJrzIhj2UMJfBC98RxxMqDhhX4lFCuEJyMo25K5Bdxy2QR9CVo0=
X-Gm-Gg: ASbGncuY/o8p7YhRNSQMXjaVBOyHWVCAjPTDRAeIJOjs8EKCfHPCk2p2k6Xq2NcMwRN
	NJ1EaMfMJo1dxD+Io9/bBS/tq1sZFLeqBA65DD4eyLPYg0scvPOWpmdp81MMY96dgw14TEjq4p2
	wwMxIhhxQ5g+Co1v7ldo1kZ7uTS/jBiznwNv0ltfkbssKm6aW2DVz1M5jQlpL6wb5JTP23CMuUy
	Tj1tMwRVdlcNyrIvr+z+AHtgVrMQNEMl+HDAqPZ5LQRoephTC7MlO8Z7eWobCh5OJDOq9FnhwJP
	b+STLELPOjlv8ZwxeQBLfGFn7sll7l92DnjLbrTkXAarqV0rBaYeY/PMsCr6iU+aDl3bezaYSHU
	=
X-Google-Smtp-Source: AGHT+IGk8jb4Q5+TtKQe7i5KrsnU2L8JxV8a+7deRG1vITo0uj9HDseycRwujjfxpSFT3oO40oNjMw==
X-Received: by 2002:a5d:64e4:0:b0:3a4:e1f5:41f4 with SMTP id ffacd0b85a97d-3b5e7f2e929mr3675711f8f.17.1752161392588;
        Thu, 10 Jul 2025 08:29:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ac0sm2649648b3a.22.2025.07.10.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:29:52 -0700 (PDT)
Date: Thu, 10 Jul 2025 17:29:37 +0200
From: Petr Mladek <pmladek@suse.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>, Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] printk: KUnit: Followup fixes for the new KUnit test
Message-ID: <aG_cYSfhXfxQoKco@pathway.suse.cz>
References: <20250702095157.110916-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702095157.110916-1-pmladek@suse.com>

On Wed 2025-07-02 11:51:54, Petr Mladek wrote:
> Hi,
> 
> this patchset puts together some followup fixes for the new KUnit test
> which were discussed on several locations.
> 
> 1st patch:
> 
>   + adds a comment exaplaing why the test ignores pr_reserve() failures.
> 
>   + was proposed at https://lore.kernel.org/r/aFUiQESkXjFIGqez@pathway.suse.cz
> 
>   + Thomas Weißschuh added into v4 of the original patch but I have already
>     comitted v3 in the meantime, see
>     https://lore.kernel.org/r/20250620-printk-ringbuffer-test-v4-1-8df873f1f3e0@linutronix.de
> 
> 
> 2nd patch:
> 
>   + dynamically allocates a cpu bitmap to make the code safe even on systems
>     with many CPUs.
> 
>   + v1 was set by Arnd Bergmann but it had some problems, see
>     https://lore.kernel.org/r/20250620192554.2234184-1-arnd@kernel.org
> 
>   + This version just integreates the proposed fixes from
>     https://lore.kernel.org/r/aFkuqaFn3BOvsPT-@pathway.suse.cz
> 
> 
> 3rd patch:
> 
>   + stores "size" instead on "len" in struct prbtest_rbdata so that
>     is can be used to check code sanity by __counted_by(size).
> 
>   + fixes https://lore.kernel.org/r/eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain
> 
>   + it is based on the idea from Thomas Weißschuh, see
>     20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de


JFYI, the 1st and 3rd patch has been committed into printk/linux.git,
branch rework/ringbuffer-kunit-test.

These two patches were reviewed by Thomas and John and were accepted.

The 2nd patch is independent and has an issue. I am going to send
an update separately.

Best Regards,
Petr
