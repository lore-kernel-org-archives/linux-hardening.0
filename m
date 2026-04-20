Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B637A493
	for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668206; cv=pass; b=jsgI374Hltl6oltonmHA4LR3CdO/eqToCoYxWX3I6tuU2K+uY0WcYshcK+JGuKRN8c/B+nfSVBEghEp660h3EqrFjf50Bque/wtyOBycIUkyi1UvxOhUMSVCZCa/95SXA4z3+9gizHMvF6TrMsOznvfY7N2N/frQLCuSizVMtoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668206; c=relaxed/simple;
	bh=q2h2S+ybPyUuORfyPrVUgIx6M1XZ4AInwFwtr0lmqIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu5TAv/M1jEJ4WRn6ssSz3FtnHeeam3wjuMJQRKLT7Lx151hwQMtfAKGM3r7FozI1pLnhjTqENqYZcuoJ3CGYF7+S9N9Q2GdAoh/Xb7Cu3D2PDV8GLEf/4SGre3D3VQS3z1F69Jtxn8Rhdi1NZ+6t0CPgGDPY+IZB9LhGfaVEbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qna4vtBj; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qna4vtBj"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba60d78aff3so181398566b.2
        for <linux-hardening@vger.kernel.org>; Sun, 19 Apr 2026 23:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776668203; cv=none;
        d=google.com; s=arc-20240605;
        b=AuMC7ux/DSntd1DU7hZI3LglKnc0zFiDYbgM6ALXL+jih3Tljj2+4tECx8LDS5cgs7
         0RNlOi46K4ZEUFyDt4yw/zenzr2xJNfwcY4RzA7ObtJwNQ1bGB3Y97l2UMH94KJNAcfU
         Roy3nQPnMSNvjq/j9PvrEnfGmhUgEibb/3es1DeemZxW8F7jrCwYwR9gY0Y7CSdxnwQG
         6adLleJs2DhJWm/BlyQeTWoPX1jSYIhF77sgd2bBQ7h1Gkw+8LKUPQ8k1WXkdkVDdhKE
         GJi2cIuis8XZsTm/h0PHC2RrUCb+2gOcb5ZpF96hVsBJTc5R3tO2F+DB3OZDfto7t65P
         1McA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bVaZtqMT64CADYWqi8aDaSmUgUoGBxSGLKSrX44BRFQ=;
        fh=FRM+9/VKEgIYar8w3+aa27/OOFRFLMgFOs91vKz1FSI=;
        b=i3UFvw0UHnhhOmuJ2h7MQYgERYWYBsAai4rJuaSwP7sHEeHjjjY4NPCv4MTYDQTP0Q
         YnGpFhkBmApon2pnlMCQX0irYiOomr9hzyvN2Q4vLkJmIxFo/J7uc0WWoKIMACM1uTzY
         RroP2Y0FThCu67aqMXrHgC7vrII6UriT3M6FS0U+imWfyldhn2dW+m16k3LNBZor0dVe
         NK4JjFsARXCeu6jCVLrFsjMG0XHVhmnQvptb1JOrJgV9Locdha1F6Eray0kDMqgxcTSu
         fMOpbzTXop9iUEJI+8RM1QbYCt8iYPSZThs/BOyQC+X/oNOYQByBktJh9wa1K2USJ468
         2NCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776668203; x=1777273003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVaZtqMT64CADYWqi8aDaSmUgUoGBxSGLKSrX44BRFQ=;
        b=Qna4vtBjfGS7sTxzR8ymtlzx4QPNFBz5P3mM8jM3E1pOUvueMr/RT9o/vDxb8Lu6fG
         tTxSC3/YZmqcbb1Q+w3JyOeM7PZFJfFOdF47wlDHsHY0Cc5q8vMX/SqLQzUwAP5wgqJP
         4vDd39XaA45+A87GZkxdyMbA9rBJpUOjhqb06carxWwiZ2Viam3ZOv4gfSzl/H3SOnzX
         SGWJhTbRsQuek7RIVtx496QP5bCWZu/ppUiVYi/Fa0VM0UjLtVl2P+hG9/hzyOVc1yRR
         JvY7cppG+l33iquD1z4FyzWUKbNCIA3jtVeE4ns200nPkOi+p9tsQX8xRbHDJbTcFvg1
         T9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776668203; x=1777273003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVaZtqMT64CADYWqi8aDaSmUgUoGBxSGLKSrX44BRFQ=;
        b=KdMkBxk/x6V03DRNAZwPTwKHhjkQTxJgxuntV5GG9mbY+XOnOOubw1meuIiQ7cwqJX
         6vX9lTnkRH+uE8VirtdiVKMvt9umbwKlEzp72c9YBau+e8A0F2r5LuEFEmcnGUY+8Dtq
         ysLvNk0GYZIwIbaEtlrU/rcCgyD4ZyOhacmgbAVcFb9ed/0dM02SuE5fKwe44qpzSjc9
         v3scpdFXG0yGr7i59iF8iXOeme7gAQAUAEOWM9KTyIVkWyq5NZWWqYwvC4ABConKUCXG
         1mKtBJ/DhlZDsL7rIW3C7W4AyLfPQq3UwB/3ZRtusY7n3VzIJyy8px3lmtHZ3zyibOze
         IbwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Tbi+5XoL3dUqh3pyoMvpIHpEFn1M4rH3LULiE3kJ8nyY/iA2o8tmylYnDtjpTG/PfnR7fEPZqvfNsJRvpI7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGxorUFzCgKsvdSHn31CUQ2DWpuBFr+nOPmsfKOTm6rHiYEFq
	npOJl2zj9UQqsKHGGn5elEBRPYN9a1gbPwMxw9XKQcpDDln8eULgZMp1/s7/EgAwf4k/qfz8DXM
	T6puO2ATt6FLA03WphEfI2kY7ZsSKjus=
X-Gm-Gg: AeBDietdEgA29H0vLk6NST5S1Qfu3IPQLQ8cKJmQHsta+Er+u4W42/xVCdjrxIoYEow
	JR6eeo+rSko/1v3/1oWpR0ZUIcM+OTh4eQfZEafFQ3zV9mwi/X2sMPW6OytMAO6TfyQpdv9nK5t
	Rb5wP9gCz13zaexcr8A+SkLiPF1wWgwdcbhCUw8EqYSkhqTF9Ks7Qo35EhfAAYCMR2433Uhlv/h
	2BO+z4nxiZnt25NYR1vU6GB1g4W5fqnlAi23xFfGPtXvf0Bb7tE4Cinj4fRFpHj0JEJ6xs74HkW
	EACdF5KkiDxEAuUR2TW07dinehUTA3LCmz/bttAvXysCnIAE9ILwow/foZuxNzXWRwRoWZ1Nd4L
	AkCEUEZSJqMaTQvF4FQ==
X-Received: by 2002:a17:906:4fc5:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-ba419074424mr620683866b.15.1776668202651; Sun, 19 Apr 2026
 23:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407143306.78809-1-shuvampandey1@gmail.com> <20260419153111.90635-1-shuvampandey1@gmail.com>
In-Reply-To: <20260419153111.90635-1-shuvampandey1@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Apr 2026 09:56:05 +0300
X-Gm-Features: AQROBzBB7sr9V9y3776Xm-nQgbVWK8ePbaEINiPI1wlUAH7f5fhqOgGYD5-wWmI
Message-ID: <CAHp75VcW0cexQk6Zg-RwKSMBpOxPa3YCAomK7PFXEGLQ0VkrMQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string_helpers: renormalize string_get_size()
 after rounding carry
To: Shuvam Pandey <shuvampandey1@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please, keep the author of the original change in the loop.

James, what do you think?

On Sun, Apr 19, 2026 at 6:31=E2=80=AFPM Shuvam Pandey <shuvampandey1@gmail.=
com> wrote:
>
> string_get_size() rounds the fractional part before formatting the
> result. If that carry pushes the integer part to the unit divisor, the
> helper still prints the old unit and produces strings like "1000 kB"
> and "1024 KiB".
>
> That misformatted carry case comes from the arithmetic rounding added by
> commit 564b026fbd0d ("string_helpers: fix precision loss for some
> inputs"). The helper already rounds those values up numerically; it
> just fails to renormalize them into the next unit before formatting.
>
> Renormalize the carried result into the next named unit so those cases
> print as "1.00 MB" and "1.00 MiB" instead. Only do that when another
> named unit exists, so the existing "UNK" fallback is preserved at the
> top end. Extend the KUnit coverage around the first decimal and binary
> boundaries, including adjacent values and non-byte block sizes that hit
> the same carry path.
>
> Fixes: 564b026fbd0d ("string_helpers: fix precision loss for some inputs"=
)
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
> Changes in v2:
> - correct the Fixes tag to 564b026fbd0d
> - renormalize only when another named unit exists
> - preserve the top-end UNK fallback
> - add decimal and binary boundary/neighbor KUnit coverage
> - add non-byte block-size cases that hit the same carry path
>
>  lib/string_helpers.c             | 12 ++++++++++++
>  lib/tests/string_helpers_kunit.c | 25 +++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 169eaf5834949..bcabb24fe0dbf 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -121,6 +121,18 @@ int string_get_size(u64 size, u64 blk_size, const en=
um string_size_units units,
>                 size +=3D 1;
>         }
>
> +       /*
> +        * Renormalize into the next named unit, but preserve the top-end
> +        * UNK fallback. After promotion the value is exactly 1 of the ne=
xt
> +        * unit, so keep two fractional digits for the usual 1.00 formatt=
ing.
> +        */
> +       if (size >=3D divisor[units_base] && i + 1 < ARRAY_SIZE(units_2))=
 {
> +               size =3D 1;
> +               remainder =3D 0;
> +               i++;
> +               j =3D 2;
> +       }
> +
>         if (j) {
>                 snprintf(tmp, sizeof(tmp), ".%03u", remainder);
>                 tmp[j+1] =3D '\0';
> diff --git a/lib/tests/string_helpers_kunit.c b/lib/tests/string_helpers_=
kunit.c
> index c853046183d24..67822cb48fd15 100644
> --- a/lib/tests/string_helpers_kunit.c
> +++ b/lib/tests/string_helpers_kunit.c
> @@ -558,6 +558,31 @@ static void test_get_size(struct kunit *test)
>         /* weird block sizes */
>         test_string_get_size_one(3000, 1900, "5.70 MB", "5.44 MiB");
>
> +       /* rounding carry into the next unit at the first decimal boundar=
y */
> +       test_string_get_size_one(999499, 1, "999 kB", "976 KiB");
> +       test_string_get_size_one(999500, 1, "1.00 MB", "976 KiB");
> +       test_string_get_size_one(999999, 1, "1.00 MB", "977 KiB");
> +       test_string_get_size_one(1000000, 1, "1.00 MB", "977 KiB");
> +       test_string_get_size_one(1000001, 1, "1.00 MB", "977 KiB");
> +
> +       /* rounding carry into the next unit at the first binary boundary=
 */
> +       test_string_get_size_one(1048063, 1, "1.05 MB", "1023 KiB");
> +       test_string_get_size_one(1048064, 1, "1.05 MB", "1.00 MiB");
> +       test_string_get_size_one(1048575, 1, "1.05 MB", "1.00 MiB");
> +       test_string_get_size_one(1048576, 1, "1.05 MB", "1.00 MiB");
> +       test_string_get_size_one(1048577, 1, "1.05 MB", "1.00 MiB");
> +
> +       /* values already in the next binary unit stay unchanged */
> +       test_string_get_size_one(2097151, 1, "2.10 MB", "2.00 MiB");
> +       test_string_get_size_one(2097152, 1, "2.10 MB", "2.00 MiB");
> +       test_string_get_size_one(2097153, 1, "2.10 MB", "2.00 MiB");
> +
> +       /* non-byte block sizes hit the same carry path */
> +       test_string_get_size_one(4997, 200, "999 kB", "976 KiB");
> +       test_string_get_size_one(4998, 200, "1.00 MB", "976 KiB");
> +       test_string_get_size_one(9981, 105, "1.05 MB", "1023 KiB");
> +       test_string_get_size_one(9982, 105, "1.05 MB", "1.00 MiB");
> +
>         /* huge values */
>         test_string_get_size_one(U64_MAX, 4096, "75.6 ZB", "64.0 ZiB");
>         test_string_get_size_one(4096, U64_MAX, "75.6 ZB", "64.0 ZiB");
> --
> 2.50.1 (Apple Git-155)
>


--=20
With Best Regards,
Andy Shevchenko
