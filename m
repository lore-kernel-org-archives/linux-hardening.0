Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4D1487CE
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972082; cv=none; b=FC202qPc2xIDlU3DVd/VuvvDWPDcRB+oDoO0+3gQII6ZEN7oWviQ10d+FYreZir2VlQ5b5w6/AkP+zW7tm8Wl8WpDW/SXRlJ9QRCfwrqJ2zMZeLQ9dxrqGtCr8hHmI5Or32n9WmGt4DQPaFK+SizdoV14k2kVaAQ25/nsDl1Ymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972082; c=relaxed/simple;
	bh=uDChScHA8/keZbVJoSWpHzwdBcCCYoYhS7GeA9recLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnUzc77HRBOFPhF8vLArLHSGZmntfbXNvfiCybamk1uiDYJeO6nClupTdsUAIZ8zzr7UOO5fEUmE5hNq74jM45OmuJjTWqpKJmJ5Y5rxbVJUkSwkXfVMZWPUl28CY7GVGa7eskmLWlJXKfv+XKh78Nfjdp3MB4aNHUIchpCuILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hyJk89p0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hyJk89p0"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e759ece35so3655543e87.3
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705972078; x=1706576878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FqBTpX0vWqNsF5lS1C9n4e9u8Ca0XIeIP2mzdNVJ8OY=;
        b=hyJk89p0lr7D4H5IFrTlLMSqx0IE3sCmggufqrn8Dc2/LW9zYTjwJxt+NIHMocrV3e
         YtVei/DbgGr5T4XeTuBl9VUVSXTXVwvessH2G7uIgMYY2Q6EpqaR7ZKegGwEAD6ZPkXN
         heto7ZrQk0iB8EK7mOUUgiRlvqR4LIEWayrQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972078; x=1706576878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqBTpX0vWqNsF5lS1C9n4e9u8Ca0XIeIP2mzdNVJ8OY=;
        b=T2rJNmUhxLP/42UI0rqsokTwyYNhxFuOvh/h+mKlnyTKgHbWupehyYVdaZuN3JOLa2
         8y2zAmwZerNpl3NBdk/CWzd48k7OtYbZH3Ib2KUS3W7ksLZbjDpQnLbN+52vN6MqnuHt
         2ipsAA5iRQ/N1O364y05+e1H5VJ1OGgfoPWh+EobhHEfKlV6OCBdyX01lMYwxIfd9V0e
         I88KTxaRLRNH/AhBVDI/8WGVueC0gZeAw+uL/ILXvQg5cEPbULNI8hfGtz+z6jlrKHM8
         qBmpXYXfvGUeLM3FHV68vAinGMMF4Lh9kfecfr+4ozKi0ZSJML/jHhZa4wG5WX/hHjy3
         Wmgw==
X-Gm-Message-State: AOJu0YxdYKFcvXbCeNsNZ7v07fnPtWgo/koiOUj3bWH8ZtNbC/ZtLXgT
	wPETzkxErTsQ99v52tMldNSRkzApA0yM9ReHbP7T7qTFIHNk98w6o66EExFctwIffufy55ohpYT
	4A6Thug==
X-Google-Smtp-Source: AGHT+IG8acgP+Fe/PS8Uqi5kjukxTTBNqwtXIVvPdFJjapHn90YPSwlQBgcRVOORqubxOx9YO9tGKw==
X-Received: by 2002:a05:6512:1304:b0:50e:d505:112f with SMTP id x4-20020a056512130400b0050ed505112fmr2415501lfu.82.1705972078301;
        Mon, 22 Jan 2024 17:07:58 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id fj21-20020a1709069c9500b00a2da3bbeb4esm10427694ejc.26.2024.01.22.17.07.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 17:07:57 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-559edcee47eso3179880a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 17:07:57 -0800 (PST)
X-Received: by 2002:a05:6402:14d4:b0:55a:553c:a987 with SMTP id
 f20-20020a05640214d400b0055a553ca987mr474350edx.79.1705972077074; Mon, 22 Jan
 2024 17:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-34-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-34-keescook@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 17:07:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
Message-ID: <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Brown <broonie@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Vasily Averin <vasily.averin@linux.dev>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 16:46, Kees Cook <keescook@chromium.org> wrote:
>
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(),

NAK.

First off, none of this has anything to do with -fno-strict-overflow.
We do that, because without it gcc ends up doing various odd and
surprising things, the same way it does with strict-aliasing.

IOW, you should think of -fno-strict-overflow as a hardening thing.
Any optimization that depends on "this can overflow, so I can do
anything I want" is just a dangerous optimization for the kernel.

It matches -fno-strict-aliasing and -fno-delete-null-pointer-checks,
in other words.

And I do not understand why you mention it in the first place, since
this code USES UNSIGNED INTEGER ARITHMETIC, and thus has absolutely
nothing to do with that no-strict-overflow flag.

So the commit message is actively misleading and broken. Unsigned
arithmetic has very well-defined behavior, and the code uses that with
a very traditional and valid test.

The comment about "redundant open-coded addition" is also PURE
GARBAGE, since the compiler will trivially do the CSE - and on the
source code level your modified code is actively bigger and uglier.

So your patch improves neither code generation or source code.

And if there's some unsigned wrap-around checker that doesn't
understand this traditional way of doing overflow checking, that piece
of crap needs fixing.

I don't want to see mindless conversion patches that work around some
broken tooling.

I want to see them even less when pretty much EVERY SINGLE WORD in the
commit message seems to be actively misleading and irrelevant garbage.

Stop making the world a worse place.

                 Linus
