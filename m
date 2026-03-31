Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1F7317150
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991133; cv=none; b=ejaZCdKfSJd1LW5VI7Y/6KYyxw0d5vrh12TmhJSxjDJYCOVubAPvHWvMp5f8Gtcj/BeTwUtJdCWZzIozU01qxtKC9KBOYxHqf0Eo6j8yoVcx/RECb6+lqQpI8Z6Ek7NbJugz+kJ80JgswNWFXPQ9LBrrWULlSDmheg93gvCmjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991133; c=relaxed/simple;
	bh=JdtX1HxX10vKkEIJTgN8UNt8Jx8wkMFYsFGA9S+Pp3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa4Zqm+21Z5LZZU4hAd2G6ZhDbtCbMK3vU1gklHcsAjG2Lw51Bs1d/xyAnB4Hi2N0Z96O0PsFZ7+nACkqZKQVyhoMjwQUqK800/01/CKtmqDqH5MAaDZK3zhbLi+Se/R6Uz4WKhd4PF1Unq51dkBgslQ7TSc0somcAfvhgvINg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dxiZpzWQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dxiZpzWQ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso9088749a12.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774991130; x=1775595930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dPaiD4OsZpalA+NXE9JYeLKvQIkP47+Rdll9Ghzi+s0=;
        b=dxiZpzWQb/VnAe2xpjxbA6oaHyfuyWnaEtQJgl+MlX4ElA1YGpCG506wVITAMWGHwK
         Ej+QIQV55WyVebPOwDRakg+8nV0RSH+UQnhtZNaSgNoyQ0uxvISNVTJbp7CpYrKUlPtK
         OsdUXK21lAGyBS26Hu0yZpFZoS9YAkjcz0bBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991130; x=1775595930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPaiD4OsZpalA+NXE9JYeLKvQIkP47+Rdll9Ghzi+s0=;
        b=iLguTdRXj7CXhuZuqfLWVOYBkrJoCtNRS/Pr+L5CG2NbMy3nDmwZn2vphwpqTAvmuL
         9uIELZLcpnvBnzq3JBfSPRnP3uEnY4vYdpXSZlPHFiapXhQhhXiRTz3I4xWh/yd2BgP8
         aYfDuApBz4cfrQLx7fiZ+XuN5ekKFuYx0BlUtZJzkzYzvz8PO/9Nxq4egk2nZcYJPDkb
         k+MKkOM4TxNCtobjtsBbHvkPHN5J0bOZkvVjQf8qTyODVFVqZjEIWCyf1qhwURBVZXlk
         A2BmqiiHTNTMRFiid7wZnuL4wfDo89J/VgkPsumTf69TkIvwhEdFDFO77pZiymIjKwF8
         /w9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQD/4AqzjCDi2pQu1eTdvHd+0jtGmgd9kr5sPZsX7wilH41V5t0QRe9dCzUO1Lq/nQml3SG8O+h+krVrOxovc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu83jUsTsRiH3GDE/WX5H4Um/EGkQlf6zSKnRXWpZvhZUD/V2y
	+12WEjFulmWzc7/yu67if0z7y0yorvTeqxmO2Entzxb8MsJcCkNYZLBHkzHBcMUDzz9dIQ5Ob5D
	GQeZTRqtm+g==
X-Gm-Gg: ATEYQzzwjMJN8phHD9F5BB+5P41iiCKCm0D6NrpT13D0QpakQlSWK76ce+VLvmNsmfa
	nMmJpgY122QVILosU9IiLz7GUF8H7SjEn5jNd11YQyQWkyzUlhRaXHXN8gbeSYEmpTdl7ujAr8L
	tRhCyAYE0/dSZUGvIFJ7n5UKCIE8X67cFCIj4hOx0qVSowytMQyMvBNnBXGfOh9r4huU2p29gjc
	hkMXq5Ocn6aM+1DTcYSndr4FDiLiEUKcPq3ItiCzwmtCDjAyWo2/PXpCa8gVJoWmPhkvNea5+6C
	E0UEywBXULELEebHbLqmDYX/cU3WGLXgNnVBKr7XOi27k2wS0juXVxCaoWJnsShCuuJRJJwT9PB
	+lVX8uA9I/Kg051Xk8m2BD1FMYkwrSkY1W+X5JGw0+Q1ZA/UsTkWZUjYDAMSCXYwO2rGthMUJ82
	AhzoIXbAtZbTEw/HaKDcdlzdwzs86GBC8x7HIbR98I8rhY+V2coB6AF74V5AEpzN4Y5yNkAaUc
X-Received: by 2002:a05:6402:210f:b0:66b:3dec:e440 with SMTP id 4fb4d7f45d1cf-66db9efd254mr651178a12.26.1774991130049;
        Tue, 31 Mar 2026 14:05:30 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b75ba970esm3962060a12.19.2026.03.31.14.05.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 14:05:29 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66dd0531d01so196739a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 14:05:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0u7BPWdw9le/bjRl5QdnK3vwoobSBWIRru3xUKXE4GKjZ2FQ+jxD5Z0ao4C7tgiiaPxc8zFFdlBRykRJavSQ=@vger.kernel.org
X-Received: by 2002:a17:907:84d1:b0:b9b:1b9f:8397 with SMTP id
 a640c23a62f3a-b9c13b0a2a8mr62577666b.31.1774990733647; Tue, 31 Mar 2026
 13:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
 <202603311253.95C54588E@keescook> <CAHk-=wjSOGaausLeTD13yAqso7qM09EnkDFiN7wF15kH0VWmZQ@mail.gmail.com>
 <202603311321.4EE9FEA@keescook>
In-Reply-To: <202603311321.4EE9FEA@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Mar 2026 13:58:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9pWsgsbrLDOk7ipKnHbz3JvuqsmQ3DhGg-OKgKS9DUA@mail.gmail.com>
X-Gm-Features: AQROBzDlSIWhA3UXAi4kJQxb1nvYqS4u6S5fbtJpBgdW6doJTV11HfE6t_3dlps
Message-ID: <CAHk-=wj9pWsgsbrLDOk7ipKnHbz3JvuqsmQ3DhGg-OKgKS9DUA@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 13:31, Kees Cook <kees@kernel.org> wrote:
>
> (Isn't this just an implicit "try"?)

Yes. And I think that's ok.

I think try/catch is broken for a few reasons, but the fact that catch
and try are tied together so closely is the main one. You can't "try"
inside a scope without having the "catch" inside the same scope.

So then the solution is to just move the try to the outermost layer,
and I think that's pretty much what everybody does.

But at that point, why not just move it *all* the way out, and make it
implicit and invisible?

Which is kind of exactly what your suggestion is all about, and that's
why I like it so much.

It *literally* fixes try/catch. It makes the only really valid usage
model just work better.

(There are other reasons I dislike try/catch too, the whole
"exceptions across function boundaries" being another one that your
model avoids).

                Linus
