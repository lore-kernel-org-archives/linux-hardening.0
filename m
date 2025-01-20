Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAADA199EB7
	for <linux-hardening@vger.kernel.org>; Mon, 20 Jan 2025 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737409388; cv=none; b=rWFJwQKlt+L3sd8YGFlcv5isLrcJOUZUzZKRJvjnwykQzXXih/fVqh6nq29nkEyENU++fCU+RF1inYnlGZVApTXohCFXZZNXlUYcjQ4jOY2S2yllf2fYQD1nZs+5lg98f/yKbpbD0hVLj2fao3TY6s9l74J7SDjCKwfFteuOyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737409388; c=relaxed/simple;
	bh=XWfIEXm93QRmWkKbfU5UTbnY7CJbm+cc8Pdw/A45k68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnuTAKhSyzPnTsHVeeAmzKCtgvx3u/IPWAyCTWv0+cJ/h7MdGzZRmQz8dl5FOy7J7jVhfOTK8djVNIVqCZtPLBTXKSa+RIblY+vgSl8YXhgJxRA5xnGgBQLS8ULgugnJXyXHIB8A99gXPKDJUMaf1Kxw6b0tjlBdsONIbcOHjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J7mNnhU4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J7mNnhU4"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e460717039fso6476238276.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Jan 2025 13:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1737409386; x=1738014186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRbNRaRO0SI5VgVGLEKrB6BcQTgHuaf5bn1tG3/NR8Y=;
        b=J7mNnhU4fdyVu11tHRi2Y7OYapFkrjYCpqpN18SzoS6SGfEjMMShzGrKVZy7ujOpCj
         by1LS4LgpDbYOKksvwjS3KdLIieldu057yKM9UktZnND6khFht+PCTVUEWYzXThaVDOK
         FH/E4bmy2oK5jR2a8c0vXew3hSl48YAlt8LsxKRzQUwhrMajxyIWg3b4oHWIjdsZWhZ/
         rEtPlA04TTDzrtz/cCxO8W/ujn1ncKubvd4Ekz8baacAAlY6RfTI3Ecw1WA1vcI9IbfI
         Qi9m4g6cyGDVKS5XPX6LKsQFGiXE0UJo/hzyCRP4tre5o8YqxT8+/vE8QJD8bB7aEuiu
         sklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737409386; x=1738014186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRbNRaRO0SI5VgVGLEKrB6BcQTgHuaf5bn1tG3/NR8Y=;
        b=p0Yleg5TGN5wzxOCCCJlbhEqvdO0yJ6wGarvrAikjP33bHUt/UidGJ9kd74E0m4Fgs
         6MbIKsG0rZQlimHEzKpuAy9weLd6SmETfu7fOm6mP5br6M79coBOAZI2Zxk53pbUWmCf
         KUqWM6+m5r41nmr12GyuZ3r00XIZ9lN4yS+ZgyyYF6/DEnjUg5zQy51VcIkpsj7t3XJr
         mNTlsZnG4SWD+iDEVqt1VNMal4bFOzir5D8OBv3UfiaLVoreJ1ULEFxo5Z4i/9qUQupK
         WgsKDPQT52SJ3TZjcMZDAw9l8SeHQ8oU8bZysLo64/8S20rQ4639+Z4rq9Bmi7RGub8D
         OzAw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Zuf9rpq99/u0xjdEzqrG2pqnrhvyWyHZlFgUHa4ZX3KQmr2/YArBPyCbyjCwG2bSuUbjmq1Zp76//u1ONpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQ3FtYxR81g0R/mHaOcUnnr+vWwoUTuVqFIMW+vLSPB0Iczq/
	qEAiSt7tt9lFIEDktRWvQtXQg2pyihMTmibz1+c+lgaFF3d4UFCL1FkMgq2gOypvxwmmd/xfICI
	ZCKgqCq7uXsTZS6km21gLSoOBHdCKuCOKIQqH
X-Gm-Gg: ASbGncsUMjMhspYerrEhTfnxM4IRRm4GDbc460DKZzx2EerZ4YswICO2oL4hczZvXeu
	ooo3H8LAC1gxIl3Yzw6NpopRCnwmRxGDbqkrLo0igPPneeqRy/Q==
X-Google-Smtp-Source: AGHT+IEfkrZcZaM4OcrwCCFu1ppQYb+u+0+ZvF4kaX6gB/GN5nxINxXC4jtIf/eTUO8QmrMg9CKoN9zG4ass7aKatF4=
X-Received: by 2002:a05:690c:358a:b0:6ef:a08f:8ec0 with SMTP id
 00721157ae682-6f6eb693fe4mr107326777b3.22.1737409385678; Mon, 20 Jan 2025
 13:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117130337.4716-1-mgorman@techsingularity.net> <20250117130337.4716-2-mgorman@techsingularity.net>
In-Reply-To: <20250117130337.4716-2-mgorman@techsingularity.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jan 2025 16:42:54 -0500
X-Gm-Features: AbW1kvarg3nT_WvZxhZbYVBI0pQNrEUaQX4QBAPYffpSfIxAizJCMp_I6UozxxY
Message-ID: <CAHC9VhS-UNb5LkjsihD1sNnSajpKyHZMym8oPsRMwTepmNpo_g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: security: Move hardened usercopy under 'Kernel
 hardening options'
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Kees Cook <kees@kernel.org>, Daniel Micay <danielmicay@gmail.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:39=E2=80=AFAM Mel Gorman <mgorman@techsingularity=
.net> wrote:
>
> There is a submenu for 'Kernel hardening options' under "Security".
> Move HARDENED_USERCOPY under the hardening options as it is clearly
> related.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  security/Kconfig           | 12 ------------
>  security/Kconfig.hardening | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 12 deletions(-)

Agree with Kees' comment regarding "Bounds checking" instead of
"String manipulation", but beyond that this is fine with me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/Kconfig b/security/Kconfig
> index 28e685f53bd1..fe7346dc4bc3 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -159,18 +159,6 @@ config LSM_MMAP_MIN_ADDR
>           this low address space will need the permission specific to the
>           systems running LSM.
>
> -config HARDENED_USERCOPY
> -       bool "Harden memory copies between kernel and userspace"
> -       imply STRICT_DEVMEM
> -       help
> -         This option checks for obviously wrong memory regions when
> -         copying memory to/from the kernel (via copy_to_user() and
> -         copy_from_user() functions) by rejecting memory ranges that
> -         are larger than the specified heap object, span multiple
> -         separately allocated pages, are not on the process stack,
> -         or are part of the kernel text. This prevents entire classes
> -         of heap overflow exploits and similar kernel memory exposures.
> -
>  config FORTIFY_SOURCE
>         bool "Harden common str/mem functions against buffer overflows"
>         depends on ARCH_HAS_FORTIFY_SOURCE
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index c9d5ca3d8d08..00e6e2ed0c43 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -279,6 +279,22 @@ config ZERO_CALL_USED_REGS
>
>  endmenu
>
> +menu "String manipulation"
> +
> +config HARDENED_USERCOPY
> +       bool "Harden memory copies between kernel and userspace"
> +       imply STRICT_DEVMEM
> +       help
> +         This option checks for obviously wrong memory regions when
> +         copying memory to/from the kernel (via copy_to_user() and
> +         copy_from_user() functions) by rejecting memory ranges that
> +         are larger than the specified heap object, span multiple
> +         separately allocated pages, are not on the process stack,
> +         or are part of the kernel text. This prevents entire classes
> +         of heap overflow exploits and similar kernel memory exposures.
> +
> +endmenu
> +
>  menu "Hardening of kernel data structures"
>
>  config LIST_HARDENED
> --
> 2.43.0
>
>


--=20
paul-moore.com
