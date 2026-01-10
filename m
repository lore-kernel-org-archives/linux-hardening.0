Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9E30F95F
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768018696; cv=none; b=hvJ2dwmEOmt9l2TI70ftFjKXZLVubaUly7y2e3IJbwFWqZYwRo/r5rzvRFhfMn3plXk/YJeqraXY/xv6HRD7tEqnrKDJXU0r9GdO8nKk5b4EJAwrGopPjq509/Doi0NuF+JZLtcniixwfjxE6cINgD5UcXk+1HhJODZQwbpQurs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768018696; c=relaxed/simple;
	bh=dpUYUjDfyoU1qeQolcb2vaj2IIakm+BGrb623R/LCm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/bTejHryhueFGbcfV5vnlWA9JzaH6HWlYPJSIQPg3m5gicoTFg7yt3iD/B/O4Ka92RRprpHT4OJAylm3Q2OwS3buJLq6wXr9FZ6tyH0Ym8i/Y4eMoZPymPHvzF0b2dq/Zs3oNikM/4wLv8DZVaPGv+fRjBfccGx1v8iaWl/UIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BfekGxZY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hn63OSp5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BfekGxZY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hn63OSp5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60A4BV703265077
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 04:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=YvjR0sBl390qKfGTGwTn1b7N4BohJDG5WI0+S6lfGO0=; b=Bf
	ekGxZYZrvAfw6lK8Y4gHqENufiUBXfU3wkG7ro068gB6oDimVe10D6URbkdZ35cw
	o/Z/Sfe9HKU2EqyccdEWiZu1Vhbw8nQyuCXuko0G8kZld4nuFBIxBo/mOBcdPnWo
	dQoTBAtSOiSwZS3qs2mMm3sBkirrj4RkiKJ2Ha8KvElBXENGufDQkIzgvdufPc03
	0cygvwlLV8VpZHHuUMSqzoCQUq6JOm61jMRuNdphO4ZqKH6lh4FQVrj95PqKN0d+
	M+Dp733rW7Pch3HbOn1GIffgkx7c2DyaxmyMoGi6ya2DwipG8TcpnhCeP84jNxaE
	ZFDjQhFH33HI03eRlLBA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfhag0dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 10 Jan 2026 04:18:10 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4557c1e9e54so10231718b6e.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 20:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768018690; x=1768623490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YvjR0sBl390qKfGTGwTn1b7N4BohJDG5WI0+S6lfGO0=;
        b=hn63OSp55dBqH9FrN31prEJ/c7XIWcLVXz+B36fta123r9FQdz5dBDsXJ2+iLNW/gV
         v9n96nlVw8rgvM67XmSilNRFSb8HqjwIJFJ8mueUzm6HkTpdj9SvXf3N6wwawzPUUjQr
         B0x2OYrmTC4IO9WPKIFm/mKrcoZA0TLgupSn8espBaBq3KgRPjVVRIn6Lk7TbO5p88gf
         qvUAx3jIMrEovddBuAMG3fsYzRAxen6p+i1fcNKIfH0DOJVae36Vcli1m2+Re45405x6
         wFj684rTtVrNx/cxpyhJAxJ1guboHMr4wuYjXLwr4/58TWYZC/T69uQugWST2se+1RTW
         thEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768018690; x=1768623490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvjR0sBl390qKfGTGwTn1b7N4BohJDG5WI0+S6lfGO0=;
        b=seXWbfYrg3igcPreKQVQHASv3viqUbPInXN3JNGMgmkQhIxAmVRNvaMI32z/0ck1a4
         7m6BhK5sgmkTU9kE27mu9eVfnFjwako1lGGy3dcZEXGjDLu2YObC6dtWYtnS9KJhCbva
         qDVki/IUrcsc1x2Rtx6ba+px3Sghc8ObgHesiibC9eVSg3lJ0DW2x3rU14r/dM0UlSRZ
         n2TbkIXzBhdP85k9v1R25RuLRo/5IsVFN66R0uzV4u3qupTU8dZbwyoDhg8WNamIwu8G
         EUGJHlehVIKu3Po+FOXxIzWeVOo+R1Y8iBCaOrmTYZuOqxXmUtROJ/r+jAO2jbii+43/
         DL4g==
X-Forwarded-Encrypted: i=1; AJvYcCVXXnCu5/DZ0WBv0cNXCy7ZcoyFDK3M0H2WVh8QTW6dy5Oy7fWItV6YEZeBazzoy+vU4zcgMzeUtL5QzW6N0ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEGqAd0IYkac9sC/Nov4q1zNMnutNgXWKCIiUr5O613iITDdpk
	RivNiG9cIk7fkYYEyim62wvXOMB6ex3UkuV5Tqg1354quPRhEpUegMA55PiI6BeHv14iLIktzCB
	GnP+aSQMr0v65f2NW6EicwkSHS0f/Vs5/AP2A6sa6mTPM21AXD6hdRKIG4TIVoyQHjHKRaa3SCf
	YXnBYUv5g6qaf7aiy5QsZz8YsDYAneInufrY1BREblF8B3lw==
X-Gm-Gg: AY/fxX6Bqo22COshAuDIuB0VgRo6z6dyPXJgkJdRIgPUtINN3T5VcuvJwJcEcFuSTbY
	BUOEyqIfoYhyQHsA1D+m4IuLhcvH0PeW2aXHrljQhnN/2iKyzLc3ehVskhfekMVInl+DA/nKDCp
	FNdBHhmZvbKxAQzVP4ySDK0RyKgJZbEeGREenrHvYZI7yRi7i3LCa1KEb/uRWzhtwLjg==
X-Received: by 2002:a05:6808:2215:b0:44f:6ab9:4aee with SMTP id 5614622812f47-45a6befaaeemr6297731b6e.63.1768018690105;
        Fri, 09 Jan 2026 20:18:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEymw+xBhx5CKa9dPjA1bNNpF9wJib+zhE+Ki6h1wPxpj6SjAHb+30fr/sZ4jiXlFDFMlOvN+MlaY3wAHuPd3g=
X-Received: by 2002:a05:6808:2215:b0:44f:6ab9:4aee with SMTP id
 5614622812f47-45a6befaaeemr6297655b6e.63.1768018684906; Fri, 09 Jan 2026
 20:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
 <CACu1E7EDmLPhUFyouD=W6n+U7=oo7+6PY0Gz9=3pVpT2Qu9Z6w@mail.gmail.com>
 <CACSVV00iiAXGOqV2HZs9KREoqatE0eNBZjFH9hSFMmNaX3_RXw@mail.gmail.com> <CACu1E7Fh=GbLTiedj6OqtUxWiZbCVcKmsEzV6FYan5G6r1uyUA@mail.gmail.com>
In-Reply-To: <CACu1E7Fh=GbLTiedj6OqtUxWiZbCVcKmsEzV6FYan5G6r1uyUA@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 20:17:54 -0800
X-Gm-Features: AQt7F2pDX7FL2yQ5nEVGvdEQ4fegGKJEg02gjG594h0T2ZpR_q9rSVNBqJ-Mto8
Message-ID: <CACSVV015qwuGnJrMiZa=eKzu8BeGyGg5gpp=ko7-QgrAjE2phw@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: ll3HO_sPLLBTGat73WlnD6YJkf6AxYEk
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6961d302 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=KgOssdJzQp_kbXOIULcA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: ll3HO_sPLLBTGat73WlnD6YJkf6AxYEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEwMDAzMSBTYWx0ZWRfX4+CYqwGMGmAS
 7Ft60z+LHGesPzDvA/mrBgKLgyygmN+xM22HJ9kf/31bW4kk7KbOULNapvNT4Nc1lct4XQeXo1t
 D2RsZRy6JPG6PP+X3+LUHU5J408Fby6ARXIM2g0pdVLrWUqpfwLbWwHyyE3DpiXu3SR3WkQKHfB
 /gWayx9H1r/JRflTWld3UQCdfwm0Pw3Ej2t8BXy1hXuW7J2XMkyhj4qL2OqqOwKHoLIn39/q4Tx
 d9i2H+2mZpY0sp2c6V6u3A1tn8omuWfPYSwZ/k8lVgxDyxk9Mv27nBWIrGiQ881wBdTCf0t6G1z
 nzl3hrKauMwx5AcpVsIArk7Sbz3ke8MMKtS+fHt4Bas26slOxnAutoZAAo41MVbWa9yYC4JwkeJ
 2EhKduZJq7X8GSO8k0zQeH4CLVgnfIjxm/R8Rx/LL/DpnKqa4yduaQ0rnWP4uR7r6jBbRJ2Yqlf
 KyLA6cIa7mlpFF4/hsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-10_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601100031

On Fri, Jan 9, 2026 at 1:03=E2=80=AFPM Connor Abbott <cwabbott0@gmail.com> =
wrote:
>
> On Fri, Jan 9, 2026 at 3:41=E2=80=AFPM Rob Clark <rob.clark@oss.qualcomm.=
com> wrote:
> >
> > On Fri, Jan 9, 2026 at 11:11=E2=80=AFAM Connor Abbott <cwabbott0@gmail.=
com> wrote:
> > >
> > > On Thu, Jan 8, 2026 at 9:22=E2=80=AFAM Konrad Dybcio <konradybcio@ker=
nel.org> wrote:
> > > >
> > > > SMEM allows the OS to retrieve information about the DDR memory.
> > > > Among that information, is a semi-magic value called 'HBB', or High=
est
> > > > Bank address Bit, which multimedia drivers (for hardware like Adren=
o
> > > > and MDSS) must retrieve in order to program the IP blocks correctly=
.
> > > >
> > > > This series introduces an API to retrieve that value, uses it in th=
e
> > > > aforementioned programming sequences and exposes available DDR
> > > > frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> > > > information can be exposed in the future, as needed.
> > > >
> > > > Patch 3 should really be merged after 1&2
> > >
> > > No. The HBB value currently returned by the bootloader is *not* alway=
s
> > > the same as what we use currently, because some SoCs (like SM8250)
> > > with the same DT ship with multiple different DRAM configurations and
> > > we've been using a sub-optimal value the whole time. After all, that'=
s
> > > the whole point of using the bootloader value. But patches 1&2 will
> > > only make the DPU use the bootloader value for HBB, not the GPU. So o=
n
> > > one of the affected SoCs, it will introduce a mismatch. You can't
> > > change anything until the GPU side uses the new ubwc config as its
> > > source of truth.
> >
> > Hmm, how is this even working today if DPU is using HBB from the
> > global table but GPU is not?  Are we just getting lucky with
> > compositors that don't know about modifiers and end up scanning out
> > linear?
>
> It works out as well as it's always worked out, i.e. we try to make
> GPU and DPU config match and pray that we didn't mess it up. At least
> now we'll get a warning when they don't match.

I mean, upstream we kinda have a lack of feedback metrics other than
people reporting bugs... so maybe the first step is to break it with

  *cfg =3D *common_cfg;

and see what happens.

> >
> > We do log warnings when the global ubwc config does not match the
> > "fixed up" config.. google search for those msgs doesn't seem to turn
> > up anything other than the patch which introduced them.  Idk if that
> > is conclusive in any way, but I hope that means we could just delete
> > the fixup code on the GPU side.  I suppose we could add:
> >
> >        *cfg =3D *common_cfg;
> >
> > after the warning as a first step.  That would maybe get some bug
> > reports along with enough details in dmesg?
>
> Yes, the plan was always to delete the fixup code in the GPU config.
> And even that first step would be enough to prevent regressions when
> switching to the bootloader HBB value.
>
> There is a problem in that ubwc_swizzle isn't as well tested. Older
> parts supporting UBWC 1.0-3.0 partially or entirely ignore
> ubwc_swizzle, because it wasn't configurable back then, but we rely on
> it being set correctly in Mesa for VK_EXT_host_image_copy and sparse
> textures. So if ubwc_swizzle is incorrect you probably wouldn't
> notice, until you hit the HIC codepath in zink or some game using
> sparse textures. I think we fixed up all the cases where it was
> incorrectly set to 0x1 instead of 0x7, but it would be worth it to
> check again.

There are a lot more things out there than there are things running
games that would hit that.  Idk about zink, but there is a gallium
driver.  Either way, we don't have metrics feedback so the only option
is to break things with enough info in dmesg to figure out what is
going wrong AFAICT.

BR,
-R


>
> Connor
>
> >
> > BR,
> > -R
> >
> > > Connor
> > >
> > > >
> > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > > ---
> > > > Changes in v3:
> > > > - Support v6 and v7 DDRInfo (v7 is used on e.g. Hamoa)
> > > > - Handle rare cases of DDRInfo v5 with additional trailing data
> > > > - Rebase/adjust to SSoT UBWC
> > > > - Expose hbb value in debugfs
> > > > - cosmetic changes
> > > > - Link to v2: https://lore.kernel.org/r/20250410-topic-smem_dramc-v=
2-0-dead15264714@oss.qualcomm.com
> > > >
> > > > Changes in v2:
> > > > - Avoid checking for < 0 on unsigned types
> > > > - Overwrite Adreno UBWC data to keep the data shared with userspace
> > > >   coherent with what's programmed into the hardware
> > > > - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
> > > >   branches separately
> > > > - Pick up Bjorn's rb on patch 1
> > > > - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v=
1-0-94d505cd5593@oss.qualcomm.com
> > > >
> > > > ---
> > > > Konrad Dybcio (3):
> > > >       soc: qcom: smem: Expose DDR data from SMEM
> > > >       soc: qcom: ubwc: Get HBB from SMEM
> > > >       drm/msm/adreno: Trust the SSoT UBWC config
> > > >
> > > >  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  11 +-
> > > >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  82 +------
> > > >  drivers/gpu/drm/msm/adreno/adreno_gpu.h |   5 -
> > > >  drivers/soc/qcom/Makefile               |   3 +-
> > > >  drivers/soc/qcom/smem.c                 |  14 +-
> > > >  drivers/soc/qcom/smem.h                 |   9 +
> > > >  drivers/soc/qcom/smem_dramc.c           | 408 ++++++++++++++++++++=
++++++++++++
> > > >  drivers/soc/qcom/ubwc_config.c          |  69 ++++--
> > > >  include/linux/soc/qcom/smem.h           |   4 +
> > > >  9 files changed, 485 insertions(+), 120 deletions(-)
> > > > ---
> > > > base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
> > > > change-id: 20250409-topic-smem_dramc-6467187ac865
> > > >
> > > > Best regards,
> > > > --
> > > > Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > >
