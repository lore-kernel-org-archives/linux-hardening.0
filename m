Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22421D7E2F;
	Mon, 24 Mar 2025 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851177; cv=none; b=Ica3XY++nenBYQHeCuoRAfHbI3bJ7xOkIxW/6QfHdOcF7ueM0YGKz9rhQK9po9pcaI9fbTg7T6kVDsQt8aTHxCTz8yNHA1TXU9nQx5wU1N8244CBBG9kHp/0OSp2aDmndWGXUkLu7IZenoI62U4q0MdKJI9/LLAoCafUKFHID4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851177; c=relaxed/simple;
	bh=lGCWURWFtjBxZ2t1Rv4FbijOpSLwnyzH5wxCECv35zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KG8rjLJLrMdZ2+hK288WUPRsoxfWAZ0BHNY0fgzw2Q125+FEQfcghp48DsZ2NJZWzfokUIl0XqqTTXSAtXTXpxgWV5T7y6Kw/6glnJiXpjgWwWQL4wzEegRai5+51m0kNA85iO9sM72L1ieKcJEzOIG83kN+ayngomxgBqwRaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU+pRWgJ; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU+pRWgJ"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c239771aeaso2320749fac.0;
        Mon, 24 Mar 2025 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742851175; x=1743455975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frDCG2qrAq7ODvL1k7fqgwhPml5YBbAy2fSTyQY76yI=;
        b=WU+pRWgJUaGQXCKMb9M3pVujzSUxIMaCfPehV2PdiywUMjrrZssIUoQ53tmq3gJfcB
         ed3GgaNeGmkCDrbdrUGgY4JUtA7s6TY5dj3FuPECJ2EIWI3LKR2ohl1lmZEBdyFKvFkf
         tnLysblr2CMC/rf1SQHVdzVrGWUsvFND2T8SD4M2pdQMJuv8BYfj1BXUqFGWeU0it3X8
         9a3v8z/odZmTNem/KLIO3Zp/vXpssP87Cobj8EYii3lRB4HEChhXcvi8fHhcMyOIfiXG
         YtAPizsSX4Yi3lr/ZGu93TZglflnJZgmWNibIgASac4WgsdZ6NH2n3jZc4ZuXSQBmncu
         8qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742851175; x=1743455975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frDCG2qrAq7ODvL1k7fqgwhPml5YBbAy2fSTyQY76yI=;
        b=r/5gL8TEeFgadvFvqIZCKWm3ceGm8YVZZ5KElKUkUPqMs3TEJzmKNdl9iognTZ3MNr
         YCyOFA3CKQy5/HXzwduqM+eqMpzcn76csRnJVAw9316/7f+4Pr4orvpugAmeYFKZp/5K
         7nNzLs7NEuVfdGH7gwQWs98MOGJJRKDHKezKuer65Z0gQaMVeUrglVfMaXh/GlqPj36X
         KLSLCWOUi8YK2u/iEXiVec7Gj/W5AWebInUDV+wZ5ngrRmb0Cd8E4fDXwhab966F/TJM
         2AicDpLJmKoKcVgNibYUOziLAIqyxFSEFa6Zeg2W/Js/vn43bdVBef9WqXvzYfevkuPf
         i1uw==
X-Forwarded-Encrypted: i=1; AJvYcCVlb9dQZ+BGdc+6AtJtUzPoRp+gzXCDuhL2rCX71x6uZuUMGEmgD12GhA5jm0dCA0kTYtXmJV9oKwWr836ds50=@vger.kernel.org, AJvYcCXUM1MJckSMpowmcRzE7jh9Cn50ldUP//XPbv4zSkAk2D50+HkKtR81dMlBEX3BXQQDrn1hPu6Y1Ws9TaET@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2xA2lRi9oseqWpt95dvafS1yux3tDsQnIImzU5hNe1pM05/Y
	WeuvD+SNuYmkc79qiMmABNQ5ncE57CTofFAgtyRrZdlF/EUwW/Z5Z4B/zbqgPjzZCHYwWqGp9B2
	DgsRHqQI41+qc3fkjjyVA5GEp3lc=
X-Gm-Gg: ASbGncvh+wwYiKBdcZnr+Err2Ld+fuN8isZwHrNc4b5VyTue+13T4LGb+zTpDNshYoX
	iLVIgl9LXleS2dFv58j0GUDD4VhWuMfUrc0uRAX1mbFha0bmW67C2Q8I2UH2tMS7kgj1Rj02SDo
	6Lq0jAV23xevqAae6Ld1Rk988lIOD9oCpzkg==
X-Google-Smtp-Source: AGHT+IHXtKrJ0p9DjxyMM87K1KNBq3hW44MMskPQ5xclT26yyj3ABz8zX1xoS7zKdxsxIX9khnDeIgXPNmjCe06FUzM=
X-Received: by 2002:a05:6870:612c:b0:29e:2594:81e with SMTP id
 586e51a60fabf-2c7802c82d8mr9115623fac.13.1742851174510; Mon, 24 Mar 2025
 14:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310222355.work.417-kees@kernel.org> <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>
 <87r02ma8s3.fsf@intel.com>
In-Reply-To: <87r02ma8s3.fsf@intel.com>
From: Nicolas Chauvet <kwizart@gmail.com>
Date: Mon, 24 Mar 2025 22:19:23 +0100
X-Gm-Features: AQ5f1Jo-T7_krtutBjAOPDPvTINCXqSyPXcHRxY3XegGinALPdX7qEtm2x02d_k
Message-ID: <CABr+WTkggOTDDzgPFmnJo3Dab4QYxLRt=_g7in3bgr0z6jXf+g@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/gvt: Add __nonstring annotations for
 unterminated strings
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Damian Tometzki <damian@riscv-rocks.de>, Kees Cook <kees@kernel.org>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 24 mars 2025 =C3=A0 13:54, Jani Nikula
<jani.nikula@linux.intel.com> a =C3=A9crit :
>
> On Sun, 23 Mar 2025, Damian Tometzki <damian@riscv-rocks.de> wrote:
> > On Mon, 10. Mar 15:23, Kees Cook wrote:
> >> When a character array without a terminating NUL character has a stati=
c
> >> initializer, GCC 15's -Wunterminated-string-initialization will only
> >> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> >> with __nonstring to and correctly identify the char array as "not a C
> >> string" and thereby eliminate the warning.
> >>
> >> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
> >> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> >> Cc: Zhi Wang <zhi.wang.linux@gmail.com>
> >> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> >> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> >> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> >> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> >> Cc: David Airlie <airlied@gmail.com>
> >> Cc: Simona Vetter <simona@ffwll.ch>
> >> Cc: intel-gvt-dev@lists.freedesktop.org
> >> Cc: intel-gfx@lists.freedesktop.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >> ---
> >>  drivers/gpu/drm/i915/gvt/opregion.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i91=
5/gvt/opregion.c
> >> index 509f9ccae3a9..f701638d3145 100644
> >> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> >> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> >> @@ -43,7 +43,7 @@
> >>  #define DEVICE_TYPE_EFP4   0x10
> >>
> >>  struct opregion_header {
> >> -    u8 signature[16];
> >> +    u8 signature[16] __nonstring;
>
> Why would this annotation be needed? It's not treated as a string
> anywhere, and it's u8 not char.
>
> >>      u32 size;
> >>      u32 opregion_ver;
> >>      u8 bios_ver[32];
> >> @@ -222,7 +222,7 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vg=
pu)
> >>      u8 *buf;
> >>      struct opregion_header *header;
> >>      struct vbt v;
> >> -    const char opregion_signature[16] =3D OPREGION_SIGNATURE;
> >> +    const char opregion_signature[16] __nonstring =3D OPREGION_SIGNAT=
URE;
> >>
> >>      gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
> >>      vgpu_opregion(vgpu)->va =3D (void *)__get_free_pages(GFP_KERNEL |
> >> --
> >> 2.34.1
> >>
> > Hello together,
> >
> > it doesnt resolve the build issue with gcc15 gcc (GCC) 15.0.1 20250228
> >
> > CC [M]  drivers/gpu/drm/i915/gvt/scheduler.o
> > /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c: In funct=
ion =E2=80=98intel_vgpu_init_opregion=E2=80=99:
> > /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:35:28: er=
ror: initializer-string for array of =E2=80=98char=E2=80=99 is too long [-W=
error=3Dunterminated-string-initialization]
> >    35 | #define OPREGION_SIGNATURE "IntelGraphicsMem"
> >       |                            ^~~~~~~~~~~~~~~~~~
> > /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:225:57: n=
ote: in expansion of macro =E2=80=98OPREGION_SIGNATURE=E2=80=99
> >   225 |         const char opregion_signature[16] __nonstring =3D OPREG=
ION_SIGNATURE;
> >       |                                                         ^~~~~~~=
~~~~~~~~~~~
> >   CC [M]  drivers/gpu/drm/i915/gvt/trace_points.o
> > cc1: all warnings being treated as errors
> > make[7]: *** [/home/damian/kernel/linux/scripts/Makefile.build:207: dri=
vers/gpu/drm/i915/gvt/opregion.o] Error 1
> > make[7]: *** Waiting for unfinished jobs....
> >   CC [M]  drivers/gpu/drm/i915/gvt/vgpu.o
> > make[6]: *** [/home/damian/kernel/linux/scripts/Makefile.build:465: dri=
vers/gpu/drm/i915] Error 2
> > make[5]: *** [/home/damian/kernel/linux/s
>
> What about this?
>
> IMO it's anyway good practice to use sizeof(dest) rather than
> sizeof(src) for memcpy.
>
>
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/g=
vt/opregion.c
> index 509f9ccae3a9..dbad4d853d3a 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>         u8 *buf;
>         struct opregion_header *header;
>         struct vbt v;
> -       const char opregion_signature[16] =3D OPREGION_SIGNATURE;
>
>         gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
>         vgpu_opregion(vgpu)->va =3D (void *)__get_free_pages(GFP_KERNEL |
> @@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu=
)
>         /* emulated opregion with VBT mailbox only */
>         buf =3D (u8 *)vgpu_opregion(vgpu)->va;
>         header =3D (struct opregion_header *)buf;
> -       memcpy(header->signature, opregion_signature,
> -              sizeof(opregion_signature));
> +
> +       static_assert(sizeof(header->signature) =3D=3D sizeof(OPREGION_SI=
GNATURE) - 1);
> +       memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->sign=
ature));
> +
>         header->size =3D 0x8;
>         header->opregion_ver =3D 0x02000000;
>         header->mboxes =3D MBOX_VBT;
>
>
>
> --
> Jani Nikula, Intel

This patch does solve the build issue with gcc-15 on Fedora-42
(gcc-15.0.1-0.9.fc42.x86_64).
https://copr.fedorainfracloud.org/coprs/kwizart/kernel-longterm-6.12/build/=
8812754/

Thanks.
