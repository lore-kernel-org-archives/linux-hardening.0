Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E71E7C05
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jan 2025 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930776; cv=none; b=SYt5wNOihppBZPAe7NmUAJQDB41Lc7VfQ96smnWbTxHPy9s2tu5v7A9tmAyvtXKIe300y0oaSEL7vQ3oHT+5GkZJE3Eb7RDlA5vqiiVwY3zR5b2UxaOyNOL8EQvcfrx0lnAqHsTkaHiPMvi1x6zrjsPs90L2ZL8ly/fgWgFOBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930776; c=relaxed/simple;
	bh=Up7sdHdULndNV3wa1eoRT8YiiUCWqExy7Bh/qkpr2c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOIxPbd+ukU0/1eMGJhhyA5ctkd7VDMozl+z24e1KyohKjag0eVBkZfTiOzfa/8Shxq03z804oOmLhP79E7p4qYbismz9yN0GDMH3qLt7qJT+lEL4zXuqdateB/xEgyyI54kGJ8dbnlbkn1Ptc9kjYg/Yf0Q/BvyzHnbRNJoqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bOHsbztT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bOHsbztT"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2760263f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jan 2025 00:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736930772; x=1737535572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vy1VNzBTuZPf0pEoPCF5h9VsVPv33S9oELOOuaVNs5A=;
        b=bOHsbztTXX3bOtoRsK65PoBtONwCWoCzv1qPDHiAsvNAiX1uWXWhf8Wl7mbKxpDBZ0
         G/mKF7xdqox4aLdAQ+b09BprSyvVjTvJa1/3uHbfcvhArTXf0gmkGq3LKyHOcJ+qKqNU
         mTsSn2Admoanm7e+rR5F8YO4ZAD6gMY6SVN5J0WfymYbwA5EAWPqA/ktcHgDK94KThEO
         7P9+moxm0fJUILYD98JmvLRlwQoaZCHtQbmkp9jbjEbXtU8pJuytNwYRUphjaYCv5gZv
         8BN3/gSVmIgAOx8natmTKC0FiSQ0iMswJ5I2Gl+e01TALHORlR+GKv0OX0fFPjjV4334
         PLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930772; x=1737535572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy1VNzBTuZPf0pEoPCF5h9VsVPv33S9oELOOuaVNs5A=;
        b=UCsKYsEw+WtS4/YETQFhtpxUnLHDjNxn23UziopQplZKBHuapLrFRkvEt4xRQxOJLF
         nvI7KU5SeqYJdNHYYBCuS6ezCIkH+KmjFh44GlpBJUXfGgWOpD11jRolhBmFXpzLwCaK
         8YSmMPhEObhh651ogCQzsUoV8X6a5tc4PPF9KqEKTleTI7Kg/dHzIU8LMD9YKSeAe4dl
         zHhQPCm+w2RAUQqJFLMXPsWiNl5O/M66jWu9sitQgikHW39ym+WpsIM0D/Va812iL8K0
         59NI43CGjyOCPzsOUUswFCIrJ6+DjxAzyFGoSg8nJkfPVux7IJOs6sns4MBrWDG5CB/y
         v2ig==
X-Forwarded-Encrypted: i=1; AJvYcCWQBRGnAv+Q7/dE1OAbrZOvjuTIFwejoj4ClI9lPYmwGdp1zmgM1Un+FzD0J5eqDqx7uOY9jSD0rfif9yqfi+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWXAnQeIgpNj/Z1gMuSLlBdnC7RnntKOskhkb4pi3zLukOurP
	wA3FMd2ZE4rfoFdZJVG3TE0I+Sff0rDrVhtpFah44Jbd01pkQqrn929lVk0jmoI=
X-Gm-Gg: ASbGnculgTLRswI/Adnmd5l4P/3TIdSPsGvzXjGtNmjfS06zU2MBmKfcTuLtk2/RNI1
	QVoCEjRXqhR7d/NGKBvgz9O94RVtYwX0TsARpAAjiIYuKLaimitQeGzrScK8Tnp7KdKXMIeE5aX
	gjKSPaj33fhJlTyrgm2Cjep3K4KRW2wnSRxGAIeRG1ahrK6Jb6L1CX3KXsqqOE4vrIhtHQiW2oM
	DkjO6tjlWqlOAkMa0kjwAeUZ4qcf6OX78ZTFjK2FL8ffVCe06rcNEedRg==
X-Google-Smtp-Source: AGHT+IFME8CbH/ZGTpWmcIC+L99hUYVgtrEwwgCc87ctbLiyealQR1Pe87aBz94hev6yzMucT7Nqsw==
X-Received: by 2002:a05:6000:1566:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-38a87303e63mr1936295f8f.22.1736930772109;
        Wed, 15 Jan 2025 00:46:12 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d472sm16689950f8f.1.2025.01.15.00.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:46:11 -0800 (PST)
Date: Wed, 15 Jan 2025 09:46:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [DISCUSSION] vsprintf: the current state of restricted pointers
 (%pK)
Message-ID: <Z4d10nHUg71Of7bu@pathway.suse.cz>
References: <20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de>
 <Z4Z2TW_HaANvT4VH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4Z2TW_HaANvT4VH@smile.fi.intel.com>

On Tue 2025-01-14 16:35:57, Andy Shevchenko wrote:
> On Mon, Jan 13, 2025 at 05:46:44PM +0100, Thomas Weißschuh wrote:
> > Hi everybody,
> > 
> > as you know, leaking raw kernel pointers to the user is problematic as
> > they can be used to break KASLR.
> > Therefore back in 2011 the %pK format specifier was added [0], printing
> > certain pointers zeroed out or raw depending on the usage context.
> > Then in 2017 even the default %p format was changed to hash the pointers [1].
> > 
> > Both mechanisms are similar in their intention but have different,
> > cross-interacting effects and configuration knobs.
> > The end result is not always obvious. For example:
> > * "no_hash_pointers" does not work for %pK if kernel.kptr_restrict>=1
> > * If kernel.kptr_restrict=1, "restricted" pointers are effectively
> >   less restricted than "normal" pointers.
> > * For other values of kernel.kptr_restrict %p and %pK have the same
> >   security properties, but still different string representations.
> > 
> > Additionally the current usage of %pK is incorrect in many cases.
> > As %pK relies on the current task context for its permission check, it
> > was only ever meant to be used from procfs/sysfs/debugfs handlers [2].
> > In reality many callers use it through printk(), leaking addresses
> > into dmesg. While restricted_pointer() tries to detect some of such
> > situations at runtime, this check is not and can not be always complete.
> > 
> > File handlers which could use %pK correctly today, often use
> > kallsyms_show_value() instead. This is similar, but checks explicitly
> > against the credentials from an opened file instead of the implicit task
> > credentials. This behavior was the goal for %pK all along [3].
> 
> > Is it time to inspect the users of %pK and migrate them to either
> > %p/%px, kallsyms_show_value() or some similar new API?
> > Then alias %pK to %p, maybe removing it at some point.
> 
> To me this paragraph sounds like a good plan, which I agree on!

+1

> > A different, but slightly related issue occurs with PREEMPT_RT.
> > Calling printk("%pK") while holding a raw spinlock will trigger an
> > invalid wait context and latency spikes if an LSM using sleeping
> > spinlocks is enabled.
> > As printk() should be callable from any context this is an issue.
> > Removing the implicit group check would also avoid this.

Good to know.

Best Regards,
Petr
