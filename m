Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC352426D32
	for <linux-hardening@vger.kernel.org>; Thu, 26 Feb 2026 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124434; cv=pass; b=k+Hfjf7YECZJ0yxCjpjgkVZEJJ9bWuBtMkJofp8IZAJDg2L1CFeld0nT+8nsOUHj/xhzA4Ut46njmRZtzKaCK12qUMoOiK7jU0+mTsR9wzNuId+oOjX7oIMe9hN8XQBEbrdxfR9Ga5ghNxtGu5o/w1Pg0xgjAOIYImnoU1dklAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124434; c=relaxed/simple;
	bh=8Q8GqJM16brRxTlXaruRQ469xvGDUaszSRF7hS4gtU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MadbYTwsPWmgsgMwn0YZnc3od/MTIfCDtPyzNO1Kz5F68OnLcBRYnqqgaoa2UKIjEeWOuWetx4N3lAtwRy9LyJ7scJbjuoA+d9SAhePtuLx4s2yLMTmgR+TF11wERiNnlA/BEGJX+63Xs0WWWX5NaRdeag90/62NgJ6a7qxZeUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCUJ5knj; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCUJ5knj"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127337e3870so88608c88.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Feb 2026 08:47:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772124432; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWS9BjQOWv6rrQLXpzYgFzKVRIKpXz1g0YFNxCCEsymn2oZWu0P5tab3q4Y2Y/7vDP
         sPbYaaN4dSGqc5QqBpT5XXpbiUjvdj5ztpSzw3JqqNka7ysH4kRukGZV18dA0k6QnwgY
         aOdskZtdt++hBAvVaDpih/inieGtbx9PsUblonTqG0T6R+ksofbL7cHR/rIEAOS/UEzI
         y1eEEFsJpGUbyyutq8p8Gnh+t+m+5frKy/hG24odRd39mbrKzQnbXLE6SAKolvz1pQwS
         BwMi6Hvv/7OyHlAH107Gp9+iA8EB9UPsmfKS9HmVGz6kURHSdJcG57zTUje4Xff8+U58
         orHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=14b7Avo43YlZe+hxgSc9nKn/f7gq8EMXA4C+O7gB90A=;
        fh=3BashU7uC7T19np0kYDd/kHm5tUPhNiD0RseBLBuaGo=;
        b=Z/VkTiogAQlJVI6TWdxIA82mUdReycxFUGzZXM4ejluga6NCYa+hmBJpQgnoS8buPi
         8uBk2fj3U4UN+QzBa7C/K86JrcXA/axKdrHY6JjA+xqv8XrjLeIp1podc6Nary58gbB/
         LfDgfOb/sZ4vsItcFcmhm0xa0Y/Ow8kB7/Ti8x8Ao09z4vmgTi5qdZ2VXm6w9vNgwVSh
         aFjK4+QOfd98ul8uNaD8yI+jvV8z9FIiKYNF/h6BTalSO5RdCP98R0g5gi6n5n58m7fn
         IXdNJmUQRSxFOl7RxzZJWH5MACk97Ncbgn5vWWpsoT5G3uQZe1O4vrPn+c2UdIzOJlyT
         YyCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772124432; x=1772729232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14b7Avo43YlZe+hxgSc9nKn/f7gq8EMXA4C+O7gB90A=;
        b=SCUJ5knj6/QHRwcQnIFkt8989tK5tUCRvEGYDpFOT3OYv2sAMJfdlHhWiHHchzS04R
         7CcdFXMpGzr4IkSe7jpI1TTfUVhxvO5fE6wcxqKxxGDw5aCWma/l8pKMXvW5XzG/e76C
         B77EzCr9z910J66mi9G9Lhcq2nXuIE0IixB/0GoaUWPvnE3huVTZcS82DXp0O3kGw/CG
         GfT7vINE0dCa7fplwVnXGUkntUukWxy9gt9XJQw+oH3Auo8V9tf43poBcYUhTqhtUKKd
         iz8E9cXMLsTHVa07toCzGgQObfIp1rNvyFaZD6mucW88XylIDtV71dDlijhRgIgaSWaJ
         Ga8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772124432; x=1772729232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14b7Avo43YlZe+hxgSc9nKn/f7gq8EMXA4C+O7gB90A=;
        b=UDKYq5tX8RgSQpoAm1gRgnPluRZqWQIzARfAE1o3Z3d4WnfA2k9xzeHY/WRBKgUOPz
         29HYU5YWF3eeXQIb92fFfX06PZEo7p5ra5HJJRsEdk7ddfYuQksD3NzXY7iQaHV9/6Rz
         bkpJQjWCUx2fmI5W40o1+LiqR2OnJEIdCaxntBtrBfmcMYJ5DdN8uVBtC7Ru6KpLh5d8
         4JLK37UJ48dCZQ9Q3WbDNpod1RgXx7QQ8cMk33p5B9NqGPMk7KVoasQaVnKGHlfdFMh1
         phGGz8kjffj/oaWKSrn01UVzYygURzITc6B39qGNVeSjgf9RdiS6zIl6mzS0bhUvIyC5
         57fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZWiri1ZzxuJkqTfM7mVnPKmwVuut89o5RMJJRsZEpFcoERBT3/C9Yyel5/g5rZ/2G1Ypcp3jiYNUrff36hYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQU4jAzQK+ooy5AOF0f5gl3KxZ2Zs7FaCIUhsAhKq/C/iT+Xr
	tWV1NLBVhad7JebcmJsEZ4Q6dzfrs0a9C4Ed6Bcb4mbHUuzhuTUEpudYIk/9VRSCbUDrR9qZyp6
	WXdkJLFlMuksLyWMLUOtW2MNaG0hD5Uw=
X-Gm-Gg: ATEYQzwXsgCC++yp/rbVfHtj0+1Ba0tfQ6l7P1Wy4Y0KsQhfIiE1ecv6s/9n07x2KHd
	ropubcA2hJbGIeemOXB0pXT4ZDWwscZt1u8ndOscz3PzInjinUPxBDiXS9f6NwHbhhU2WCWEmf1
	eiURTwtmknqbudts9Gf2NNQdtozEmDmpUdIvpdm+MnNnMvVcqxwjjT00a3Si/OaXdd+GmoYf5g7
	mPHmwfdNuNORdmAKJXJy99lclAvqFN2HWQ+k0PrcIWnEocGL0q8CtQ1MTsF41YxA7oPIsC08JWa
	d7i4Og0xCAXYySGs+po9Tb7mjj3ksDZHmYxT3RefiJcplV6cAgK3yfxK/JNZ7GFNHpydfw==
X-Received: by 2002:a05:7022:521:b0:11e:3e9:3e88 with SMTP id
 a92af1059eb24-1276ad1a953mr3945750c88.6.1772124431737; Thu, 26 Feb 2026
 08:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225174702.it.918-kees@kernel.org>
In-Reply-To: <20260225174702.it.918-kees@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Feb 2026 11:46:58 -0500
X-Gm-Features: AaiRm51xyAWxRasXbIsk-hsIItXJk-3QDBUo6dz1ndGIfSkhqxcHNt_CuM4bM8E
Message-ID: <CADnq5_MWNLM+KUb09LgPUq6QsY68paojSAWXEZ3n+YLHq0ULxA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/ras: Fix type size of remainder argument
To: Kees Cook <kees@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, YiPeng Chai <YiPeng.Chai@amd.com>, 
	Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Feb 25, 2026 at 1:04=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Forcing an int to be dereferenced at uint64_t for div64_u64_rem() runs
> the risk of endian confusion and stack overflowing writes. Seen while
> preparing to enable -Warray-bounds globally:
>
> In file included from ../arch/x86/include/asm/processor.h:35,
>                  from ../include/linux/sched.h:13,
>                  from ../include/linux/ratelimit.h:6,
>                  from ../include/linux/dev_printk.h:16,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/ras_mgr/ras_sy=
s.h:29,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras.h:=
27,
>                  from ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_co=
re.c:24:
> In function 'div64_u64_rem',
>     inlined from 'ras_core_convert_timestamp_to_time' at ../drivers/gpu/d=
rm/amd/amdgpu/../ras/rascore/ras_core.c:72:9:
> ../include/linux/math64.h:56:20: error: array subscript 'u64 {aka long lo=
ng unsigned int}[0]' is partly outside array bounds of 'int[1]' [-Werror=3D=
array-bounds=3D]
>    56 |         *remainder =3D dividend % divisor;
>       |         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c: In function 'ras=
_core_convert_timestamp_to_time':
> ../drivers/gpu/drm/amd/amdgpu/../ras/rascore/ras_core.c:70:19: note: obje=
ct 'remaining_seconds' of size 4
>    70 |         int days, remaining_seconds;
>       |                   ^~~~~~~~~~~~~~~~~
>
> Use a 64-bit type for the remainder calculation, but leave
> remaining_seconds as 32-bit to avoid 64-bit division later. The value of
> remainder will always be less than seconds_per_day, so there's no
> truncation risk.
>
> Fixes: ace232eff50e ("drm/amdgpu: Add ras module files into amdgpu")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v2: use temp u64 to avoid 64-bit division later
>  v1: https://lore.kernel.org/lkml/20260225024716.work.043-kees@kernel.org=
/
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: YiPeng Chai <YiPeng.Chai@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: <amd-gfx@lists.freedesktop.org>
> Cc: <dri-devel@lists.freedesktop.org>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm=
/amd/ras/rascore/ras_core.c
> index 01122b55c98a..02bbee64a5bd 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -62,14 +62,16 @@ int ras_core_convert_timestamp_to_time(struct ras_cor=
e_context *ras_core,
>                         uint64_t timestamp, struct ras_time *tm)
>  {
>         int days_in_month[] =3D {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, =
30, 31};
> -       uint64_t month =3D 0, day =3D 0, hour =3D 0, minute =3D 0, second=
 =3D 0;
> +       uint64_t month =3D 0, day =3D 0, hour =3D 0, minute =3D 0, second=
 =3D 0, remainder;
>         uint32_t year =3D 0;
>         int seconds_per_day =3D 24 * 60 * 60;
>         int seconds_per_hour =3D 60 * 60;
>         int seconds_per_minute =3D 60;
>         int days, remaining_seconds;
>
> -       days =3D div64_u64_rem(timestamp, seconds_per_day, (uint64_t *)&r=
emaining_seconds);
> +       days =3D div64_u64_rem(timestamp, seconds_per_day, &remainder);
> +       /* remainder will always be less than seconds_per_day. */
> +       remaining_seconds =3D remainder;
>
>         /* utc_timestamp follows the Unix epoch */
>         year =3D 1970;
> --
> 2.34.1
>
