Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7982BE035
	for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016640; cv=none; b=aG0TmITtNKKiy7vULHVOQvAZhpxfPx+1UCK0Od3Y57aCX4p3HCq04D0GC9ttkD5fXkdB8tSV3O+OJwH9cUbGVYBWyxUCTaClsvlEoBGCu2R2FgtIkFqHPYEqmuCTXaYfTe94joAAIUkQfVdgFfXFvNSNz1+3xU+3MAR2XavkouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016640; c=relaxed/simple;
	bh=ZnhcQFF/kNHsXZB5vBd6wRZUgfEQt4y20yo15G+SD8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaIAxy8uYQqfxrfbjAKi0aHjRQjsSyW+4md6MqsuPaD5rWFN7fpBj3ssojdlKKQM2phl8X/B/CJntLj6WCyNDb/aGhRGNNao7jRX16ZYUVLtB7kUL+rG254YSjXoys7tUJz9LpBZOIrLIZoxQhgK7pO1hbVXUpzbRJpOgF8FG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fx4G09wQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fx4G09wQ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07d4d24d09so271549066b.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 Sep 2025 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758016635; x=1758621435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HInf3vVICYvsjl1BbLw9IcLOL1iDFPRtoXvi2r6kSo=;
        b=fx4G09wQh2nj5wtXeimkI58jbfjP0B4qsjNFUbox1Gq+Eot7XsoyxIh5koenMNiZpo
         blMSXQVFS3feT+yHkAIGuRa9I5cI2rB3NdCfsodu9soqduvZa/OK5oVZM/fTdLLn0nqz
         ZsitVlTaj0y+spz2kNaTZ0FnfXJFWOdhwcZI2xfk0l5QzbKSXQ/dsEfk7yXjRteHTUEm
         JCPRCJ0Ud0U43+B57ZQ/AlknBg6TNAhaBhgSXztlhZecGiVtgWIptnu5gCk8MqNcuL4e
         ctnvI2Bgla4UjGzOHVwjss9umPBNT91bzMLkmLAjm122h5cFGdlxhnhtTP0e36GyMMsx
         u1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016635; x=1758621435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HInf3vVICYvsjl1BbLw9IcLOL1iDFPRtoXvi2r6kSo=;
        b=b3/juGg/eq5P4OEwaYTnkHXvuUdvn17rHjp3xiQEuu52ttmGHLxF1SPjCZdJqxQfl9
         8isEK0W70TE9WO9mJWOc4yLTtWoljrfhbiqWjo/Dcd30koQnul8cZok54UCUHlbKW3W0
         EGn0OapLh4qW6mfqPEzFqDEf7mpQVMZLdGjtCYp2uhh9bXobENxul5vA7HT6dOBhobnA
         CRFrtqgRAM5fyVaOJ0W+01o61OIvbtN6olU42QpSFzrShFAiPC6jOkQlgeDEYUhGqNub
         0uinIRQ8e37TgNtFd9kDSXdXyMbPuLrN5Ym6S0JxhHZoyL/lOlysLpVpNB2Zvy5PMFNr
         ch0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzlHn8U25yuYq6NOL9Yjnrr0XiBl5M7jXIFoZIs66GDn5nqyovkdSwXC/N0QPIujvlfYE53BdenTKsx0LP4zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGjWZiJqRfvyUpSgyXknyEc0GRaCTGvf0mOckbRBfNLuwCXYU
	+EvYedWJH7bOrhmu0HNiVsjc/MbNgHvwYgOc2z8M2INhcSu0tpAGEJPQ45WYcATMKFw=
X-Gm-Gg: ASbGncu0JmuWnkW2d+QXquRXsF+VsQXYhBaGUTWfT95/hbeWCGENFQ36WHwRByk4rMZ
	gBm1zdSZv0misdfnYIp0YjKy0jwH+kaOfeZ3RdTL7XIjkcDeMESF1NdFZKtCsUmxuAzs8wnrcKh
	FTrQ9/id8CY4tLgZn1Jdmbob8IeoMIy4G1o9MGRgPq+K1zmWWkgx5tkLI+52V/WlOkvcPH5C93/
	j2a9nbyflv5ExozUqTiMKSk4XRYIoz29DjlqaekmELZBKOJi4SibRjYwcM4L4nC70O6mj9toP3y
	BvJRIWZZDfksPDBFL/G14rtUyRxm2zyYQEDlKc+XAUz06S6dls6UrwPGFH3M8GlFcQpGteBh4vr
	sEDQf4t5cYJO2qeEeI15iD/tUvqvEaCMraVg//D2g
X-Google-Smtp-Source: AGHT+IHumhbFeoKijO1bIfbeRN7muXKT3iQrz7PNZcfL0Hw4Nuwk0HrRa1xVrQAwNjSiMUzT+ONYBQ==
X-Received: by 2002:a17:907:3e9e:b0:b04:5cca:9988 with SMTP id a640c23a62f3a-b07c38699ffmr1699588866b.43.1758016634556;
        Tue, 16 Sep 2025 02:57:14 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31291b0sm1128497566b.34.2025.09.16.02.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:57:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:57:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
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
Message-ID: <aMk0d5JO_4YECYGY@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-2-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-2-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:29, Jinchao Wang wrote:
> This patch introduces four new helper functions to abstract the
> management of the panic_cpu variable. These functions will be used in
> subsequent patches to refactor existing code.
> 
> The direct use of panic_cpu can be error-prone and ambiguous, as it
> requires manual checks to determine which CPU is handling the panic.
> The new helpers clarify intent:
> 
> panic_try_start():
> Atomically sets the current CPU as the panicking CPU.
> 
> panic_reset():
> Reset panic_cpu to PANIC_CPU_INVALID.
> 
> panic_in_progress():
> Checks if a panic has been triggered.
> 
> panic_on_this_cpu():
> Returns true if the current CPU is the panic originator.
> 
> panic_on_other_cpu():
> Returns true if a panic is on another CPU.
> 
> This change lays the groundwork for improved code readability
> and robustness in the panic handling subsystem.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  include/linux/panic.h  |  6 +++++
>  kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c |  5 ----
>  3 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 7be742628c25..6f972a66c13e 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -43,6 +43,12 @@ void abort(void);
>  extern atomic_t panic_cpu;
>  #define PANIC_CPU_INVALID	-1
>  
> +bool panic_try_start(void);
> +void panic_reset(void);
> +bool panic_in_progress(void);
> +bool panic_on_this_cpu(void);
> +bool panic_on_other_cpu(void);
> +
>  /*
>   * Only to be used by arch init code. If the user over-wrote the default
>   * CONFIG_PANIC_TIMEOUT, honor it.
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 72fcbb5a071b..eacb0c972110 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
>  
>  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
>  
> +bool panic_try_start(void)
> +{
> +	int old_cpu, this_cpu;
> +
> +	/*
> +	 * Only one CPU is allowed to execute the crash_kexec() code as with
> +	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> +	 * may stop each other.  To exclude them, we use panic_cpu here too.
> +	 */
> +	old_cpu = PANIC_CPU_INVALID;
> +	this_cpu = raw_smp_processor_id();
> +
> +	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> +}
> +EXPORT_SYMBOL(panic_try_start);
> +
> +void panic_reset(void)
> +{
> +	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> +}
> +EXPORT_SYMBOL(panic_reset);
> +
> +bool panic_in_progress(void)
> +{
> +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> +}
> +EXPORT_SYMBOL(panic_in_progress);
> +
> +/* Return true if a panic is in progress on the current CPU. */
> +bool panic_on_this_cpu(void)
> +{
> +	/*
> +	 * We can use raw_smp_processor_id() here because it is impossible for
> +	 * the task to be migrated to the panic_cpu, or away from it. If
> +	 * panic_cpu has already been set, and we're not currently executing on
> +	 * that CPU, then we never will be.
> +	 */
> +	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
> +}
> +EXPORT_SYMBOL(panic_on_this_cpu);
> +
> +/*
> + * Return true if a panic is in progress on a remote CPU.
> + *
> + * On true, the local CPU should immediately release any printing resources
> + * that may be needed by the panic CPU.
> + */
> +bool panic_on_other_cpu(void)
> +{
> +	return (panic_in_progress() && !this_cpu_in_panic());
> +}
> +EXPORT_SYMBOL(panic_on_other_cpu);
> +
>  /*
>   * A variant of panic() called from NMI context. We return if we've already
>   * panicked on this CPU. If another CPU already panicked, loop in
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0efbcdda9aab..5fe35f377b79 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
>  }
>  #define up_console_sem() __up_console_sem(_RET_IP_)
>  
> -static bool panic_in_progress(void)
> -{
> -	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> -}
> -
>  /* Return true if a panic is in progress on the current CPU. */
>  bool this_cpu_in_panic(void)
>  {

All the functions are trivial. It would make sense to define
them in linux/panic.h. Then the callers would benefit
from the (unlikely) prediction macro...

It can be done in a followup path.

Otherwise, the patch looks good. I think that it is too late
but feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
