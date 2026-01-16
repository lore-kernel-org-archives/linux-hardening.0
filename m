Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9834D39B
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588348; cv=none; b=N5d9ScyeDiI2ZF4neXrDrEWVDWvG2S/GTiqNh4q65in4hU4akIx8/Thi/NpBoTo1ZnjIDB7Gv8OMDqxLGqwVgFKZ7zZc0lYKQ762IImMs7OK0AXkqmO3iUMqGNeOngrEoNFZkRI2qCzug81P5t2fYC0kYz4TXrpu88yqJH9oiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588348; c=relaxed/simple;
	bh=GNtOFmbQPCuGx7/cehoqKwaq1nJk88tQ5TpWevZY90E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8PpkBOFhdqj0/OaUU7cT0he7RwETahwL12DcuqDdb1+ci5/2nAAtUz+MqQo1sUpsYxTWwQFX/8HcX2EBfHBopsw/XbfApHmBhwDhPXeBE/u/FVSzr6+xPyrNJWrP9lruEESZCuKx0LiYAVkMInqm6Iv8jcQJvv7pv0x+gOkZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WeXJeooC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LtrmEMDx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeXJeooC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LtrmEMDx"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GGUpQ32819336
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 18:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=gmJnwrq+qEZAzMC/5VtipcOHi3CTOErwfCEAzXc3NFA=; b=We
	XJeooCi/htsfcbB3EGGRbEd7Rfn+iUsr/AiADvRPO5UG65C1LpKcIlWJNEx9zTsf
	nmUrKVrm1VOsu98IUq3QqYRvA0nB/kswxtEDZnxv5K7x8V0MMYVhpDG5q3XT6ntC
	L8qWt7rDw3QIo4PUYBL1kB/1cTUfjWyU4OD5kurVUwHKaTm+I0WAuA58gt6bhUpm
	kCJAfskyctKgKxTuYopPuEV0j4zNxKoLUngtbx7lrcTtE4mRFJURjRs4FaLoa9X3
	3PA+szo8g+2GGEJI1dO7Um6uAUmQyJvJoXqGShkfcdTkCRsDOMJrN0Nl5yryGViw
	hEnnaIUvNfiTgoPu7mJw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq99ak6hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 18:32:25 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-459df8c820eso3103803b6e.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 10:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768588345; x=1769193145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmJnwrq+qEZAzMC/5VtipcOHi3CTOErwfCEAzXc3NFA=;
        b=LtrmEMDx3/z3ldtXM9aK1eh8fkG0G4lSN5rPTstBF5RfZoQMpfza/M8dzIUHoMPoZA
         uiHZVqqX2mc/s10Ld7KjQIZ9/G88lbc1oyRgdgcSDnjtFvqFcovVXUPp358SBrvBwGBO
         mYF7EnsI7yWp4ZybTi69T5RIdC9Z+X1mfQNAeEGn7ROFP4H08D5JXM6yRnCnOokE43eE
         hKotXAU8wwek45GHisiw5HuPyyo2YjKVxqx3ReQTjzm+u76KznNRy3Sw4sjkGbyEx4GK
         6Yje5zt1QUZRV8wwd5mC1r6r1QLsy4yDSGLnUmn8mn8XlYQ2PZ82cB9zPhehxQN3/lxC
         S61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768588345; x=1769193145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmJnwrq+qEZAzMC/5VtipcOHi3CTOErwfCEAzXc3NFA=;
        b=rBb8fdMoU//BNHOadlypi8XWhbSI6xjhEnDSO6XL9uBznqxBchOARdwLEmjeq+0Ji3
         owYs5Ltuhv/3sSZTcLXIDpv5rkp8vKJlEqwzsGZbjMyO7zrvQCOhpRtcasSSIeSBJEB7
         c7lbNkndM+lsP4zb36Zuwbg6EKdpRAW/7aoacRbsXaTP7Y7njQ57T6lMSR1JrpQtYc31
         GDlRX+6rAw0vyOPmde+ZSnvsHjJkK3GagylgH45hi0EjxbZ5RkT87aH7I6gNkd4FjMo4
         MrkZMtjbEfhOe4i1JZMJgohU4MZZ92HkQucmAsLXj1Dlohu2hb04u0mnTsoitAvCx/ET
         wcRA==
X-Forwarded-Encrypted: i=1; AJvYcCVl5GjhoXiIr2Z5Gppa6yyj+Pnt4snZCPRCCQwC7ijV7ohHi5Tgjq57Uih/l81TYucadBMFZRC6wxOuNweazGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzeFFyDZD9ln+r4Q1pW5Px3n8nOqMZ0n0Q+PkYqRkbymYBSh+
	Eh1qEwxDhfUI6GrGj/TtiNEYiTCz7LGAlZHUhdBxMXrndPpHsIhbdE0LnU2D8IwsUf9IqzpxAip
	1tOYJYn3lYj8rdBnhuJ24IrpT9KIL9j2Hed4g4fklEtj1u/1NakmZA7fvyYbghLLoovBtNOFrxn
	TzAFqes53m2n9B8jFuGy+UNKS7Gx4B9L8fK3wiT9xhcyFyGQ==
X-Gm-Gg: AY/fxX6BsociWESODaa18dDbuPkEupjERq4K3dpfxFc4Lsf5FnGC4Kfok+zoKpQ8FQd
	htG+XiaKXsQVLHH1BrHhqTzPN5EsIelBCXVA86EQpk7RwvlTbre0zkxAWGM+L7eeZ9Ijn64PYAE
	l32Vc9aQzE8OtbR3m6Lp41LK5gyz4nOGxNhqqvssmyZa9TOlACrz+zWxUGqoRVQD1cBA==
X-Received: by 2002:a05:6808:2902:b0:455:ee1f:e1c3 with SMTP id 5614622812f47-45c9d6b8fccmr1377672b6e.13.1768588344651;
        Fri, 16 Jan 2026 10:32:24 -0800 (PST)
X-Received: by 2002:a05:6808:2902:b0:455:ee1f:e1c3 with SMTP id
 5614622812f47-45c9d6b8fccmr1377653b6e.13.1768588344235; Fri, 16 Jan 2026
 10:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com> <20260108-topic-smem_dramc-v3-3-6b64df58a017@oss.qualcomm.com>
In-Reply-To: <20260108-topic-smem_dramc-v3-3-6b64df58a017@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 10:32:13 -0800
X-Gm-Features: AZwV_QjH_LAJrQbB9_T-U4SXhnS2PgPmgjjp6eFhzSG2zqHvjXMmhiR_pWC6tNs
Message-ID: <CACSVV01EiCmG=tLH=UOyHUVeUVnQ0X52OUeOAmXHFvRfeuj2JA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/msm/adreno: Trust the SSoT UBWC config
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
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
X-Proofpoint-ORIG-GUID: _KeV0ulISwG-WSbRP1wJrv2ndu0oMcIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDEzNyBTYWx0ZWRfXyFKV9mNVzhE+
 a5pouYTzYMGk4BCkqeRzmHrp4RHOO5lRtgLwOW6qWKIx1Pyo+sm78MDCvjoPlNwKrlPxywBCiKB
 XBeH0nMFnRTufMCgc8RxNw5hZFMmO0vYDuWzqs3tTQXLm/9EkdpQ+zpFsnkMq/lxnOKHSMAQe+s
 2Lt30hSiwqsmgLOQae7N5Aj3XomAFYJs8FXKshka2TVv4++LN27WHOVRUtp9UU6YzzkRFwiyw67
 Qgv9RL9QwVb7nFOl9UCXZKQCBLtO3Ro3YuZmHnVvkP+UmcrZ8kRcQvnWw1dghjg8BKJwGmm5QW9
 URjuXByRU/oCRZb8WZrIcqWmm2SHjuVlHLQp0D5FR/Xlf9V0/VnT+V2xe1S5S6WcWCknsLbdpr3
 /GxbcDDk412sbIvUI8QHhaP5/UyDPoKkdKOJ3VNgY3ucuLAlPuifK99LY8KbZAfdhj/Uoe5DkwT
 i8MZD8AXTXJOZfa0AiQ==
X-Proofpoint-GUID: _KeV0ulISwG-WSbRP1wJrv2ndu0oMcIq
X-Authority-Analysis: v=2.4 cv=f5ZFxeyM c=1 sm=1 tr=0 ts=696a8439 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=d94RvPs_YAZp7DxcWNsA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160137

On Thu, Jan 8, 2026 at 6:22=E2=80=AFAM Konrad Dybcio <konradybcio@kernel.or=
g> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Now that the highest_bank_bit value is retrieved from the running
> system and the global config has been part of the tree for a couple
> of releases, there is no reason to keep any hardcoded values inside
> the GPU driver.
>
> Get rid of them.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Rob Clark <robin.clark@oss.qualcomm.com>

> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 11 ++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 82 ++-------------------------=
------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 --
>  3 files changed, 6 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index 56eaff2ee4e4..eba6e74d0084 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1728,7 +1728,6 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_dev=
ice *dev)
>         struct msm_drm_private *priv =3D dev->dev_private;
>         struct platform_device *pdev =3D priv->gpu_pdev;
>         struct adreno_platform_config *config =3D pdev->dev.platform_data=
;
> -       const struct qcom_ubwc_cfg_data *common_cfg;
>         struct a5xx_gpu *a5xx_gpu =3D NULL;
>         struct adreno_gpu *adreno_gpu;
>         struct msm_gpu *gpu;
> @@ -1766,13 +1765,9 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_de=
vice *dev)
>         a5xx_preempt_init(gpu);
>
>         /* Inherit the common config and make some necessary fixups */
> -       common_cfg =3D qcom_ubwc_config_get_data();
> -       if (IS_ERR(common_cfg))
> -               return ERR_CAST(common_cfg);
> -
> -       /* Copy the data into the internal struct to drop the const quali=
fier (temporarily) */
> -       adreno_gpu->_ubwc_config =3D *common_cfg;
> -       adreno_gpu->ubwc_config =3D &adreno_gpu->_ubwc_config;
> +       adreno_gpu->ubwc_config =3D qcom_ubwc_config_get_data();
> +       if (IS_ERR(adreno_gpu->ubwc_config))
> +               return ERR_CAST(adreno_gpu->ubwc_config);
>
>         adreno_gpu->uche_trap_base =3D 0x0001ffffffff0000ull;
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 2129d230a92b..3a2429632225 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -729,82 +729,6 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
>         gpu_write(gpu, REG_A6XX_CP_PROTECT(protect->count_max - 1), prote=
ct->regs[i]);
>  }
>
> -static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
> -{
> -       const struct qcom_ubwc_cfg_data *common_cfg;
> -       struct qcom_ubwc_cfg_data *cfg =3D &gpu->_ubwc_config;
> -
> -       /* Inherit the common config and make some necessary fixups */
> -       common_cfg =3D qcom_ubwc_config_get_data();
> -       if (IS_ERR(common_cfg))
> -               return PTR_ERR(common_cfg);
> -
> -       /* Copy the data into the internal struct to drop the const quali=
fier (temporarily) */
> -       *cfg =3D *common_cfg;
> -
> -       /* Use common config as is for A8x */
> -       if (!adreno_is_a8xx(gpu)) {
> -               cfg->ubwc_swizzle =3D 0x6;
> -               cfg->highest_bank_bit =3D 15;
> -       }
> -
> -       if (adreno_is_a610(gpu)) {
> -               cfg->highest_bank_bit =3D 13;
> -               cfg->ubwc_swizzle =3D 0x7;
> -       }
> -
> -       if (adreno_is_a612(gpu))
> -               cfg->highest_bank_bit =3D 14;
> -
> -       if (adreno_is_a618(gpu))
> -               cfg->highest_bank_bit =3D 14;
> -
> -       if (adreno_is_a619(gpu))
> -               /* TODO: Should be 14 but causes corruption at e.g. 1920x=
1200 on DP */
> -               cfg->highest_bank_bit =3D 13;
> -
> -       if (adreno_is_a619_holi(gpu))
> -               cfg->highest_bank_bit =3D 13;
> -
> -       if (adreno_is_a621(gpu))
> -               cfg->highest_bank_bit =3D 13;
> -
> -       if (adreno_is_a623(gpu))
> -               cfg->highest_bank_bit =3D 16;
> -
> -       if (adreno_is_a650(gpu) ||
> -           adreno_is_a660(gpu) ||
> -           adreno_is_a690(gpu) ||
> -           adreno_is_a730(gpu) ||
> -           adreno_is_a740_family(gpu)) {
> -               /* TODO: get ddr type from bootloader and use 15 for LPDD=
R4 */
> -               cfg->highest_bank_bit =3D 16;
> -       }
> -
> -       if (adreno_is_a663(gpu)) {
> -               cfg->highest_bank_bit =3D 13;
> -               cfg->ubwc_swizzle =3D 0x4;
> -       }
> -
> -       if (adreno_is_7c3(gpu))
> -               cfg->highest_bank_bit =3D 14;
> -
> -       if (adreno_is_a702(gpu))
> -               cfg->highest_bank_bit =3D 14;
> -
> -       if (cfg->highest_bank_bit !=3D common_cfg->highest_bank_bit)
> -               DRM_WARN_ONCE("Inconclusive highest_bank_bit value: %u (G=
PU) vs %u (UBWC_CFG)\n",
> -                             cfg->highest_bank_bit, common_cfg->highest_=
bank_bit);
> -
> -       if (cfg->ubwc_swizzle !=3D common_cfg->ubwc_swizzle)
> -               DRM_WARN_ONCE("Inconclusive ubwc_swizzle value: %u (GPU) =
vs %u (UBWC_CFG)\n",
> -                             cfg->ubwc_swizzle, common_cfg->ubwc_swizzle=
);
> -
> -       gpu->ubwc_config =3D &gpu->_ubwc_config;
> -
> -       return 0;
> -}
> -
>  static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
>  {
>         struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> @@ -2721,10 +2645,10 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_d=
evice *dev)
>         msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
>                                   adreno_gpu->funcs->mmu_fault_handler);
>
> -       ret =3D a6xx_calc_ubwc_config(adreno_gpu);
> -       if (ret) {
> +       adreno_gpu->ubwc_config =3D qcom_ubwc_config_get_data();
> +       if (IS_ERR(adreno_gpu->ubwc_config)) {
>                 a6xx_destroy(&(a6xx_gpu->base.base));
> -               return ERR_PTR(ret);
> +               return ERR_CAST(adreno_gpu->ubwc_config);
>         }
>
>         /* Set up the preemption specific bits and pieces for each ringbu=
ffer */
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.h
> index 1d0145f8b3ec..da9a6da7c108 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -237,12 +237,7 @@ struct adreno_gpu {
>         /* firmware: */
>         const struct firmware *fw[ADRENO_FW_MAX];
>
> -       /*
> -        * The migration to the central UBWC config db is still in flight=
 - keep
> -        * a copy containing some local fixups until that's done.
> -        */
>         const struct qcom_ubwc_cfg_data *ubwc_config;
> -       struct qcom_ubwc_cfg_data _ubwc_config;
>
>         /*
>          * Register offsets are different between some GPUs.
>
> --
> 2.52.0
>
