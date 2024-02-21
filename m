Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F4127B67
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553604; cv=none; b=IqQx0Dw1t/TTPHfcm2OuB4zZc5J/AO5FD8ymXfwL3zf2rhb4vgdfDcJYUDu8kppTGMk7CgniFwhShSAYXtTlLhs4CCGpaJGzgyfgw56cVEevBFbsHdgfBRe2mN3Gz71Xt0Mpck7nyXegULnmSOIgV/voWgQZRduQHXalVXZSoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553604; c=relaxed/simple;
	bh=9hg4ljWhbMxM26mrW5JK2oxtbOcxNnG3OBsmEApOFmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmN8WEL3EPsxGScZlMUvtf/QTcj5jYMvPVjreQ/MIWUcirqQ7RlCwA9zlee1cukYOXwlSeXiOTUw4JyZRKRHPegL+ysF25VrtaOkETe6KT1Cg4SDhQM6Mw11DOI8BRVlVbQjQ48pGBoJ9H4dtZFUJBfYawfSFdKezB9BeO2KcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CC42Iebv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CC42Iebv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so1449724a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708553601; x=1709158401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfbuRjkNALu/kNaGNH8dl3lJtOSzdqqz7XS1RFNencY=;
        b=CC42Iebv6OKRbec5mCmp5OTeDu+rMvMIafBW8H7dPV4AJA9q2WaJI/z24J8KTlZap5
         pGWoAGjoCJVq8BaWy/ZDXKmHNO5SRrFh3/KNV4jOlBB2CBAz1mUtAJk2cGfaQFpaw8qJ
         +jKdZQHTwMvU//Ai57v3jGUB0QDTb3IQaJCX41/w1bkTlWBJ45/mOnoBco/1wijupyG1
         ZWKKTPeXSeAbztE/ABVwTUVgZpqAufd8zmPo5xI5L80r0xv0iGRU1GRd602DbL+jA8O8
         WMmDI6e+84e9ta5lRMKY0ahmXzSf/pn+9POMINr2uGxutrjA5HSil9qRbu/+quvbwbkq
         DEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708553601; x=1709158401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfbuRjkNALu/kNaGNH8dl3lJtOSzdqqz7XS1RFNencY=;
        b=qeVbqyBwW1tSEIot1HzwuIL1Evl3Iia6e1FNaDFnqO2xW5X2zPp5/THtdlJSm4q8EC
         Fp0npGaz31+unwPvzk1xBDrfel/r9fEA8UScbKfDPNHSnyuee85nc8iRSCdEBLqIs8c6
         jnB9FjzM3pkWLvWnPkGSWuvT24skpZq3vexvEQ6H8MI8rEpy6sBXHNw5Uh0E2vT9Hov0
         nL9Z2ZGG09MDvIsyWnwVUimW7Qkf5z6cDwFBzRzqigs6ckdQ+tvCttMWui67HMQz916E
         5axzaioPyWnXEfehpU+CzlOIk8/MEb4YkkashRuYsCOH8inYRqfeH4RPc01ad4mzP6ho
         PXcA==
X-Forwarded-Encrypted: i=1; AJvYcCVaGcHf7GcL4mGPVLyKvhirIgT9O05ac0jATS/idjWyNoQUXPUSmBin5gW0ZqyDF0D5zRI1n3YuX6NnoOaXFR8XuVLeec7Brg+9wYBS4nmE
X-Gm-Message-State: AOJu0YwXk5bFjQVU79yjIGV2HnTPc3sCtTpv/H6zEmrX6k5neCI/yXEQ
	nPNPyjl49LoECBnrWEtqNV7P3ThxNmHRuQaxUvfTYw6hIGrEZUFwN0Z/rAdY+FIhASBOe6EXYmx
	05grK3Cdy0u3NOqIZnzm4cEVW/cRgqqML3LhZ
X-Google-Smtp-Source: AGHT+IHtCDTQuwKXVaaVB+TFF0/BgLTDic3wf3VHQMwJmIRqqIFanvbjSRQRreYPOw/KbmNXqNEAJoY29b/oG7qQuYU=
X-Received: by 2002:aa7:ccda:0:b0:565:25c5:5d91 with SMTP id
 y26-20020aa7ccda000000b0056525c55d91mr421910edt.4.1708553601064; Wed, 21 Feb
 2024 14:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com>
In-Reply-To: <20240221-snprintf-checkpatch-v1-1-3ac5025b5961@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 21 Feb 2024 14:13:08 -0800
Message-ID: <CAFhGd8qU_xvo6kwxzmHXz=Sx4rFQWaXY5XNDbMqfbHjmbtKK5w@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add check for snprintf to scnprintf
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:05=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
>
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
>
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
>
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> From a discussion here [1].
>
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@lin=
ux-m68k.org/
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9c4c4a61bc83..bb4e99c818a9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>                              "Prefer strscpy, strscpy_pad, or __nonstring=
 over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr=
);
>                 }
>
> +# snprintf uses that should likely be {v}scnprintf
> +               if ($line =3D~ /\snprintf\s*\(\s*/) {
> +                               WARN("SNPRINTF",
> +                                    "Prefer scnprintf over snprintf\n" .=
 $herecurr);

Whoops, I dropped the \b with some poor vim skills.

v2 is up.

[v2]: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1-9baeb59da=
e30@google.com

> +               }
> +
>  # ethtool_sprintf uses that should likely be ethtool_puts
>                 if ($line =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$=
FuncArg\s*\)/) {
>                         if (WARN("PREFER_ETHTOOL_PUTS",
>
> ---
> base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
> change-id: 20240221-snprintf-checkpatch-a864ed67ebd0
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
