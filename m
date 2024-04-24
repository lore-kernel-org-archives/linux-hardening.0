Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817A16DEDE
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998711; cv=none; b=EVLy6QEByQjqy8/JMZjj1zx7Lct2y3VWIyDhiZ4sCxwBz1NfY8yJ0PIVlFRkbt4lQBhfu987tYWkoCAiNFiBJokmiqHkxfLkP3n72uUw5Y9t97HXkyokql0Kz6y4srcJruKLnM9fS8U3z/0iAaVetQX1wyQ/0IqFX7C0PzhHUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998711; c=relaxed/simple;
	bh=PesUfngxJz9TzB+RXrKPi6gidufT5NJWBpNfqP6UeSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6n1MZlRS9XdoFSV5sesHKvlHsmJ9l8A1kQuvFB7IAoDXsz7ImFtPTvbNfhQMBZ4fwy1Fr9ID190/2fbheqS2e1S3t4ZFG2OfXvv2D/cZbVhDB0whDR6ozCB+dEVdyX1HeziE9Lzo+2TXnoadkzU3hKPuKmA5t/2Ar+eMab3y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ip2IuUZ5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ip2IuUZ5"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f30f69a958so373165b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713998709; x=1714603509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=Ip2IuUZ5LfeaeG8LgTT7FPRSNVprS1WtQ8j+0rOBMsdFH8RkkiUSJdxlYmcWm0keco
         D0VyxtpaYBK3q8eO/87uN8z81J/XdcHp44mFnYRtTQyLFhhWKfvbInbP/sym7rPhnNN8
         73IKrRKCZtycqCXOrZtxQ2k6kD6uCr8YzTm4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998709; x=1714603509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQ7aAoW8uYuZUJ8c+fQ05Y2fxYHEV3uQB6MRkhy36Ug=;
        b=NfASNa0mzLjXlAu6+Jtq4L7Q929g9vcvT9E+okrONv2t/DK/zxs8z8db8u0Xqd9/fK
         S7yWBxHMOnFxLwL2SazaAZUKxpVsJkv2Y5BRpRrgbS1IxWNVzli6Ro/4ZKppJGjW5ZuG
         badrpgR4hI4YqwHYazgnIWE6PKaE5FlspBgR+KcD+pqrGjdwN4uCHCTE3aqBOgS+AKDx
         kQMCV6TZvQozlN48K9WM1ePcrqLWWJpk+Dnw3mVzLAVPFwKM0HbGmlLcjq9FgpdjbFR9
         3YE29EtR4tnbJ0Kw2kIzTQaCPVECe/5PR9zcXiUXq0FdD2Lf+whSSFsbkgyT6j7pL2bw
         aX3w==
X-Forwarded-Encrypted: i=1; AJvYcCXbK2Sps5V03Yhiw6juuTL0U9+w60sdpCMehcpjNvvuazLM/Jbs9aunZboKC6+Z3+AO6qOWQ29Gw7s+/yBJJKuz5SLhiehqEQmAMMANOi7i
X-Gm-Message-State: AOJu0YxBBzuFsji7EN/UkB+jibAKtcpYFahIrCkUEx/hfBiXzq1SpEqe
	ixbpLnklPBW/m1PHs1wPeSjP184xVyC8ECu3VLGg/J8QELT6krQSxt+g0orWmQ==
X-Google-Smtp-Source: AGHT+IEAjXKcOqWbmJBmZ5dMg2rtYhG1LF2zwzQbtnGchw8LS/JZuvVMQDMhTtYVw79O2YlLzJPAxg==
X-Received: by 2002:a05:6a00:4fcb:b0:6eb:2b:43b4 with SMTP id le11-20020a056a004fcb00b006eb002b43b4mr5470380pfb.27.1713998708861;
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ln2-20020a056a003cc200b006eff6f669a1sm11902767pfb.30.2024.04.24.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 15:45:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 15:45:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202404241542.6AFC3042C1@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224141.GX40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> 
> > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  
> >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> >  }
> >  #define arch_atomic_add_return arch_atomic_add_return
> 
> this is going to get old *real* quick :-/
> 
> This must be the ugliest possible way to annotate all this, and then
> litter the kernel with all this... urgh.

I'm expecting to have explicit wrapping type annotations soon[1], but for
the atomics, it's kind of a wash on how intrusive the annotations get. I
had originally wanted to mark the function (as I did in other cases)
rather than using the helper, but Mark preferred it this way. I'm happy
to do whatever! :)

-Kees

[1] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook
