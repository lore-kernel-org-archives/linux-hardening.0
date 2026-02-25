Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F00296BD1
	for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988167; cv=pass; b=UDcPTP9BUHW/nnWf8dPTq140jIveIVQNsdLJ0XoIC2jfIvrc4OOjdKW/YbVO/AOhWTKsSvlRreDcEhD2U3QrMfI1RcdwY/1odvqSfh/SdakjKFJyUUjAef/NERTrd9tLapaa6hWbXvKb0J+5zdI3/vERmxRepwMJGeHcIOsyN7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988167; c=relaxed/simple;
	bh=YEe4JU3gZ1AYNNZzR2AtL0prHODUxNibRD65/Wgd16Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE752R2URq/vv34IgoFAlMYiAyuCTtH9fLqUCs0AcrBeKojrb73g54dbHfPKp74Ttz0RsvBDmHzTgsrJLMtilw6Qi0xCa9j7ifTcLln2Q9HzrnNuJ5Cloumwq9uTu9wA+hTCziVwhy4/ncX1DwzAcoj3Wm4Qfo8+BJvoQEBsq9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBrNOfUl; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBrNOfUl"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1273349c56bso7589276c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 18:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771988166; cv=none;
        d=google.com; s=arc-20240605;
        b=cWxeyZhj98QOlKI0l7fYoD4oc72qeoxXTRdnkOuItOzTcaLP/KtF5BMjHApUeju5By
         sWwUFjmflmXxPMzDW9t4XLtJSRqz9diC07UxX0jpORquGQwrDiZiMun8h4br71J/qpPZ
         A3LpoJALmPPJMPHZVV5+Ek7I374y1+U7iI7m4TC2I01R1A4/SkQqmSxvYV9S4gEogvTV
         GF2PHMAJVsaTOJLNDzr7DP0k1e1Tp7WqKhkT5aTk7loQMxi42qOjZhg1S+7Us7rU4dAt
         tHe+TYLA+by6irLZ7ij6hyoaPS2MKHLqhPaIzl4YakUykft/na8MA/N0ZgCrLdkbfLex
         lPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TA7qDg4NCtd1YAnZI9KvDRHNA97lBlSYLdzRKpUyISQ=;
        fh=HfSBeJ/s8Cown3Mq5ZEsT14gmrM8qttmbmod+guValU=;
        b=gpMs6mmvq/oDyMqweUAgO7m7nGJr8U9et5da6P3C5xK6xfvqOIaUIlsvFKb51ZuEZN
         NxRvxLEsTelAbOEZW10JsRpODwvsss9FkV+a/mJEJzzk/NqWtz4RdUlpdPDYU71bgFPK
         1b2WLdOFCBFQRkupgUr1QP9QfG9eSnDXGCUbSxjocWOU2mOKrt9yRZ+r4fkwoJuVNGHT
         VrBd4qRwHs9wBIrRVGGmL8hmWwZibKrnQUCFpMCVsgQXom/zISVEhlaux4ny6SquJHRX
         EcBRZaZNfhg/QakyDS+8MJQUJIih7HKIa94uY3tZfmzcmXcbMHNCjWjZ7HXGW4jNx8WP
         GX+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771988166; x=1772592966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TA7qDg4NCtd1YAnZI9KvDRHNA97lBlSYLdzRKpUyISQ=;
        b=lBrNOfUlVgu5WDbfd0jfJZWjWQOQxZGkrd0KdTzFd1/1xFFey3MZRwDyZ8zDpUeJDM
         9Q5TGaEh8bCxty7XhLQU6WsrcHDrJMwZeO11kmzZmurZG+hoqkGCHFW2vfvvpSUChdlo
         dRQBF3bf8wNBcY87Ra5M2gg4TQFUFljswJvOaJLULcaPiqZGMXR+/nGDddDPvQAMLB7y
         iTz8A1FHG0KRliEhf30NFWyExggFtBiLJzCivFKEwJW/BNMccWI018jJVeL0ik0Gi49J
         kteivP5g015CIuAMiCOhENttgr4H/0ByHJacXADx3vdQGk1qnhFzGjpqhf/igvE2bd7X
         Wcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988166; x=1772592966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA7qDg4NCtd1YAnZI9KvDRHNA97lBlSYLdzRKpUyISQ=;
        b=pwWx01DPYAvW3ZyetU+5uQBp1cCxXoSP03DhX/qLp50ERoG9Fc0FUZTeUztHu8Zjjz
         YK7EvzxFk9CL7MAaXc6pEA7WBLigWseLOuyroWh29B0x3doo9Tgu3BS7MMpeAVftCOTo
         6cMhA3OUh//OgZGMsLk2xF+i2HqOQMxzBANyRzKs0rzkOfTRzdgAfFpBfSi80ClGHJFQ
         YYS4iTifnYvXoEjSw/c0QFUgWR4iAEFcZXAUX1EGP1hp3Z82l8FJAKf+Dpk96muLB9rz
         W8jX1aF+jA/iA5fhJMcGQoBRQz2obmMQfHSS7zSj8A6viiIov4Ka6utBa/3xXMiHkFy8
         yLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0orAOHNEGVKapiLlhrr1DcMsockV95mNTH+nbKp3mWsOg2kf4JJ2u2XAeCl+51sqObnTo3fCWhmsD8pWCIzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWBkxPIOjshizVLGxb1gYwZet37oEZ0HDtDc8WlHirwn9jR+u
	+u+21j+PCcjk8Z5lbIrCU/5S1rsY+0a5UKYzpCmbIt2HtviruhZeZk8R85aj4A7hXnREWQvRhLk
	2C9fQyckqpBWqdFyiFLHdpQY5KvHMvIVMD3wpdBVP
X-Gm-Gg: AZuq6aK3dW8d9ciRmfpJLq1Rh/gZtasLl1srPVqwENdCAEdWCgHpFnrGx2e46+k5DWX
	ILspOz6ObbKCS7LCMBIo0UM0q8R5QSi3Te3hbCNa1PgwiUyqjuZWSNaP4XKJbSZzl0jP5DOXvwt
	VFliQySG2rG2x/aC7tzcbdf1Ll0BYLmQfgb44a7PGs0ZoHmFlsduZzO21PS6crqiN0rEqR9gUYN
	F1bNogebcs8psVcrry7xn0UHevAnhcAIB3O/P4NxDst4DZcFDyqPSGR1/GOxmec6mNaOEgHaZmr
	L5nvTjoSnPMDN6griYRTBu3YdipuEUBPR4sCNQ==
X-Received: by 2002:a05:7022:608:b0:124:a8dc:c1b4 with SMTP id
 a92af1059eb24-12781eff3c9mr273321c88.45.1771988165187; Tue, 24 Feb 2026
 18:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224232434.it.591-kees@kernel.org>
In-Reply-To: <20260224232434.it.591-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 25 Feb 2026 03:55:29 +0100
X-Gm-Features: AaiRm514aelrg8NyTSJLn7ZpuNuUcLbDTH1_TAzrgxY3Zp5UfRGLpkjOsY51Yxs
Message-ID: <CANpmjNNyvrrOi3m6XUg+Hq39qdVHTvD88ODotYjPzTwC2Kh9pg@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: test: Adjust "expect" allocation type for kmalloc_obj
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Feb 2026 at 00:24, Kees Cook <kees@kernel.org> wrote:
>
> The call to kmalloc_obj(observed.lines) returns "char (*)[3][512]",
> a pointer to the whole 2D array. But "expect" wants to be "char (*)[512]",
> the decayed pointer type, as if it were observed.lines itself (though
> without the "3" bounds). This produces the following build error:
>
> ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> [-Wincompatible-pointer-types]
>   171 |         expect = kmalloc_obj(observed.lines);
>       |                ^
>
> Instead of changing the "expect" type to "char (*)[3][512]" and
> requiring a dereference at each use (e.g. "(expect*)[0]"), just
> explicitly cast the return to the desired type.
>
> Tested with:
>
> $ ./tools/testing/kunit/kunit.py run \
>         --kconfig_add CONFIG_DEBUG_KERNEL=y \
>         --kconfig_add CONFIG_KCSAN=y \
>         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
>         --arch=x86_64 --qemu_args '-smp 2' kcsan
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Marco Elver <elver@google.com>

I'm assuming you'll take it through your tree.

Thanks!

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: <kasan-dev@googlegroups.com>
> ---
>  kernel/kcsan/kcsan_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 79e655ea4ca1..ae758150ccb9 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
>         if (!report_available())
>                 return false;
>
> -       expect = kmalloc_obj(observed.lines);
> +       expect = (typeof(expect))kmalloc_obj(observed.lines);
>         if (WARN_ON(!expect))
>                 return false;
>
> --
> 2.34.1
>
