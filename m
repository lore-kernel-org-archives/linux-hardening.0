Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226F315D5D
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992610; cv=none; b=OXvSlpBgPRw9/AlDBjSPhJ6qYZlQDDtrfCzWi0RqVoDtUKw+r+kCodCCnzhIRmBVSenXhjWHRS03KVDrRMdfsEM+K+0bzYltQfJAG5eNh3PL2jcbke9P6PTzQEGMfSV+AuUYSDOMjJZsTpRJXlr2l6wk15XTBlorbByc+KjzcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992610; c=relaxed/simple;
	bh=AzyKVBKxcBqLMhFEsyX9gIfzx+kfdwmhzGCULfUTNO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnRCqsJytjFe9IjuC9gkn/OklmdHdLJtIoCfnIKw0Y4czcDYsugYhhW6fqjtkIpB+5GXw/sgSGTigqWmLpSp7EwBPwxi7dyas6hdwHnNpcwxocIYUJ6qJyTWwa738Y7bxe/T5iVyv8HfiJMj8l39YA1eoBemJ5yFtIZXPTTwV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilJASmOs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilJASmOs"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34f62e71769so544780a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767992607; x=1768597407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyOVDUF74gAYTbKoqj0ae3EHZS9go1yG7YgI85ErsM0=;
        b=ilJASmOsi+wyE5FBVy0tL0sO6a7ol6EE6+yhIs9B6WnkEWDu829QvdUKNcygBvAqDH
         nl4Lb6GLyV9fffENa1X1baeYgMKqBfFZAfBgKQqmGU7ajoCPeY94Cgb6Mg+spgDD2U1Y
         8zpvqpH0AyQD3wumoHxcWNqgFh1G+xeeAJ4IKEmBDQ7ci7dq8kG0tUhxQCgSnc6KNvsA
         IK8n4QB9fispwvZ9XHg+8HpRNcRYEYHC+fABJp3c59HNgkkxlIe2TrIzP+p/HnKrsYpA
         LvltGYyLzMMG55G8hOeHqL5z6/euRSpvgTYFfjzHQcLZnzCwY0gFIzCr7eT8mSphdghR
         a3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767992607; x=1768597407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyOVDUF74gAYTbKoqj0ae3EHZS9go1yG7YgI85ErsM0=;
        b=Q3Ls252vI2hQF81Gu6PKrrPc0gNJEKYWxMS7acSZCmbo9ya/DoMS+DDfNjdDRCodIJ
         SqGVpx7nmpZEdAOp7MItbeBN5w7SmUWKHwbKMJInWeAK7kM3MAGfNhA//AgqQpo5SDlL
         qSGqA/EJNb8eXtMFt7UX/jUXpghMCP1NgDu8qw5vD62BhhKkTAQQuFLXYh8drQxHgAQU
         FAdOIok37x11EN4ICiT7QJylgGnkwbA1R9eFYEE86rxOBZzbR/ShsfSd8LH7tW2z0UeA
         f2QmAKBCOX++fkW+Y5dJUBtFljfe17rrGG664Htq3B/uoKZKNOH8Xm6mWvuVh28ZmIox
         yaTg==
X-Forwarded-Encrypted: i=1; AJvYcCVKweS7bKkv1oAXUXZdZ0c9eAvf532bTMP9uPdiBmEZBkmFdjH8cbzvqynRYJ/ImIySn60YL4USUwaQ+qXj6QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6EvxRYyZxwF8GyODSjvSW/Pk5X9fO3RfupqLW69JwwOt1lrH
	jOXWpO1YZlK28J9RIokj+6rSW+FFY79QNR59xZsDYSCM3CocqMlApIgqzY2rFrF704YTjKaDCRG
	tEkrJNR/yIsLv90RTY51WCbSl+2jxlq8=
X-Gm-Gg: AY/fxX4APJDLaaEPRoer5uuXBZz6utrMP104RsUbj6XfeiEUWZEeajDHygjLgbKALm/
	GPZzThhpbdmV1ZYqOPhSQM/zZVtTD17cgysW9gmY/i9kZNRG92sbdSUHihKitB3m/Z47g+wjDrJ
	C+ZLbzBW/t8TvTa/YlxY1w18GOQrkgMRcI4kuqQEyrf1/IPHeOFYWAPACATegsmaHWopPglUAld
	8ubg4tYHeb+EggSAXYQi9mgYCmsXWjyDZnOWZYLV/i2rB8OrzngcDwWwNsYRJMKivMk5fE=
X-Google-Smtp-Source: AGHT+IE05GJLOX7J9o3rv9JKWTOoOlTvZY9nZW90P03JGgrN2QFWyiHlqKTLk+SGCgsCEZfgIesafoFepLnyHuO2ttQ=
X-Received: by 2002:a17:90b:4f88:b0:340:aa74:c2a6 with SMTP id
 98e67ed59e1d1-34f68cbe5ecmr7454279a91.6.1767992606559; Fri, 09 Jan 2026
 13:03:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com> <CACSVV00iiAXGOqV2HZs9KREoqatE0eNBZjFH9hSFMmNaX3_RXw@mail.gmail.com>
In-Reply-To: <CACSVV00iiAXGOqV2HZs9KREoqatE0eNBZjFH9hSFMmNaX3_RXw@mail.gmail.com>
From: Connor Abbott <cwabbott0@gmail.com>
Date: Fri, 9 Jan 2026 16:03:15 -0500
X-Gm-Features: AQt7F2pM1G3qtIE9uPH0KTNnnwwx0yjLdXW5AgqF5oEPRMWpeFIUrXyH2ORXjfE
Message-ID: <CACu1E7Fh=GbLTiedj6OqtUxWiZbCVcKmsEzV6FYan5G6r1uyUA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: rob.clark@oss.qualcomm.com
Cc: Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sean Paul <sean@poorly.run>, 
	Akhil P Oommen <akhilpo@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:41=E2=80=AFPM Rob Clark <rob.clark@oss.qualcomm.co=
m> wrote:
>
> On Fri, Jan 9, 2026 at 11:11=E2=80=AFAM Connor Abbott <cwabbott0@gmail.co=
m> wrote:
> >
> > On Thu, Jan 8, 2026 at 9:22=E2=80=AFAM Konrad Dybcio <konradybcio@kerne=
l.org> wrote:
> > >
> > > SMEM allows the OS to retrieve information about the DDR memory.
> > > Among that information, is a semi-magic value called 'HBB', or Highes=
t
> > > Bank address Bit, which multimedia drivers (for hardware like Adreno
> > > and MDSS) must retrieve in order to program the IP blocks correctly.
> > >
> > > This series introduces an API to retrieve that value, uses it in the
> > > aforementioned programming sequences and exposes available DDR
> > > frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> > > information can be exposed in the future, as needed.
> > >
> > > Patch 3 should really be merged after 1&2
> >
> > No. The HBB value currently returned by the bootloader is *not* always
> > the same as what we use currently, because some SoCs (like SM8250)
> > with the same DT ship with multiple different DRAM configurations and
> > we've been using a sub-optimal value the whole time. After all, that's
> > the whole point of using the bootloader value. But patches 1&2 will
> > only make the DPU use the bootloader value for HBB, not the GPU. So on
> > one of the affected SoCs, it will introduce a mismatch. You can't
> > change anything until the GPU side uses the new ubwc config as its
> > source of truth.
>
> Hmm, how is this even working today if DPU is using HBB from the
> global table but GPU is not?  Are we just getting lucky with
> compositors that don't know about modifiers and end up scanning out
> linear?

It works out as well as it's always worked out, i.e. we try to make
GPU and DPU config match and pray that we didn't mess it up. At least
now we'll get a warning when they don't match.

>
> We do log warnings when the global ubwc config does not match the
> "fixed up" config.. google search for those msgs doesn't seem to turn
> up anything other than the patch which introduced them.  Idk if that
> is conclusive in any way, but I hope that means we could just delete
> the fixup code on the GPU side.  I suppose we could add:
>
>        *cfg =3D *common_cfg;
>
> after the warning as a first step.  That would maybe get some bug
> reports along with enough details in dmesg?

Yes, the plan was always to delete the fixup code in the GPU config.
And even that first step would be enough to prevent regressions when
switching to the bootloader HBB value.

There is a problem in that ubwc_swizzle isn't as well tested. Older
parts supporting UBWC 1.0-3.0 partially or entirely ignore
ubwc_swizzle, because it wasn't configurable back then, but we rely on
it being set correctly in Mesa for VK_EXT_host_image_copy and sparse
textures. So if ubwc_swizzle is incorrect you probably wouldn't
notice, until you hit the HIC codepath in zink or some game using
sparse textures. I think we fixed up all the cases where it was
incorrectly set to 0x1 instead of 0x7, but it would be worth it to
check again.

Connor

>
> BR,
> -R
>
> > Connor
> >
> > >
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > ---
> > > Changes in v3:
> > > - Support v6 and v7 DDRInfo (v7 is used on e.g. Hamoa)
> > > - Handle rare cases of DDRInfo v5 with additional trailing data
> > > - Rebase/adjust to SSoT UBWC
> > > - Expose hbb value in debugfs
> > > - cosmetic changes
> > > - Link to v2: https://lore.kernel.org/r/20250410-topic-smem_dramc-v2-=
0-dead15264714@oss.qualcomm.com
> > >
> > > Changes in v2:
> > > - Avoid checking for < 0 on unsigned types
> > > - Overwrite Adreno UBWC data to keep the data shared with userspace
> > >   coherent with what's programmed into the hardware
> > > - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
> > >   branches separately
> > > - Pick up Bjorn's rb on patch 1
> > > - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-=
0-94d505cd5593@oss.qualcomm.com
> > >
> > > ---
> > > Konrad Dybcio (3):
> > >       soc: qcom: smem: Expose DDR data from SMEM
> > >       soc: qcom: ubwc: Get HBB from SMEM
> > >       drm/msm/adreno: Trust the SSoT UBWC config
> > >
> > >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  11 +-
> > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  82 +------
> > >  drivers/gpu/drm/msm/adreno/adreno_gpu.h |   5 -
> > >  drivers/soc/qcom/Makefile               |   3 +-
> > >  drivers/soc/qcom/smem.c                 |  14 +-
> > >  drivers/soc/qcom/smem.h                 |   9 +
> > >  drivers/soc/qcom/smem_dramc.c           | 408 ++++++++++++++++++++++=
++++++++++
> > >  drivers/soc/qcom/ubwc_config.c          |  69 ++++--
> > >  include/linux/soc/qcom/smem.h           |   4 +
> > >  9 files changed, 485 insertions(+), 120 deletions(-)
> > > ---
> > > base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
> > > change-id: 20250409-topic-smem_dramc-6467187ac865
> > >
> > > Best regards,
> > > --
> > > Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > >
