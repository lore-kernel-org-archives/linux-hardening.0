Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948171F4C92
	for <linux-hardening@vger.kernel.org>; Wed, 17 Sep 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758074961; cv=none; b=hUyJlNt8PC33uUXzJ4bnnKGlHuBwFvWAY3YjYQm2MO0ABmQZeUYlEB0H217Q7UmeeeCbn1/Ls3gGLBp2ZPGTKEdUhJrz/vU9IvNjFsUQdoYG9Cs+vK8AOxoqTJwtxBNl4xRNAsrSyP6k2RSUb4RhjMERhgwgQoKj0RVrCG0FA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758074961; c=relaxed/simple;
	bh=9Uos3Cj/r3bNwVwBbAMSOGK6nTL3M/iIao2va7IjTHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE+k5AgPMCCP72/sVlVebaIFGMDDYBf9EOf88cdXUGg6jYmPCviMfnZtCWF4x+IKYA4a4CjbhnqGZhhRxkDcM7Wj8u69+iLgf7sLwLYeSwTCSP8PvX9Vga70NHxGJ3yXSyiBNETa74UZqG+Zd2ezPOScH2iij+201FBaQsZ3qTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVau2eK8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVau2eK8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32e1c40ecb0so2716176a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758074959; x=1758679759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec0asGTrd8ayRRK4foZ3FyVP3qtZ9n13Tw5uWDKt8/4=;
        b=aVau2eK8E7JxlfS335s5a+CbasZt2IfRGQcEsBRFu1oojsde3u+vSP0Rx86mVfafk1
         Bn3lAFsupy0sYGX0Gs6M/auoeDHMfASAD8XXbO8HrBJaIicfyp5iZu/D7DG/ikdXFrpP
         kqxtCq48FxDuEnRjlwMp1Y0tujVXbYQ7IfHF+Kxj0Iur192PFAahP1IZJJEtzgopPRPI
         dLUtDstLp2Xe7n7fC+Q1R69hDx3nGXUTpUj0zW+S7QgUxdIQM9Shnz2TpH4/tijYDNte
         Xvfj5X19Qp9dj1k6gIB15jsdP1IPnn/7ULkhwMlsDOHNG8YGKVPwwbhAAkv+aUmKCn/t
         k+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758074959; x=1758679759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec0asGTrd8ayRRK4foZ3FyVP3qtZ9n13Tw5uWDKt8/4=;
        b=BtOSYaUWX4JUG5HO7mwHsfdMBVFVSyVOD27vNzWhmPY3eYMZrXZter72N4BfUZmVRG
         Z9SJU7vYHzeNszHPsOf1WrnOqFTdbkDEOHpheVOJNl9j4vSJGkfwqr3PrfFbXpdjwM14
         RGMjetcTyEV1rpOPetxwr9/zROqfsid6h39y+1o1ehDl/dQhcm6T5qxyQOHeq44RYwcz
         jkCDvBf9c68BiLUE/tfR7GwwFIUAhHV8PnS32olEn2rY+xf+BxDmZndgKRvDKPoM5e0Y
         joAbcHRjVZoPaQEUDsDMQT61b6MphAsyFujxEJ1pSK0vwMI0SL+aaMeXCOZ5O3MQxc0I
         82vA==
X-Forwarded-Encrypted: i=1; AJvYcCUx0csXNE6ccodzS/beHxo6/sGLVtfjB8Mu7rsD0MOquDYChBHEQjZjLSg/tLlHe/GJ8dlAlFRpi62p3kk6SDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzo7OmopTRrj7FrqK0/ZtyrreFbCDsIK+xAek6VFVhqnGBY4Sd
	yC6ZDtYDGRb0t/qMpQKD9f90PriwrRhvMzqHGs0JoIx5K27culd1r0id
X-Gm-Gg: ASbGncuiLmgU4LnqHA+dqFJ7m+No7xD5mamp5WDOhGP8TBr2Vrw4ISba/7Wc/WLgdcN
	9StIN4Lcdl6lkytQm0mKxz4wp+vDANrfyhT8MoNabJCAdh5dB2VN9W4PyG/qgevbWUBb3BT/Ai/
	smxosFyWVSBg3ZbP8d5ORTPhEl2o8a6CgIT3Iz5aB+mnxVz0r4Yw/NowMgpigEgh3BJ8av1MGjD
	mBmThDart2a9fEJr7qvVyBSs6BsXztT3hDlEew+4573MHe2y+nifpj8Qm3Tphq8k7QM561oWVfC
	tD+DxihaavEjNZvovn9vJPiMF8TqvC+9aAlaqBk1b3LJM73/LWB3jy66vMf2pSBhUuEollHF1QA
	XLsgJuTPW0D6EYUKTzqw3gGnMy8ftqAN7fixKSZVO
X-Google-Smtp-Source: AGHT+IGE1lxlxAvcVFpWcXZnKgkQRp7XPS1CVNzz6zy0okJvDf1X7FhTYPGTQTnkoTiUrMzQO5PECQ==
X-Received: by 2002:a17:90b:4a41:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-32ee3f60244mr511848a91.23.1758074958707;
        Tue, 16 Sep 2025 19:09:18 -0700 (PDT)
Received: from localhost ([146.19.163.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275fb3csm862045a91.20.2025.09.16.19.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 19:09:18 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:09:12 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Zsolt Kajtar <soci@c64.rulez.org>, Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] panic: Introduce helper functions for panic state
Message-ID: <aMoYSElAEBiBvVET@mdev>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-2-wangjinchao600@gmail.com>
 <aMk0d5JO_4YECYGY@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMk0d5JO_4YECYGY@pathway.suse.cz>

On Tue, Sep 16, 2025 at 11:57:11AM +0200, Petr Mladek wrote:
> On Mon 2025-08-25 10:29:29, Jinchao Wang wrote:
> > This patch introduces four new helper functions to abstract the
> > management of the panic_cpu variable. These functions will be used in
> > subsequent patches to refactor existing code.
> > 
> > The direct use of panic_cpu can be error-prone and ambiguous, as it
> > requires manual checks to determine which CPU is handling the panic.
> > The new helpers clarify intent:
> > 
> > panic_try_start():
> > Atomically sets the current CPU as the panicking CPU.
> > 
> > panic_reset():
> > Reset panic_cpu to PANIC_CPU_INVALID.
> > 
> > panic_in_progress():
> > Checks if a panic has been triggered.
> > 
> > panic_on_this_cpu():
> > Returns true if the current CPU is the panic originator.
> > 
> > panic_on_other_cpu():
> > Returns true if a panic is on another CPU.
> > 
> > This change lays the groundwork for improved code readability
> > and robustness in the panic handling subsystem.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  include/linux/panic.h  |  6 +++++
> >  kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
> >  kernel/printk/printk.c |  5 ----
> >  3 files changed, 59 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/panic.h b/include/linux/panic.h
> > index 7be742628c25..6f972a66c13e 100644
> > --- a/include/linux/panic.h
> > +++ b/include/linux/panic.h
> > @@ -43,6 +43,12 @@ void abort(void);
> >  extern atomic_t panic_cpu;
> >  #define PANIC_CPU_INVALID	-1
> >  
> > +bool panic_try_start(void);
> > +void panic_reset(void);
> > +bool panic_in_progress(void);
> > +bool panic_on_this_cpu(void);
> > +bool panic_on_other_cpu(void);
> > +
> >  /*
> >   * Only to be used by arch init code. If the user over-wrote the default
> >   * CONFIG_PANIC_TIMEOUT, honor it.
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 72fcbb5a071b..eacb0c972110 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
> >  
> >  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
> >  
> > +bool panic_try_start(void)
> > +{
> > +	int old_cpu, this_cpu;
> > +
> > +	/*
> > +	 * Only one CPU is allowed to execute the crash_kexec() code as with
> > +	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> > +	 * may stop each other.  To exclude them, we use panic_cpu here too.
> > +	 */
> > +	old_cpu = PANIC_CPU_INVALID;
> > +	this_cpu = raw_smp_processor_id();
> > +
> > +	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> > +}
> > +EXPORT_SYMBOL(panic_try_start);
> > +
> > +void panic_reset(void)
> > +{
> > +	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> > +}
> > +EXPORT_SYMBOL(panic_reset);
> > +
> > +bool panic_in_progress(void)
> > +{
> > +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> > +}
> > +EXPORT_SYMBOL(panic_in_progress);
> > +
> > +/* Return true if a panic is in progress on the current CPU. */
> > +bool panic_on_this_cpu(void)
> > +{
> > +	/*
> > +	 * We can use raw_smp_processor_id() here because it is impossible for
> > +	 * the task to be migrated to the panic_cpu, or away from it. If
> > +	 * panic_cpu has already been set, and we're not currently executing on
> > +	 * that CPU, then we never will be.
> > +	 */
> > +	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
> > +}
> > +EXPORT_SYMBOL(panic_on_this_cpu);
> > +
> > +/*
> > + * Return true if a panic is in progress on a remote CPU.
> > + *
> > + * On true, the local CPU should immediately release any printing resources
> > + * that may be needed by the panic CPU.
> > + */
> > +bool panic_on_other_cpu(void)
> > +{
> > +	return (panic_in_progress() && !this_cpu_in_panic());
> > +}
> > +EXPORT_SYMBOL(panic_on_other_cpu);
> > +
> >  /*
> >   * A variant of panic() called from NMI context. We return if we've already
> >   * panicked on this CPU. If another CPU already panicked, loop in
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 0efbcdda9aab..5fe35f377b79 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
> >  }
> >  #define up_console_sem() __up_console_sem(_RET_IP_)
> >  
> > -static bool panic_in_progress(void)
> > -{
> > -	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> > -}
> > -
> >  /* Return true if a panic is in progress on the current CPU. */
> >  bool this_cpu_in_panic(void)
> >  {
> 
> All the functions are trivial. It would make sense to define
> them in linux/panic.h. Then the callers would benefit
> from the (unlikely) prediction macro...
> 
> It can be done in a followup path.
Thanks for feedback, I will do it later.

BTW, this series was merged to -mm branch already.

> 
> Otherwise, the patch looks good. I think that it is too late
> but feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

-- 
Jinchao
