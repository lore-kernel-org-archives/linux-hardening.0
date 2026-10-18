Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF55388E68
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792299918; cv=pass; b=YLettVzMKv3oIX92qyKYL0y+FUHuaJK7rfqPM1T8BXP/yNzAvr2Ure1P7f5vZkIvFrIhfzY7gzwWjXJGseKgD96AwlcGHACThzFJhF/iPCcpab4MmU9ELt+NvD9V+iB5Yoz4NCBq7yuT4ZvvdRDfyMeBmKKXcGxFZlhACvIjGm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792299918; c=relaxed/simple;
	bh=YnhtSSB8nZRhBohNK+Ha3Mxq4te3x02LOrcyBX8A7pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9K8VnRqnKtXu/xFDezwX5Ehn4l3Jmjaph/6x9mAJ2N4A+Cw2AbY8satacJznKr+pKs/QK/Kbc9ME6mSiRZg3CmMrXeSamATuUCPJG978K5dntOnrchkTnfbN36330qHqDDlD3aZN+J/ckx2TrMskE3/sBPtbZibBxDdRi331D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=R5+Iwxfn; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="R5+Iwxfn"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c434376dbebso32589866b.1
        for <linux-hardening@vger.kernel.org>; Sat, 17 Oct 2026 22:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792299915; cv=none;
        d=google.com; s=arc-20260327;
        b=lb6u0LfnTEHMh857Mk0ciQjwaHnyp22B83vFu+kUlOeQ53zamlV8oMNDpf19gWBEF4
         tUfkSepmtaQnB72w7VxZtTaVLdu9WoA2A9AIKDWo34ltASXCYyKKd0I4zTBhiDP30JM1
         WJRaxwgLYZ940GjWpXsrWLNaJCyekpglEtHWcF7Ol2CkYEvH32fQNb6WujUfJfvDE5LP
         gv4dOtAYQzeG5aUEHYt5/JEZW05LoxbInL4I4UPsrmtIu8n1j1QX4QoRzUv6zxyPfcYw
         NL7pIf0v1rwRrNzVdVeEU3La3kOx4RdR8+17PiWZvqP3zGFoBX4v/yB3RAVMozR1tEAG
         z63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QxYDg45A1Xl222gPYyi8L6/LqFiJJVoHaNN/GFautYA=;
        fh=0eNEyIzH0JVcZL9YVg7/0gNUtL9+4XjeypvUl/3Kz8E=;
        b=ljd9tjgFv9qSTXj2z/CwbeGgMZwuXW1M2WT0hMIyZUteC16okqVdJ1/GrshB+RYdwj
         Zx6erHqy269G2Aq6b5iUk2ZDWBEHtne4cNFhrES78r6Ew0V0WFe6C1zcsshCW9l3TiGf
         V2HMhLDtxLO4Lc/LG2bdUF/lCbmRhgmi76VluOaev0kKU25rnG4OKNE4La5TQDBFBNKd
         VELqZnMoQ4yKbwEOv4wPTTMAfhwriFaVfM5HpHRJGGFDM99fDghJWz5m9GWjSn6IoOjn
         n9dYn3KcOAx46XZvoyW6pCPp5c0QMFlJR6sLDLRg3HzxnbhkwbLLsO9b/tCOwlWOWatU
         UXRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1792299915; x=1792904715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QxYDg45A1Xl222gPYyi8L6/LqFiJJVoHaNN/GFautYA=;
        b=R5+Iwxfnp7vYq0Kvwm03lGp3L2Im06oCLKrnDzy6xOBKM6GxB3EhubMifYXYXhaDHt
         s12Oj7zsHMzQwdFpHarWAogpVKc0vT2DMlfwQkXax7n7NcN2r/W82Kn6bY6d6Qysd7sC
         9Oncy6yQCddQR/FGo19AYSvr+b/g03h7zxYRq9bZIM4Efc4ugSDHIF4mIFWIHHaJh0P5
         NcE75FDsk2byXuusbkgbVryz/ls5zSFgiy6MJqBklB6JWsK/ykLp1RlZhhVB6X5WEZcE
         ZH/IPG1IY5rCNi2Wc1smh4cUnw/DV+rDT6fzHRvH48nPoPawyAZrxGyjA78JemOJZl4c
         y3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792299915; x=1792904715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxYDg45A1Xl222gPYyi8L6/LqFiJJVoHaNN/GFautYA=;
        b=Ni8dhIgzms0jRgyUalcHioDT3tauy+6MmnahDR6sZRLsjNE2XhiA/76kjupt62W52o
         Qt1AcBtTM4fCRqswJqa1Phni2UPLHH+uCkdjKjiGgLkdXTfzLDW4Qqg50qALtgTC/YcG
         XfUqkECRH5Ig2cIU1QUw0cyIiNTw0XI9I/E/7xX7bzNzfu1sZ8L8OhQaLaN9gXevHPtn
         41dGaVu6s1GRQPYdMsVbnz7ZyIpAdFH8/Y44XA3g7TWAj5PqVIYxVKjDSCZAJM8ErGnu
         rlmiOCddQnR3g+1NqDLmHs9OOed5NpiyH8AZhFCADkd4qQoSXzBmZZpxJ2mOG4rYLwIa
         cMQw==
X-Forwarded-Encrypted: i=1; AKwUvBwgSW/xy+ON5tefhyQ97UEuGA05JnfJOa7i8Djqiu/b9D62O41rHk/zZHio1O8cdiQGbuZ7CWCCrpyiBjXyP9o=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5SFj1uKe1Ga4cxQos+fUwPEix5FU7gIanfRQTGL2737y34QjE
	+l9xkpB9VhXivK5Pgkk7S1KSqpo2NYqB7S19Hope3VB1Q6UCWCNnkUT1mboDnpM7DFbTseTRxnI
	cSlK0QYENvxhXHnzyZJN83BQCrMhpz9CrE4gx7GNdwA==
X-Gm-Gg: AYBFou3TqyW6V8L4c5kZoC1zTPSzHLahWvL2l8Ee1Iw4Lp/Rv6TpwwsuaWYn8+IyvBY
	SdP45vVHdcCgqxL6UK3skToF5r6l1MklSsn4DfEJ/WZ8eLIeYpD0Hh0tQrYy19maa4m3VRvuIiD
	UwGLmR0yTeBJwsjh/K3Y9V4RMRDgT7f0bBpyOfEtNQEho2tndci9GPtAGUyD/EqnqdFyUlHpedi
	Lcxb8nYqyRsRZa6mlDzRmbsox4IBBG/1EIWyWzNSWNEkxx9B72nUqnv+SUxtlefV3hnAFivmmW5
	CsQuVKQeLIHO0X81o27mJstvBYw1cPDnCk+EsPtJYHeUNCklC+VD1tDOZ36uC8Z7ucXjMYgObsS
	FIfx/KOvb2rYr
X-Received: by 2002:a17:906:99c2:b0:c41:825d:ed8c with SMTP id
 a640c23a62f3a-c41825dfa20mr296694066b.26.1792299915074; Sat, 17 Oct 2026
 22:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018-bug-string-strscpy-kasan-first-byte-v1-1-375a2c46d88f@gmail.com>
In-Reply-To: <20261018-bug-string-strscpy-kasan-first-byte-v1-1-375a2c46d88f@gmail.com>
From: Peter Collingbourne <peter@pcc.me.uk>
Date: Sat, 17 Oct 2026 22:05:03 -0700
X-Gm-Features: AclHuK-A8ldGKQ1YLtwqcTfHeRS7W4qDOo99_fThOBQNK4r230uqHy-5Gtj2lKQ
Message-ID: <CAPQLkRhXZwozmfhNd_PEx1ihwdH1_5qthP6PANYJ_m-v9vfQTw@mail.gmail.com>
Subject: Re: [PATCH] string: instrument the word loads in sized_strscpy()
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 9:53=E2=80=AFPM Qiliang Yuan <odys.yuan@gmail.com> =
wrote:
>
> sized_strscpy() copies a word at a time. The loads go through
> read_word_at_a_time(), which checks the first byte of each word with
> KASAN and KCSAN, or through load_unaligned_zeropad() on architectures
> with CONFIG_DCACHE_WORD_ACCESS.
>
> load_unaligned_zeropad() is inline assembly that the compiler does not
> instrument, and it has no such check. Since sized_strscpy() switched to
> it, generic and software tag-based KASAN no longer report strscpy()
> reading from a freed or out-of-bounds source on x86_64, arm64 and the
> other architectures that select CONFIG_DCACHE_WORD_ACCESS. On x86_64
> the kasan_strings KUnit case, which expects a report when the first
> source byte is out of bounds, fails as a result:
>
>   KASAN and string KUnit suites      failures
>   on x86_64, generic KASAN        before    after
>   CONFIG_FORTIFY_SOURCE=3Dn              1        0
>   CONFIG_FORTIFY_SOURCE=3Dy              1        0
>
> Check the first byte with instrument_read() before each
> load_unaligned_zeropad(), as read_word_at_a_time() does. Hardware
> tag-based KASAN does not use this check, so it does not bring back the
> tag check faults that load_unaligned_zeropad() avoids.
>
> Fixes: d94c12bd97d5 ("string: Add load_unaligned_zeropad() code path to s=
ized_strscpy()")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  lib/string.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/string.c b/lib/string.c
> index a3778d5aab4af..91de344956fee 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -19,6 +19,7 @@
>  #include <linux/bug.h>
>  #include <linux/ctype.h>
>  #include <linux/errno.h>
> +#include <linux/instrumented.h>
>  #include <linux/limits.h>
>  #include <linux/linkage.h>
>  #include <linux/minmax.h>
> @@ -132,6 +133,12 @@ ssize_t sized_strscpy(char *dest, const char *src, s=
ize_t count)
>                 unsigned long c, data;
>
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
> +               /*
> +                * Unlike read_word_at_a_time(), load_unaligned_zeropad()=
 is
> +                * not instrumented. Check the first byte, which must be
> +                * readable, as read_word_at_a_time() does.
> +                */
> +               instrument_read(src + res, 1);
>                 c =3D load_unaligned_zeropad(src+res);

It looks like at least some of the other callers of
load_unaligned_zeropad() have the same problem. Would it be better to
add the instrument_read() call to load_unaligned_zeropad()?

Peter

>  #else
>                 c =3D read_word_at_a_time(src+res);
>
> ---
> base-commit: 90201351a862182bdabfc1ad1c97b1e1b6ed5931
> change-id: 20261016-bug-string-strscpy-kasan-first-byte-335585ce203d
>
> Best regards,
> --
> Qiliang Yuan <odys.yuan@gmail.com>
>
