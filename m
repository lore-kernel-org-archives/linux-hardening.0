Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FF1EA7CD;
	Thu,  6 Mar 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253852; cv=none; b=ZRKAYrXbjPeNo9qo9WZ/OBvBypHYPzJvrIx73xYFlxivcoktbNjhmGaKcjmOF/eEthi0aw039o4YzdBvFbxT94X+YLQhmK95lg602ZJuUDLL318x+i09ZDdsb2Q8tBBYNWAFeQvd0TdkbN41hZVvORE7N3nHt2JDscbuozU/QK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253852; c=relaxed/simple;
	bh=732h9girWgFnvVQvApu9Uvs/bcUr3m8WGqWSmfl21Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skqHLZ2lyY7m2NfrvzsdVn4bgdVGxjVE1fsxBKMs+JRs06TxMlO8ja2X0ZGX9TCvs3nhsueIsKlgGvNdyUp4Sfq6WhCxIDWOS6I9k+37x2YCuvPLcqXg4DTrTHWhoULRRjSJ89EX8V5r+ZR3PGMK5BDJl7EjzxMTOmsABjVL3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC1A9kmx; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC1A9kmx"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f546cbf71cso277843b6e.0;
        Thu, 06 Mar 2025 01:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253850; x=1741858650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLprdd91YTpO/D6PCgkynt4/vJgy2iO2mLGTKPJDuBE=;
        b=EC1A9kmxBpu+T79k3s+O4xp87K3R4whKNkTjStT9WMZ2XLuEhBExK9CujlcAVc2wXl
         Y0AipswKITTF+EN53Hk9xHGbOhNKP6DnydyyGKJq71KhDjK6GF+6QxkO/P2y53emv6sT
         U5LiKfmN+zQKqsofeGJpmLjCYEyNAeKmYQ9Ln5KVzIaxfHYgAYPSV28xivOfshEQ4Y5l
         5KicOYNmE1qDLu+tIUAKS0s6Hf/zd8flQwbX9OwJYs479ikQq25z2glOtW2vo1gYMXNu
         agVaFqUTiegiCjgAmolsJiOW8kHf6IfT6kVY5IPEWyTgYvi0PH22/nVs79Step9nGRrS
         KUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253850; x=1741858650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLprdd91YTpO/D6PCgkynt4/vJgy2iO2mLGTKPJDuBE=;
        b=Qxr7d6uiLQMrGGntZ+ZHSJTcrhtA+XVBIMzJPvdDNVze9SBEvs+qG2h++xaaATucJm
         h6sa6yiPgazLUujeNfdDJfiCarMXLO4o64DpUbrILVbc7rYsxPwZIA/iy15uqacvtYum
         s1Sa/wHk5x74IjO7WcV/M8gzQinqG+k12Nvlgw6Irx8h5hX9+IX29/j2JUJhoswwFR2g
         71izYPzBzUUmQuu9xtCLm3w8024Mc/9ZbB4+rXRqEO5MFq3JNux9MBx+L25qGtQUIC3j
         htn9sPPQn02kqzV6t7PmVg7PyHtrfKBHG3OYyoqkhXT3Hx/1OnApLblcHM7CRdhowB7N
         1avw==
X-Forwarded-Encrypted: i=1; AJvYcCVcV8gqlRzSgtlQQ3exgiex4IctA7T+R/O32BAZT7M2Mz5kFggcpLZU4DMIlEZ+ACkJ//FeHlupyLB6tu17@vger.kernel.org, AJvYcCXEKQnDYo3PCDU2Q17rTDbeTSYMqS0IqtAzetOgjhw4x2jKCKAWACs9bBb5mj0kUfguCAWliuKpCAP4H2E7tM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVzQsH2FrfIKxKaEQZ/UfLgGnkCX5GygP8+yfBUtK6Vhucldm
	eTVzoPcj/ZSt1TWXsPTr+pl1fnXBJc9nQkUKI62A8U7HHVFw5tfC+QnyNFz0uqlR66MqVavJ+NV
	Mu1DG/yXLDlbYrtNx4TjxXowYllHTQUlB
X-Gm-Gg: ASbGnctSduMhavI7Fj41BoIEaOraxNq+PfGJtPrHSwtGos7U34/DYP1whprVOAVT6IQ
	0mlHuglqSaTkUb8VC0ZxcMkT56E85X46UPvtsHkcxxXuaBlZel5Mw78vaPtS265v+8OJ+LLADME
	KeSqrWKn8i4gxG/g+bWGUvU/IM
X-Google-Smtp-Source: AGHT+IG9A27vX8y4RjMpuxk7loCAGz0dZw9H5VkaAL6LjExFUGPLf0UL66ugvSrUJjKHZoWAZYRZwHUIAF3aSPY3uCk=
X-Received: by 2002:a05:6808:1901:b0:3f3:fca6:e780 with SMTP id
 5614622812f47-3f683144936mr3774926b6e.4.1741253850578; Thu, 06 Mar 2025
 01:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225203932.334123-1-thorsten.blum@linux.dev>
In-Reply-To: <20250225203932.334123-1-thorsten.blum@linux.dev>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Thu, 6 Mar 2025 10:37:18 +0100
X-Gm-Features: AQ5f1JqPYte1Y1sfZ1elIHoDjXZLpaJ74CYxKBCuHA-IVr92zEQbBbverVAm8j4
Message-ID: <CAMeQTsZaE626TpmygVQTXDep-8KiB=HcEo62x+EL=F4Ctfq+wQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Replace deprecated strncpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:39=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
>
> Compile-tested only.
>
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks for the patch.
Applied to drm-misc-next

-Patrik

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma5=
00/cdv_intel_dp.c
> index cc2ed9b3fd2d..ca7f59ff1fda 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -855,8 +855,7 @@ cdv_intel_dp_i2c_init(struct gma_connector *connector=
,
>
>         memset(&intel_dp->adapter, '\0', sizeof (intel_dp->adapter));
>         intel_dp->adapter.owner =3D THIS_MODULE;
> -       strncpy (intel_dp->adapter.name, name, sizeof(intel_dp->adapter.n=
ame) - 1);
> -       intel_dp->adapter.name[sizeof(intel_dp->adapter.name) - 1] =3D '\=
0';
> +       strscpy(intel_dp->adapter.name, name);
>         intel_dp->adapter.algo_data =3D &intel_dp->algo;
>         intel_dp->adapter.dev.parent =3D connector->base.kdev;
>
> --
> 2.48.1
>
