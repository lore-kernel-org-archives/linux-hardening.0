Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C168111A3
	for <linux-hardening@vger.kernel.org>; Fri, 15 Mar 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533675; cv=none; b=kc7SczcXC7L3+MSm9JUURDw6jIF0cTGI8hAP3/yeIVDJnRk2JSSSzBHHBJGlDCYc9zzbEbIQki1WJaWcBNWIY81N07Ygtw+vRMWzeDYBDoEMdU2Yz0leHezBh7dN4yLGG17FuBLZCRbxnEeqh7vsOnKIbb03JF0jgU9KueX5p+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533675; c=relaxed/simple;
	bh=y1BTYZXLc0pjmzbXa+mfMIir4aip9V/TivPImo1c/VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dviwj8aQ+5MaMbIgZGEQkDp7rY9MyY+jrVvV2goC6w9K6yNw8fsKFysfpgdpnqeU8rLahwfbwBytq7siwrbV0LUHsNNzxzJA/jNfqex4T6mkmRhvO/I9+2BWeXlNv6wQTPt0LVL4zXH7QeDJwgTYdiVnPbLKUaUrd23X3r2Cl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQdUdC0S; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQdUdC0S"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so332a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Mar 2024 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710533669; x=1711138469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjN4sGS750eWboC8w29xo5TO2+i7icdu7hvgKDpNx8w=;
        b=jQdUdC0S63hFWMsCr5Bdb+9d1tN5IavTXrXROqWRDxoZsh3UsmvJkVzrGhhEXCl46f
         myxdFAG0FpUBlv4aLpSPJs5irOMnOvQu5q8dqtQ9EdrfqwhGBADe+vhbagbMtdHbHtxE
         MtUXlOIWWfvf3qRD8yXXKt7G51eij1Gsn2VecIhU4rbGVwlPN6iVIn6/62sdExvwdGmH
         GCA94t9CsTYkl1O5lQKsgKWOglLy1xcLboTL8RPpBwpgXNamld5SikMoK3HjHIUS0SNg
         T/v3uF1QcIcFfYVMtuhet65bQeePGpT2DKmfuFRomFHy+WJNK5ia5DzV7Y3ksUfdt3YF
         L4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533669; x=1711138469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjN4sGS750eWboC8w29xo5TO2+i7icdu7hvgKDpNx8w=;
        b=vG/HXhQyNHo9hQ+ZyKYl5gsBAI0xHnCqry2cAecgRMqIUEhbUTmPpn1PLfDX+cCoQZ
         CbLsKtfDsP8QnANPe/44kdlp+6drm1m0+NOOCTS7oz7ium6i87Di02MTBBP8emO6cgEb
         uBGyQryCSI90zimC1FZ1GK4F6r/66rlJARZwRDXumNac+huycocHIPcZlyDaH2mZlJLt
         4aEl8DoyCVsDbUqZ5j/mTi5IsL1uG/myeal+977E1Svn4Vy/fUG+KQAdcVwjKbbGI4RF
         cDXxANk+eyx/wM5ruPEaWbrBUa9SV/ckDmC5roRSEmkPDgKydzL0LnGcGM+ybliJoKNB
         LYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2JbwTn1ydFiouhZpzHHSLZLRmik1MU3FzSDAqTU5aHIwIFS9yrWqbwOOI5rqH6zoQyDsIgmWOKQtDocs2vMDgdGbbLi/tTRti1tqnQByx
X-Gm-Message-State: AOJu0Yyp3OpJvA/jV72DwTUiAoYE6ohS9fQh+Q71rUb+ra3enJDf7Jwv
	AAM9eFq196gaLteJUh327miB2rdfcDmsYgVH5TRDI3SSQ9cG+m8uWt+id6ltG8dL9NHtY17DdhX
	lsbgJtgUp/+z/0K0zlhLlnquvB3No3QAo6BxKNPhy6ugGAfhc
X-Google-Smtp-Source: AGHT+IE/YLoz0wFB/AdPNemdkai2WeDZkSxuMDauynHrgL3l4ZXHXI17FWnDpmKh+BBz03z+kIqLGQUpWDojUT8GUEY=
X-Received: by 2002:aa7:d74c:0:b0:568:b6de:4904 with SMTP id
 a12-20020aa7d74c000000b00568b6de4904mr144849eds.5.1710533669330; Fri, 15 Mar
 2024 13:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com>
In-Reply-To: <20240315-snprintf-checkpatch-v3-1-a451e7664306@google.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 15 Mar 2024 13:14:11 -0700
Message-ID: <CAGG=3QUKdEB9nw=Gxppewww1tzC=hcry1UnZ-j28=RU1KWFm7A@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add check for snprintf to scnprintf
To: Justin Stitt <justinstitt@google.com>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 1:09=E2=80=AFPM Justin Stitt <justinstitt@google.co=
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
> Changes in v3:
> - fix indentation
> - add reference link (https://github.com/KSPP/linux/issues/105) (thanks J=
oe)
> - Link to v2: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v2-1=
-9baeb59dae30@google.com
>
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1=
-3ac5025b5961@google.com
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
> index 9c4c4a61bc83..69dfb7412014 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7012,6 +7012,12 @@ sub process {
>                              "Prefer strscpy, strscpy_pad, or __nonstring=
 over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr=
);
>                 }
>
> +# snprintf uses that should likely be {v}scnprintf
> +               if ($line =3D~ /\bsnprintf\s*\(\s*/) {

Should this check for the 'vsnprintf' variant as well?

-bw

> +                       WARN("SNPRINTF",
> +                            "Prefer scnprintf over snprintf - see: https=
://github.com/KSPP/linux/issues/105\n" . $herecurr);
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
>
