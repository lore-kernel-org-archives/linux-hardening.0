Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1DDDC5
	for <linux-hardening@vger.kernel.org>; Sat,  9 May 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337043; cv=pass; b=rTSO//e/n9iaOx3hdpr8mng6bqKed3VGjt60q6cKOs3oc/pwxzx15LCICJcTVenZVY9BQeIZ0yI08IMMHIdZ9Bo+Yv8TNzwPy9TeolMP5BgBHiSSWoNWl6HlchQK3aVcMnL1X20px+nqLRq5P7HZ5txvTetkqE8RSNbrS5k5Ea4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337043; c=relaxed/simple;
	bh=qR4wL5XttJUg7TwW9yDaV59E/TQb0zyC4nYBUtxTJzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4UztmeVz0+WoJKRzTaBscJsmld97rkp6fFUzjSDGHBroGgcPqDsiUy62QPEPlnFp+3UrdL0H2IUXVfA0n3OBM5nyPPEWJJxeYUCccze5Z+LTwT+TGHjNXthENTFP3sF4v67G6vTpFdxnF3GoMw0pFFny3zGKoU/VDgCBWJT26s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pOpzOajY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aA/lnsBh; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pOpzOajY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aA/lnsBh"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 649BNfIS3845274
	for <linux-hardening@vger.kernel.org>; Sat, 9 May 2026 14:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qLoc4zG4PaP8yM0Gui5KMUEYFN7xKuV0cNDCyxDDm54=; b=pOpzOajYONIpyxb/
	gDbQtFCP65EO8g3xaOlrDSUpyNO1neWO8LpGOhMLq/mE7YbzHEikwklEBMiDyjHG
	/bdxuvPTVM2khktnsTG5y5AJTzT4cvWAYSb0VBWtQBfGhsgMbRPZ1aUp9mjKLpRl
	MGy23rsUEa7uGz4CQbsYNaLD6aXyGM9HrEtGFu4Rp1/Yn74G9+W7R5RGHBSTPEJK
	u+3g+/dggGSlURzzvd7FTjoU0QCGC1wZXlVY7cZqiLHRxj9o8PJZv0kzHSwusxxo
	bSHu9YHzzaWHx0zamVMrlSb5uQuBwUVMX3FWdyHP0H3wpTWSpcayOT/XcJ/r79J7
	QUgWNQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e240h09p2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Sat, 09 May 2026 14:30:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb0aa51c6so2558506d6.1
        for <linux-hardening@vger.kernel.org>; Sat, 09 May 2026 07:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778337040; cv=none;
        d=google.com; s=arc-20240605;
        b=fZg7Vdm6OAEuklbXblDGlRUs1MTTzaWYf4f66C5nxfdYbPU80tbW50ayHSV/q3uhJ+
         /TTe/GvkXqr6mGY/uyU7CdS3kdG4x5GDaRWAW9FGFPOd7cBM7jFfCqDBTjlptwDPqNxp
         Qsmf1PGBGf5dCIjwZp5lTnSxB0/trahFsXjKmSwu0M6mqPJCtR3HNwj3ZsMRxNrHbxyN
         lTGAJRDBznImqSrdsbWLfHZYSUd+W//Nfsdnq6oD+xlsCMx8oVewUhvELTgXBw/UFp7C
         +7rKJCapn0iWwvsCOaHQkhT+Lyk3axp/HEiPdna8AHBUMo5gnUKUif6iMlmhQKWFhAFX
         zgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qLoc4zG4PaP8yM0Gui5KMUEYFN7xKuV0cNDCyxDDm54=;
        fh=aC/qBu1jq3LrMqf1TmIhta/Q3pCG+KWGxiXtTZWbTik=;
        b=PwpENOPgfNPR2PsqkCwWFqddUNptSgYNUSrNw73gTBdwcgbDlrV9FLszWARZhUfdGN
         GGj2FDBpsI2CO7VmN3tjylTq7ob1hznExqLGxrbh4U6+/2QjsHXtA32tfArmiBNktGuA
         G3mpdo6YxVzHW4fNY34I/daaR/caDH9A6tKDJSm2RC0EnyR1bPRRJnLdQP6kq+3a14/o
         49WVM9gwdNQt4iAPxRUPuUY1i7ZiZ2/ktVVgznwwy4+9gmrU4SlCXIElss7z/TA2omMd
         PhNcC8Ywg8eNF/kiIKAxFnGNCfC3BdvAYSOjlB/me3rOhhY/ROokkyZpp2j8clOBOhr2
         +w2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778337040; x=1778941840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLoc4zG4PaP8yM0Gui5KMUEYFN7xKuV0cNDCyxDDm54=;
        b=aA/lnsBh4mTID6HlUwGZLtdjVGE9OJTF8p2IsOQfA90ELCZg/ZUb0L9IvSviEmWeOd
         PqQuBEV02b74A4zzpAEeaVrMHSEJGPwFwxneICcXVFMcoFCVujrRt4mex36XQ/oK4c/s
         oOj/a9xxmnZPBToaJVz5S+UioQM6AI1l1pdnecsln1aISjl7dH8mxAN/137FAPAxAIKP
         iC/cYlzHIHu1dKOhL+hfj8ooqzoNRYF7F4rriCGuh348v/F7s4TLMfLLWwpsNwYggcs7
         xsqv6jwgTdG7CyBFFGTf0PO8HdxvsE+gNJ31bLdJEdwXXVdai2l4xkc6ChIn04oLPaW2
         ngIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778337040; x=1778941840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLoc4zG4PaP8yM0Gui5KMUEYFN7xKuV0cNDCyxDDm54=;
        b=AkQrsNdrqVAgGgbdOX1qtDzcilLL8FTc4fIyfFLpYd48c/ZSZeKZaL1K8n+KJgn2IU
         c3K/Bb0Ds0CD6HthAm0Hfl32jppVyfZ1pMEdUC0W4afogZnbyIDLDKSMgBdtPp9jp0tb
         Lfzomf41Q4wlSLcwHaMKJjFptW8MGqt0Y0V86ZdTQfuIEZDfvki6oV53x+I0gI2l2XeN
         dnNTgmryGio0Eu3fAlWOjz5yZEwUqISPNe6x+6O+RV4qNEIikiuV3GrWK0SZahWPl7R2
         yEZCB4bgV1HQGF/ZInaTJ+PXyeOHXrJL6a4eT+MzSw72GuFgOjAsNDB/0DkyOaXAbzjE
         KaNA==
X-Forwarded-Encrypted: i=1; AFNElJ8VQejqykK5WrAfd+ChA3o3HG0SLciYW75CmPA5oDoiPP9OsK+ea+M//j6M/qDWKa/AM59lbuENmSCUb7eg2UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcKPmUWUJzZ4GWANrn+40C2nq2iq7aI3MdTXY21BfwsG35mHT
	mZiLE7e7dS2o/nVSi/e+iDlS86y4EyjWarfeF8cIVpx7IkcGxO1P7Ar7CJRT7dPaHUovQsugdYh
	62ppLvxmGUSrUptzWKMZDQfGTuk/Q6++rOa/1cGk6jMWWyl3+unB/UGfwMK7GTvhMZ7XXaxf18/
	R/AYW+U6Fg/7Eywx3H6EY4riNbCVoEnJQhRR/YP69QZBN1kQ==
X-Gm-Gg: Acq92OHCSkOHa6WH89myrNzULPqLWkHHfgBJGUpb7LpDHRBsjlIjZHHKoAE6laXAM6C
	dtrIpOs23hNgLexJgCsptV9qOSWJ9BEpgD3mUGC6yPlw9n+GOmfnBQKW5NpuBcis0gqpZ+MWLSz
	agbg9BrZNilOcTEp/27sKLlp+oQVhVuMpcrkolnmqMLlTurkozc2kBut1B0fhQn+4GLTEEkNcXG
	zRt8+9nMZPbyUlvSDBAW87qrBlVITgeIGDWZV86
X-Received: by 2002:a05:6214:ac6:b0:89c:cb57:6227 with SMTP id 6a1803df08f44-8bdb787ab26mr169124726d6.12.1778337039900;
        Sat, 09 May 2026 07:30:39 -0700 (PDT)
X-Received: by 2002:a05:6214:ac6:b0:89c:cb57:6227 with SMTP id
 6a1803df08f44-8bdb787ab26mr169123296d6.12.1778337039012; Sat, 09 May 2026
 07:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
 <20260508-camss-isp-ope-v3-4-bb1055274603@oss.qualcomm.com> <3c46545a-64e3-49f9-a2db-7de154e92daa@linaro.org>
In-Reply-To: <3c46545a-64e3-49f9-a2db-7de154e92daa@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 9 May 2026 16:30:27 +0200
X-Gm-Features: AVHnY4LaIxtaxRLQlsLTNzpoxqkLbKq5CQju--zUlyVSjph73J3Ssds_i3lIR7c
Message-ID: <CAFEp6-3z+DTU9E+RwKQYshe5KjbTxjkWWCsjgzAhnj=bf0usZQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] media: qcom: camss: Add camss-isp-bufq helper
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, devicetree@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, kieran.bingham@ideasonboard.com,
        johannes.goede@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1NiBTYWx0ZWRfXzz711w0U0dvm
 cmQjYSl4H7/GEv+IPlNltGh823dc+PPHJiKzagt7QWMuSDbeQGFJQw6u3eJTQjRn4NJcGWSXflM
 mgxeYlNOFLlkrsNyg3vyN2/wdJaK2DAn2mAl5cMpsWQ++P0JkItoeKctRkKP2Cal+xmqLbQ5WGH
 Zk+aNu1KI/9EUkymJmGO9zYYx1dInmftyo2XYo4UhbLNmwVI3cf/nD7i22hRHCOSeUOmt85Jzbr
 iTEXqpDA8U0L9Z7nLIZuOPy7Jg65cFgUdZcgDTNCgme74Hef8pSk3EHcjHNFkadPjLKqDRTM8aK
 oL/JdH4WgNoCMyyDlyBSGBt/oqydhj9ElU5M5oqvVgY6KnuYfzilVrJuHOXHnVz3ZH5/Q1lrw6c
 bONFlJGsXxqKqPqWAmwpCpFAs2s3b++Ovhc/qvxB7fi3JK/RCdJXNuiJW/Tw/jSVo7vUun9T8nP
 gh3NB1h1k6taecgIbKg==
X-Proofpoint-GUID: epcgX55y9fZNKO8VqNff3IiDwCeoGb-e
X-Authority-Analysis: v=2.4 cv=X5Bi7mTe c=1 sm=1 tr=0 ts=69ff4510 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=BQXfQ4Z-Cs0ksQ7NdlYA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: epcgX55y9fZNKO8VqNff3IiDwCeoGb-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090156

Hi Bryan,

On Fri, May 8, 2026 at 11:57=E2=80=AFAM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 07/05/2026 23:49, Loic Poulain wrote:
> > Add a per-queue ready-buffer FIFO helper for CAMSS offline ISP drivers.
> > camss_isp_bufq provides N spinlock-protected FIFO lists of ready vb2
> > buffers, one per queue index. This can help multi-queues management
> > and synchronization in ISP context.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/media/platform/qcom/camss/Kconfig          |  14 +++
> >   drivers/media/platform/qcom/camss/Makefile         |   5 +
> >   drivers/media/platform/qcom/camss/camss-isp-bufq.c | 101 ++++++++++++=
+++++
> >   drivers/media/platform/qcom/camss/camss-isp-bufq.h | 122 ++++++++++++=
+++++++++
> >   4 files changed, 242 insertions(+)
> >
> > diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/=
platform/qcom/camss/Kconfig
> > index 4eda48cb1adf049a7fb6cb59b9da3c0870fe57f4..d77482f3f5eadc65856806b=
9b237d65ea484f267 100644
> > --- a/drivers/media/platform/qcom/camss/Kconfig
> > +++ b/drivers/media/platform/qcom/camss/Kconfig
> > @@ -7,3 +7,17 @@ config VIDEO_QCOM_CAMSS
> >       select VIDEO_V4L2_SUBDEV_API
> >       select VIDEOBUF2_DMA_SG
> >       select V4L2_FWNODE
> > +
> > +config VIDEO_QCOM_CAMSS_ISP
>
> I think this config option should be dropped entirely.
>
> > +     tristate "Qualcomm CAMSS ISP common helpers"
> > +     depends on VIDEO_DEV
> > +     depends on MEDIA_CONTROLLER
> > +     select V4L2_ISP
> > +     select VIDEOBUF2_CORE
> > +     help
> > +       Common helper library for Qualcomm CAMSS offline ISP drivers.
> > +       Provides buffer queue management, job scheduling, MC pipeline
> > +       topology builder, and ISP parameter buffer parsing.
> > +
> > +       This module is selected automatically by drivers that need it.
> > +
> > diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media=
/platform/qcom/camss/Makefile
> > index 5e349b4915130c71dbff90e73102e46dfede1520..bfc05db0eada1d801839ceb=
8a3b157baae613053 100644
> > --- a/drivers/media/platform/qcom/camss/Makefile
> > +++ b/drivers/media/platform/qcom/camss/Makefile
> > @@ -29,3 +29,8 @@ qcom-camss-objs +=3D \
> >               camss-format.o \
> >
> >   obj-$(CONFIG_VIDEO_QCOM_CAMSS) +=3D qcom-camss.o
> > +
> > +qcom-camss-isp-objs :=3D camss-isp-bufq.o
> > +
> > +obj-$(CONFIG_VIDEO_QCOM_CAMSS_ISP) +=3D qcom-camss-isp.o
> > +
> > diff --git a/drivers/media/platform/qcom/camss/camss-isp-bufq.c b/drive=
rs/media/platform/qcom/camss/camss-isp-bufq.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b1dcf60afcc63d112eee7bd=
143f08a7b4aac9a18
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.c
> > @@ -0,0 +1,101 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * camss-isp-bufq.c
> > + *
> > + * CAMSS ISP per-queue ready-buffer FIFO.
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +
> > +#include "camss-isp-bufq.h"
> > +
> > +struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues)
> > +{
> > +     struct camss_isp_bufq *bufq;
> > +     unsigned int i;
> > +
> > +     bufq =3D kzalloc(struct_size(bufq, entries, num_queues), GFP_KERN=
EL);
> > +     if (!bufq)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     bufq->num_queues =3D num_queues;
> > +
> > +     for (i =3D 0; i < num_queues; i++) {
> > +             INIT_LIST_HEAD(&bufq->entries[i].rdy_queue);
> > +             spin_lock_init(&bufq->entries[i].rdy_spinlock);
> > +     }
> > +
> > +     return bufq;
> > +}
> > +EXPORT_SYMBOL_GPL(camss_isp_bufq_init);
> > +
> > +void camss_isp_bufq_release(struct camss_isp_bufq *bufq)
> > +{
> > +     kfree(bufq);
> > +}
> > +EXPORT_SYMBOL_GPL(camss_isp_bufq_release);
> > +
> > +void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int qu=
eue_idx,
> > +                       struct vb2_v4l2_buffer *vbuf)
> > +{
> > +     struct camss_isp_buf *buf =3D
> > +             container_of(vbuf, struct camss_isp_buf, vb);
> > +     struct camss_isp_bufq_entry *entry =3D &bufq->entries[queue_idx];
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&entry->rdy_spinlock, flags);
> > +     list_add_tail(&buf->list, &entry->rdy_queue);
> > +     entry->num_rdy++;
> > +     spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(camss_isp_bufq_queue);
> > +
> > +struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *buf=
q, unsigned int queue_idx)
> > +{
> > +     struct camss_isp_bufq_entry *entry =3D &bufq->entries[queue_idx];
> > +     struct camss_isp_buf *buf;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&entry->rdy_spinlock, flags);
> > +     buf =3D list_first_entry_or_null(&entry->rdy_queue,
> > +                                    struct camss_isp_buf, list);
> > +     spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
> > +
> > +     return buf ? &buf->vb : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(camss_isp_bufq_next);
> > +
> > +struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *b=
ufq, unsigned int queue_idx)
> > +{
> > +     struct camss_isp_bufq_entry *entry =3D &bufq->entries[queue_idx];
> > +     struct camss_isp_buf *buf;
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&entry->rdy_spinlock, flags);
> > +     buf =3D list_first_entry_or_null(&entry->rdy_queue,
> > +                                    struct camss_isp_buf, list);
> > +     if (buf) {
> > +             list_del(&buf->list);
> > +             entry->num_rdy--;
> > +     }
> > +     spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
> > +
> > +     return buf ? &buf->vb : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(camss_isp_bufq_remove);
> > +
> > +void camss_isp_bufq_drain(struct camss_isp_bufq *bufq, unsigned int qu=
eue_idx,
> > +                       enum vb2_buffer_state state)
> > +{
> > +     struct vb2_v4l2_buffer *vbuf;
> > +
> > +     while ((vbuf =3D camss_isp_bufq_remove(bufq, queue_idx)))
> > +             camss_isp_buf_done(vbuf, state);
> > +}
> > +EXPORT_SYMBOL_GPL(camss_isp_bufq_drain);
> > +
> > +MODULE_DESCRIPTION("CAMSS ISP per-queue ready-buffer FIFO");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/media/platform/qcom/camss/camss-isp-bufq.h b/drive=
rs/media/platform/qcom/camss/camss-isp-bufq.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1a8bc7b112a1b039233cfc7=
be573f1f40fcda7c9
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.h
> > @@ -0,0 +1,122 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * camss-isp-bufq.h
> > + *
> > + * CAMSS ISP per-queue ready-buffer FIFO.
> > + *
> > + * Provides N spinlock-protected FIFO lists of ready vb2 buffers, one =
per
> > + * queue index.  Drivers call these helpers from their vb2 ops and job
> > + * completion paths.
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#ifndef CAMSS_ISP_BUFQ_H
> > +#define CAMSS_ISP_BUFQ_H
> > +
> > +#include <linux/list.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/types.h>
> > +#include <media/videobuf2-v4l2.h>
> > +
> > +/**
> > + * struct camss_isp_buf - vb2 buffer wrapper
> > + *
> > + * Use as vb2_queue.buf_struct_size so buffers can be placed on the
> > + * ready lists managed by camss_isp_bufq.
> > + *
> > + * @vb:   The vb2 V4L2 buffer =E2=80=94 must be first.
> > + * @list: Entry in the per-queue ready list.
> > + */
> > +struct camss_isp_buf {
> > +     struct vb2_v4l2_buffer  vb;     /* must be first */
> > +     struct list_head        list;
> > +};
> > +
> > +/**
> > + * struct camss_isp_bufq_entry - per-queue ready-buffer state (opaque)
> > + */
> > +struct camss_isp_bufq_entry {
> > +     struct list_head        rdy_queue;
> > +     spinlock_t              rdy_spinlock;
> > +     u32                     num_rdy;
> > +};
> > +
> > +/**
> > + * struct camss_isp_bufq - multi-queue ready-buffer state
> > + *
> > + * Allocate with camss_isp_bufq_init(), free with camss_isp_bufq_relea=
se().
> > + *
> > + * @num_queues: Number of entries in @entries.
> > + * @entries:    Per-queue state; flexible array.
> > + */
> > +struct camss_isp_bufq {
> > +     unsigned int                    num_queues;
> > +     struct camss_isp_bufq_entry     entries[] __counted_by(num_queues=
);
> > +};
> > +
> > +/**
> > + * camss_isp_bufq_init() - allocate a multi-queue ready-buffer state
> > + * @num_queues: number of per-queue FIFO lists to create
> > + *
> > + * Returns a pointer to the new bufq or ERR_PTR on allocation failure.
> > + */
> > +struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues);
> > +
> > +/**
> > + * camss_isp_bufq_release() - free a bufq allocated with camss_isp_buf=
q_init()
> > + * @bufq: bufq to free
> > + */
> > +void camss_isp_bufq_release(struct camss_isp_bufq *bufq);
> > +
> > +/**
> > + * camss_isp_bufq_queue() - append a buffer to the ready list for @que=
ue_idx
> > + * @bufq:      target bufq
> > + * @queue_idx: queue index (must be < bufq->num_queues)
> > + * @vbuf:      buffer to enqueue; must be embedded in a &struct camss_=
isp_buf
> > + */
> > +void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int qu=
eue_idx,
> > +                        struct vb2_v4l2_buffer *vbuf);
> > +
> > +/**
> > + * camss_isp_bufq_next() - peek at the head of the ready list without =
removing
> > + * @bufq:      target bufq
> > + * @queue_idx: queue index
> > + *
> > + * Returns the head buffer or NULL if the list is empty.
> > + */
> > +struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *buf=
q,
> > +                                          unsigned int queue_idx);
> > +
> > +/**
> > + * camss_isp_bufq_remove() - dequeue and return the head of the ready =
list
> > + * @bufq:      target bufq
> > + * @queue_idx: queue index
> > + *
> > + * Returns the dequeued buffer or NULL if the list is empty.
> > + */
> > +struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *b=
ufq,
> > +                                            unsigned int queue_idx);
> > +
> > +/**
> > + * camss_isp_bufq_drain() - return all ready buffers with the given st=
ate
> > + * @bufq:      target bufq
> > + * @queue_idx: queue index
> > + * @state:     vb2 state to pass to vb2_buffer_done() for each buffer
> > + */
> > +void camss_isp_bufq_drain(struct camss_isp_bufq *bufq, unsigned int qu=
eue_idx,
> > +                        enum vb2_buffer_state state);
> > +
> > +static inline u32 camss_isp_bufq_num_ready(struct camss_isp_bufq *bufq=
,
> > +                                         unsigned int queue_idx)
> > +{
> > +     return bufq->entries[queue_idx].num_rdy;
> > +}
> > +
> > +static inline void camss_isp_buf_done(struct vb2_v4l2_buffer *vbuf,
> > +                                    enum vb2_buffer_state state)
> > +{
> > +     vb2_buffer_done(&vbuf->vb2_buf, state);
> > +}
> > +
> > +#endif /* CAMSS_ISP_BUFQ_H */
> >
>
> I honsestly don't think patches 4,5 and 6 are necessary and TBH they
> look at least partially generated to me.
>
> Several LLM patterns abound - em - dash and (parenthetical style) as an
> example.
>
> I just wonder is all of this code really necessary ? You could do all of
> this locking in the OPE itself and save ~200 LOC.

I'm inclined to agree there is no real added value in this change at
the moment, and that it can easily be handled within the OPE
code/structures. I=E2=80=99ll move it into OPE in the next version.

> I think in the previous cycle we discussed articulating some of these
> concepts in v4l2 itself - I think you could achieve what you want to do
> here with a struct list_head and a spinlock_t in the OPE driver context.

Yes, there are ongoing long-term discussions about improving framework
support for drivers requiring multi-context or job-based handling
(e.g., offline processing engines). Since these are longer-term
efforts, the current approach is to have OPE components such as job
handling, scheduling, and buffer management reasonably abstracted,
making it easier to transition to a generic V4L2/media solution when
it becomes available.

So I will (re)integrate this buf/q management in the OPE driver (4),
but can I have a second thought about 5 and 6? I agree they may not be
worth to be their own patches and modules but would it be ok to keep them
in separated files, creating a camss-offline/ or camss-ope/ directory in
camss in which I could have the OPE driver files (i.e  camss_ope.c,
camss_job.c and camss_pipeline.c), that would also allow a future
ICP/HFI based driver to be integrated and use the same components?

Regards,
Loic
