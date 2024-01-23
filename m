Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B47811F9
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033194; cv=none; b=KXXBM8X/YdSzjcqeQAx8s8pyofBPjNrm9KxPfLZQGPmSHFGeBvDVp9EXRAQnTShK+9aLGaPPKWDfrfOYLRImb6CdlCC5nZYDQRCeEj0MoB3RBiubhZWK8tX7QpdyoIZbTI7GNjiVrVhkHlE4zhc2sKLnceVAqIq0nAiseoPH4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033194; c=relaxed/simple;
	bh=DSKd2JcJ2/mza9EM+Xnm+jdVYiFpr3Vkuf4kEF/SCIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNBOifAECOqZCM5Fa0yWiDOn7eaNMIuDIliOX2oEftKK9khXPfvCYcGUSiXryopLIFLN9PwVhT+YiR6oaicDpoBjoO3lTqs+hNqO5247GwvvUnYLCPV3dUrR0OHtwhPvk8QqtMmKmxAu2FyTkkWVLIR2eE2zNkBHxMQ2cjFYWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SXl8Q/ec; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SXl8Q/ec"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso2438235a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706033191; x=1706637991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPOVFQl2tkZfe3QyiMSbVqeq8qtXQuoltOLEZXEAb4Y=;
        b=SXl8Q/ecMZB/UMQysXz88PMxEHev6hL077NpL5gsMW0TCuAY6Qi4bOPVjKrRIksIgR
         x2PfsxlrYyrbtec2IZKHXirj/fN+YmY2ITshai5EaHMNKEezjye6HWUsAwvkgJ6KEQ1Y
         wkDBxgZphwqfTAI2QGvHisqkiDS+3EfNAzQp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033191; x=1706637991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPOVFQl2tkZfe3QyiMSbVqeq8qtXQuoltOLEZXEAb4Y=;
        b=AdlLLKeyq3eU0SBi6V1z4uC45vEeDRrAYnwx8QTXksPsOJsRMYPOeCdLw3XHfjvp/+
         q9FfbdICbcRL/YQ9dQ5V/Hy6vVo+p+6ljSFKO78hN7MNgKcFX07EXzoqEqYh1BnY9Tpr
         /Vl2D5UW8AZTyjwUhj6ZLXuFXH4uzbN2h9f0ELIjOPhOenUxmM21YkhwKrjp/wRqv3U7
         VmmSlzAGbNXy+Gz01Em1kjqJ3M4p71l95vLDCR8d+xTkzIWW7e2Q/PHvOwnvI+vXLmFE
         kZVzwaFpmdPB7cu0rquNJA9P03oLYixdVdcEOGJcZxlEkgoK56G/+SKziGZTSbd2iXR7
         IZ7w==
X-Gm-Message-State: AOJu0Yyq/XAgbl//SpoYQqPFxuXakyb06zYgyQ3C2Tf8BU5TKaP+H33d
	SAJBQB34NIwFYUi1Cu37cdwJOSy7RQ95VaMyejY+Uxxfn4Qu7NvGHF3QiMRvHuIwbF4KtYJUIxr
	uFG8BuQ==
X-Google-Smtp-Source: AGHT+IEG1nTIedtnzhCe1NilhjmxQcyzXiUnoYfZZIwRzPhqOHHQHM8T7rw4Yjob/VImvee/Q7XCsg==
X-Received: by 2002:aa7:c403:0:b0:55a:45b8:1e3a with SMTP id j3-20020aa7c403000000b0055a45b81e3amr1180250edq.32.1706033190635;
        Tue, 23 Jan 2024 10:06:30 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id cn7-20020a0564020ca700b0055c349e04f8sm2741242edb.36.2024.01.23.10.06.30
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:06:30 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ea5653f6bso43304825e9.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 10:06:30 -0800 (PST)
X-Received: by 2002:a05:600c:42cb:b0:40e:4ab9:70df with SMTP id
 j11-20020a05600c42cb00b0040e4ab970dfmr368030wme.245.1706033189635; Tue, 23
 Jan 2024 10:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-34-keescook@chromium.org>
 <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com> <202401221713.3FCABC9290@keescook>
In-Reply-To: <202401221713.3FCABC9290@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jan 2024 10:06:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>
Message-ID: <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mark Brown <broonie@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Vasily Averin <vasily.averin@linux.dev>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 17:38, Kees Cook <keescook@chromium.org> wrote:
>
> I've tried to find the right balance between not enough details and too
> much. I guess I got it wrong.

My complaint isn't about the level of detail.

My complaint is about how the commit log IS ACTIVELY MISLEADING
GARBAGE and does not match the actual patch in any way, shape, or
form.

It talks about completely irrelevant issues that simply have nothing
to do with it.

It talks about undefined behavior and about a "unsigned wrap-around
sanitizer[2]", which is nonsensical, since there is no undefined
behavior to sanitize. It literally gives a link to a github "issue"
for that claim, but when you follow the link, it's actually about
*signed* overflow, which is something entirely different.

And honestly, the patch itself is garbage. The code is fine. Any
"sanitizer" that complains about that code is pure and utter shite.

Really.

If you actually have some real "detect unsigned wraparound" tool
(NOTE: that is *NOT* undefined behavior, and that is *NOT* a
"sanitizer", it's at most some helpful checker), then such a tool had
better recognize the perfectly fine traditional idiom for this, which
is to do the addition and check that the result is smaller. Like the
code does.

See what I'm saying? The patch is garbage. Any sanitizer that would
complain about the old code is garbage. And the commit message is
worse than garbage, it is actively misleading to the point that I'd
call it lying, trying to confuse the issues by bringing up things that
are utterly and entirely irrelevant to the patch.

So:

 - get rid of that commit message that is lying garbage

 - fix the so-called "sanitizer".

 - stop calling the unsigned wrap-around a "sanitizer" and talking
about "undefined behavior" in the same sentence, since it's neither.

Do you really not see why I think that thing is actively *WRONG*?

           Linus
