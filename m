Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896131B0125
	for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669567; cv=none; b=uKe3fBHP7RIlgP9OH5KNEFWrQormLoQ0nKCwAgPz+GOaKUfb8LQXLsXqjUCtgudncXDlaDrK0ETooFnGhVCOXl8QnyQn6O5p6TysSVCFI8oYXrJB5oUw+uGQSUHqEUx1NKEugebqG53uF8YoyOm/0fJkMZt+lXInr6EeNnAIOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669567; c=relaxed/simple;
	bh=H0/+AlUrAVPwZVlgF2f63uEjQjWCVEgtVgFPVQf/v/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fc/IenWE8dIllGTlfFsfX3I/m3jmdIa+YaeVsB3/BQjYgpd5W71VTxaw6rQRIVhjsaDaezsy7quSiDalodmdUTjuFaRW83gdHYw8r/SGsH6eGYLTCaglvErEGZ5jiMecsDPHlHwqE4WHuQPoztvTgLseQFZy1vdN+RiQX+6opa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIoQjUka; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIoQjUka"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-492aae5fde6so124542137.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669561; x=1724274361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZKLox5eS3QRtbNUFn2cEECTACt7m3r5KD0Nhy6dpnY=;
        b=PIoQjUkaZMMbJSEh/9MnK+4/o3s3bO78a/qkPf0LSYHYnHvAvxXqgE/grNm7bE5Uvn
         338bOm22SrpSJxC5tOf6pr1QBVoY3mZAgPeTDLRC1tYGuHuo0otOSS97rGLzsjKlwL+A
         Cf4gDTmwe8Lmfj8Fw/e1NkWY/1jHF5cTLg0clJ9/bA6uDmNYxYBYz9Wybpn4rkbHGUsW
         fHYarNIB8TqhXF7uORD3pxZ20Q+RxAuX9eQFBLFYDSwHhGCPGpebZl0S3L+ZBW0JJSJx
         VXOGhBdjG1npttT2dH49F5CCEAD0OMglRGR5ZKrU+8Y3UnofyhquFFBjaOQ3MwSjgZup
         8cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669561; x=1724274361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZKLox5eS3QRtbNUFn2cEECTACt7m3r5KD0Nhy6dpnY=;
        b=Gaw48QiqQyoFkiJeWkzc5Nas72Ub3ou55Ihw/k5SBKc8ui0lIYwdAJ9NmhZDtnayY5
         VrDkZCdDVTHgKxNY10doIjbSQqs2dSu9UQmtvjvz2ttqTgoUYAwLj1FQb6Tid3ox1zat
         w4/cMZjlPgz7Do67c2KOGz/IaKY+Bmh1aIB/4EmLovc4xEMf3n/fO9/L+vV5A4ExXS6n
         crCT5JWdoWdnsYDCyVJ149gd/XwN4+0Su+ReCsx02FRGeLyy6NpFfSujCK0DlGMmC50y
         KLQLvwttGrd1+phgSosrQbPB3ItiY3cjQfNIWVYvbmV2wgLU62XCzDgAB7chOwuuoIuU
         8q1g==
X-Forwarded-Encrypted: i=1; AJvYcCUNE3HY3Ko5Xt2OokpWCQOnETRO8KkS95Xl9b33Jdl8/F5hmFYUC6tXhavVnR0y3c7wMqvKvhIopnizQpwFOAtdw0EWim5BEqCuOTwf/ezb
X-Gm-Message-State: AOJu0YyunYcY2jEPHrf+pwhERb4xdq9YbjHunAzc8xytXOt6xF0Nullb
	MePICj6mOQdGegu+sIJbHIqhCctFmRqzMzK72l5ot9twaXcOpk4qC6yOA2IsLO/uEUj9jKB5BJK
	64urJGqgPVkiXtKz5sUJCzscWLWdBvN+NSkm8
X-Google-Smtp-Source: AGHT+IFhhGxcNIG2aUOot8SFL7p0VSL1VjzZGKWoR3i7NdcKgE7axBiFKDojFaazDvC4pd+ClFRktfSHuKzMJ3Co+SU=
X-Received: by 2002:a05:6102:6d2:b0:48f:461c:ab86 with SMTP id
 ada2fe7eead31-49759928e16mr5099648137.12.1723669561306; Wed, 14 Aug 2024
 14:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zrzk8hilADAj+QTg@gmail.com>
In-Reply-To: <Zrzk8hilADAj+QTg@gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 14 Aug 2024 14:05:49 -0700
Message-ID: <CAFhGd8oowe7TwS88SU1ETJ1qvBP++MOL1iz3GrqNs+CDUhKbzg@mail.gmail.com>
Subject: Re: UBSAN: annotation to skip sanitization in variable that will wrap
To: Breno Leitao <leitao@debian.org>
Cc: kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 14, 2024 at 10:10=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello,
>
> I am seeing some signed-integer-overflow in percpu reference counters.

it is brave of you to enable this sanitizer :>)

>
>         UBSAN: signed-integer-overflow in ./arch/arm64/include/asm/atomic=
_lse.h:204:1
>         -9223372036854775808 - 1 cannot be represented in type 's64' (aka=
 'long long')
>         Call trace:
>
>          handle_overflow
>          __ubsan_handle_sub_overflow
>          percpu_ref_put_many
>          css_put
>          cgroup_sk_free
>          __sk_destruct
>          __sk_free
>          sk_free
>          unix_release_sock
>          unix_release
>          sock_close
>
> This overflow is probably happening in percpu_ref->percpu_ref_data->count=
.
>
> Looking at the code documentation, it seems that overflows are fine in
> per-cpu values. The lib/percpu-refcount.c code comment says:
>
>  * Note that the counter on a particular cpu can (and will) wrap - this
>  * is fine, when we go to shutdown the percpu counters will all sum to
>  * the correct value
>
> Is there a way to annotate the code to tell UBSAN that this overflow is
> expected and it shouldn't be reported?

Great question.

1) There exists some new-ish macros in overflow.h that perform
wrapping arithmetic without triggering sanitizer splats -- check out
the wrapping_* suite of macros.

2) I have a Clang attribute in the works [1] that would enable you to
annotate expressions or types that are expected to wrap and will
therefore silence arithmetic overflow/truncation sanitizers. If you
think this could help make the kernel better then I'd appreciate a +1
on that PR so it can get some more review from compiler people! Kees
and I have some other Clang features in the works that will allow for
better mitigation strategies for intended overflow in the kernel.

3) Kees can probably chime in with some other methods of getting the
sanitizer to shush -- we've been doing some work together in this
space. Also check out [2]

>
> Thanks
> --breno
>
>

[1]: https://github.com/llvm/llvm-project/pull/86618
[2]: https://lwn.net/Articles/979747/ (Arithmetic overflow mitigation
in the kernel; Jul 1 2024)
