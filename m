Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D498130AC0
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715198880; cv=none; b=EraCiaqa2RF2p185/yUxEjBhiOD7DdJ4WGWwJPX5mI7jVwDlArFZU5AYyxyM6BMpa+4xsvFXCihOoTeZUICOXxeNAArY94SmaUvXT/7oKw70fbKB5egXK4Cjwtem9MkGBKnwL4GBWaXvFBidh8P3PoYhH9Kr4VENiBL72qm6fjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715198880; c=relaxed/simple;
	bh=cUhMA3hEDpUsxR6hzz85ZAu88LnRo8wpM9SADaguZmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soI23/AvyxqfU0EGA9ZSO1vJWkTXYESL7WnIOosPsUJO0Oxz/gLxtO/koPs+5URxRuQAgFBVJfFR8TL1U0dQEXxQTZapMTpJGcJ3qETQgVO0bfrIi804mmSWowEtYXuf9DiAgRKT51dXWqjdD6R98IoH178LNT9CKbsnrtwGZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c69RNwZt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c69RNwZt"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59b097b202so29334366b.0
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 13:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715198877; x=1715803677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNS3uukLqvQS7T/1QMyWRNid+5RlhH+5kk2j7s9gPHA=;
        b=c69RNwZt7i9rvNaTJ1H/ApakTxMtwE8yExIpP/CtkuC1Vy0B20P0ywr53temR2QQKg
         jdACnyFqju9aASG36FbnXPf1dYJNKn/02Miw6UQzvlP/QrxzkWLET/4pJwFzbi9Hy2GL
         QXAsWUsQRXWbv46329z5ePFvSpGtN6VHfB1EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715198877; x=1715803677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNS3uukLqvQS7T/1QMyWRNid+5RlhH+5kk2j7s9gPHA=;
        b=sbKrWJwsRKx/l2By0SIHDzbjwVF4bu4AwJC+bCSUfvPiSZ31jgaoGo405V/Casfrfz
         gRR06zrYnaEaH2P1qnB01FFoaJ/rP6TZ3R1Okh6IaJ9DMuOhq5/thF4HcJxvZ8yW7Vj0
         udsrF/vnK87SFpce0WQcdwnE5wgAAnlSYHI0IKuB9G/A4lmsbRmJB3pYVWIxuZe9NLCv
         dAH07gF73vQsndMHtR9hBjxerZKjWeHdbD7hKfcn65byFsOCBhbHwqCE6oLh2VpDMP/g
         No1OzVQm9tDysOcmWrwkEHlVB5yr3TQhPKC9cH6ntjW84shaPqwuj5rQYhLDJuq/jxOP
         gEEw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1OCOE7ZppXOmMIIwSDw2EHexmvud7ok+0w0mTz1/o3JhSrauQRNiTzUl9QVTJ4SLqc/DAk8W/xTRDoTCPFHSJLIyeYpu7+dpQ9SIeemN
X-Gm-Message-State: AOJu0YyqBzvCm5BHbwBdCNqjPOvGnINp8acg7hPyk9S1Z+B0TVoLm6o4
	z3tdp7od2hJGdyg6fG9uNEEMemz0owFYAZNATT8gRuQlOzYisxcq9NNZbvVmQXRY+D507YTGJQ5
	dufR4hA==
X-Google-Smtp-Source: AGHT+IHUsiZqCzFtChqklCpY6pcrG8A/4FkkoVsrX4BQog0tSAbuoydm7Is4y5e8dFmnNNx7RPjEYA==
X-Received: by 2002:a17:906:b851:b0:a59:c833:d272 with SMTP id a640c23a62f3a-a59fb921347mr220309866b.13.1715198876693;
        Wed, 08 May 2024 13:07:56 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906445400b00a59bba81e97sm4956841ejp.126.2024.05.08.13.07.56
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 13:07:56 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c0a6415fso32043066b.1
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 13:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBKYqv6oQFl+/EevOu6B6Zt9vFbOJb0nzT5YvWC/oOQ2MUUnHx+L5eA0kJN9MXqgsLZF3cZZyDxdLGY5Ek9W3spWirN++6q20juB5ENTsB
X-Received: by 2002:a17:906:74d:b0:a59:bb20:9964 with SMTP id
 a640c23a62f3a-a59fb94b8f0mr259835466b.23.1715198875937; Wed, 08 May 2024
 13:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
In-Reply-To: <202405081144.D5FCC44A@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 13:07:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
Message-ID: <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 12:45, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, May 08, 2024 at 10:52:44AM -0700, Linus Torvalds wrote:
> > Example:
> >
> >    static inline u32 __hash_32_generic(u32 val)
> >    {
> >         return val * GOLDEN_RATIO_32;
> >    }
>
> But what about:
>
> static inline u32 __item_offset(u32 val)
> {
>         return val * ITEM_SIZE_PER_UNIT;
> }

What about it? I'm saying that your tool NEEDS TO BE SMART ENOUGH to
see the "what about".

> All I did was change the names of things and now we have to wonder if
> the result is going to be used for indexing or sizing

Exactly. Your tool needs to take that into account.

Any kind of mindless "this can wrap around" is inexcusable.

It needs to be smarter than that. And yes, that means exactly taking
into account how the result of the possible wrap-around is actually
used.

If it's used as a size or as an array index, it might be a problem.
But if it's used for masking and then a *masked* version is used for
an index, it clearly is NOT a problem.

IOW, exactly the same as "a+b < a". Yes, "a+b" might wrap around, but
if the use is to then compare it with one of the addends, then clearly
such a wrap-around is fine.

A tool that doesn't look at how the result is used, and just blindly
says "wrap-around error" is a tool that I think is actively
detrimental.

And no, the answer is ABSOLUTELY NOT to add cognitive load on kernel
developers by adding yet more random helper types and/or functions.

We already expect a lot of kernel developers. We should not add on to
that burden because of your pet project.

Put another way: I'm putting the onus on YOU to make sure your pet
project is the "Yogi Bear" of pet projects - smarter than the average
bear.

As long as you are approaching this from a "this puts the onus on
others", *YOU* are the problem.

Be the solution, not the problem.

              Linus
