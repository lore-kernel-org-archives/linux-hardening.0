Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6D1E86F
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001455; cv=none; b=ZNIC4uyqHPhw1lQyIucvIRR0orgd2n59k53r9rMv18KbMvq7nVqYDLOh02DiSAUW3DpT5lLAXpcP/RmS+Sdz6YQnBlao+bkiNQUIe2NCKLLIQzkVVdehyleGjFq/cF8C6+lWGETsv3mbttZkknoDCAs4+FF+359KnPfrqR/VI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001455; c=relaxed/simple;
	bh=oH09D5zkFXRFNfU7QJiNFf+gIh+lrRtBdFHPc4eg0Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCSWHTVJ7LlQ3wuZLsR+1EC9LNJpkSQzHtBX9NtCRE48Jue1DWCcE7D2cIRcee5OuVnH7mGvNmT79maeh8wJpwFurpm81j/DFCcNXM2gxf3SIedQO+oDwFId3IP0+YEJVr847Yp8VLMlsUtOAYx5bXT5bKZRXe/IzgSBYUrIzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PuaOvteq; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PuaOvteq"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb7d1a5d39so252471a34.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714001452; x=1714606252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwtnqARf0+6Z9GG1dv72c6Df9XT02q1HeJoWwzmw6v8=;
        b=PuaOvteq0mMRgO3Jlb2dgmiCdAPFB3Btc8zIHX74LLL3fcOxKUNDdejxB4uqBY5JPG
         gzeSqc5Q6og7ag+mA85KLwOLD2cgygAFMqFSk4UJczXMpWloJJYfcMV9Dq0DpY7UpbE3
         IpKBWIDyFj1vZDAhupVMhZaYLMQxGDePYUc5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001452; x=1714606252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwtnqARf0+6Z9GG1dv72c6Df9XT02q1HeJoWwzmw6v8=;
        b=uOaa0uF8F+ke0oYEvy/EIDwpIPGc0kO5YzV4PSBMWtHs1pQHu6A7pbPLKzREd1ZasW
         cnB5wuXpNfaTV/fheOvHgEhRT2nmWf4jonWm/HGVYg3K30ySGLa0ATgwksMqzvvF6B9L
         LelRjFBgI8VOQ1GWPhSssB9qT+bviNDBANbFiEcIuJEtklKEp8gKmM4plhJzzIYpiBxu
         Z/NWYEHGoRLJApGIjR8HpfietzZYa5KO03B07dOG94Q+8KR9M0w4/NH5rk3CBfjE4A0g
         A9l5sXc5X44+Q4mFvwHDc/MKFICgCn6cDyDDBQT8tYn1vIjPJsL1TsmykyjspMW+uhx2
         IOlg==
X-Forwarded-Encrypted: i=1; AJvYcCUFzbil4JmKbkSwPvGkzvNtMiogxWHLItmBFAbSkXhYPQIXrfvpziN4Pb+AkypWbQPgpsjdQr+j7emJtFVwnSL5YdrkYy2WuAigwJBaRLqr
X-Gm-Message-State: AOJu0YxRc/N6m9f9EcOaa6QzOW7vOT/dd8O5vF09PeMvCjZX3xJWk9Y2
	Mt85+3GlzUSHKSgHG7wi0zFF+kdq0R4IEUHHJKMRY266BSgl5iIipOMLJMkv4Q==
X-Google-Smtp-Source: AGHT+IG1ie+7N7gLAuYGp0jXBUvNN0VNl/qnLnqCCnwse0PJuc/S/QdeclEgnM1MgF3ysfsWuiww9g==
X-Received: by 2002:a05:6871:7410:b0:233:56e5:ff99 with SMTP id nw16-20020a056871741000b0023356e5ff99mr4180313oac.23.1714001451762;
        Wed, 24 Apr 2024 16:30:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k73-20020a636f4c000000b005df41b00ee9sm600140pgc.68.2024.04.24.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:30:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:30:50 -0700
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
Message-ID: <202404241621.8286B8A@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
 <20240424230500.GG12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424230500.GG12673@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 01:05:00AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 25, 2024 at 12:54:36AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 24, 2024 at 03:45:07PM -0700, Kees Cook wrote:
> > > On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> > > > 
> > > > > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> > > > >  
> > > > >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> > > > >  {
> > > > > -	return i + xadd(&v->counter, i);
> > > > > +	return wrapping_add(int, i, xadd(&v->counter, i));
> > > > >  }
> > > > >  #define arch_atomic_add_return arch_atomic_add_return
> > > > 
> > > > this is going to get old *real* quick :-/
> > > > 
> > > > This must be the ugliest possible way to annotate all this, and then
> > > > litter the kernel with all this... urgh.
> > > 
> > > I'm expecting to have explicit wrapping type annotations soon[1], but for
> > > the atomics, it's kind of a wash on how intrusive the annotations get. I
> > > had originally wanted to mark the function (as I did in other cases)
> > > rather than using the helper, but Mark preferred it this way. I'm happy
> > > to do whatever! :)
> > > 
> > > -Kees
> > > 
> > > [1] https://github.com/llvm/llvm-project/pull/86618
> > 
> > This is arse-about-face. Signed stuff wraps per -fno-strict-overflow.
> > We've been writing code for years under that assumption.
> > 
> > You want to mark the non-wrapping case.
> 
> That is, anything that actively warns about signed overflow when build
> with -fno-strict-overflow is a bug. If you want this warning you have to
> explicitly mark things.

This is confusing UB with "overflow detection". We're doing the latter.

> Signed overflow is not UB, is not a bug.
> 
> Now, it might be unexpected in some places, but fundamentally we run on
> 2s complement and expect 2s complement. If you want more, mark it so.

Regular C never provided us with enough choice in types to be able to
select the overflow resolution strategy. :( So we're stuck mixing
expectations into our types. (One early defense you were involved in
touched on this too: refcount_t uses a saturating overflow strategy, as
that works best for how it gets used.)

Regardless, yes, someone intent on wrapping gets their expected 2s
complement results, but in the cases were a few values started collecting
in some dark corner of protocol handling, having a calculation wrap around
is at best a behavioral bug and at worst a total system compromise.
Wrapping is the uncommon case here, so we mark those.

-- 
Kees Cook
