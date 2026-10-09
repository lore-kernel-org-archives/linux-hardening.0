Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CB45C6E3
	for <linux-hardening@vger.kernel.org>; Fri,  9 Oct 2026 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528753; cv=pass; b=bxAiPbevxY6vt9JsHZ4mMnDRXsjIGQqRPX4J56i2qOiAifyYqbFa8ym+kuXnwJXhRsM33kLVhmv/3MTG1FzIZNcPL8NELd/YgRlmD0VIKrgjzxRxobtSrmldWPaLbO8r4TqguV/8fjs76Iwl76BHGEuD9R+qNUOuS12HKLftVY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528753; c=relaxed/simple;
	bh=4NY3b/9uFqqbJNZv2e54a4GGP4HJaG4h9wCOURl2pcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXbyYqddZV2yaPTegZuP29Zxh5T8qEn0VlEEz9gCUeAreMlh3ATvLiI2ljSAKw60Xujn355+ahXda8WW7R3N82S04O+CsALFKOLxbvqlOxY4fhsacwAUJYjLEj8I8JoLyO3uMVn+bmnONn5lqi+iKeediS6aUBSF53EC4dGeJTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdAMV4Ni; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdAMV4Ni"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso4291870a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2026 23:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791528748; cv=none;
        d=google.com; s=arc-20260327;
        b=ROaXVeJ0iYj+gelKDT/baYNWAwHnRRyHMCTNlMOj7BVG1QwG0JeH5XHSh+p7+/aa+9
         O5h58zmK7Gq+Mk1xLwsL/XryiYVMSmJfNA7byk1JQngRSY6FqzRIW9Vk61G/KybTAN8+
         jG/h1XPGQQjgfeJNhEBkj/uRxnTzP8EPoD7IBFAXvxG4pHHBYCB477y5nyn2+JADD7m1
         HIsS2jqk+GZzNLVNJB1S2apZ9CL8neJlqgBCUKOIUYzCKdr/7LB/khzT6htAbYlWagQR
         2lXfTHwup0sLc/952gmOGV62usHFSMr1p0raYa6NttO6ksPO2ZG/lxCKR0NAR5nTyjXL
         YLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+dS3K8yuawIJTpHR5tebZaf9aB405AvauMGqVL4l6U0=;
        fh=CvH7TF1m2mQClmFHEtr5zBJ4J1CZcpwRgG/7AQZ0YFY=;
        b=KBXAzdq7UIg/s+Sy3yiNo9bJK1MZPSJex1HXOPLNWhnEPzlNC/KhbRU1vsxuly8qYe
         J48wdeWi8UwKgNxhtYBydE7fSGYu7/IYenGABsVLxr3Yef2fiHhCSH6z9gyI67DCs7fo
         PMErB0KkxE45AoUNImuKPl3RDnPw2Vk1rrjOJMmwvJ1l1IvYpxbBUT+GXNSNwBE89bNB
         kITAqtSo//8C4U+ZGPWnU4d2Bo3C1ES+6gyO2sj/t8QjRMLG26Sj2gt0A2k/RrOK5j05
         YiieFv8/gQxJZ579t7Q6ymC7hdcKhYOuXRmBLSPQ9a+PRyEctDXZfxv3vit2fFk9RUz2
         n5vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791528748; x=1792133548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+dS3K8yuawIJTpHR5tebZaf9aB405AvauMGqVL4l6U0=;
        b=JdAMV4NiOsNnKzodZ1REyjHh9rZxhax/u/cAmbUKdeMyaIR1WVQqMK33pFmHUGKWWT
         w4CEDkbEG6hiL+/e3UBo2iR65oNMPZsAOB2f8jGB4KEyQJduOVe94SuDO74cK6ZNbJh6
         XQMPcVq7tNvG5KZqLov5JgUtSx5+OYkh3UA6ePd+Y4ec7M3sFMCs2Ktw17qA9QbeiHKw
         epCwfJskhgIKdvANnwtSmb1t4TvjvaOfO9DXT1RdC54oQ43n6PKnkTQxR1kAc2E+dBWZ
         69EIHWDrKqZqb/7/q2WQVkY3UDPYX1pzoI62PVaqmpP0CXR1MFDXzGt+VRcereBHzpcU
         Ouhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791528748; x=1792133548;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dS3K8yuawIJTpHR5tebZaf9aB405AvauMGqVL4l6U0=;
        b=VfE82Qf2EnpN7NBY7IVci3uIj3Dgv4/GVQmQzdNZX4bWMuRzTKPqN2ZWm9S29wYOa5
         0v91zI6clih/kbWMNhEe2KVd/FtDqcRLPWpeLIB5uvv2ABjB90a9cHZ8DcDYmXbfeV+A
         aODOIZI0ml3Xn5p/VirebZE78IDPVVR0q3PpGFG+isWe0IQa8Me82ZcTn8gZaH7f6MbJ
         hDiAv2g7UAwsAuwdf14zTyEl4rvcDugMqel/NNbX+7hC6XJKMrdv/wM3xgNnrqMrsaOO
         RSKtadzujkgSj7AHe0hKyBBUSsYhl77leyZqv3XHnW2yy3CcY/2jLaEk1AbTdx9cvOjI
         PY2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxrZFLyasVrGpuEMl5mTyp4vHzaZA2rD18S6iG5FKYhxKGrKxbenFjcNOVPd4BJgtOOG4J5beruTaNC/LCVlhE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn5i6uJkj/2VyA7hBe8MIuzKYnymx3VpmvHLW1BsGgvxfOmCC3
	HvIfqVPWipWjjVaqOwA4V54PD7xEK4/HeuojswvZubP7fbKDF0rndWwv1Y4oMyNWPILbtb+wnrO
	LxiR6iltMH00RHSUNDrQC7cgQy8P+qfA=
X-Gm-Gg: AYBFou16pyoC3ghAGgzLifdPJjXJoO5b5RwVHtaypkMw2nLgM7avcN0yhNkhgjZXFQf
	xyC0i3mJTOnPWYQuF2TAbciGD8jb8s5NIEbyMDjtjCunLG2dt9eGNWSLh0LmyzVVzHTzRawszZE
	lxY5hSVFLWI5et7MRMULBuet3oieZjnFTvGTE1qIhngA2LDiZ0NbyiwGdzXMCGNr+J9RkLDATOW
	ao6iq9O6LmuXg2fBuR7QsSHt/NKcHoNNheFChcgmAef9E2rOkywDuNstrRz4t6htt4ZyTqiR9GI
	k7glwcx6nCvG6nL3+at4YV6o7YAP7/K2FavcCV/FmGA202fQSl+DNJjF74mt4qnEK6Zf0zKd77f
	XB/wPx+Rd8x6S6bJdTBVJIV19arEVENJqsc6SaBrLYg==
X-Received: by 2002:a17:907:a089:b0:c2d:cbc9:3529 with SMTP id
 a640c23a62f3a-c31a9ffd78amr101019566b.20.1791528748116; Thu, 08 Oct 2026
 23:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com> <20260905-arch-kconfig-options-v2-v2-8-83e8245761a2@gmail.com>
In-Reply-To: <20260905-arch-kconfig-options-v2-v2-8-83e8245761a2@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 9 Oct 2026 08:52:16 +0200
X-Gm-Features: AclHuK9oTCyjIBQo-KDpBuWM_JxhK4IiThl5vFb7lnINqfE-VDcwwfdZ-Pom2sQ
Message-ID: <CA+=Fv5RJpeusA2W4rRHOJMPRn8iF=OngRy05X22Myurs0wA-sQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/22] alpha: select ARCH_SUPPORTS_INT128
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Kees Cook <kees@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Sat, Sep 5, 2026 at 9:29=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> gcc supports __int128 on Alpha, and the 64x64 to 128-bit multiply that
> the users in the scheduler and in lib/ care about maps onto mulq/umulh
> rather than an out-of-line libgcc helper.
>
> Gate the select on CC_HAS_INT128 as the other 64-bit architectures do.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 2672971b83f3..bed3f1c8d9d2 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -16,6 +16,7 @@ config ALPHA
>         select ARCH_NO_PREEMPT
>         select ARCH_NO_SG_CHAIN
>         select ARCH_SUPPORTS_ATOMIC_RMW
> +       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select FORCE_PCI
>         select PCI_DOMAINS if PCI
>
> --
> 2.54.0
>

The kernel test robot reported undefined references to __ashlti3,
__ashrti3 and __lshrti3 with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy.

Alpha doesn't currently provide these helpers. CC_HAS_INT128 confirms
support for the type, but doesn't guarantee that the generated code
can link without libgcc.

I suggest dropping "alpha: select ARCH_SUPPORTS_INT128" for now and
bringing it back once the required helpers are implemented and tested
with size-optimized builds, including UBSAN. Removing the select
eliminates the missing references in the affected objects.

There are no functional dependencies on this patch in the rest of
for-next. I tested rebasing without it: the page-table-check and
hugetlb patches each needed a small Kconfig context conflict resolved,
keeping their own selects and omitting ARCH_SUPPORTS_INT128. The
remaining commits replayed cleanly, and the resulting tree differs
only by that one-line removal.

Magnus
