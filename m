Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A47C352012
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940123; cv=none; b=nSRmx1KClOTlfWdNalXBjkZYaDVC2TKzs1Iwkkrn/fTfaAMm4HsmF0x6CwMBklesDn/YBoF4dhK3nLgPdtUlwa0jqF/qyNXcVNDgFI2/18/v8S3mfblk6tMnjxKqRNYuJEA8+3TCBEewlLf85tOtf91jbR43VLFuVpJhuxuJDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940123; c=relaxed/simple;
	bh=Z2kkPJEtUv5Itb7UHCg5vCmpI9l0SwueXvSUCaK7TBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0+pOjeIkywcaRcBRp2LO4JM2dtgHG5YvdOhAAbmeY+j4bfZpUVOA9ji5PdvaYDOSL7z8groDEasZ9U0I8Y24Y85saB8jHU3kcw+vwC1V3rWXNiqv6Znzy3TdIZTFvsfVwEYTQ3e5T/fdfO1B7DgyNO5j85EH1NiTNrjGVENo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfqfn5/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfqfn5/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA971F00893
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940122;
	bh=2Z8d7p9f/yH/BDO4K7VB3UqEVZNRL0lXGMvmspHcKGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Gfqfn5/mikBlUEI8/kmdC1WhS5HvtLpFlc0v9xhBjBlgD/FQn/UUFT6BYzkqR23Fh
	 GAdUMIPbaMsWXyCWgV4i1nwPYT4HNhtZiGas+WVVulI6Op2eH8z0uJvTVxyQkYsGdV
	 lV3FeCd/+7JLz6zMhkEFoAkUnD7apH6fZgfQL4E58ZK/LSCELVQ9rnSTpCh7uCrz05
	 TA/yKmZcYh5lTHT+hA69P/eSdG/CzpOiiybMdofX6vtWU2OzC40umXV0wps+TqFNGk
	 jc8fXNSoTYxWh0tFgIey0sxZxny6C37KEwOAA5gvFeaIxoQwIgTnylEuPQaN2KWHVW
	 1raDFdcHa4t/g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so662346466b.1
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 10:35:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/pAbaH/tP2xfcxvPZbSrMAbZrnRczV5G2VkgROyT8MTMKBQc+AKXBaBRJ2v5tXOigTv6VJt4o91N5ffciZYjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXuc3YR6noqzmz9B+nyvYxEfozuHfBse/98cxd7WsJKYVSKYK
	hLhnSA1Xv6F3wlbCOTuXkwvYjU7oBOrtiLLMEHOO2kkdIdw8SgTNhglxhHcSi/o/G9n2xqQ9vN3
	tHyYPteuQJGC+miYasuJQijuCtiESHA==
X-Received: by 2002:a17:907:1def:b0:bda:dd7:2e42 with SMTP id
 a640c23a62f3a-bf3a900fad9mr536071866b.19.1780940120819; Mon, 08 Jun 2026
 10:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608095523.2606-32-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-32-david.laight.linux@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Jun 2026 12:35:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+W9HBmHFwzAROj-1LHK45WRFh2ry5-++K2YZiZj2n=ig@mail.gmail.com>
X-Gm-Features: AVVi8CcEb4UpoZ0z7MRgJ6s8yiR4SsoXslJHtStxObGq4-0gqyBQd2_1D5BYP8Q
Message-ID: <CAL_Jsq+W9HBmHFwzAROj-1LHK45WRFh2ry5-++K2YZiZj2n=ig@mail.gmail.com>
Subject: Re: [PATCH next] drivers/of/overlay: Use memcpy() to copy known
 length strings
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 4:55=E2=80=AFAM <david.laight.linux@gmail.com> wrote=
:
>
> From: David Laight <david.laight.linux@gmail.com>
>
> The lengths have been used for the kzalloc(), use the same ones for the c=
opy.

This doesn't answer why we are doing this. Only the below which gets
removed on commit provides the reasoning.

>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>
> Note that all the changes are only compile tested.
>
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>
>  drivers/of/overlay.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index c1c5686fc7b1..656867009514 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -258,8 +258,8 @@ static struct property *dup_and_fixup_symbol_prop(
>         if (!new_prop->name || !new_prop->value)
>                 goto err_free_new_prop;
>
> -       strcpy(new_prop->value, target_path);
> -       strcpy(new_prop->value + target_path_len, path_tail);
> +       memcpy(new_prop->value, target_path, target_path_len);
> +       memcpy(new_prop->value + target_path_len, path_tail, path_tail_le=
n);
>
>         of_property_set_flag(new_prop, OF_DYNAMIC);
>
> --
> 2.39.5
>
