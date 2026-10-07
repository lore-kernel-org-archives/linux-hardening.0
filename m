Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2D3C8705
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 21:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409784; cv=pass; b=ILRozRg5Y22L5mfHOyR+zzsdWb4GLNTiLQhXS/7xXXYPcxjACebL4kasRbwT9yx8klbqgga0WpYkp8T1VOyLj7DOZ6n0ZiUMnFeMldR+JxveHX7YPKPMBT5+TM5G2hV32xH65EqXrJuakJaEI3F91Fx8bNqs73sqEI0+mqeB0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409784; c=relaxed/simple;
	bh=iUfeVPFcJRl2l483RVn1FexTtf702f8k8YD91745DT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF1RL4MXaidUL51nJmfXhN8AKD5thBRpitu18unAmIbz0GmcP19vGsnfAr4LjngimqO/VfIymF55PodroFZHAMppz0GqfW9AInr4PKBIeSLYCIdsugtgWaZiKuJQB4Wx8dlCVMqKBEtVFfFz0A/Q8s0t15GVa7MTOUQziUc4fKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7du2heG; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7du2heG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso1933845f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 14:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791409780; cv=none;
        d=google.com; s=arc-20260327;
        b=LV+tspGxapg2mbspLrO9uCWQ4R6pyLGCOYTMRlszX8ErbIjXnWpdrSw4xjM3OPpg1d
         EwNUk4Fq1pUVTldm1Z6LpLKJ1MqSmrgVcWvHCPyanuMq6keFdxT/TV+FagObIfcSArly
         Ai309PYXjiccYECailSHuk8kWZAV9j1J+kInQ/wppZxdc7BMXqQg4TdbCe7jI6b+2AZi
         K+1Y+Y2lQu46TI9jEkRY1h69BC6Lf1dSJcFst6rkw2dAdT3qAwaa7d4SEp/nfWXF+cL8
         6AhPch1MbPxfz4dMNgz0hMYWRdX4nLC8VWQeEbDRMCmBfOsqZFgnzydVBIbRncE7zrCE
         8jdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dz2+W8ZDe1ZO58k707wXjnIbgkdV89r041+gMmUvvKQ=;
        fh=LMiH5blefM2N25eTN0zZGGcYwXhccJivM5xAK5ssqLY=;
        b=RLb4OaPBuXj57hy11ldDfk5gGqnIrJkSJkRs8Lc8nZ6PIiTtFoTHHew+Wx4Kl2GwCT
         IQWramDjOUenUIDFDmccUuGHftoEjR1Y06xf9kcsHnWCowx2XPXXNM/u6PJ7vst3XvuO
         3iCY7A2R4HwzH/I/yj9QHYdRY0wo+rRMeifhds85qypULdciTCUUFkSGUUUFrXTIXegu
         z25utCKTJKrpAYT9L7rKSybYzMqFv2JHdKHhhaVnIHaxvG4IzhcjhXcZzWrhNIo1EYUf
         KRV20oTQku6RHK4DPPpPrHl5wpsgiBEk9FLSmDaaB7J5OgncqTXF/yC5/aI9+hJJ1nh1
         Whxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791409780; x=1792014580; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dz2+W8ZDe1ZO58k707wXjnIbgkdV89r041+gMmUvvKQ=;
        b=P7du2heGRRe0NdxFmkQLnmpZhVk6IdKQBDPC/Y+UQy0PXijq9nuRtFz/ETBT6HKKq+
         sSsQ+P18FwQQVyRn4D51kzd/Cf0YyU62abyqfNRchaTz5EGHGvqw7Xn4qbeiHw9JBc6P
         eMeYBjLQ08NerlnwSiDNIWCuMiFsin/+26zzaoDcpDmP4gcA1dkS7kiVN0aoWbMXMNUb
         xegC1bik2ULslvOVb1hmlw4o+2Xx6OgwROwONx9xPwkbgV9PcmMHM62uJ5y6c7qGKBNX
         Rh93fibkDk3ttVRb7iN+VKVmAxfs/lUrJ/D0Xea3XtxxYGbbAX3FC+dQcxxg9CBmBAnP
         JVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791409780; x=1792014580;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dz2+W8ZDe1ZO58k707wXjnIbgkdV89r041+gMmUvvKQ=;
        b=LuKv2305hEjvch0O6qlDCRZt7HhJDKiuAhLLCJex7BypsLPtqexRZNW/LJ0IxL+aS/
         bIYLZKC/CC0/L1PfKM+MfO+Cd6NZ4tN7764eDE+esO0Le4xD4GyAARxHTlMHs+K1J1jr
         yqxB34UD52HnxB35vIFLUzuh4J0hgVyIkqu9kKB/iF9VySoVJm5ywoLyohrg8jc88aIy
         HXIvUdoWTGWW8tfEkhrqwml4OlSYCG4UtqDxuWyIfVwZE+MfUo6Xvc3hPJ88h46vnZZ/
         1pZ6SF4MLcqcc6d70j8F+haar89f3ec/RpHEtGYXAHG4VYXCVHrmqZ7snILwOc3AdxsZ
         wteg==
X-Forwarded-Encrypted: i=1; AKwUvByj82oeunkc/isWeJEGgKnyEmKxsoDsP55U6H0fsqrsNWBMpsQJWDnLfajy/YGlDjD6PXMGXv3aor+4nthvfRU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTeymKxph1AsaZdEcATWFE2RfeqgEyIzNEdOYQMYA2Pj84ON+v
	Q/yByGXvNeaAkzxruC7tnHorrWhCvhU5Ip+g92aa7ur/JTDJWYVqhI0+AIxZG+2NWdRPTSyYuDe
	4nqEAMbGZx4PXgPcJ4t3jsBwAt54Gb58E2IGGKsg2
X-Gm-Gg: AYBFou3w+UjBGzcGob+IS1uKJ5H+6qDl+l9txVDcXw50bvB0Qx93jsOlbrZiMAC/IkT
	63aEFDj8dYSUwLV3exPfCfxzOZ2byJRtuXtzW4achRcNsgfqTsbte8LCLzjcwibbpSMtP4kP6Sb
	80rypqrvMi8VNpg5WO/QtcMknZ+hgvah41mlOf9klluy7Tcqf8ouzslT+2lpjhh8U/oohLNEiuw
	yDES0QXWUs+X/ZonrZBx8Bu6pOvhnXfrZRYWZMj/9kYo4MYayhMDuEeHGz+1GX4qE7CggfF4BJB
	8cRdrMHMk5xGc8M/5zaBmebq24muE8k1nYPeugjxCZjO7ms3Tmcjfiyq9WcYu51EYBwaur/z6I7
	zCJUHsl2FMMSEaeiH6kies60RfinitMyvQM7iK32SW1qeY3T92itvXYVrwPqcSHXZ4Urd6Vr/jc
	rTpQ==
X-Received: by 2002:a5d:64c4:0:b0:48b:f92:1f75 with SMTP id
 ffacd0b85a97d-48c7289726emr6747670f8f.48.1791409779287; Wed, 07 Oct 2026
 14:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
In-Reply-To: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 7 Oct 2026 14:49:28 -0700
X-Gm-Features: AclHuK-XtGI88zcQiAtV3bin7-xktDfZZWB8sWf-q8RSqTy-N84xG7PdKD2ogLk
Message-ID: <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>, 
	Tingmao Wang <m@maowtm.org>, Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 9:28=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> With Clang 20 and CONFIG_FORTIFY_SOURCE, stacking Landlock domains can
> trigger a fortify panic in the handled_masks copy in inherit_ruleset():
>
>   __fortify_panic
>   landlock_merge_ruleset
>   __arm64_sys_landlock_restrict_self
>
> Clang miscalculates the location of the __counted_by counter in the

Thanks for the patch.

Would you consider this a bug in clang, or an error in how the
__counted_by attribute is applied?

If the former, then a bug report against upstream llvm-project/ and a
link to that bug report would be appreciated.  Then Bill can take a
look.

Or if this was a known issue specific to clang 20, then we should have
a link to the fix (or consider bumping counted_by support to the
compiler version that is bug free).

> anonymous structure nested inside the domain's union.  In an arm64 build,
> __builtin_dynamic_object_size(domain->handled_masks, 1) reads offset 40
> (the first handled_masks entry) instead of offset 36 (num_layers).
> Because the destination domain is zero-initialized and its masks have not
> yet been populated, FORTIFY sees a zero-sized destination and rejects the
> copy of the parent's layers.
>
> Move num_layers and handled_masks to the top level of landlock_domain so
> that Clang uses the correct counter.
>
> Assisted-by: LLM
> Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Move the domain layer counter and flexible array out of the anonymous
> union to work around Clang 20 reading the wrong counter for __counted_by.
> This fixes the FORTIFY panic when copying the parent domain's layer stack=
.
>
> Based on next-20260930. Validated arm64 Landlock object builds with
> Clang 20 and GCC 14, with CONFIG_FORTIFY_SOURCE enabled, and checked the
> counter load in Clang-generated code. Not boot-tested.
> ---
>  security/landlock/domain.h | 48 +++++++++++++++++++---------------------=
------
>  1 file changed, 20 insertions(+), 28 deletions(-)
>
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index caa3d19d2c43..5e65ab004f62 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -216,37 +216,29 @@ struct landlock_domain {
>                 /**
>                  * @work_free: Enables to free a domain within a lockless
>                  * section.  This is only used by landlock_put_domain_def=
erred()
> -                * when @usage reaches zero.  The fields @usage, @num_lay=
ers and
> -                * @handled_masks are then unused.
> +                * when @usage reaches zero.  The field @usage is then un=
used.
>                  */
>                 struct work_struct work_free;
> -               struct {
> -                       /**
> -                        * @usage: Number of credentials referencing this
> -                        * domain.
> -                        */
> -                       refcount_t usage;
> -                       /**
> -                        * @num_layers: Number of layers that are used in=
 this
> -                        * domain.  This enables to check that all the la=
yers
> -                        * allow an access request.
> -                        */
> -                       u32 num_layers;
> -                       /**
> -                        * @handled_masks: Contains the subset of filesys=
tem and
> -                        * network actions that are restricted by a domai=
n.  A
> -                        * domain saves all layers of merged rulesets in =
a stack
> -                        * (FAM), starting from the first layer to the la=
st one.
> -                        * These layers are used when merging rulesets, f=
or user
> -                        * space backward compatibility (i.e. future-proo=
f), and
> -                        * to properly handle merged rulesets without
> -                        * overlapping access rights.  These layers are s=
et once
> -                        * and never changed for the lifetime of the doma=
in.
> -                        */
> -                       struct access_masks
> -                               handled_masks[] __counted_by(num_layers);
> -               };
> +               /**
> +                * @usage: Number of credentials referencing this domain.
> +                */
> +               refcount_t usage;
>         };
> +       /**
> +        * @num_layers: Number of layers that are used in this domain.  T=
his
> +        * enables to check that all the layers allow an access request.
> +        */
> +       u32 num_layers;
> +       /**
> +        * @handled_masks: Contains the subset of filesystem and network =
actions
> +        * that are restricted by a domain.  A domain saves all layers of=
 merged
> +        * rulesets in a stack (FAM), starting from the first layer to th=
e last
> +        * one.  These layers are used when merging rulesets, for user sp=
ace
> +        * backward compatibility (i.e. future-proof), and to properly ha=
ndle
> +        * merged rulesets without overlapping access rights.  These laye=
rs are
> +        * set once and never changed for the lifetime of the domain.
> +        */
> +       struct access_masks handled_masks[] __counted_by(num_layers);
>  };
>
>  static inline access_mask_t
>
> ---
> base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
> change-id: 20261007-b4-landlock-fix-domain-fortify-panic-510367f8cfe3
>
> Best regards,
> --
> Abel Vesa <abel.vesa@oss.qualcomm.com>
>


--=20
Thanks,
~Nick Desaulniers
