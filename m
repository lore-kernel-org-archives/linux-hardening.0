Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B50222578
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549330; cv=none; b=CYF4Pptpv54c9+tHAWhGbJxoPVmsMP0tJjWWq7k6Y4uTaktNoeJ226Rf0QND/o9CuAFpeNFJbWZlxrS4qqUvLlBL7B8IUhhEfJE3cPTEoSABWA8vfet+hikg/AKksDJX0IhIKkafQZSU0miY2FDz6n7J36PvkWkeoKyTM2UaG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549330; c=relaxed/simple;
	bh=eqVkeZYur4vB9IiQRm1NCdJ4YaR7bQVBv12DWTl1zCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGYOrPh4K3jq8//omPoqJJG43AOR6/jplE4FJvV+RzdNUMbvuPZGaCFaG09SSUuVlnifIfUkJyAVgOtxQdvC9zw+SxMJj5HSGfyJzY+bT8dKDYcX59en3jd1Az1RCj8J98u54vYBj4MvWzdQ2nIhW/2ZWDv4GFAHwcS4SSi1Ov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H37SIN9x; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H37SIN9x"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618adc251f0so5650048a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755549324; x=1756154124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrUPoAix4GJmNCXAtshi2uvFt0DKJJ/xCnFV+qY1rgk=;
        b=H37SIN9xg4iL/3m5T6V59aOLt3yxsbsHMSo27zcbJYdwEDsMhpH6NBlUskQ9/8xVtU
         QRVIe6gS++vgKJGnfaLtUY+vDB5pypRTeKlwJCZehEnHUaVOtxh+3k9kY4LKsydtZQ8a
         uTu6bDjhPtHUn61zHVCJu+H/lzPBM/5bFSQHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549324; x=1756154124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrUPoAix4GJmNCXAtshi2uvFt0DKJJ/xCnFV+qY1rgk=;
        b=GKEF9JcVRsqn0ZGJWKb+VfpEYxnYbT7v0yHDzfqN5Q3ZZOgcBYW8r1YC0UGrXzGG22
         kboBbvtLYZg4XINIg7Y0Qrl91G2pmmGGSw558ZbocFqAfXgv44nnvwtGAye+eDlzmZYA
         MLvtEDZ8itOO0JftaIiEH+vO0NjAr+Zp4v8lyJbssaQfJKkfXeNzABJd0v4fBxTzWiKr
         Yd5TqIPTHDdoIu7FtwM2pRCA8RvmI8WbBHB9vygoGa4eOcoFogaxp78FZneDijXcpt4Z
         QvSIbTbkQmfDwRIWoX7lar/dabmJ33cNtiTaSOjP1hjUfAM1vOss6nDMBVLrxM6Jv7zI
         AjrA==
X-Forwarded-Encrypted: i=1; AJvYcCVtYnNe3VjxNbh1qkIUg7D1q8cebnOxWMzgohMcGjRpHBJegn5unqwbLwMOtpCY5BC/+sqPcEANLO41dQxDssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRRUJcpfzMiCmz0Bw1KGyDkXTyQei5pA9MWi19CMuEAWav0/n
	n0dkreoWLTswQ1lloqd8L8joPJSwkSCnj1MaQ9UOv/mQ8gBrjFRTMl11b7U/NH+ry/JB3efgoXr
	eVZexh90o
X-Gm-Gg: ASbGnct7eFiL/arqZeJDhfX7/3oz0ajdYdkPPJ3Sp5NbfZjEkwiTfle8UcwCKjRVz+U
	yF4qL+nf4wAWhH4m3My4+WkoDVRhPIRYrKBynltpqlWsjmArBguCcHPGrSNOgc8hrbvd767dn2J
	vB+rXpuY4UvSWEsnebyQbzOnrWjA5miFeYou/1SjYi8kq9dmCBGDsTyoTNDV0Mem7POxA0kTmgG
	wM6E2FZhbsqhTDJXjAFYTlobg0Aqx1av4QFpT7CbPDrEsiBCWMsKcVXbR2DQZrTifM+O098IWYa
	xGxFoQImXyhdOsAhX3WcEKmpNwoMgb6gmBeOUhsF52SEQGLb+95MlHH54stcUfNpCHR5kUbWYPQ
	qpQPHusj6iy7rdM44K+7dhW/X3uJZHyLwygCWbmIJxkUOOarh+6VVRQLUyEwz9A==
X-Google-Smtp-Source: AGHT+IHpi1g1Zx2MGSNXJsU9R2vJCZRyOML7K03OiPG0vYfSOtrfOQ0B0LuNhza6I5KH1i8ERFp0jQ==
X-Received: by 2002:a17:907:9720:b0:ae3:b22c:2ee8 with SMTP id a640c23a62f3a-afddd0d2d2emr11895466b.37.1755549323916;
        Mon, 18 Aug 2025 13:35:23 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53c1bsm870717466b.13.2025.08.18.13.35.22
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:35:22 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78c77ebso739606266b.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 13:35:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfiVu5m5yAcVtt776QY5IoeikkghTrjiEXZYnRKvSLx97eoI5VLH2ePQuLlIt/5dGcdBNX2ysRNRCuyrasy28=@vger.kernel.org
X-Received: by 2002:a17:907:94c8:b0:afd:d9e4:51e7 with SMTP id
 a640c23a62f3a-afddd24e88emr11714066b.63.1755549321531; Mon, 18 Aug 2025
 13:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818181153.661431-1-thorsten.blum@linux.dev> <20250818181153.661431-3-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-3-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 13:35:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7Qhz4dNnhb3t4+Bz3Fk5iKxRNwrq8u4X73tpGsg=hyA@mail.gmail.com>
X-Gm-Features: Ac12FXzfHvX5IPb4DpSB34IuOPv7zZbGkqkbrqt_GWvH8ZKvsXy6Qt9lVJvk3rU
Message-ID: <CAD=FV=W7Qhz4dNnhb3t4+Bz3Fk5iKxRNwrq8u4X73tpGsg=hyA@mail.gmail.com>
Subject: Re: [PATCH 3/4] kdb: Replace deprecated strcpy() with memcpy() in parse_grep()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 11:14=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> strcpy() is deprecated; use memcpy() instead.
>
> We can safely use memcpy() because we already know the length of the
> source string 'cp' and that it is guaranteed to be NUL-terminated within
> the first KDB_GREP_STRLEN bytes.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..cdf91976eb7c 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -860,7 +860,7 @@ static void parse_grep(const char *str)
>                 kdb_printf("search string too long\n");
>                 return;
>         }
> -       strcpy(kdb_grep_string, cp);
> +       memcpy(kdb_grep_string, cp, len + 1);

I'm OK with this:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

A part of me would rather use strscpy() the way it's supposed to be
used to simplify the code a tiny bit... AKA (untested):

-       len =3D strlen(cp);
+       len =3D strscpy(kdb_grep_string, cp);
        if (!len)
                return;
-       if (len >=3D KDB_GREP_STRLEN) {
+       if (len < 0) {
                kdb_printf("search string too long\n");
                return;
        }
-       strcpy(kdb_grep_string, cp);

I guess this does "change" the behavior in that `kdb_grep_string` will
still be set to the empty string in the case that "len" was 0 and will
still be set to a truncated copy in the case that "len" was too big,
but based on my quick analysis of the code that should be fine.

In any case, we're getting pretty far into nitpicks here, so I'm also
OK w/ just leaving it the way you have it. ;-)
