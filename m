Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11347CA88
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240464; cv=none; b=SdSql2F+D7Ey+gP3rC5GR22Djokui/3lc8qCuFmbZ8YI9hxs7e+jL50Z1GHEstE5P7MiApFK9muh8p7ngtQG9VBZBDJ9Y5pSEqVRZGD4NITjhpKl1tnghRBqgeNZPieXKmLjCUNnGZH9WYppcT4O4CEGZ5gQtOpBMn5Idz0qL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240464; c=relaxed/simple;
	bh=GruX7oLTdhV3iy2Tf5qHkC3ie6pEwvgQMgJztpukt90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCQoZ9nE6WpmRhjW65AxeQgtn9zaX4SOHFzzAKhIpVNFzPzO19p/zqRf0ZaFloW7ZzZsS7nrR0M8LMFtLJEtJ0NhKYSCPM0LMAOlwyk+PIHGEeQ6zVQ/vb5vdpgRNdo2eKIhYq0L/cNK9Y8L3xtiBbI9kyIEzQ4ToYisI4miAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dZTRhkMG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dZTRhkMG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso36836f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787240460; x=1787845260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vW2vbLauS6L+WRF0P3Pb5/mw3R9o0oY2tWuO8zELCcs=;
        b=dZTRhkMG62pOlIDVYienVv5yVksALHGHKaUQBKoqqFq3ZcbB9ybX/XmDbRxgys7Sul
         QcYyRINiPWisiGt8TCGff1rOuVIroIr0nxC87BOmDd0rHnKBiE7p7Idnta33qlkzYr+A
         o/fTsBkzhdXZ4ulpQwLalwkMYlfyypk2S7vOeHXnnkIYNiP42ePlviXyZLmH/GBKu9bH
         tSa0ANce1HAHXzpyVKfCLwt8nn/xLsAzmiVq6EmeR6664ZqZ2Sls5soOXMfjs85YhhoS
         VVMxidMvvPwEIIo/WCqfvOVcuEL5nfkLailk8PqK5Jel1qXxQf8Zdk3QNyRhEQs9Plx6
         um6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240460; x=1787845260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vW2vbLauS6L+WRF0P3Pb5/mw3R9o0oY2tWuO8zELCcs=;
        b=GgDtdcL24DMfwBp+gHOBot0yexQEt8c9R6190QQfH06FawEkBpJ99ZpZMp6doZITQg
         sAyAQIdEshDMzWVPBU8diwpzX5XEOnvb6vK4FHdkuBYNgAkj9cWjECVrVm51H1aU4pSN
         lgFIrcrHh2z4CuhUyk9adPffcf8qqI1PnTfLOroy/ZDH5bw0uCJCsgIDLGTK8S9NcPXz
         CK9Uy/wXOaXzEcvb3qu+ydVH1puPVVz43fMvJ3BSn2UDLHcHeauThoaH64mJHhqWyJkU
         6+4walUQFgphbKYNQgR+IRhAIuH8ASoGkeRBPQM/3PEXRMYFD8RSK2EpIGkFd7HSsWCM
         3qQw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4FQfDNUDoFEeYDdTIkP2/rYc3FuX3rrFNHSTgwMpUtUXeM+rMWhZ+2KcTH1Af3lOT+RkScX3yKjzKUmiQcqQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mSj2aWRM76e6zcaYB1Mc9U5BubcrU5HPTr6iAws2CXFHA/6xac
	FTxZg8hHMxkI9uY29JQ4SRqd+JsiPOdY8iOudwDEmBFP5cqCnzmVimR/XCrBt5LkfuM=
X-Gm-Gg: AR+sD130aunzzLIXbpFnowqsLxSBMR+D0hGyfrBFf/vjdsCM5SU75cJmK6sWJJLzkRe
	wGnlIAM0RVT/p0C+fEyXQc2pyvdtgKKXdEAc0T/OBX1rsYytLinwFU17A04VWpIquKpzLP6oyFJ
	sBt6U+At/FKqZ++E0yGDFu+NYI1zmZuv34mJaan5PcziwRLyIyeHPrKdkC+TMR06kxMebn18l+U
	mrrNe2XKZ48UsUeGHadX9FSKaeSUUdZdE4NhJ3+eDHtPVmiq7qOFC7PEP2IBX1Ze+CQVZaXd5k4
	zw+bwWbZE71TzUNQMlBil7jWBurUeIvOtDjJyFH7L/7KDeYwfFlLumau9BcsD3OwhudMR6Jhp16
	5GU4uZhjznEryNDZ6QHcwg0Fd4sS0/QLnfNrk4Dr4YjJY5+On32P5P+2+iIHELYJrLplpaZltp0
	0RPCryb4hih1IDv5pBDNq2E3AOcyKAzqV1P4aRAZBvNkvXpXGXPr56VKv+cIAJqw==
X-Received: by 2002:a5d:5e02:0:b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-482b1fd3a9cmr25092691f8f.13.1787240460299;
        Thu, 20 Aug 2026 08:41:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b802dsm12188252f8f.17.2026.08.20.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:40:59 -0700 (PDT)
Date: Thu, 20 Aug 2026 17:40:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 1/2] vsprintf: Don't leak pointers for %ps without
 KALLSYMS enabled
Message-ID: <aocgCfQoKIVbaU4k@pathway.suse.cz>
References: <20260814144854.746840-1-bigeasy@linutronix.de>
 <20260814144854.746840-2-bigeasy@linutronix.de>
 <aoAqG0kKxvBbed0M@ashevche-desk.local>
 <20260820142426.Q3y-RHVx@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820142426.Q3y-RHVx@linutronix.de>

On Thu 2026-08-20 16:24:26, Sebastian Andrzej Siewior wrote:
> On 2026-08-15 11:58:03 [+0300], Andy Shevchenko wrote:
> > On Fri, Aug 14, 2026 at 04:48:53PM +0200, Sebastian Andrzej Siewior wrote:
> > > The "%ps" format modifier prints the name of the symbol which is more
> > > valuable in terms of debugging and does not leak the actual pointer.
> > > 
> > > Without KALLSYMS it will leak the pointer which is not intended. The
> > > default policy for pointers is to print a hashed value and not to leak
> > > the actual pointer.
> > > 
> > > Print "(unknown)" for any symbol resolution witout KALLSYMS enabled.
> > 
> > Hmm... I would expect some test cases to be added/modified.
> 
> No bot complained so far, so maybe not ;)

It seems that we really do not have test cases for this. I guess
that it is because it is so tricky with the various fallbacks, ...

The existing test cases for %p are tricky as well. As a result
they are an infinite source of problems ;-)

Best Regards,
Petr
