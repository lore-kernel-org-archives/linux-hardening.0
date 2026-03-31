Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C64365A17
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977404; cv=pass; b=Tm/DkA8mob3J+BUpajmz1iN2HxRxYmwQa5EhD7hTxZaxhiuMxfx0OQLmvSRp7ISgoqqM8RFVR/eoqSjD0zU0mtswvNYmq7PEBxfsfakZmpqhDKbCWpVsf6TXDaSxsb7bhJO+rdBtnjKVJ1kNvPmfozbA1lSYNhq9KaDSH+o7YZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977404; c=relaxed/simple;
	bh=AlaAv/oY4ZLWVnm12PAYx9dKZ0BFTL5ugcVHQKGpG3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ru1ObEh6dO1iQoJdVAfRrKwFTaKTbBQRBYQrFyVS0mo067TR/tDlnfK6IJi+rqqCqEEL3Y2LfRILSKPRps8oLdjEt86yC5D6eZ7ef6EtR0HzQmow4r/gxhia2RmPP9ty/Eyrr9XScUsLE77M/Y3zk1qbpVnRiuYG/IOUQdScWkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MK0ji7lx; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MK0ji7lx"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60328744754so3688405137.3
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977401; cv=none;
        d=google.com; s=arc-20240605;
        b=av9De9pBdU5NSHzmYGyVvyzCUPCwgR0oLOSrfauG9T0maOSUj9FoQ32u2+PHGzRXqX
         kjIOhmBySLpZXoP2ho7QCPrnKjTx48v/d4ynXk/UtMEHZkw5DDBi9zZiyFLFbmxpjCeD
         FuJBSqGxwR6aenWgEMSibAkErylQNs5MaRThGFHKLA6XEgobjirZcsjLgx/wR/fXapl+
         ed18iRxNOBo2L8Tgt05E0hFO/SBODqEs5JULTepcA6aDA3jxG5p/TzQ+9ZxK0ncWSXpL
         xP34PKLTdGKB8qQROJsFNfVhVR+f5AC8wupZRdNjiqr6fOt3up1HifKntJYD0APCzjB3
         li5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8hJONhGlSkQz5oARDr2KezeMGnAwxGjBhhSBkIE6ImE=;
        fh=ntIkO5gYEXoXfe0HjdxxXUxHtt7soGfJROsic05AQDs=;
        b=SCpB2r+CLlixP3RJImDNkvJJOrYAXZyVwR9HYmk6TnsstR1njSI9sSNb+SzU8xYlQF
         USxDGsauaiK7NAOKvdKXsBOTIt/vOv2R1PP7vUsy5ODjYnHi0w5rdNqdTjrz7I+wn8Ef
         Ag7djTXeEroeBliJXeIiy1rOq8NxW9iQ/+0RlCtIPoIwq6b1mXdPU6L8H32lf515qWxb
         cWwJVK/mBvvtYzDfUWDjJ9D55A5rljt66IYF5UjCDfDAKjlWtYCvDMYY1A3dgs0FL1yH
         wUwyJ8FGsKU+yOli/wQacxz4zWQKbkSqayYQGF8dAPyn6DKXdCCstjL78AmGG1Q+9c9b
         ilQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774977401; x=1775582201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hJONhGlSkQz5oARDr2KezeMGnAwxGjBhhSBkIE6ImE=;
        b=MK0ji7lx5K+4J8My7zWUMRzX2cDA1hoBCASSEgK8e5DPbLIag/wFTlulTZrauW9Nbn
         0+B6u5lOwAku3SMMMXFnIGNy8HxowIu+HV2bkvgwE45DvELmrOu7DV0j7jO035bXxaNf
         LOV/p7SznWRuTDaRHUS7EZmYOyROphaWZ8GnYO+x8Sw09jk8lhWg+LBHZS1wB12+dKYn
         cqiQm1xlVQ4V4/OMUw6+tPrJvAJkY7poDW9VSxWLv1lT1HplEV/s8XPUfGCFbf5EEyNe
         tr/GeAoV1kwLZHsLC3PMkhU1slo8LxiM/A8dKbmk4R0xZE7TxUo15q6Tr4aLugaY99KN
         86Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977401; x=1775582201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hJONhGlSkQz5oARDr2KezeMGnAwxGjBhhSBkIE6ImE=;
        b=irVeS7GXPi02Y/S8qnJ019aVER0/Ue6cAP7FTwaMI4uWk3YPuElTgbXX2k/SeP7+dX
         /+DwyEb0qQ3Uw7rhX8v5BlG+6yhp16P5NzW7zWCdewe2RVDfcdLPjte1OITjQZwGZp1T
         l+FXAsEtHNo2XLSe/Vgv7a1AHzM6+ONbs55x4JgmOSKw/0rbTMapKCeYhsYBhVe67QiL
         0WxvPYHXZfaEJkEaBMnX5mhclWA31zUpT6HTyXQzujahsqU5zk7lSfGpa+CKa5jpWuQW
         xQFUnpf8y2mjRRDBq+KQntLdFJiMXf8qKxtsC+9DgKOHOmZQf3r00geOap6gfzEgBaEI
         0AZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaElISevs//5adv5/y3WcXsucD9LG2PlfvAGmAHDdT3+Nuu3418fR0aQOJGagSyTqunZ2gIihMe84F49rajAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgM1hbAd/7eTshgFZrEhbmZ0XG6bbYBD6qItDi86+V2z4fa2Eo
	NkatBC71mKL2+5EPt/T3VsbpXpVVt1tloicYaae1ojwhkQP584gj553j8IvfF5DMXDpV6qmSI8F
	qog20I2dPZuwlh1U2IvKGq1aiQVsR5fTIzEbZfo8r
X-Gm-Gg: ATEYQzwpIlKJAYox7UJADOCsL6rdlhVuaRPSysEAbS54q0J5shHF6CHM6t4DoWSAR4j
	ZXmgOJr79m3XyuxGnFQcjIU1HolVZ/nNC211f39OpMdDfmKci0+WRuuVAq8WLhbBXM5H7DleVL8
	rLDJsI2S6FSJXRgw5jDXaG0m4lHiNAQ8hkGANo7WX8bpVMy9G652pdZEhSedhO22zfAZoeUV4A0
	fLZYejBik8x3ptZOjZ9RGwbkhap5MLi8q4xrFeYKmUPrZlb3YN0qrYO5aCY9dUmqAD5AidZrY3v
	EZocEL4=
X-Received: by 2002:a05:6102:c94:b0:602:ace8:f20e with SMTP id
 ada2fe7eead31-60567e8d127mr38526137.14.1774977400614; Tue, 31 Mar 2026
 10:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-4-kees@kernel.org>
In-Reply-To: <20260331163725.2765789-4-kees@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 31 Mar 2026 10:16:27 -0700
X-Gm-Features: AQROBzCGiv9foA1bZmO6VZEpCJ9MD_wSGSd-WaAakLK22vknVxHA_3Jppbf1n18
Message-ID: <CAFhGd8pqeckxVVmNrGkb51gdaeTa7MY3BvsRfWVBGd_i=oZxEg@mail.gmail.com>
Subject: Re: [PATCH 4/5] lkdtm/bugs: Add basic Overflow Behavior Types test
To: Kees Cook <kees@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Marco Elver <elver@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 31, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Exercise the end-to-end build and trap infrastructure in the kernel for
> __ob_trap, __ob_wrap, and associated sanitizer ignore patterns (i.e. idio=
m
> exclusions). Add a test for each of the basic overflow conditions under
> CONFIG_OVERFLOW_BEHAVIOR_TYPES=3Dy, as well as the corner cases associate=
d
> with promotion, casting, etc.
>
> For example, executing this test with CONFIG_OVERFLOW_BEHAVIOR_TYPES_WARN=
=3Dy
> (instead of CONFIG_OVERFLOW_BEHAVIOR_TYPES_TRAP=3Dy), will show:
>
>     $ echo OBT_ASSIGN_TRUNCATE_TO | cat >/sys/kernel/debug/provoke-crash/=
DIRECT
>     $ dmesg
>     ...
>     lkdtm: Performing direct entry OBT_ASSIGN_TRUNCATE_TO
>     UBSAN: implicit-conversion in ../drivers/misc/lkdtm/bugs.c:825:10
>     cannot represent 'int' value 2147483647 during reference binding to '=
u8t' (aka '__ob_trap u8'), truncated to 255
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: <linux-kselftest@vger.kernel.org>
> ---
>  drivers/misc/lkdtm/bugs.c               | 253 ++++++++++++++++++++++++
>  tools/testing/selftests/lkdtm/tests.txt |  10 +
>  2 files changed, 263 insertions(+)
>
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index e0098f314570..f00c9099957e 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -817,6 +817,249 @@ static noinline void lkdtm_CORRUPT_PAC(void)
>  #endif
>  }
>
> +static void lkdtm_OBT_ASSIGN_TRUNCATE_TO(void)
> +{
> +       volatile int big =3D INT_MAX;
> +       volatile int wide_low_value =3D 5;
> +       u8 __ob_trap narrow_low_value =3D 0;
> +       s32 __ob_trap same =3D 0;
> +       u8 __ob_trap small =3D 0;
> +
> +       pr_info("Performing same-width assignment to OBT\n");
> +       same =3D big;
> +
> +       pr_info("Performing small-value assignment to OBT\n");
> +       narrow_low_value =3D wide_low_value;
> +
> +       pr_info("Expecting trap on truncated assignment to OBT\n");
> +       small =3D big;
> +
> +       pr_err("FAIL: survived overflowing truncated assignment to OBT: %=
d -> %u (ok: %d -> %u)\n",
> +               same, small, wide_low_value, narrow_low_value);
> +       pr_expected_config(CONFIG_OVERFLOW_BEHAVIOR_TYPES_TRAP);
> +}
> +
> +static void lkdtm_OBT_ASSIGN_TRUNCATE_FROM(void)
> +{
> +       volatile s32 __ob_trap big =3D INT_MAX;
> +       volatile s32 __ob_trap wide_low_value =3D 5;
> +       u8 narrow_low_value =3D 0;
> +       s32 same =3D 0;
> +       u8 small =3D 0;
> +
> +       pr_info("Performing same-width assignment from OBT\n");
> +       same =3D big;
> +
> +       pr_info("Performing small-value assignment from OBT\n");
> +       narrow_low_value =3D wide_low_value;
> +
> +       pr_info("Expecting trap on truncated assignment from OBT\n");
> +       small =3D big;
> +
> +       pr_err("FAIL: survived overflowing truncated assignment from OBT:=
 %d -> %u (ok: %d -> %u)\n",
> +               same, small, wide_low_value, narrow_low_value);
> +       pr_expected_config(CONFIG_OVERFLOW_BEHAVIOR_TYPES_TRAP);
> +}
> +
> +static void lkdtm_OBT_CAST_TRUNCATE(void)
> +{
> +       volatile u32 __ob_trap big =3D INT_MAX;
> +       u32 trunc =3D 0;
> +       u32 small =3D 0;
> +
> +       pr_info("Performing wrapping too-small cast\n");
> +       trunc =3D (u16 __ob_wrap)big;
> +
> +       pr_info("Expecting trap on too-small cast\n");
> +       small =3D (s16)big;
> +
> +       pr_err("FAIL: survived truncated casting: %u -> %u (ok: %u -> %u)=
\n",
> +               big, small, big, trunc);
> +       pr_expected_config(CONFIG_OVERFLOW_BEHAVIOR_TYPES_TRAP);
> +}
> +
> +static void lkdtm_OBT_CAST_SIGNED(void)
> +{
> +       volatile u32 __ob_trap big =3D UINT_MAX;
> +       s32 neg =3D 0;
> +       s32 small =3D 0;
> +
> +       pr_info("Performing explicit sign-changing cast\n");
> +       neg =3D (s32 __ob_wrap)big;
> +
> +       pr_info("Expecting trap on unexpected sign-changing cast\n");
> +       small =3D (s32)big;
> +
> +       pr_err("FAIL: survived lossy sign conversion: %u -> %d (forced: %=
u -> %d)\n",
> +               big, small, big, neg);
> +       pr_expected_config(CONFIG_OVERFLOW_BEHAVIOR_TYPES_TRAP);
> +}

Note to travelers and testers, we still have a compiler patch in
flight [1] that fixes a bug with sign-change instrumentation
concerning OBTs.

> +
> +static void lkdtm_OBT_MUL(void)
> +{
> +       /* Promotion means no overflow checking can happen. */
> +       volatile u8 __ob_trap a8 =3D 100;

<snip>

[1]: https://github.com/llvm/llvm-project/pull/188340

Justin
