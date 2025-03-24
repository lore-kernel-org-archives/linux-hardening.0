Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732625E445;
	Mon, 24 Mar 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820887; cv=none; b=r/T/IAfWTHvayZgw2rtP/4fK1yc59ZYWh2wie7LtKM5XXt0saib7Q28c3w0KI0xTZ3zTVYA9wMfEyxLB0T/K2WGlmpjYGHFtHWodHXSX+LATglguqoaCCYW4FgPgNUVcgEcXJeD1pdc/YVllJ66Fz00PwK2kazbuw5RHKQ6Spzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820887; c=relaxed/simple;
	bh=5Yofkm1dNa6vGniR8xlKP/z1QwhPxmHysFr4OgO1Qtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KvOdr5FCeoveD/RgdMJ+hFBWRQ1Qh9sJC0lHSzfNWFi2F+U7I1OSTY0e7ZZrG8aShzRiOBUZnSvbJziItm6e/8zVSmCrdMppJfbfQhHitXrdTPBSgdXgdiaMy03FjaYZM59hnAJJrH8hyMU87lz6AK2lT5kqJ5LwTop0Bj0CBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjqGr3+m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjqGr3+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742820885; x=1774356885;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=5Yofkm1dNa6vGniR8xlKP/z1QwhPxmHysFr4OgO1Qtk=;
  b=cjqGr3+m94657UAMQLtc5dieGJiIS9TGNrVmcPeWCHxonAzFoWvgzKC7
   oSA1NoGK3s4tb8MfTVtFk7tnFn91Ehd/+tfihgLuk/NEspALOADXCQHQO
   iw5rUlIOMX7wfIs9SXxcrKpteJNuibdYOFTjK4s0f/oTpB4Oz6/b6rkUf
   KWNHXCqv4hbDYd9hBe6QkpnT+5sJSVC47yvgsgeJl9tOdPglfBN+gKtjM
   36IFyU9Pv3BBednbov7TmpTHc5vXm2Yj7HUvbMWa0A6s8yViGHrkMWQ7H
   UqMzx3qGzM1tv9OjAaJHp2W/i18PkAtxRp+OUPyMyR2/jp7P9TY/kadl5
   Q==;
X-CSE-ConnectionGUID: 4sMa5BH5R4KQpoGGRdBzxQ==
X-CSE-MsgGUID: 4ANoNXOOQvi3w988TJ2ABw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43178727"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43178727"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:54:44 -0700
X-CSE-ConnectionGUID: YsdPNGcISjGrFVNme+iMeg==
X-CSE-MsgGUID: IBn7zjQUQz60GGLw/GwisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="147243419"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:54:39 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Damian Tometzki <damian@riscv-rocks.de>, Kees Cook <kees@kernel.org>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang
 <zhi.wang.linux@gmail.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Add __nonstring annotations for
 unterminated strings
In-Reply-To: <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250310222355.work.417-kees@kernel.org>
 <01070195c306db7f-9f28efdd-9456-4db3-b6c6-343298bd571b-000000@eu-central-1.amazonses.com>
Date: Mon, 24 Mar 2025 14:54:36 +0200
Message-ID: <87r02ma8s3.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Mar 2025, Damian Tometzki <damian@riscv-rocks.de> wrote:
> On Mon, 10. Mar 15:23, Kees Cook wrote:
>> When a character array without a terminating NUL character has a static
>> initializer, GCC 15's -Wunterminated-string-initialization will only
>> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
>> with __nonstring to and correctly identify the char array as "not a C
>> string" and thereby eliminate the warning.
>>=20
>> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117178 [1]
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Zhi Wang <zhi.wang.linux@gmail.com>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: intel-gvt-dev@lists.freedesktop.org
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> ---
>>  drivers/gpu/drm/i915/gvt/opregion.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/=
gvt/opregion.c
>> index 509f9ccae3a9..f701638d3145 100644
>> --- a/drivers/gpu/drm/i915/gvt/opregion.c
>> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
>> @@ -43,7 +43,7 @@
>>  #define DEVICE_TYPE_EFP4   0x10
>>=20=20
>>  struct opregion_header {
>> -	u8 signature[16];
>> +	u8 signature[16] __nonstring;

Why would this annotation be needed? It's not treated as a string
anywhere, and it's u8 not char.

>>  	u32 size;
>>  	u32 opregion_ver;
>>  	u8 bios_ver[32];
>> @@ -222,7 +222,7 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
>>  	u8 *buf;
>>  	struct opregion_header *header;
>>  	struct vbt v;
>> -	const char opregion_signature[16] =3D OPREGION_SIGNATURE;
>> +	const char opregion_signature[16] __nonstring =3D OPREGION_SIGNATURE;
>>=20=20
>>  	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
>>  	vgpu_opregion(vgpu)->va =3D (void *)__get_free_pages(GFP_KERNEL |
>> --=20
>> 2.34.1
>>=20
> Hello together,
>
> it doesnt resolve the build issue with gcc15 gcc (GCC) 15.0.1 20250228
>
> CC [M]  drivers/gpu/drm/i915/gvt/scheduler.o
> /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c: In functio=
n =E2=80=98intel_vgpu_init_opregion=E2=80=99:
> /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:35:28: erro=
r: initializer-string for array of =E2=80=98char=E2=80=99 is too long [-Wer=
ror=3Dunterminated-string-initialization]
>    35 | #define OPREGION_SIGNATURE "IntelGraphicsMem"
>       |                            ^~~~~~~~~~~~~~~~~~
> /home/damian/kernel/linux/drivers/gpu/drm/i915/gvt/opregion.c:225:57: not=
e: in expansion of macro =E2=80=98OPREGION_SIGNATURE=E2=80=99
>   225 |         const char opregion_signature[16] __nonstring =3D OPREGIO=
N_SIGNATURE;
>       |                                                         ^~~~~~~~~=
~~~~~~~~~
>   CC [M]  drivers/gpu/drm/i915/gvt/trace_points.o
> cc1: all warnings being treated as errors
> make[7]: *** [/home/damian/kernel/linux/scripts/Makefile.build:207: drive=
rs/gpu/drm/i915/gvt/opregion.o] Error 1
> make[7]: *** Waiting for unfinished jobs....
>   CC [M]  drivers/gpu/drm/i915/gvt/vgpu.o
> make[6]: *** [/home/damian/kernel/linux/scripts/Makefile.build:465: drive=
rs/gpu/drm/i915] Error 2
> make[5]: *** [/home/damian/kernel/linux/s

What about this?

IMO it's anyway good practice to use sizeof(dest) rather than
sizeof(src) for memcpy.


diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt=
/opregion.c
index 509f9ccae3a9..dbad4d853d3a 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -222,7 +222,6 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] =3D OPREGION_SIGNATURE;
=20
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va =3D (void *)__get_free_pages(GFP_KERNEL |
@@ -236,8 +235,10 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	/* emulated opregion with VBT mailbox only */
 	buf =3D (u8 *)vgpu_opregion(vgpu)->va;
 	header =3D (struct opregion_header *)buf;
-	memcpy(header->signature, opregion_signature,
-	       sizeof(opregion_signature));
+
+	static_assert(sizeof(header->signature) =3D=3D sizeof(OPREGION_SIGNATURE)=
 - 1);
+	memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
+
 	header->size =3D 0x8;
 	header->opregion_ver =3D 0x02000000;
 	header->mboxes =3D MBOX_VBT;



--=20
Jani Nikula, Intel
