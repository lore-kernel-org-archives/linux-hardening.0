Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972D292917
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223519; cv=none; b=IocWc0XbpMlKlpv2k86WOpyOmvuQr5r6NWYY4cBzF3OR5+DeQKDUtpDZUB8Z3l++a1rY96sxbE67pP8DW2YAfYrwHZ04rzy4FP0oziDiatInP/COHY/BeZjXTKZo4hhqeA8GzE+8YqhYmDLAoC2mUtJBeiIq71QSI9ubP1uavTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223519; c=relaxed/simple;
	bh=qORkR3wVopq+YUsdTjTIGDl/nDcPEBniGidcjDhySDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuXsf0vjOB6FW/SBbDrBODXg0mT6ym9l+PQNSZzdv+hSKosqPLKuvWZ1Hg9kElJiPm1IshW23+6H/TBUVAH1izoQl1f50O+bAMlIRYHgitRclTx5o2TXGaoS3b102VqgXGE2rOcZMn2qThNDYJ/X6cZMy0RzkOC0snzJ7PO9sEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aJ24+SUb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aJ24+SUb"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24456f3f669so17231175ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 19:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755223516; x=1755828316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czq9Z+KET/jVXs/EzDrGbxQ/5L+K1L0esuJSVThSc10=;
        b=aJ24+SUbcLOVVK2saXNFltoEkTWFsxp5REUSk4pQGmWF6GCDnAnkS0ydcvI5gGULsC
         iojD87RDfJ8R524DHdu5k8QxHEr5gQrg3R+l/wqxSS/tQt6lDvmnEg+gNdK1Ui9zPDky
         Aa1Dh+NypKnbEwrGcka16gAL55zbhbfWrDtLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755223516; x=1755828316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czq9Z+KET/jVXs/EzDrGbxQ/5L+K1L0esuJSVThSc10=;
        b=lJGGj89XPv5csy9DqVB1ZByHo0LfyyPWJiyzlNRgV0l7/JCOMWPN1GFj0UbIV22H52
         NbjRsLhBGM+UgarBYobAMPbxu/gccvMV1hKSE+qXjEfIEVd31nCyd+rZOKda9O58yqLz
         N3uCpQtzh4F7zfvbUX6L6HAa9RM2YYq2Qj35cyd2Iz6Hm2mPeHgnJP5a+jAFZA/c+reJ
         0cIgOnlzxiHCb8E36/HGz/zALb/wRqUC8D34mR17fAsjn6oHCSHYe4Qn9nSp7Ovh+06g
         60LwsFQaCtkHayg4h0IBcg8kjoZO+t20KcxRCmyP1NUlipA8g3gAlBRX5/V1xfp6qxLs
         Q4KA==
X-Forwarded-Encrypted: i=1; AJvYcCVBso7kDtoXW673N5Wb9GukJAYUdS01R2ehxdCDhabTkDjbBc96zwCZjWbA1wmvX2BAs9jQ+ga5qx74KdsED2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfxWfZmVA8otkNNt66UD8K8KTRwyPDcALuJjZKRj6VIFTJ6BC
	lf7TZymDStCc2FambBhgtmNG8w9+F2sTOL9FCVPGGdrglmZYdMj/kEe2PU17/SZ5fsNgFgLaPoq
	3avM=
X-Gm-Gg: ASbGnct9mOWe7ZD8pA2A/WQNAnCcCxI8jVmrsaMczE5qBN0hkXYREKHIk3EZ5DiLhkW
	M67oa0+5E07j3PzIRWSMvHEMeigMNIHlIhjr+yxFhHdP+8tbOg5eIgPCfwcumCU41qk6c7BSTsl
	Lvv/ltXmnrDxwrPCD5p+W3fPYg4LrA3i4p0mJY5rqCrpwXGDM5wrGZO+UugYX0l2HJ+mdDeQ1Zg
	kSYNrsxYchorzcUCbaiPgYEmYvvxbzC46RPW5orcg+oUEt1lYj+sv3Jy+fyO4WOdEJhOiYrDeCk
	hrd1hINqrUyAwqGfMQ9mRjjymObb9+KpMy9gd95m3ZbrNSU2Iy8jnn16nnqEuh6B8NqPr8MwWKE
	sZ99ydXqN9nFjVsrKKZkNGUJtFwgMyz2hW+BJFcHI2hwtFYdOobNfciye/ZQrSAZPOg==
X-Google-Smtp-Source: AGHT+IE2iQG4/kXZ8m4wznlq/9qR0F/TpogSTnl0WfX6ghVrJdXCWT7h6FRsW/ocOaXOCSDpd4xVqg==
X-Received: by 2002:a17:903:32c7:b0:23f:ed0f:8dd4 with SMTP id d9443c01a7336-24459867c7dmr75844725ad.23.1755223516180;
        Thu, 14 Aug 2025 19:05:16 -0700 (PDT)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com. [209.85.214.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330fc986asm3209495a91.14.2025.08.14.19.05.14
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 19:05:15 -0700 (PDT)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456ce0b96so18495725ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 19:05:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6VpTgLjOTgodub+ZXKjNdeHsTbE6Y2w/dLONvxQrWuWc9p8774MhCo0XMiler1vrrUzGoFeXKsXlnecJoKKQ=@vger.kernel.org
X-Received: by 2002:a17:902:d50b:b0:242:b138:8110 with SMTP id
 d9443c01a7336-244598679d7mr74419825ad.24.1755223514160; Thu, 14 Aug 2025
 19:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
In-Reply-To: <20250814220130.281187-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Aug 2025 19:05:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
X-Gm-Features: Ac12FXyz0N6lYfN0uKFzb67JigmIfAX8HYG9O649Ly1mqN7DuMLlThvvJiVlxQE
Message-ID: <CAD=FV=Udf3pZjhpPxEuHsFynP7GoHnZ7RG=NYZ2gLzm=E_4V4A@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and memcpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yuran Pereira <yuran.pereira@hotmail.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 14, 2025 at 3:02=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() and memcpy() instead and remove
> several manual NUL-terminations.
>
> In parse_grep(), we can safely use memcpy() because we already know the
> length of the source string 'cp' and that it is guaranteed to be
> NUL-terminated within the first KDB_GREP_STRLEN bytes.
>
> No functional changes intended.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v3:
> - Extract the strscpy() changes into a separate patch and focus on
>   replacing the deprecated strcpy() calls as suggested by Greg
> - Link to v2: https://lore.kernel.org/lkml/20250814163237.229544-2-thorst=
en.blum@linux.dev/
>
> Changes in v2:
> - Use memcpy() instead of strscpy() in parse_grep() as suggested by Greg
> - Compile-tested only so far
> - Link to v1: https://lore.kernel.org/lkml/20250814120338.219585-2-thorst=
en.blum@linux.dev/
> ---
>  kernel/debug/kdb/kdb_main.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 7a4d2d4689a5..40de0ece724b 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
>         mp->help =3D kdb_strdup(argv[3], GFP_KDB);
>         if (!mp->help)
>                 goto fail_help;
> -       if (mp->usage[0] =3D=3D '"') {
> -               strcpy(mp->usage, argv[2]+1);
> -               mp->usage[strlen(mp->usage)-1] =3D '\0';
> -       }
> -       if (mp->help[0] =3D=3D '"') {
> -               strcpy(mp->help, argv[3]+1);
> -               mp->help[strlen(mp->help)-1] =3D '\0';
> -       }
> +       if (mp->usage[0] =3D=3D '"')
> +               strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
> +       if (mp->help[0] =3D=3D '"')
> +               strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);

Let's think about some test cases...

Old code:
mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
if (mp->usage[0] =3D=3D '"') {
  strcpy(mp->usage, argv[2]+1);
  mp->usage[strlen(mp->usage)-1] =3D '\0';
}

New code:
mp->usage =3D kdb_strdup(argv[2], GFP_KDB);
if (mp->usage[0] =3D=3D '"')
  strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);

Example string: argv[2] =3D "\"xyz\""

Old:
  mp->usage =3D strdup("\"xyz\"")
  mp->usage becomes "xyz\""
  mp->usage becomes "xyz"

New:
  mp->usage =3D strdup("\"xyz\"")
  mp->usage becomes "xyz\""
  mp->usage doesn't change (!)

To match old behavior, I think you'd need "strlen(argv[2]) - 2", right?

I'll also note that with a different (malformed) example string, the
old code would have also been broken.


Example string: argv[2] =3D "\""

Old:
  mp->usage =3D strdup("\"")
  mp->usage becomes ""
  mp->usage[-1] =3D '\0';  // BAD!


That should probably be fixed too. Luckily this command can't be run
by a user in kdb and it just runs stuff at init time...

Maybe a right fix is something like this (untested). You could even
put it in a small helper so it doesn't need to be duplicated for both
help and usage:

len =3D strlen(to_copy);
if (to_copy[0] =3D=3D '"') {
  to_copy++;
  len--;
  if (to_copy[len-1] =3D=3D '"')
    len--;
}
dest =3D kstrndup(to_copy, len, GFP_KDB);

...of course, that stops using kdb_strdup(). I don't really see why
that exists? The comments make no sense...



-Doug
