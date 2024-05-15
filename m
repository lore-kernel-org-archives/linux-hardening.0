Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3124AEF8
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793155; cv=none; b=RIAQnUtmApbW3ydIolKiOqeznwo81IXutNO10phRhtCWT7ZEs3erqYriMANqgBIbcLfUFh0l1Su+C/RRIm8KvbMsRbpdOowdLfFjafsvJDzCrsh7uSs1Hy/DRIeDu5CTpkStAnAqVzd0qtC18pFfI3urZlsl27OOLiEzX0Xch3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793155; c=relaxed/simple;
	bh=sFdFO/3PseRV0I24tfvAl/Tu3SeNdZ+dYLb3bjXAJu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWsRfcOTdRbYBOt/Wpm2rd1qyrE2qlgshoE8CZ+Cw4q4hnM8aS+LkbLDw1KxjoshcXwhjzo6tpf07MugOVsGIug1lUOf7f21Z2NMm0WnDWwXXAX9JmzWSNKuWr0nTbKAmH1STV/gbH01Wu5GnrF2jcqxCeKonOYhPuvPbBIofjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSIZ8j2a; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSIZ8j2a"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23d3d092a1bso3864363fac.1
        for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715793152; x=1716397952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFdFO/3PseRV0I24tfvAl/Tu3SeNdZ+dYLb3bjXAJu8=;
        b=QSIZ8j2aBzKVx6dFzUgfgxy4FxbPy1RzZSOEF/YtKW5zI2kRPd9V9sXohfMKvvfGnh
         LIAUgBErOhh9hf3cRKmJ1+CU/v6SuBPWFzseVylOOzQSCUiwEIZ2YAmjbqcr5EGHovNV
         PglXLUOMIKQXEVZb7WgTrELqyRLZEwPJuH7TBACQb9UMCBcvYp3M9yWB3/vUduOwqVek
         SMzSFUplHOgX7RvyTB5JlDn9Qt5/1/nElbYNG9wl5GEx/T1Q7xVU37CBEb/+wbPONmV0
         g8VLgj3E5xsZuWd+DtjDvl4TEy0pmuMro5lqnnOuOnr+ymxbu1bOuA8lXIz7DYTqj0QX
         UdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715793152; x=1716397952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFdFO/3PseRV0I24tfvAl/Tu3SeNdZ+dYLb3bjXAJu8=;
        b=i7bHbNY70ZDwASsf68vUQYn+MVjYcnoFjz7SZihuuBiWHtSAsn9nwMPOklJVBvZfoC
         dwaZ5eaH1DcztgNhp+HE0OiNTdl5Ao6Wez7dXfKLhZkUWz+fHFGzIA5+BRrJakfONmE2
         qST1D4G1lDlcOGl6CAan5ozx1pZB7YI3LR0kcynZ7o3uvL2w6ihlzuKAdzbom6oMXuVE
         XbuYHuEL6CrEJEvFIc8VmnkLhoY5qcunuaByke4wftWsfom3ArMYr3oychyHH1Jid3ol
         JDffkGMsndVDzXPVNfdAtY2lgPUXU5GR5t6uytbwy2htIhiq860By+y0bCJivJQ2prmg
         oeFA==
X-Forwarded-Encrypted: i=1; AJvYcCUov3WOvmsQ0ILKc/ANfHB5ZJ0uFuPtGtumu7k4hGq8MwQP3b0yL6UBeaC3LnmEOLRTrH2TgaSwoigddYcP8GoQdmlSTQM14Wnb739CMUNw
X-Gm-Message-State: AOJu0YwGN4+qv3CUTsC98mF6jbwPmrUX8BOggdLvxlpDPpQP0NcP1RqC
	+LWhxC+KPngko6sLTx0XoNxZzJoyb3PzCOx/0E45ZvaveZlQ+1rFigA0t6qtbI7CZrfYv7pNYua
	VfESavCRRF7TBx7SRww+84zExy4KLhMcXhqMq
X-Google-Smtp-Source: AGHT+IHdPnCg97tJxWZG1Gb/DpWshKQCgosn26p/oXEI08Q9kC9bnAhNtdBzk1KnL1lvOIiK1jkJOT92D0YO6qHuMVs=
X-Received: by 2002:a05:6870:1690:b0:23c:ee0a:260f with SMTP id
 586e51a60fabf-24172a23552mr18594820fac.3.1715793152544; Wed, 15 May 2024
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515073636.GY40213@noisy.programming.kicks-ass.net>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 15 May 2024 10:12:20 -0700
Message-ID: <CAFhGd8qKObvqbLJWvkG+Wfuy0gpWiTsSmFrBO-NzC-akB6bhzA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, May 15, 2024 at 12:36=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, May 08, 2024 at 04:47:25PM -0700, Linus Torvalds wrote:
> > For example, the most common case of overflow we've ever had has very
> > much been array indexing. Now, sometimes that has actually been actual
> > undefined behavior, because it's been overflow in signed variables,
> > and those are "easy" to find in the sense that you just say "no, can't
> > do that". UBSAN finds them, and that's good.
>
> We build with -fno-strict-overflow, which implies -fwrapv, which removes
> the UB from signed overflow by mandating 2s complement.

FWIW,

Clang-19 allows -fwrapv and -fsanitize=3Dsigned-integer-overflow to work
together [1]

And the sanitizer was re-introduced with Commit 557f8c582a9ba8ab
("ubsan: Reintroduce signed overflow sanitizer").

>
> With the exception of an UBSAN bug prior to GCC-8, UBSAN will not, and
> should not, warn about signed overflow when using either of these flags.

[1]: https://clang.llvm.org/docs/ReleaseNotes.html#sanitizers

Thanks
Justin
