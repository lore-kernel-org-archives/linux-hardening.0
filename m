Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605752EA480;
	Fri, 11 Jul 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255829; cv=none; b=pGUiJoFY+H/Qf4LdeuYpAtASTAhJoTIH7bUb0uAkyyaOApusAFi7MIUv9qtW/fDL29HWKjMmiE9AMxhLoiw3meamoH0Pp8vPatVBvw2ov4baMb8ExttRLXMZsVbIq6YKlpP79eva6imnef4Lf/OwMDCEWJ631tjdwMHq/Fettiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255829; c=relaxed/simple;
	bh=35BcY/6Q80oE3lxSzcJnrlGt2obqeaKDof8caRPjbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmUEcTdvBPoRu02GXasMlIHI1c3REe8nMx1bo7U32O7hzYE6FcfmIR+wMnPfFrZ2LvSmKkuzsg8VYZ7IPWqoz42RztKeMiEpRco3OVKoqgjknkXODJieSUF3c8n9Wr9Vf6xSL2bfQUgrb5ioUecRMsTEep8xiGGeTTlp3L2I29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDeUHQb6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDeUHQb6"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2229283f8f.1;
        Fri, 11 Jul 2025 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752255825; x=1752860625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VknUmgzMCiBefIq6vhslDBLHtoemuumEdTr+qyL4BSs=;
        b=IDeUHQb63YGJ5ZhvVMU9+YzZsGO7XcjjMQCwWWholCEcaAAk6hDydqxYTBLWt8AH3K
         jTavBd8DVFSg4dokL822VOl6T9dJnUNv/eQBJvyTEa4IARV6EEj4g19mFJf805HryzCK
         9LAdG69pmuTreXX5t35w87wLTWR7O1sDUPey/xdHQH5QXV1+UXvmUC3/OjhG5dCCOIaY
         IeHjunMJLq5pTUOSJxCrmNULKy6IoahyXmZqcv7Itv+WvDzlZkkCzpe3Hx2JZNR6CbHI
         o7X8AQzW2HQBfknUn4XPh9pmTkGbU2BYTQnbP+uKun1/ov6CkqJ4MH+N6xozm4yS41At
         Q3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255825; x=1752860625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VknUmgzMCiBefIq6vhslDBLHtoemuumEdTr+qyL4BSs=;
        b=m/O9i8hZs75zfdzcw0M8nv010QjtoyRP5k2lY+fFrck5BchwG/LZFyhPscUbxwducv
         Uaf05tsk2HlarjEAuhhKTWhQI5Rr/471kh7QaTkUKZ8u3kCong3nVNWC0cjFWieN+jKT
         1+D1SLB4Qo3C4XXQrGlm3BS27wrcGDOvHyXxvRvYvpuLmwx512Z9/CuMNu7+CRiXGeRh
         LwtlITvFGdqoICdvKrhztelmFNESsTxfYTPW9yZ5i4uOnM/mNgpUgJBq/Y/A+pNAspWO
         NGX1HAPDT82PvYPTf7jAIWs57UhC4xtz2bZt3bnHhzNI1qLIBsf/CEZjamCozH2yBIDX
         X4tA==
X-Forwarded-Encrypted: i=1; AJvYcCXALCsUwTuPFrkRWYM916Y+dXxL8g4wH9TgfEwxzfHnM1IOoDqaHbzJ96cZqHkCinilN0Z0MTFzG6IO384u@vger.kernel.org, AJvYcCXFyoMzljP9AlNapymsdSYd4jaH4VlZPIkzQaLXId26wh2Ptoudacw6+cYBD+u9wXv7slKQRwemEZqccFviiew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQgCTyx8+fMkzkg/ChXbgEJBbEn1SOzYURm06hguDyFCj1SpMt
	4e6pZTiVqUzkdq4J28uG4gDrnTh5qC3jvfry0e9fzilPC77F0c2ejIZC
X-Gm-Gg: ASbGncuIhyXbvpQcEX0SWAhnCNhOf4u6Z2U3HwslAjugaF1sVexKlsEsyXthsGlDLkA
	h2Nog/CDnwBXMLs7+xoC/xsN0tQSe5rU/o+zZ3xabaYYMt6jPVuRCtyft1K3WbKRTZm7Nw47dyS
	WJ7CyuB8/jg6FMh9FYSaZ0McbdmgTFMX1EWGVCEu8dwzGu7tx0NMf9vqgyKDmbFlLwzgnHoxAiW
	x2zmOFBnrO1BvkdJLOAfcNjMIJuWtQeoDviZE2F5TRstcV2UtsDl6Ro/Kqqf4gcbI8SeuTsZ7Ci
	2yQvLmwEg7Venl1tb0ufkKndfytHPbz0RSUrsgGQLabJm9KjwmF7fTglrxKLRKClqx+8knDEAwb
	e0kPrwhNVF/wQLAX6aFNbyBo6u+wLaUsVRINvJz1g7JTwCTvF4A7I4g==
X-Google-Smtp-Source: AGHT+IF2FUJm50SIImAtnkLfjpZxfOQ0V8XNcp8oj0UXtEvNIKIo/bW01pizDxqtXrEQGSaKXvDafw==
X-Received: by 2002:a05:6000:2f86:b0:3a0:b565:a2cb with SMTP id ffacd0b85a97d-3b5f1c67becmr3586044f8f.1.1752255825300;
        Fri, 11 Jul 2025 10:43:45 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm4954576f8f.74.2025.07.11.10.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:43:45 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:43:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, Christopher
 Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph
 Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil
 Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, Harry
 Yoo <harry.yoo@oracle.com>, Andrew Clayton <andrew@digital-domain.net>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko
 <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Martin Uecker
 <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski
 <pinskia@gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
Message-ID: <20250711184343.5eabd457@pumpkin>
In-Reply-To: <krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
References: <cover.1751823326.git.alx@kernel.org>
	<cover.1752182685.git.alx@kernel.org>
	<04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
	<CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
	<krmt6a25gio6ing5mgahl72nvw36jc7u3zyyb5dzbk4nfjnuy4@fex2h7lqmfwt>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 01:23:49 +0200
Alejandro Colomar <alx@kernel.org> wrote:

> Hi Linus,
> 
> [I'll reply to both of your emails at once]
> 
> On Thu, Jul 10, 2025 at 02:58:24PM -0700, Linus Torvalds wrote:
> > You took my suggestion, and then you messed it up.
> > 
> > Your version of sprintf_array() is broken. It evaluates 'a' twice.
> > Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
> > argument.  
> 
> An array has no issue being evaluated twice (unless it's a VLA).  On the
> other hand, I agree it's better to not do that in the first place.
> My bad for forgetting about it.  Sorry.

Or a function that returns an array...

	David

> 
> On Thu, Jul 10, 2025 at 03:08:29PM -0700, Linus Torvalds wrote:
> > If you want to return an error on truncation, do it right.  Not by
> > returning NULL, but by actually returning an error.  
> 
> Okay.
> 
> > For example, in the kernel, we finally fixed 'strcpy()'. After about a
> > million different versions of 'copy a string' where every single
> > version was complete garbage, we ended up with 'strscpy()'. Yeah, the
> > name isn't lovely, but the *use* of it is:  
> 
> I have implemented the same thing in shadow, called strtcpy() (T for
> truncation).  (With the difference that we read the string twice, since
> we don't care about threads.)
> 
> I also plan to propose standardization of that one in ISO C.
> 
> >  - it returns the length of the result for people who want it - which
> > is by far the most common thing people want  
> 
> Agree.
> 
> >  - it returns an actual honest-to-goodness error code if something
> > overflowed, instead of the absoilutely horrible "source length" of the
> > string that strlcpy() does and which is fundamentally broken (because
> > it requires that you walk *past* the end of the source,
> > Christ-on-a-stick what a broken interface)  
> 
> Agree.
> 
> >  - it can take an array as an argument (without the need for another
> > name - see my earlier argument about not making up new names by just
> > having generics)  
> 
> We can't make the same thing with sprintf() variants because they're
> variadic, so you can't count the number of arguments.  And since the
> 'end' argument is of the same type as the formatted string, we can't
> do it with _Generic reliably either.
> 
> > Now, it has nasty naming (exactly the kind of 'add random character'
> > naming that I was arguing against), and that comes from so many
> > different broken versions until we hit on something that works.
> > 
> > strncpy is horrible garbage. strlcpy is even worse. strscpy actually
> > works and so far hasn't caused issues (there's a 'pad' version for the
> > very rare situation where you want 'strncpy-like' padding, but it
> > still guarantees NUL-termination, and still has a good return value).  
> 
> Agree.
> 
> > Let's agree to *not* make horrible garbage when making up new versions
> > of sprintf.  
> 
> Agree.  I indeed introduced the mistake accidentally in v4, after you
> complained of having too many functions, as I was introducing not one
> but two APIs: seprintf() and stprintf(), where seprintf() is what now
> we're calling sprintf_end(), and stprintf() we could call it
> sprintf_trunc().  So I did the mistake by trying to reduce the number of
> functions to just one, which is wrong.
> 
> So, maybe I should go back to those functions, and just give them good
> names.
> 
> What do you think of the following?
> 
> 	#define sprintf_array(a, ...)  sprintf_trunc(a, ARRAY_SIZE(a), __VA_ARGS__)
> 	#define vsprintf_array(a, ap)  vsprintf_trunc(a, ARRAY_SIZE(a), ap)
> 
> 	char *sprintf_end(char *p, const char end[0], const char *fmt, ...);
> 	char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args);
> 	int sprintf_trunc(char *buf, size_t size, const char *fmt, ...);
> 	int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args);
> 
> 	char *sprintf_end(char *p, const char end[0], const char *fmt, ...)
> 	{
> 		va_list args;
> 
> 		va_start(args, fmt);
> 		p = vseprintf(p, end, fmt, args);
> 		va_end(args);
> 
> 		return p;
> 	}
> 
> 	char *vsprintf_end(char *p, const char end[0], const char *fmt, va_list args)
> 	{
> 		int len;
> 
> 		if (unlikely(p == NULL))
> 			return NULL;
> 
> 		len = vsprintf_trunc(p, end - p, fmt, args);
> 		if (unlikely(len < 0))
> 			return NULL;
> 
> 		return p + len;
> 	}
> 
> 	int sprintf_trunc(char *buf, size_t size, const char *fmt, ...)
> 	{
> 		va_list args;
> 		int len;
> 
> 		va_start(args, fmt);
> 		len = vstprintf(buf, size, fmt, args);
> 		va_end(args);
> 
> 		return len;
> 	}
> 
> 	int vsprintf_trunc(char *buf, size_t size, const char *fmt, va_list args)
> 	{
> 		int len;
> 
> 		if (WARN_ON_ONCE(size == 0 || size > INT_MAX))
> 			return -EOVERFLOW;
> 
> 		len = vsnprintf(buf, size, fmt, args);
> 		if (unlikely(len >= size))
> 			return -E2BIG;
> 
> 		return len;
> 	}
> 
> sprintf_trunc() is like strscpy(), but with a formatted string.  It
> could replace uses of s[c]nprintf() where there's a single call (no
> chained calls).
> 
> sprintf_array() is like the 2-argument version of strscpy().  It could
> replace s[c]nprintf() calls where there's no chained calls, where the
> input is an array.
> 
> sprintf_end() would replace the chained calls.
> 
> Does this sound good to you?
> 
> 
> Cheers,
> Alex
> 

