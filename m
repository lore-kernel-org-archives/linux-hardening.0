Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E41E766A
	for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505125; cv=none; b=IDATA4+B9+TU9QkDblMJQpBDL6fjnud4ALXtGr0/nH9rGfqaFaRJl5FSQqLQqR+3t2GY/bLd5e4k9/KJsP+EwpZi1XG7ySzrOZ9r1mqdbBqlygubC8rUgGr1yCHs2P5L3Mo7UH/8JA2Im7p8Sv5hj9MRabJ6p/eZ6KJnpwLJato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505125; c=relaxed/simple;
	bh=E6P1aiZ4PNxlxIt/eSfDf1aGFNTvnsK/44ZRqs3l3Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYWPULZ8R4qlQRKcHpSwYW9jXlaAaYssBRPMYs4ET9XAnhST23z05XdrvV88RZ3cW3UJpdpZREa29/whCr7S89FrXiwuj2zLj6iiYjX11gV9ccxTBQKse2EMXGW8Su1uUAdZPCN7ArZ/KxQ7z5a/rPDH65u/EyNgmdvJw97fbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IRX+5+Qh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IRX+5+Qh"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so4310101e87.0
        for <linux-hardening@vger.kernel.org>; Mon, 21 Oct 2024 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729505122; x=1730109922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubpo6S6NnJRiZloFHEIs004TDIT5EnWgHXwynKK1RNw=;
        b=IRX+5+QhDA0eMMFvohTdyOd4v+d78Q7qPIFCLpRpSf+s1Tr1898hiMDXVTn1YLsDgf
         SQRMQ1FuNnbBQrd1wGAk4NG1AYk6Qc/1W3O+PKMf37mHFlXHJNU4WY3NR8r0DC+Gipi8
         rVNK2VJ/LpOcpJcGjn99/ifmYFejNijqY2X+c62jQI03xDavjaHLjuw2hkjof9bOHcGZ
         O7Qv/FwflE9A3tXkDgfMWn91eOFDyuOKoZAh8teDzRmKUTewA9RG6f+Wf2a+AEv1L3xc
         5RBXM8b+BMAPvPEJuvMiDZsLxySMC7oPIsQeqh1fFbVHeqaXFxUAwi+RUtd9lkk4fWAC
         3IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505122; x=1730109922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubpo6S6NnJRiZloFHEIs004TDIT5EnWgHXwynKK1RNw=;
        b=CrRBwbG/3PgU/6IaLr/Fm3pMUicow0qVrY9gmE4vcVFka6u8uOIERT6SYuQ7LEbbDY
         A6Jm7mOgik1uwDDD2WXmy05sRsHxK6o4cH4ypffU6KTQk9iC336y5HYM3Av5LAFQEr+x
         l56EPWz2s2PDU6XhNnBN8m3kxAGR2gGf/+ZKnka6MYAXqvTkSVzokolR7IUf3/o2QtCF
         Tps56KhU2MzQIrssHy6bk4t+qtPkr9UxbK2Ja8TZxh9s6Ng9u6fqGqQjUw/yHqSjYPW6
         gjd0SjrHPEneI8SAFtCUq0b6yhVytkAY4jGxLiekr4PmQJyukG7fWL66ZvjOOYijD8+q
         RwmA==
X-Gm-Message-State: AOJu0Yx3yf3TNAwDZlnKJj+Kn7ZG3yfRXwvjUIlwwtqWMsxfdiXnZXWo
	quOb8jk0elg0GkAvc0i/ih3EYXd9R5M1+clqQjkUH4mIHbjxVdQH9p8LWT9s8F7oAJqMzk35KyG
	mR3Ewcds+3LKMCDXAia6buT136dp2OeO2YJ0DwA==
X-Google-Smtp-Source: AGHT+IFTo037Z1skIcXKzO5cwDAxFNKnzxbP+Sb3jV24EF83ny3xaXZBa8+M8OB9fSFHBSuFFLGmzMvjOyEf7v9KuHs=
X-Received: by 2002:a05:6512:3b93:b0:539:fb49:c48e with SMTP id
 2adb3069b0e04-53a15441716mr5327039e87.11.1729505121534; Mon, 21 Oct 2024
 03:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100421.41734-1-brgl@bgdev.pl>
In-Reply-To: <20241021100421.41734-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 21 Oct 2024 12:05:10 +0200
Message-ID: <CAMRc=MezpJVQUaetodJbxn7VU5rLaZUFumVsmCcwgOYdLSk8-Q@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The output of ".%03u" with the unsigned int in range [0, 4294966295] may
> get truncated if the target buffer is not 12 bytes.
>
> Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes round=
ed to the correct SI range")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  lib/string_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 4f887aa62fa0..91fa37b5c510 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -57,7 +57,7 @@ int string_get_size(u64 size, u64 blk_size, const enum =
string_size_units units,
>         static const unsigned int rounding[] =3D { 500, 50, 5 };
>         int i =3D 0, j;
>         u32 remainder =3D 0, sf_cap;
> -       char tmp[8];
> +       char tmp[12];
>         const char *unit;
>
>         tmp[0] =3D '\0';
> --
> 2.43.0
>

Sorry for the noise but the tag should have said [RESEND PATCH].

Bart
