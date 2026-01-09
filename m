Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC219D8BC
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991283; cv=none; b=IBCq03iN28hP+YI6n1/n2stkG7i3JCXswh00yYKYiHE2014+Yqwspd+BF4RTjtjilBl65dDsfby5e/NE7bc+sc7egbQFRo/KnVlr6ZR1EQ4o5E9kobZNZ/QHQ/7cQ3hvT/Dh1edIspelAXo++pmx3TKsoihn5NZ6y0svsCBOIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991283; c=relaxed/simple;
	bh=to9ahcS4219wq5I/lD0Sq+R4Za7W+mDk3w0XKlFRtOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiLTm0ZPlMuu4oPFDGJT86S/6Po99Mmecl3c8RKRDw+VR9o/y7wA819SyPuQTdtnz7x87U083Zkx1zGXsFvtI/DX/9phg7V1GJI1sziiKqwkzdPQPyoxHQlQv4/gGuckd7bOlCf0oivYFJi49Rrjr+LcqSaSE6Onnd58BWSLVmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hw6lZDKr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J+XREj7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hw6lZDKr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J+XREj7/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609CkLlO3542328
	for <linux-hardening@vger.kernel.org>; Fri, 9 Jan 2026 20:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=Hir9brUJpHlA7x/ase7YIvZHRMJOe3oUrJ+uuUbm8s4=; b=Hw
	6lZDKrJ46BEgUBnKqkzKorchH5R3IBD1F77gZyULb3YSoBlzwstHEtdE5PA7lVBt
	ocoEVSMC3zDNrSwIQBouzsnEUmb+AqT6Iyc7rVL5s7EN22cQpM8Lool158nRjbhH
	uXCDw2aLt/igk9m/Tmu68JO1YyrA6oVUAaA6yKraVP7NrQM0Lep/EIQiodeUPGjx
	Pna9HeH7eiUWt9Ar39AumeNOnt11ctdcTbsghpXzjrWBjLe+G3Q1GYfkFiu/XuCV
	nOSryMIFZ/0BHn6jjd4/HWgyWDNzt7EPEjQluDTSgwVKOBejuqkcg+0i0Cabzr7/
	cO67bS6I+2LwAFTxSzag==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bju6b2m75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 20:41:19 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45015d0d16aso9925986b6e.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767991279; x=1768596079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hir9brUJpHlA7x/ase7YIvZHRMJOe3oUrJ+uuUbm8s4=;
        b=J+XREj7/01vTX4CzKhjaoA9ZX1GRBICaaHorpRuFFvhJU4ywSKxzGajBUEF6+KITCR
         RNV6tUk+wrplBncfItJ0IL/aY6N6dfEPMmO1i/2JGUFwprP+gyiXNmdZ1OS0sZowLEa7
         99qQ5/6Dl0qZlQvl7bmiegWB+HocpHvE41i2j7EA2WkHMQeqeSG5PIkXFMe8Js490VMQ
         wic9FfVJ8gI9+PSd757rzjiqOWK5J6nYRPtkyLYbij7zHg7CztStNgw4h/5wGG5eNsII
         6/L/b5pAEGveY73k7pStMseI+xs388Yl6K16gVKiloqE2MQcclVm+sI1WNyjjB7ffyP8
         55tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767991279; x=1768596079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hir9brUJpHlA7x/ase7YIvZHRMJOe3oUrJ+uuUbm8s4=;
        b=LTVtEsaJENinru4i1Fm/7uUseej5MUmwlei0otPyVL8ZTcWO6NPtBBKmJ73VRSNSQe
         gtyxy1C63ErLgIwtYkjulnPf9bDYsIrC76pgj9ujxZMA3luDL4Q2Dp7JqyAb+HlX+HCv
         9VJpwKx0d57kwkBibtnMzTdceb2birxoAdhul7nv/eWnV4EAvMGQUL9xjdo4m1ZM54Al
         mcOHtTopmL4QrPWob4/qOv5b114/ZdrKj4GhLhe9hhlZCkxRO6DeHtxO8Z13zGP9sEUI
         tyjjEcC8hbijhqDppSN88ckndAt+01inqWz3Qotp8eTZ3+bv68IvI8UlU8LMLXES5VRC
         9qnw==
X-Forwarded-Encrypted: i=1; AJvYcCUO6ZEOLd+clWGqfKRKKf4Q7xdKDpfkkS8Gia5Glp81UfAAs9q29Fyz8mSPfhN0TKS2aFutk6t5b58Q+gtAV4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3/lqeGw7auLneF9nWAI++SyDHK7xr38V3XvlNrfAl3tRQ7p+l
	mygOiTGmaufMdhJgp8RCFd49ISX+rZiOhUF85KQKqIwV1GuJfSCV/XkrVQs8qWotg4TL1fI1yPS
	Kbd6w85aeWzq0ubEzaQBOO3UGKoxh6ScWc0kCHvXhDpf5NIiQcnAHASnZPHHi86dTMAp3nvNEks
	Pgu2lZEBXBtMnvBhjmqbDWuIC5LYyRLFTg0bVvoENYBGZGlA==
X-Gm-Gg: AY/fxX75NKjanCOzrbzuUSePvk7/NGD4T9i20V3YD+iyeO+jytlvzvUAjJPCk/U3mff
	C68ERqq38mASMWviPHgdmc/oiEGjy3sxG3u+q6+bmIE0Q+0EfJG105Ed1y05mOToiwrU3UpOFHE
	4WKeQtu7O/nGeorKk+18WWRnHu6/YSB2G+aVHDXC0Sncr7mNQ330ZWyOmK+KM5/DDZNA==
X-Received: by 2002:a05:6808:c16b:b0:453:7404:90bf with SMTP id 5614622812f47-45a6bd85759mr6083949b6e.14.1767991278954;
        Fri, 09 Jan 2026 12:41:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpfhjiKOuT+qlJfi6rYssjk7Vc0RpE22HCOpT+0NSEG6xwpBeSi/q77IqnzuKXXx8CpL/quxvWSJlWHLbx7ow=
X-Received: by 2002:a05:6808:c16b:b0:453:7404:90bf with SMTP id
 5614622812f47-45a6bd85759mr6083932b6e.14.1767991278592; Fri, 09 Jan 2026
 12:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com> <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
In-Reply-To: <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 12:41:07 -0800
X-Gm-Features: AZwV_Qh6Gca2q8cBDwfG4Zl54AnO5eHMEPHL-qw8ARyTQOHUjVKrl7UjWTjSTY4
Message-ID: <CACSVV00iiAXGOqV2HZs9KREoqatE0eNBZjFH9hSFMmNaX3_RXw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: Connor Abbott <cwabbott0@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE2MiBTYWx0ZWRfX63WDHLbXmxe0
 ILVDoL44gpQSrjCYkKlfLmgWZzvRpzm1z9GJw189iFvmEI5H/I0yn0hcjIIktZPvFNty4uNBWFK
 n6Ukhfce8HZPFK0t8a4XHayLqPyR9LgzhWA4Nc0so1QbFihTqAt48bb+Y+EQXYJPnVC13XiX7Cb
 eMhi/b/agZIvcoKLrmguQ5Eo5ANvxm0/Ww+Azh5LbUzyO2hx7W0OmjpauubPZaafeg9BMSLCH91
 /n8ajZc8s2tZPbehJL9EBHFUUYWwxpTZ6ThwC0D0t0T9dLFUN5fnf00gGVnvw2yT2hoXfbYDixF
 31SyxR7PSFDj0BwOzCMIrQWTG9IsP9UtSVR5YzhcU7odqeDBMAiIF4WsYi1w7yxvwWDHYC5iPBD
 S90M+VjyQRqzEyp2LX20raifPzl9JXxZl9xhlQtiZFfoDZjSP0OJRRtxSIyVn5qsCzHaIpbE5Px
 7BmGkDTjDq4CslKT4pw==
X-Proofpoint-ORIG-GUID: 55N1eokqmeskBsMthzPpVsoYGE2-Xrco
X-Authority-Analysis: v=2.4 cv=V+5wEOni c=1 sm=1 tr=0 ts=696167ef cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=I_tfjSbw-6LnIXkDKrAA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: 55N1eokqmeskBsMthzPpVsoYGE2-Xrco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_06,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090162

On Fri, Jan 9, 2026 at 11:11=E2=80=AFAM Connor Abbott <cwabbott0@gmail.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 9:22=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.=
org> wrote:
> >
> > SMEM allows the OS to retrieve information about the DDR memory.
> > Among that information, is a semi-magic value called 'HBB', or Highest
> > Bank address Bit, which multimedia drivers (for hardware like Adreno
> > and MDSS) must retrieve in order to program the IP blocks correctly.
> >
> > This series introduces an API to retrieve that value, uses it in the
> > aforementioned programming sequences and exposes available DDR
> > frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> > information can be exposed in the future, as needed.
> >
> > Patch 3 should really be merged after 1&2
>
> No. The HBB value currently returned by the bootloader is *not* always
> the same as what we use currently, because some SoCs (like SM8250)
> with the same DT ship with multiple different DRAM configurations and
> we've been using a sub-optimal value the whole time. After all, that's
> the whole point of using the bootloader value. But patches 1&2 will
> only make the DPU use the bootloader value for HBB, not the GPU. So on
> one of the affected SoCs, it will introduce a mismatch. You can't
> change anything until the GPU side uses the new ubwc config as its
> source of truth.

Hmm, how is this even working today if DPU is using HBB from the
global table but GPU is not?  Are we just getting lucky with
compositors that don't know about modifiers and end up scanning out
linear?

We do log warnings when the global ubwc config does not match the
"fixed up" config.. google search for those msgs doesn't seem to turn
up anything other than the patch which introduced them.  Idk if that
is conclusive in any way, but I hope that means we could just delete
the fixup code on the GPU side.  I suppose we could add:

       *cfg =3D *common_cfg;

after the warning as a first step.  That would maybe get some bug
reports along with enough details in dmesg?

BR,
-R

> Connor
>
> >
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Support v6 and v7 DDRInfo (v7 is used on e.g. Hamoa)
> > - Handle rare cases of DDRInfo v5 with additional trailing data
> > - Rebase/adjust to SSoT UBWC
> > - Expose hbb value in debugfs
> > - cosmetic changes
> > - Link to v2: https://lore.kernel.org/r/20250410-topic-smem_dramc-v2-0-=
dead15264714@oss.qualcomm.com
> >
> > Changes in v2:
> > - Avoid checking for < 0 on unsigned types
> > - Overwrite Adreno UBWC data to keep the data shared with userspace
> >   coherent with what's programmed into the hardware
> > - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
> >   branches separately
> > - Pick up Bjorn's rb on patch 1
> > - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-0-=
94d505cd5593@oss.qualcomm.com
> >
> > ---
> > Konrad Dybcio (3):
> >       soc: qcom: smem: Expose DDR data from SMEM
> >       soc: qcom: ubwc: Get HBB from SMEM
> >       drm/msm/adreno: Trust the SSoT UBWC config
> >
> >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  11 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  82 +------
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h |   5 -
> >  drivers/soc/qcom/Makefile               |   3 +-
> >  drivers/soc/qcom/smem.c                 |  14 +-
> >  drivers/soc/qcom/smem.h                 |   9 +
> >  drivers/soc/qcom/smem_dramc.c           | 408 ++++++++++++++++++++++++=
++++++++
> >  drivers/soc/qcom/ubwc_config.c          |  69 ++++--
> >  include/linux/soc/qcom/smem.h           |   4 +
> >  9 files changed, 485 insertions(+), 120 deletions(-)
> > ---
> > base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
> > change-id: 20250409-topic-smem_dramc-6467187ac865
> >
> > Best regards,
> > --
> > Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >
