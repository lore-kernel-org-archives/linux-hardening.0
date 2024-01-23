Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD762C682
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046875; cv=none; b=mNiOMYw0n98Y9Kpqz/N4Jd/xo5c6VUvVPjaBOUkfbz5TQRmPH/qhguT849uNhatgTHzBPVQ3qQFwsliG0Ns5jfdQvobojDrh7LjFhMyRDRAEXDNufQB7+9kLhLXHxy4v/3BQPL7tz1F5T+t97aWp4bzkRYU2JeQWxQZ7/eTjz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046875; c=relaxed/simple;
	bh=OyptoQZgrz1X8m1OAIxrZM7I+UrxAKsz3tc4tHk75g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgwx0EITHAAwbiYz8S+ZOFuj+zWuePm7C8slLMCTMhgD/4jyxcekb+kspAYxRIMx9bZOxaKgu+v3jfoX2uPoGKLk4YpvFbJzibBYw9QtU0eFGxf9o9TOAi+QuekykoNHq4F8ZXq7bnt0ZixhcwXQzrRGrmkAGzDFD4Irqg3RfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aTh0YbBO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTh0YbBO"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso3644009a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046872; x=1706651672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16BHFWN5mZqDE+m/8++0MKdvvntMugYUqf/gfAr3/kk=;
        b=aTh0YbBOe5KdtcoJamLZVZjRKWh7HEVknl7PbdqPBghsOwTTm4pPofn1rAuQX5dknT
         dcbrvtIeir1jIK2hcr+Q47z6weUntBMmKytFsRYR3ZW1HVgd4uFJpSrYBnPCnR3zMams
         uqcj2jYCWePy27CdB0EHXxfL4mKhV8Jg9D9Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046872; x=1706651672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16BHFWN5mZqDE+m/8++0MKdvvntMugYUqf/gfAr3/kk=;
        b=cxGMHl6qDldaDLePI8k+OC0XsI5y4VaymZWaSaThbKdpi+tve3bBiR7lkQjS+hetXo
         fEvplYLFaDGYU/Nq5J+hG5+aGcT+2xRMfU1PAdwEDEp/XSiTwtdrTcslDQl6WWEJFs8J
         t+1DTSoZpjcxNpiOpJ+nYTzGOGslC0rZ4JgJ1WgFlZgilctU0bHK8mWG6K62XV9UZlJ1
         GBnhLtqZfisuiaTjQ55mhZ9qNrhyaEpZk7rnfFz7YbEtqmQWyVK73URsDhXPq+oo0M6v
         sY/F28z71gHZEIygu0SysklRMEL8pQqqhrYOT09EX+7oahl74mHbkpppVLhAeQJ7OB+Y
         ArWg==
X-Gm-Message-State: AOJu0Yw3KK3V99hGJeWIa325NvtOJB6ifHjCwOABATGjQX/rjHfwnZk4
	EKmXCiaaZWOqIhtIjukTZ8yZDzA+yS85kVjBvoEBj/g9jhVJzdRGDFfvE7blng==
X-Google-Smtp-Source: AGHT+IE8xK8v5OyPoVXhFhlYATfCJ5ikAR9uO9SWATCJ9F5lbjhJZjmG8W8l8y+KkO6ctC60W2qk1Q==
X-Received: by 2002:a05:6a20:6f9c:b0:19a:788a:1c6a with SMTP id gv28-20020a056a206f9c00b0019a788a1c6amr7906708pzb.79.1706046872539;
        Tue, 23 Jan 2024 13:54:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a0018a200b006dd873f44e7sm371966pfh.115.2024.01.23.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:54:32 -0800 (PST)
Date: Tue, 23 Jan 2024 13:54:31 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/82] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202401231353.7AEF98F625@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-10-keescook@chromium.org>
 <Za-GfqSFEA_4fUtA@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-GfqSFEA_4fUtA@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:27:26AM +0000, Mark Rutland wrote:
> On Mon, Jan 22, 2024 at 04:26:45PM -0800, Kees Cook wrote:
> > Annotate atomic_add_return() to avoid signed overflow instrumentation.
> > It is expected to wrap around.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/include/asm/atomic.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> > index 55a55ec04350..4120cdd87da8 100644
> > --- a/arch/x86/include/asm/atomic.h
> > +++ b/arch/x86/include/asm/atomic.h
> > @@ -80,7 +80,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  }
> >  #define arch_atomic_add_negative arch_atomic_add_negative
> >  
> > -static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> > +static __always_inline __signed_wrap int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> >  	return i + xadd(&v->counter, i);
> >  }
> 
> I think that here (and in the arm64 patch) it'd be better to use add_wrap() on
> the specific statement, i.e. have:
> 
> static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> {
> 	return add_wrap(i, xadd(&v->counter, i));
> }
> 
> ... since otherwise the annotation could applly to the '+' or something else
> (e.g. if the 'xadd() part is a special macro), and the annotation might
> unexpectedly hide things if we add other statements here in future.

Okay, sure, I can do that. I may have some header inclusion problems,
but I'll give it a shot.

-- 
Kees Cook
