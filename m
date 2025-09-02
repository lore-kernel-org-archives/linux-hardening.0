Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615952DAFD2
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821333; cv=none; b=AOClHomSzA/q8LnXDSJ4+5nqff4hwitcWQh0XugrBTQIMvLNeixcPHmmEYiiDXq8I7Yoy6CXBpdvsWiJGx2jYefSxKMXJJekgumAPtXKCM002ob/NvEkUvlhUzP+fKt2/HDHAeEDVfiozUYDb4azuFad9HNVGwj3CU0BCVtCyvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821333; c=relaxed/simple;
	bh=bQakP1YsFZpN261MdTv67NQ3SO9sRRoupHv7KYhCKvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5KsUlu+2ZpuDLH10QGqUu3kQE/pTaXW7sJsK5eAzOHphNvxJRogTvr5uwDagnh5G82A1XqO7sCGrtQRW32lqWshg53Y/o3z5gFbAUHJ28+GWEWxIP99Ej0OKiy9ds/aTkgZasTTD6HYU5CQM2WoS1TYfGNpSZhhz5qc42haNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BBoM17pD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BBoM17pD"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso7728048a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756821330; x=1757426130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ux1+zM7DCGKk8Y0pNnzy3MA9mFKRSAX580GQ0UU99YQ=;
        b=BBoM17pDDz4pTG+yQQkZNCPHzFb+sqNNNPnzNE6XnQxvJKCZXrY9y5VJf4kkGEOIgx
         ydEkiEHqR3V1Oi/XJXlWHaa5a+hzJLnoTFj8W9H+aYPEHQ39Tz6Jo5/ZkiO+0F9sD/u4
         K8mR9N6KW18MD9fwxGgR8bHSe4dZ2OsXP1NJmopKwwCechitZNog58ufXpf2uglRvm5G
         SvGz5ILKq+7b59llHzAzx5FZZ78L7EdVoPk4QOGvMWn5UYnQvtajPDyMbLN3iy14wUY2
         +gW8zBe6E2GOkvMFfe1gbcM2bUJJ1pYrrs+/rQBpANOkOEAzkKgPnT6PPLPVVvZZ4NvS
         z0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821330; x=1757426130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux1+zM7DCGKk8Y0pNnzy3MA9mFKRSAX580GQ0UU99YQ=;
        b=Vh4jx170AbHdM9n/qRO6H1FmqjuwKNjpUO/oSv2FZN4ioSBZQBi2HnE0zm/g2vQUM5
         fiYjXK7ClXqZbHHjFSqAwCIDScOGdyOOtvtm5J8RiLlJ968dbX4vYg1gc1ZQQQ9kALiu
         BjEnElLl7FxBOqnuL0QGBdar8ajtsMkm747JdAnnGo4vkBgzzWWWWWvcFM0uFa/ZHqhn
         CviuXFmk+jjy05quc5KSYlgGawsFplUuxloUGuBo6leFaDEVaFDYEXpP8oFUCioL2nyP
         7/YvAf+eh7GMugEmsy912CwEfs2mLTPsi3PlNbulBHQRbeSruwfVc4ooVKCNx3Z3b1WE
         jadw==
X-Forwarded-Encrypted: i=1; AJvYcCUf9WYsfRfIUEH+9YRcDpbdtax/Mu+cpznWIRXtNzWTHDEbpBWKrrD1CWJn73PkI9smHE3lKkrBYWwygrGSegc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVjON1ia/UsIQNhe+agpuEgXTj/dz0z1IjE/5mJeN8/dM3FuU
	VKeT+EgX+2VmM7Pr2EgSs0zz/mtlKiuQobvjUVlEXzn9DdUjosyPljkHInk2hGGMTHc=
X-Gm-Gg: ASbGncurxw/xXGrZ0vrLKboK2TW497J5woMdH3H1KZlJFbZsxbRftopO06l573E7Dc2
	nJvkh3yEVylHeLOVL4BRtQ33s5OTeTBYFtaBeTWqTCJRv9MlQBx2CR0Kj/EmqWDwAzyeLrinpSu
	24y66A1kfZxVX+vM1welOVqB+Kb5sNqDmtQpQOdZ/t5JR+b/D9P1rd1Savy0UcKvGJd7MdspuaT
	go6VARBZ49ZCBb65pWDYnpq0LAsqBEBHTdwAVZC09K3/PtAZz3e5E9bNN0rWKhQME0EQnzmwcqC
	3r2RIbW70j+CLv5/PSyN6A6cMXLH+aPDV7RrnEw91tBzUzrorCvu2E3TwuPbUoq48zdh64BEuG2
	puMpo0HOsl7Jvy2vzmU1PmdC6sM0dcSUxrtppJdVba690W60=
X-Google-Smtp-Source: AGHT+IFYZsCEWcaT1DOSZuHxLNtRPdpvwo7JLtkjMRaV/jRgWXdGVcGEYo0U2qGMp5Ea0wH4E60Deg==
X-Received: by 2002:a05:6402:24d9:b0:617:eb8d:283b with SMTP id 4fb4d7f45d1cf-61d26eb3cafmr9948273a12.26.1756821329693;
        Tue, 02 Sep 2025 06:55:29 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214bacsm9895291a12.16.2025.09.02.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:55:29 -0700 (PDT)
Date: Tue, 2 Sep 2025 15:55:27 +0200
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
Message-ID: <aLb3T6hjtX4M37dA@pathway.suse.cz>
References: <20250702202835.GA593751@ax162>
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
> 
> > + */
> > +static void prbtest_free_cpumask_var(cpumask_var_t *mask)
> > +{
> > +	free_cpumask_var(*mask);
> > +}
> 
> Or you could pass this as a cpumask_t pointer instead,
> which should do the right thing without the indirection.

It was actually enough to use this in the KUNIT_DEFINE_ACTION_WRAPPER()
definition. It removed the warning about passing an array type.
And I needed neither a wrapper not #ifdef.

I am going to send an updated version of the patch. I am sorry
that it took so long. This patch has fallen though cracks because
of vacation and other urgent tasks.

Best Regards,
Petr
