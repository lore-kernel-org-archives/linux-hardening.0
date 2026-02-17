Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111B36C5AF
	for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771345318; cv=pass; b=GPHo7Pi466AwOpS6XBndxOQ5zwNcQZQG99YZzO6BkxlODuIkruaxcobJHqbykdEoBXWPux/c3I53aqELWeGiqPChH0RC6Z8KcXqh19mxa9bj2P5XNKp0e+aQ2tfRtbG4ELlJM5YvJjlH4sCNrtEAuLhG2kmsMxCUHVPscx/RxtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771345318; c=relaxed/simple;
	bh=S0/kvxUd+l95Tq2HANWXTxFFbFxadhlsa0fyr00cF9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moJh65e2UiY+eH72HlA5hZTxAoRm9RwIp/gGu6eiUJBOH8le9A0pH0vqGug1XiwQVKlBq8O8EJm2eATMDoBQtPp3Fu7jIcq0m8sQ0qBgLpPgD2rZFE3pCtL14xYW4qtmxmIAfKrnVCvJmtjVIv0PY20KdfR8umFuXZrrT1TCwnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWvpFe9M; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWvpFe9M"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1273882d901so207711c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Feb 2026 08:21:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771345317; cv=none;
        d=google.com; s=arc-20240605;
        b=ji9XLXiFvSorPM/lXGP/e49QXMGOKfcXXQIJd7xsZEMcWsYM0f7kITSrNnfjsUkcPy
         VxxTUX5H0B4B3a7wGSDPgo6n1OrA2+Riv8hVXr0ZNf914bdEMposH8ObHKbgWapiqwsG
         lHlzxkS6F0MbwtPW/UHINq3hjcVZrT0SfTBkTvUrKhAsBc6FhIv8pXzuxspUI44BgSJA
         Jj4V4oZMInvSb3M5aROH8jD7CSg13HjVBOhVg9n39ObSJFkHA0gc/+MrAWW7OIWb5I93
         zBAUzSjBbHJaxzl+yXnnZ40slFvvESnNJ9V/2U3Ten8gs2V0a3dk+mkyVOPI7XtSQ/es
         6Bqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JI+eAeEIWKzUc1jTb5Uxg80e6X7Dqvgv9KFMaR62OBE=;
        fh=oP1ZwrnEfZHk0hUQxWnt3N+9TFNzHRsnOz6SjG17yBE=;
        b=U9G65W4UMC4wwxX9WEs84G/u4Gbf3Wawbf2fO7zUHIeb7bS2rv3wNRAp+KHSkdwK+R
         spO/bbZpthonRoa6k5kFcUs/vjIeaYd470it4LfE3jTTEWmoSKMC5h78nUPYOfmnb/4w
         LuoQwO8xZffeBL9Z38LcWuThZNMNhBomgafAg6FFxtYh5Pv3o1yVBHEJAcNjnAV8SNxI
         rnlPlUDQydad0V/tfLO7X7TxnWYJHW22jTpbGNBaZ2oEXODQjxRCP8L6QETga9r0SCyw
         2+RflInT0xC8XdfEsY74oVx0rT74v/+MdTJ1RsSpKSuYm9LQ0/+bzTg9fceBeHF7lvHD
         ME2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771345317; x=1771950117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI+eAeEIWKzUc1jTb5Uxg80e6X7Dqvgv9KFMaR62OBE=;
        b=nWvpFe9MZhETXbDfobDLRz/hJNRaB9nlQnMNxSqho57nKI8bPxSgMBhCc/v+OSDXyX
         iXNb5sU3EHiJIRaEYPfZj9IesuJ7QxWecMQBJIrBvHkFs4wF5x2lyFPzJx4gxk3zCMTN
         OaUpQG1U3h4P55OOwDqM1U8kS4E/UpE4zH6eVu7c/R5qVuvcuccDAZhjdHokqu90pbvY
         MkqjF58DQ04AUXlxuKfom0fDOFDZFOp2WtyYtjvYTokOfg+31RbU1kOc/UjNMjAI2uRY
         sXZWLscVIiEL9Lf/LyP+0WB2Rntm91AGsiyvMwIHtsly3PClpQYqYDLwwZCqv4WD5i99
         c6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771345317; x=1771950117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JI+eAeEIWKzUc1jTb5Uxg80e6X7Dqvgv9KFMaR62OBE=;
        b=peoQ434RIwb4KGq6IpzrL2611xSL2w7tk+5z9OnJnWQalgMwGW7e7uVJqNQO7m0qO6
         p4GtmIfnwiQF7shwo40dAOx0NiZrfOkplLjbCxGsoL9mjhKKbBZ0KVG8pTiOHxdgHURG
         yHi894qUIPh6do8Ne3fRMx3orX62xV1Vxoid0g0F3csimGLSgvKu8WlaXSPX6hrmkuu5
         kLZEu7RvWPB0Fm4CBufiYPb71ep0DUm+14JcYaI7adlc0XnxCEdZRmpHTTfeBbX97A5Z
         1g+E3+arXF0as0aJEU+0SKNUOtXopy8KxL0NEtv+oB6wbbo+jIOiMHvNZeOe2Ogr/m6z
         cxlA==
X-Forwarded-Encrypted: i=1; AJvYcCXbfrsB/viXbquaPy6uVJNOyWckr9WYrhnFcmeainMQH6d5bwmMPqDsKSI9s1AraSof2255yfN9DePxuyTfNgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxErITtVLVFYfIGNGqTzckhQNdf5i4nN5+ugt0MLOCFA3Gmpy4C
	ryd45/UDMkqZTIxBDA+2g8gBZDkyEcUBARLGGGylea97Pcpmb8X5Zvjgc47nMUPTlBa1Jm7Q09S
	XfO1bDYU8Ic12b1UKLl7D2hycSOsgW0Y=
X-Gm-Gg: AZuq6aJ+tOM0cxTNDgNlhLVPbd7dgMA8bERm95DrIHp8EpZ3/R5fzioSFfY1Akr2VWl
	549qkQuMTfNRmMWzSv+QPIJsiySMvSWP4XkrDzNYNQ+yL2wI/dgNYf9LUizwEChO6wpgmkeXMBL
	PdgY0L0XY38sYAOZQaoQ3LDpcjbMIKOVstGcrDqtK2P+ibfLXvetkHpVFXpFbb2mndcRtubqIXt
	AkkJYU0bzHJSbKSfAZG1Hrpy0Mc02Ayh5JC+8C/XqZN93XHQkhiyNVzPmyCFR9BEUrwirwObSdz
	9iSbs4SCgKlZrzKdzULSNO/e1sVZ//g2mD1hFtJ/u16RQzUXfLw+Peqi4SEvvsexLG0s0w==
X-Received: by 2002:a05:7022:ead2:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1273979e682mr3080179c88.1.1771345316437; Tue, 17 Feb 2026
 08:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com> <20260211102657.4180-5-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-5-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:21:44 -0500
X-Gm-Features: AaiRm51vZKMiP2LZQsl7_es59ocK_810Bdu0_NdUsWKUDv9OGdKsU4jiGzIh6Go
Message-ID: <CADnq5_P02Fx6-VG8Nei4QZozZ9hK1vY=1sYm4DOh71nXtmVehA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] drm/amdgpu: store ib info for devcoredump
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 5:29=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Store the basic state of IBs so we can read it back in the
> amdgpu_devcoredump_format function.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 13 ++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h |  9 +++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 0bf85ab43204..d0af8a294abf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -387,6 +387,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>  {
>         struct drm_device *dev =3D adev_to_drm(adev);
>         struct amdgpu_coredump_info *coredump;
> +       size_t size =3D sizeof(*coredump);
>         struct drm_sched_job *s_job;
>         u64 total_ring_size, ring_count;
>         struct amdgpu_ring *ring;
> @@ -395,10 +396,10 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol skip_vram_check,
>         if (adev->coredump_in_progress)
>                 return;
>
> -       if (adev->coredump_in_progress)
> -               return;
> +       if (job && job->pasid)
> +               size +=3D sizeof(struct amdgpu_coredump_ib_info) * job->n=
um_ibs;
>
> -       coredump =3D kzalloc(sizeof(*coredump), GFP_NOWAIT);
> +       coredump =3D kzalloc(size, GFP_NOWAIT);
>         if (!coredump)
>                 return;
>
> @@ -406,6 +407,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>
>         coredump->skip_vram_check =3D skip_vram_check;
>         coredump->reset_vram_lost =3D vram_lost;
> +       coredump->pasid =3D job->pasid;
>
>         if (job && job->pasid) {
>                 struct amdgpu_task_info *ti;
> @@ -415,6 +417,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, boo=
l skip_vram_check,
>                         coredump->reset_task_info =3D *ti;
>                         amdgpu_vm_put_task_info(ti);
>                 }
> +               coredump->num_ibs =3D job->num_ibs;
> +               for (i =3D 0; i < job->num_ibs; ++i) {
> +                       coredump->ibs[i].gpu_addr =3D job->ibs[i].gpu_add=
r;
> +                       coredump->ibs[i].ib_size_dw =3D job->ibs[i].lengt=
h_dw;
> +               }
>         }
>
>         if (job) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 1c3d22356cc7..49486d1f6a5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -38,6 +38,11 @@ struct amdgpu_coredump_ring {
>         u32                             offset;
>  };
>
> +struct amdgpu_coredump_ib_info {
> +       uint64_t                        gpu_addr;
> +       u32                             ib_size_dw;
> +};
> +
>  struct amdgpu_coredump_info {
>         struct amdgpu_device            *adev;
>         struct amdgpu_task_info         reset_task_info;
> @@ -58,6 +63,10 @@ struct amdgpu_coredump_info {
>          */
>         ssize_t                         formatted_size;
>         char                            *formatted;
> +
> +       unsigned int                    pasid;
> +       int                             num_ibs;
> +       struct amdgpu_coredump_ib_info  ibs[] __counted_by(num_ibs);
>  };
>  #endif
>
> --
> 2.43.0
>
