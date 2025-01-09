Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8761FF602;
	Thu,  9 Jan 2025 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455966; cv=none; b=UXnCc4v6tcFmqBDavhjpddBx7uEEbaQKE1RhoWJSBc51RxsUmNa0xKQf2UtaZUgOcOtnnecge9/qLhONDKWTBkZqWJTL7It9sotKYghvkospkuNdCLBwytGneP6iXGbNhEJw459+BFr6lVoVQQ74pP241jkqgnydfjIs7w/8UjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455966; c=relaxed/simple;
	bh=KnxtAk8qTKHGN09scdtFagXnmUyYHSHslz5s4xuHouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgaxyAIJnLLCcXj/+B9pBsYo04y3VF5BJfRSYH8dXqJaRE0UkSyDbZEzQe/ewZn63bg8bKOT4Yvq8mvvHWILXkjXoqxfwpmMSZBAMsO3QIliSvjDJQCR1sp1ftr4aUNvgm9VAzrlG54vGCq1jYWoKGM0ekq8814IRvqivTWnDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCOU0RxH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCOU0RxH"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaee0b309adso229878666b.3;
        Thu, 09 Jan 2025 12:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736455963; x=1737060763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HMFdHqbka7izRuN40UhAvy6hkpZnK617+IDz/TGNDE=;
        b=SCOU0RxHtRRZDN5fe4+EgzCzgvOEWkSXIAK4fFSoO3/7dq6PsjIv29j+Jakk+Y7TOA
         Vk6BQdJEtwJsHGSrRT2Iu0qa2gpvGwafbN17p49UZ/iyGrRenLKLRPhdQTUm6y0MmgjD
         qePX5Wl3ZYZFHzKvRKWH+zuNh4RYGm3Y75YauC1za7Qj+68z7d9sgc993rLn2zQb8dz9
         0i5mpeEt1OVEYVArI5FYMgutIOer5EIEjmM/3+lMd3f6Un49nHq8Wzc6z4Tad6G1GKE6
         UPs/WzwfTx48VpRNg0hWTlBWoZE/IQGAf8Cgkc9DcyCY8DJJ3tPKhI3e+hyFVtaCdPVx
         6f8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736455963; x=1737060763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HMFdHqbka7izRuN40UhAvy6hkpZnK617+IDz/TGNDE=;
        b=J/KZdVql7Qnnqkrv9Q8zdFcMa43tmrJZKY0U+vkxrmhUf5tWcwmUu8p0ZsBlyTOCvZ
         2D1IoM3N+LgDFQxl77QOPPXOVGj633QbnH86xyW0I8PSKJPp3TOF+W2mnJBS3RGQokal
         QkjFOVwaTiVLixzwrhgRf7cuCTexAX7ndE8G1vl1hyIXfsTN2D8zPuVANmHZS4D5sClZ
         EN8yVI8gi6SMnhISoW+yxF2Y2AY0oiVDTKIlAaiGnrI+pFoXWanIDC2LMBOFV1D4vkGB
         xYTKM841ep4vWUE3UXSg7fTwc2MZYDSsHhosEG8rlrU5ZCvf8O7gUpdBUEXg3FcUpWPL
         5vzw==
X-Forwarded-Encrypted: i=1; AJvYcCUNhpwkyYFQ8N17RsRz7RL9VKOrFZN6WATEj8BTxUv8YYw9VmyXPEKOba1ZV17FdEwJ3LvNW47IQMW2jpnt@vger.kernel.org, AJvYcCXrGHWd5nSZAQCc6M3QjfVIl4jytfGm7RuwfFA4pVSUuYyGqDrVOrg5ddbvcwil9a7TRSsuQ5cNZafHbEZzLKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8bLNlslMg8hQkw/2MOp40L3smPnEVz1QQoRg+XidUDjnAfXN
	U1qPYWuX1Clkj747wiOV2agPk+1mq9iPWy6v/HI1Ys14Mf4wqB5s8IkvQw==
X-Gm-Gg: ASbGnctcj8sETAq4UOgWx8RXelKZ1pLzDgEUexRRRunQYSnkhlKdeMYOU3ZaucRGRkm
	i64gK1TzOVz2oOCGQR0r5VyJjSbp8uh2RPK9xSVfCG0UzPrVJMhsyhyTwZiPHQLjSb9KtxtoKRs
	lAm3Ls2+bprL+ddmUlVVXwxFOrSdwfHOpLRAq8qNQBGLcTGHGugsJMFtwK1byx7087eSA/VNIeX
	SteIGuHAOOpmZbUXsrvpYUzVosTaBrdrihz3yV/5OTguFWoNf/RHg3qq52KDnMoP1rcQA==
X-Google-Smtp-Source: AGHT+IE2N0g2afqQmbpKEe4JDRouonFPw+VVQiG2IG9yRG16DPXEXTdIBmlslgVrCerWmyqV7Q2zWQ==
X-Received: by 2002:a17:907:97d6:b0:aa6:6c6b:15fd with SMTP id a640c23a62f3a-ab2ab6b52b8mr708177666b.20.1736455962526;
        Thu, 09 Jan 2025 12:52:42 -0800 (PST)
Received: from f (cst-prg-31-79.cust.vodafone.cz. [46.135.31.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b09a6sm103010466b.145.2025.01.09.12.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 12:52:41 -0800 (PST)
Date: Thu, 9 Jan 2025 21:52:31 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Nilay Shroff <nilay@linux.ibm.com>, 
	Yury Norov <yury.norov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org
Subject: Re: [linus:master] [fortify]  239d87327d:  vm-scalability.throughput
 17.3% improvement
Message-ID: <pep7tppcmd77ejaa47bhajc3uoy2q2n3cladgc4btdri4mth65@dqjulq2hx4l2>
References: <202501091405.a1fcb1ed-lkp@intel.com>
 <202501090850.F23EBEBC5B@keescook>
 <202501091236.E3EDA2188@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202501091236.E3EDA2188@keescook>

On Thu, Jan 09, 2025 at 12:38:04PM -0800, Kees Cook wrote:
> On Thu, Jan 09, 2025 at 08:51:44AM -0800, Kees Cook wrote:
> > On Thu, Jan 09, 2025 at 02:57:58PM +0800, kernel test robot wrote:
> > > kernel test robot noticed a 17.3% improvement of vm-scalability.throughput on:
> > > 
> > > commit: 239d87327dcd361b0098038995f8908f3296864f ("fortify: Hide run-time copy size from value range tracking")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > Well that is unexpected. There should be no binary output difference
> > with that patch. I will investigate...
> 
> It looks like hiding the size value from GCC has the side-effect of
> breaking memcpy inlining in many places. I would expect this to make
> things _slower_, though. O_o
> 

This depends on what was emitted in place and what CPU is executing it.

Notably if gcc elected to emit rep movs{q,b}, the CPU at hand does
not have FSRM and the size is low enough, then such code can indeed be
slower than suffering a call to memcpy (which does not issue rep mov).

I had seen gcc go to great pains to align a buffer for rep movsq even
when it was guaranteed to not be necessary for example.

Can you disasm an example affected spot?

Gcc has a bunch of magic switches to tell it what to emit in line, the
thing to do is to convince it to roll with a bunch of mov (not rep mov)
for sizes small enough(tm). What constitutes small enough depends on the
uarch.
