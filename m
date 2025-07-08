Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B81E5B91
	for <linux-hardening@vger.kernel.org>; Tue,  8 Jul 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982676; cv=none; b=CBLXz+ghvi5MRCyJK8iWnQK0dqw6PuxYkgnnKO6KX5OO3H9wdSn6nNziQdvCkgZI5Hpz0y1GOlF4F6O75pGt+hsd3bvxU3E4XbAwRztP8X+7KDRkYZd9Qs5bP9fwd1ez5TWz4akapDufDzwcr+Koi3+B8Vag9C/led0mOhWBio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982676; c=relaxed/simple;
	bh=qkHV+oubYu/O5KpKB/TIsQpLDj5mKUNq2idhGzy+r7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdNYHpdsY5hYPTqnGThiDXWGrtfBlMwk+0Ee/di9BD7lRi6LWtRWbE0wlPAapthJAqNMQpL6u+x/ALrXNa2b2Rl195de70rrGah4o3n3oBNmQnjeNDaHuzf5oX5SmG57wVhXJhSlvr5jPzgqmMsLmI1UAdd7SjdKHb3ffho4pYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=MBlRUTly; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MBlRUTly"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-553d52cb80dso4055791e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Jul 2025 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1751982672; x=1752587472; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31MqR/E8gvc45qHOvdbZr7UXtdSXHcy53Qh8ZwjxaD0=;
        b=MBlRUTlyH9cxaYU2jSw6vYHjJysk670xKuSrcsrt30nXStnUHx/1DBAyNfDbjxG4Be
         sM1cghaj64PrdF+wd3jieeqiXODHrgk7HH2AmdmRU7nP0AZ9DnY9O9Vi4xdTv6xQOzmU
         zksgurKCsDTu/uUJxP6mUN7N8I2WWEtfRCY5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982672; x=1752587472;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31MqR/E8gvc45qHOvdbZr7UXtdSXHcy53Qh8ZwjxaD0=;
        b=kfhM66frK2vIn5wTsdnQ+sTWiNMcl9eA6W2xJEljdj6IXBI60uEPmGOmL4HzP26Oqy
         +V5IbZKnnRbydXpAymbb3sib4oTpXvppM6YGyHjKikyqvcpH4sbNM1bUL7RFX9BzgbVQ
         DpI9ThFLI95oRhHil2h4NrYPUz9DKJN2X9FrheBW4/abWTTeMiUREBW6iEJTa708Q7dV
         h7dXJbwCiu0PZKQgJEUiknRlVgIUN1gGb1z4tSq5rlrr0FQbt0kRsWYPUTQh1hx5z/Rq
         LZWZhTgU5wgYtllHQdm+X/hVjK98bSJ6f/thUWVI1u/i1DXxYdEov1wVP2TxaOPJ0HBv
         c5pw==
X-Forwarded-Encrypted: i=1; AJvYcCVpDXCZU9NTv72VIPAPE4d4zPjBrjov+fiMqYXsiZlwAJ2jvV+jdD0694EcN0eojYiqUZ/tSnq5xA6L7hxrph0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8n18lZ2lbdoGYCm80dt096tbIvKqNGEFP5N/5vEM0NF6nSnz1
	TYfo7xkHSuNhFqhoU/WXCnoqseDjI7u597N5Otmqw4KY2PIOCkytm5ADWYK/hfij+S9tWBEK7/C
	7Fbe1684=
X-Gm-Gg: ASbGnct6InZ5M8DeQ1dCebCzUdiTcysrJbXN/ub6G4uIevi9uTqM9SIx4sPlG1mzPg9
	njC9sguXFidzXNHic3xy1fqvpcI+apj20a1Ibxqzz8+qX7zkVS+csSxgXlWLwsQrat97K/nL9Sf
	e2I9ta92XZ1B3y8ZCwXwk6O0+l3/UX8EWEVAmUPR0Dy0ORidHaGbzRSltlbelK4TA4BQKQyzCQ7
	hoXAQadNRBBM82eDYu2V2qm3SBc8GgSNwX4x9aeFDYpOnSLwt7He4hPa/2TKqUkJU80IlGcktTr
	YrfZqey8K3vBVhUGovlaAaLU98ziv2sJj6LM9J3nPImcEuGgn9QGd2T9xp8Hck1a
X-Google-Smtp-Source: AGHT+IGAGFiZWkwFnSiMkLwKey/goUWPwP6l7a9KOAhmvZ6IpsJt6jVgzyte8sMjjpbz+51yLmRVhA==
X-Received: by 2002:a05:6512:2381:b0:553:2308:1ac5 with SMTP id 2adb3069b0e04-557f8d6a9efmr1017578e87.4.1751982672246;
        Tue, 08 Jul 2025 06:51:12 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-556384cdf6fsm1699987e87.242.2025.07.08.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:51:11 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org,  linux-hardening@vger.kernel.org,  Kees Cook
 <kees@kernel.org>,  Christopher Bazley <chris.bazley.wg14@gmail.com>,
  shadow <~hallyn/shadow@lists.sr.ht>,  linux-kernel@vger.kernel.org,
  Andrew Morton <akpm@linux-foundation.org>,  kasan-dev@googlegroups.com,
  Dmitry Vyukov <dvyukov@google.com>,  Alexander Potapenko
 <glider@google.com>,  Marco Elver <elver@google.com>,  Christoph Lameter
 <cl@linux.com>,  David Rientjes <rientjes@google.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Roman Gushchin <roman.gushchin@linux.dev>,  Harry Yoo
 <harry.yoo@oracle.com>
Subject: Re: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic APIs
In-Reply-To: <ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
	(Alejandro Colomar's message of "Tue, 8 Jul 2025 13:36:57 +0200")
References: <cover.1751747518.git.alx@kernel.org> <87a55fw5aq.fsf@prevas.dk>
	<ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
Date: Tue, 08 Jul 2025 15:51:10 +0200
Message-ID: <871pqqx035.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 08 2025, Alejandro Colomar <alx@kernel.org> wrote:

> Hi Rasmus,
>
> On Tue, Jul 08, 2025 at 08:43:57AM +0200, Rasmus Villemoes wrote:
>> On Sat, Jul 05 2025, Alejandro Colomar <alx@kernel.org> wrote:
>> 
>> > On top of that, I have a question about the functions I'm adding,
>> > and the existing kernel snprintf(3): The standard snprintf(3)
>> > can fail (return -1), but the kernel one doesn't seem to return <0 ever.
>> > Should I assume that snprintf(3) doesn't fail here?
>> 
>> Yes. Just because the standard says it may return an error, as a QoI
>> thing the kernel's implementation never fails. That also means that we
>> do not ever do memory allocation or similar in the guts of vsnsprintf
>> (that would anyway be a mine field of locking bugs).
>
> All of that sounds reasonable.
>
>> If we hit some invalid or unsupported format specifier (i.e. a bug in
>> the caller), we return early, but still report what we wrote until
>> hitting that.
>
> However, there's the early return due to size>INT_MAX || size==0,
> which

First of all, there's no early return for size==0, that's absolutely
supported and the standard way for the caller to figure out how much to
allocate before redoing the formatting - as userspace asprintf() and
kernel kasprintf() does. And one of the primary reasons for me to write
the kernel's printf test suite in the first place, as a number of the %p
extensions weren't conforming to that requirement.

> results in no string at all, and there's not an error code for this.
> A user might think that the string is reliable after a vsprintf(3) call,
> as it returned 0 --as if it had written ""--, but it didn't write
> anything.

No, because when passed invalid/bogus input we cannot trust that we can
write anything at all to the buffer. We don't return a negative value,
true, but it's not exactly silent - there's a WARN_ON to help find such
bogus callers.

So no, there's "no string at all", but nothing vsnprint() could do in
that situation could help - there's a bug in the caller, we point it out
loudly. Returning -Ewhatever would not remove that bug and would only
make a difference if the caller checked for that.

We don't want to force everybody to check the return value of snprintf()
for errors, and having an interface that says "you have to check for
errors if your code might be buggy", well...

In fact, returning -Ewhatever is more likely to make the problem worse;
the caller mismanages buffer/size computations, so probably he's likely
to just be adding the return value to some size_t or char* variable,
making a subsequent use of that variable point to some completely
out-of-bounds memory.

Rasmus
