Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F192E7F3A
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985893; cv=none; b=M861S2SYbBUce3DlXfTgTFfqYHKGPiN2hZpynz1r8ZKrKQsRI1CnT/JQY72u06wORwN9UuEFKYcdawEhhKOvttf50lsNhUVhf1lF+GfcHYCz8JqocLVQaIEtcwQWHREFRVuuTRiJrL+hhBrP5D3dYwkr56SzIjgjtsH9DVnLmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985893; c=relaxed/simple;
	bh=capi1eQmEYYcpeLmvuBwQLEqV5FUgPLgSckxnyAvCmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPGzDevWvcRgoqn74+q1EhSHkZu147xj+VuSihF8tkakoPJ+3s3Kcx99IuxsJgGeh8+MTS3VXHTtzJG9oUaFHjUO8seYFuYEmyfJHTgld8UTVdYX7yPlUl50ci+QhMzAK7cO8+xa+6kBwqNKsCmGVI3r32xPEjuJq3rK7xtvoaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot+P+qJk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot+P+qJk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f08b909aeso9967795ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 11:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767985891; x=1768590691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGucWZxG4H0oACzMuTEPVrhVqGkXJT23twyUUE6h0GU=;
        b=Ot+P+qJkdum0e34DsqVBc61PSl41WOeeRn6OxBNk0p2AWEowv27SmjdQ8KHZpBtNqe
         TJ969dHuNHTaVnNNkCyOk2lM2IK5YHzUhsjYmbMjvB1sUqqXun1R8RdiK3oM4Gr6Uhtt
         z/NsAgkZbHyAlobnv+g1K1b2MuBHlBaa8k1fknM5/EzD60g/E65WCDtcnqRnB8jGB8mm
         XX/IhoI9IliDMRW97y36vlr/L3/2YYGvs07bLqZ9n8rOU7mloHpUAR+ONsI4UYTkrJE1
         UXYU0WYQbKYZ+v2KuJ8Ci89uaBQn2I+YsmDjd9aZx1N5waEVLL3jH2upQHj4ynhOkczf
         HBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767985891; x=1768590691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGucWZxG4H0oACzMuTEPVrhVqGkXJT23twyUUE6h0GU=;
        b=TvJfADY+nOe5nCecPm5UcO3D7AoozfkMdbXBTqPMaodtS6fcSdfgU27X7eiTrOsBrt
         NvKFJbSusdtbRG1AQXZPJhwwHTlmpO+jU8pf6mFuiTyxuC9pwE8vqTte0BaYaarw6mqy
         bDiIG+M0E/mf+RRNZp5nKLPvDJvV4Z9pG7Osd+lI2dNNMyKngDmRmCbQMm1UOX/o7U8o
         Qb6d8SYG7OFOjyDRwXvqRC7kGhEAAK5gkmKFpBucUw1tzPUTxw9tboU5z3aSL3pnirCy
         8o0X8djTZpf9J181D60yD4mNK2ZlQ9kB1I1dUVQ87yEkVHu0qxc+kL3TEEK+WiezCD4A
         ++wg==
X-Forwarded-Encrypted: i=1; AJvYcCWgg/PQIu3OgWmc9+3s/Va+I91vFlOOj82N86MV174Jv5okprb/wT/f2ArxMosvy2uDrTqWKKckV4++JN3Xkqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEBgfOG7oz5eZ67tgFTkppQHXTkDGflWtDPXxRMfFR499rNb8Z
	Dae22ta9hMfRUzDiHcHSwtE4OFku/CS5s62W6YpONJRcuk82yefDpwICrHd8eak2Gv3rHv2Qa68
	jvQKGFeKTWKytaOvz5gz5MT4KAx2jnfY=
X-Gm-Gg: AY/fxX48BpCWXd1kt8MUtU9IHmZAKuVf8qCUPnmGDKtc/BCE4LzZrr5JWXKAEY9hEyX
	trOiOlAdbD2T1KHQzsyFE5UAk9sFrxwaGyGC0+XvUPHLKxMDbgbIqlcQ2THqJ7GW/QqH5DESw43
	KEgyio6nT6XydRiQjfufqxI7/p1ZPDzCDKeXXGkUmJEu1RSKT6TOXY6S/ESqi8MR2n4ObxfFrtQ
	CG5yS1x9bwE+JIq48ht3K9BwbswFgKQUU01POV2ZYpEwXLlwTXglr4L8NaNffntoIm4+uA=
X-Google-Smtp-Source: AGHT+IF7dTGSqJqWZzwnIHslSdlw6WekSrgn4f0+hOUkO918cHCqTxp+XTuZOMvQz9g2tVbmrdlQKCQmnYtBYPnHFfw=
X-Received: by 2002:a17:90b:2e0c:b0:343:e480:49f1 with SMTP id
 98e67ed59e1d1-34f68c28ea4mr7819215a91.5.1767985890668; Fri, 09 Jan 2026
 11:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
In-Reply-To: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Fri, 9 Jan 2026 14:11:19 -0500
X-Gm-Features: AQt7F2qD5NQlHCyqdD_zHjmxV20bvOEGT_rKXFuqrKobJujnG-hNvI21StHEA5Q
Message-ID: <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:22=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.or=
g> wrote:
>
> SMEM allows the OS to retrieve information about the DDR memory.
> Among that information, is a semi-magic value called 'HBB', or Highest
> Bank address Bit, which multimedia drivers (for hardware like Adreno
> and MDSS) must retrieve in order to program the IP blocks correctly.
>
> This series introduces an API to retrieve that value, uses it in the
> aforementioned programming sequences and exposes available DDR
> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> information can be exposed in the future, as needed.
>
> Patch 3 should really be merged after 1&2

No. The HBB value currently returned by the bootloader is *not* always
the same as what we use currently, because some SoCs (like SM8250)
with the same DT ship with multiple different DRAM configurations and
we've been using a sub-optimal value the whole time. After all, that's
the whole point of using the bootloader value. But patches 1&2 will
only make the DPU use the bootloader value for HBB, not the GPU. So on
one of the affected SoCs, it will introduce a mismatch. You can't
change anything until the GPU side uses the new ubwc config as its
source of truth.

Connor

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v3:
> - Support v6 and v7 DDRInfo (v7 is used on e.g. Hamoa)
> - Handle rare cases of DDRInfo v5 with additional trailing data
> - Rebase/adjust to SSoT UBWC
> - Expose hbb value in debugfs
> - cosmetic changes
> - Link to v2: https://lore.kernel.org/r/20250410-topic-smem_dramc-v2-0-de=
ad15264714@oss.qualcomm.com
>
> Changes in v2:
> - Avoid checking for < 0 on unsigned types
> - Overwrite Adreno UBWC data to keep the data shared with userspace
>   coherent with what's programmed into the hardware
> - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
>   branches separately
> - Pick up Bjorn's rb on patch 1
> - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-0-94=
d505cd5593@oss.qualcomm.com
>
> ---
> Konrad Dybcio (3):
>       soc: qcom: smem: Expose DDR data from SMEM
>       soc: qcom: ubwc: Get HBB from SMEM
>       drm/msm/adreno: Trust the SSoT UBWC config
>
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  11 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  82 +------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |   5 -
>  drivers/soc/qcom/Makefile               |   3 +-
>  drivers/soc/qcom/smem.c                 |  14 +-
>  drivers/soc/qcom/smem.h                 |   9 +
>  drivers/soc/qcom/smem_dramc.c           | 408 ++++++++++++++++++++++++++=
++++++
>  drivers/soc/qcom/ubwc_config.c          |  69 ++++--
>  include/linux/soc/qcom/smem.h           |   4 +
>  9 files changed, 485 insertions(+), 120 deletions(-)
> ---
> base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
> change-id: 20250409-topic-smem_dramc-6467187ac865
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
