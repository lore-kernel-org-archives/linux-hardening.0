Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E047ACE3
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467442; cv=pass; b=LO3iIGcFcO+6IHzU6ZwJWWXVD+mS1Yr8jDy9gJB982C4GLwty+8MEFz3y7zc5vYrGzh3gxRy3Qz4yzfY4W0hqa9Lp0lf945Nbkh9BkYbg71pDCYcd+pfoaf9W7M8CtzTgC+26KSKWIhTghX5PgwVXBtzMpsNd/uuAu1Htlo0uQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467442; c=relaxed/simple;
	bh=MSWHoWGIFn+iwFs4suHXdlxtL4JfLcvYlTQxB2Sr6m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om2lCEo0wxIN3E5CE4N0WM5d2e4u5k39u/RNzxoE6NUZ4ENBA6rPBFLI9cowPSm8z+taoCtRCrv9hEEDfVYcQdZSY20MXWXPrvZvzICZbYqzz69spzgYE9dOOHYqQLiwB7Ncr+XIkhbgPLCmhuf/gl++5Z7Xzma++YiMlJg4zlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwlEfJCk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgB+WPfR; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwlEfJCk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgB+WPfR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9hPZB3742103
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y4oAyrq2KtQXNsE5MFIxXDu1u6My17cNb8DrQ/MjMRk=; b=NwlEfJCkHhcoeSOK
	bmZITvB9u6oxNjBQ7h8OqvduG6KCTuaHaqtd6r7UtHxSq9vvGuJoYmXWue24/YWs
	MB609WXQEURRd/LJndkTYQ6tbZ9N3xKbp9j4xqrmYqudZRmUR23aOjb1wiSMl9x2
	WraC9KiG18nhXL5+RWojUvSULL38a1AVIuq5wq4oC2SIwPK/yiuq7QxjLvhDS92V
	TtLI4pKdvjibQRzT//j2jYyCCunekiY9BJgaAkPJB8tYYO6yH9LJwaixx9l6rHzQ
	CyuIomy4EwIApyYEM55fZcqdQ+/gbGyH5NI4FWon/jf2iN0qItqpwrYceAbbhvzX
	5kbpMg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpyux16y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 10:17:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52dcf1bb6e9so14146401cf.1
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 03:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789467438; cv=none;
        d=google.com; s=arc-20260327;
        b=REYwW+JroRzuKTtSpZHcxMbkYwJpOBzOF7Y55prEiL1iuYe4TabZQVnsCAc/FnZS6X
         zIgo4VF5842h0dVxcJL/70LfpZ7mfzUMG22Yr+6FLLcKW75p5T5DdUIvQLZMEq75VUOC
         c2P8gdV3ejMSCshYxfEbgfRSFZ47c75FU4uGyehMKFKUgQcEGNMeYnH++m7Vnxp0fdY9
         cNMpxWiP+vGYUyjH9oQq3KwINMe4ETDwPsBSbYawSa2cwAXWuSOEH6WXUJAsfvBe/6dC
         fbY/VbPswFIU/D68wLrdSuEj/l0FWvW+0CV8/iRlXuQTYT1fxl1E3zoMD1amLoIGqZyq
         xs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4oAyrq2KtQXNsE5MFIxXDu1u6My17cNb8DrQ/MjMRk=;
        fh=6C8rGvia/1k8uXScAaDI9hRjZ1AANN7YK607d5qIKKk=;
        b=kI/tTZEkzxawuSfpiihocSn6EN4KYDLmYE4mIkTonjUCgrgKCGDnZZhYJItqygmjYr
         +whKkOk5NPaPStBwRI/+VE7AMNHHxlpduOBIUQoxQCPDF37L08Ews+yTnfhD8sgpOrBv
         9wfecn1cqVG46weAMZz6tH7d9IVSRXBtfEF4TCB0eecttpltNaJKWWGWJbfdb/U1uTq8
         SwUSvoFAt/c3qr/CBvRYRLKXlIeh4YrcG2lZKehtYK/FA+a9z2lkmCry5bOP6ixmw/J1
         aeiKDXHydLBQ8Nv32z9ej6ttK1Qron4zpTtO/h9b64tuye9Qj0/D/7dNTH/TEHmOMjGG
         8njA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789467438; x=1790072238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4oAyrq2KtQXNsE5MFIxXDu1u6My17cNb8DrQ/MjMRk=;
        b=kgB+WPfRNtBYroWJuT+BADNoMFDxeZv2ePNsQTVDgIz8e5BxZ/O+MmxoFT60ikZgvY
         0Esw2B42vJuKSEnxNi+8xU3/CTaw75oEPWi1B8B0jZw8y47f5T6hJiB84sUIZrDc3zfY
         uZTdmgI4XQfMzpCs7LRJtck89ODH+3V25mEPr4W11mt+0lBPQoGJc7X5ZONV+xtCdx9H
         +6YncmshYoN3FFsDNVIuTmcsvitheVo7shMQeUjL6mlzpd90EGHXukKjJ5vewjuqZVzo
         GpuLTdhka34ep3JR7bsnLHlgkOqeX0KtTjVGx1N43aQ/dCZDn459wVA3oztAsR/8wt9s
         bVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467438; x=1790072238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4oAyrq2KtQXNsE5MFIxXDu1u6My17cNb8DrQ/MjMRk=;
        b=Jod5FvwcX/Aklm0E2rywt5CvJHcECUc2jsFCKFvjF5vQERaYPGOK1Cz8AlkYjwvvpy
         vGEMcSU86BHmEgP43R7EcZ89NYIaKS6plRpcJnuNRceZXXUNCHOff6Syn3mrLj8VPj02
         qgRXxWNcukDHl/7xPm/QoiMp7m+JM07oIk/6hocVhkfrJXfdqLdOVUnjhuA/5c+GOZmd
         j5R7gWjU3kKhyQlcdFVvx10ERaNetpXRa9xxvuOgnToJZktgj7EoA1SWujcHBIkfEIeo
         q4VU+pbBEyYWFqjPs5Vx1+22RcOF8412PhGkPrLAFWdgGZSfiZ/Q6zEvqS6sdJeIgkC4
         dzFw==
X-Forwarded-Encrypted: i=1; AKwUvBz3RbvvBtb3fpIG5UEcTKPPszYfGIq6YH0gqbIZkHt5WIQ10ty2vumMuw2yXpVJe6Gup0i4s5ayDji/ECWMWC0=@vger.kernel.org
X-Gm-Message-State: AFuF++meah9qeuIxrXyuZ6sECQmwAdD7Nuux7eUJ+dle9FbEUNlqtCwp
	PmfWqZmI4niYbVAcya9y5YLiibdLbf84fbr/+578Ym2zC/aa/h6JEJLnSMpCoEgaLOalVCkh9B2
	d6dLw7DvZ3Dp2BQ7G3WreItZMRmuLmxCpTMCSWc5ExJHkRV3mobkeXpmVJZ0kfMhoNbLBsz0m37
	hDUAPUA2t4soGSdac2l/Ae6uOdOGvvOPbefRZe/5lc8I52cQ==
X-Gm-Gg: AYBFou1/NWn8CBDuf76CT+szGC9h764K+9CPItNz8XPPtLKzt0xcKU0k33STWbTHwZ5
	nFtaZSEVueOfWwlxBitaAhE6wRB9zbDuFRIv+QK/FCXGbOYgtRLyJ9G/2oIafqX2/0a1CvSHhBu
	q3BzncwJZ5vvlUZsZqrB+k7Sc4ZAV49oSjErgq+jbkg1ABNzz3nR8bVeFcRbK6UV96QlNRLDjeP
	6ps3cbt5C6PCtvtnA1nzDgi1kitm/VAg3y0tyWT2jI81BNl/TtsRLUHTgB/ghElEH2XCJt0RLj7
	Obj7zd3izRS5AlAlwmAqZfsUfsrD
X-Received: by 2002:a05:620a:2b8f:b0:936:d00a:4947 with SMTP id af79cd13be357-93a345745demr388744685a.2.1789467433590;
        Tue, 15 Sep 2026 03:17:13 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8f:b0:936:d00a:4947 with SMTP id
 af79cd13be357-93a345745demr388741685a.2.1789467433112; Tue, 15 Sep 2026
 03:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
 <20260915-camss-isp-ope-v7-4-77b13d131d3d@oss.qualcomm.com> <4b8f4fd6-53e0-4efd-953a-cd8ebad7d479@linaro.org>
In-Reply-To: <4b8f4fd6-53e0-4efd-953a-cd8ebad7d479@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 12:17:00 +0200
X-Gm-Features: AcwNN1Xege-7rQu-hUK_GBF3L260MNhym32h4wKC90S0C1_dNyEg6Nm0Y0W-5zQ
Message-ID: <CAFEp6-3bvRtjDhmRy+G3AzP9vL=TrnGpOf1gU-=aQKNcdyzn_w@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] media: uapi: Add CAMSS ISP configuration definition
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE0NyBTYWx0ZWRfX4n6vGerLMIbL
 ws9WkavyImnMCAI9vFQIdIybodjWTFLhiyuP5QySQwQON74zuk60zI/y8dQeEW2F0BHKoljs3pe
 ctXCse52KVkOETezUhtn95cg1j5Jh8abSRsLxCo4g2IxbAAKNPtX2s7v/sQ/j3TDshUkIG54kHq
 Ujofk3rdfUj1ZQatuk5Jxrq1/WF9TXb6TNjxqP5c6xBClKnuQXMTK91+mhv+9rO0Xc3224n3eiM
 pjSzr+67QswkbxUgtW9Vs4eEyZHZ7GThB9gsGnHzHKVmCdJePKBKnJ3YySUq9Bsi3rIVP3A0HnH
 JrdmPJWBEGj+HUJV47LPcbVCexsVjZhTDhl8+E+fCcivog+AFUawdI1BQA0vZO1c2jkSdUgmUWs
 PCrWTbpA/4dB4j01+25La4CEE/jiKMu/WcIWIexITx1B7xsA/NeTXrepH+DGReLWNiAovLKnuZB
 FSSFhSOOHFK3SjVm8tQ==
X-Proofpoint-ORIG-GUID: i7vvdwdNiyn_fyL8XQlP1aTxnYjf_G4M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE0NyBTYWx0ZWRfXz6F6HQ1QIzha
 gKBOyOr6lHoj1R1nPu/lIYpB9k2zv5oFlAyfSwMx4GPflXzFqlV2O85i7cI9PmWZ+XSNpMoMgM8
 F4SGuk9ZXOTFN8tD+xkVvteJKcwG6v8=
X-Proofpoint-GUID: i7vvdwdNiyn_fyL8XQlP1aTxnYjf_G4M
X-Authority-Analysis: v=2.4 cv=QYLzLcbv c=1 sm=1 tr=0 ts=6aa91b2f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=xq3W2uTSAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=_-fwvmfW1z61RZSq5NcA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=P5L7wpMTXyg1GfFA3Gwx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150147

Hi Bryan,

On Tue, Sep 15, 2026 at 11:11=E2=80=AFAM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 15/09/2026 09:11, Loic Poulain wrote:
> > Add the uapi header qcom-camss-config.h defining the ISP parameter
> > structures used by the CAMSS Offline Processing Engine (OPE) driver.
> > This includes structures for white balance, chroma enhancement and
> > color correction configuration.
> >
> > The block type enum is shared across CAMSS ISPs so that userspace only
> > has to deal with a single set of block identifiers.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   include/uapi/linux/qcom-camss-config.h | 212 ++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 212 insertions(+)
> >
> > diff --git a/include/uapi/linux/qcom-camss-config.h b/include/uapi/linu=
x/qcom-camss-config.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e3d6cc4df7de00345e8142c=
81392dd42338c6ead
> > --- /dev/null
> > +++ b/include/uapi/linux/qcom-camss-config.h
> > @@ -0,0 +1,212 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +/*
> > + * Qualcomm CAMSS ISP Driver - Userspace API
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#ifndef _UAPI_LINUX_QCOM_CAMSS_CONFIG_H
> > +#define _UAPI_LINUX_QCOM_CAMSS_CONFIG_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/media/v4l2-isp.h>
> > +
> > +/**
> > + * enum camss_params_block_type - CAMSS ISP parameter block identifier=
s
> > + *
> > + * Each value identifies one ISP processing block.  The value is place=
d in
> > + * the @type field of &struct v4l2_isp_params_block_header.
> > + *
> > + * @CAMSS_PARAMS_OPE_WB_GAIN: white balance gains and offsets (CLC_WB)=
,
> > + *   &struct camss_params_ope_wb_gain
> > + * @CAMSS_PARAMS_OPE_CHROMA_ENHAN: RGB to YUV colour transfer matrix
> > + *   (CLC_CHROMA_ENHAN), &struct camss_params_ope_chroma_enhan
> > + * @CAMSS_PARAMS_OPE_COLOR_CORRECT: colour correction matrix (CLC_CC),
> > + *   &struct camss_params_ope_color_correct
> > + * @CAMSS_PARAMS_OPE_GAMMA: per-channel gamma correction curves (CLC_G=
LUT),
> > + *   &struct camss_params_ope_gamma
> > + */
> > +enum camss_params_block_type {
> > +     CAMSS_PARAMS_OPE_WB_GAIN =3D 1,
> > +     CAMSS_PARAMS_OPE_CHROMA_ENHAN =3D 2,
> > +     CAMSS_PARAMS_OPE_COLOR_CORRECT =3D 3,
> > +     CAMSS_PARAMS_OPE_GAMMA =3D 4,
> > +};
>
> Most of the OPE specific naming can be dropped, I shared the ICP
> data-structure analysis already:
>
> https://patchwork.linuxtv.org/project/linux-media/patch/20260426000346.11=
58633-1-bryan.odonoghue@linaro.org/

Ok, I thought we agreed on having OPE specific structures, that is why
I recently moved everything to OPE specific name.

>
> i.e.
> > +struct camss_params_ope_color_correct {
> > +     struct v4l2_isp_params_block_header header;
> > +     __u16 a[3];
> > +     __u16 b[3];
> > +     __u16 c[3];
> > +     __u16 k[3];
> > +     __u16 qfactor;
> > +     __u16 _pad[3];
> > +} __attribute__((aligned(8)));
>
> For ICP I have:
>
> +struct camss_params_color_correct {
> +       struct v4l2_isp_params_block_header header;
> +       __u16 a[3];
> +       __u16 b[3];
> +       __u16 c[3];
> +       __u16 k[3];
> +       __u16 qfactor;
> +       __u16 _pad[3];
> +} __attribute__((aligned(8)));
>
> So this data-structure is shared camss_params_ope_color_correct ->
> camss_params_color_correct

Ack.

Also, I will remove the _ope_ suffix from the wb_gain and
color_correct structures. These structures may differ or even be
absent in the ICP case, but they should remain aligned with the IFE
implementation since both use the same underlying blocks.

>
> > +/**
> > + * struct camss_params_ope_gamma - per-channel gamma correction curves
> > + *
> > + * Implements the CLC_GLUT pipeline module, applied in the RGB domain.=
  It
> > + * holds one independent lookup table per colour channel. Each table i=
s a
> > + * direct (not segmented) map of input level to output level.
> > + *
> > + * Each table has @CAMSS_OPE_GAMMA_LUT_SIZE (256) entries of 16-bit un=
signed
> > + * output. Each entry holds an X-bit output value depending on interna=
l bus,
> > + * the upper bits are ignored by the hardware.
> > + *
> > + * On Agatti OPE, The module maps a 12-bit input to an 8-bit output, t=
he top
> > + * 8 input bits index the table and the low 4 bits are used to linearl=
y
> > + * interpolate between adjacent entries. Entry i therefore represents =
the
> > + * output for input level i/255 of full scale.
> > + * Output range: 0x00 =3D black, 0xFF =3D white.
>
> That's not specific to Agatti, its hwo the Qcom gamma silicon works right=
 ?

Yes, as far as I know. However, we may observe some variation if the
internal bus width changes.
Considering the hardware platforms we currently support with OPE, as
well as the upcoming platforms, I think we can treat this as a generic
assumption for now.

> Same RTL synthesised in OPE, IPE and IFE. So you don't need to make this
> OPE specific commentary.

Ack.

>
> > + *
> > + * How to fill a curve (same on all three channels for pure luminance
> > + * gamma; different curves per channel additionally shift colour balan=
ce):
> > + *
> > + *   Identity (pass-through, gamma 1.0):
> > + *     lut[i] =3D i;                                // i =3D 0..255
> > + *
> > + *   Encode with gamma g (e.g. sRGB-like, g =3D 2.2):
> > + *     lut[i] =3D round(pow(i / 255.0, 1.0 / g) * 255.0);
> > + *
> > + * @header:  block header; @header.type =3D CAMSS_PARAMS_OPE_GAMMA
> > + * @glut:    green channel gamma curve
> > + * @blut:    blue  channel gamma curve
> > + * @rlut:    red   channel gamma curve
> > + */
> > +struct camss_params_ope_gamma {
> > +     struct v4l2_isp_params_block_header header;
> > +     __u16 glut[CAMSS_OPE_GAMMA_LUT_SIZE];
> > +     __u16 blut[CAMSS_OPE_GAMMA_LUT_SIZE];
> > +     __u16 rlut[CAMSS_OPE_GAMMA_LUT_SIZE];
> > +} __attribute__((aligned(8)));
>
> For the ICP I have
>
> +struct camss_params_glut {
> +       struct v4l2_isp_params_block_header header;
> +       __u8  instance;
> +       __u8  _pad[7];
> +       __u16 r[CAMSS_GLUT_LUT_SIZE];
> +       __u16 g[CAMSS_GLUT_LUT_SIZE];
> +       __u16 b[CAMSS_GLUT_LUT_SIZE];
> +} __attribute__((aligned(8)));
>
> So it makes more sense to differentiate the firmware type to the
> register-mapping type. i.e. the above becomes camss_params_icp_gamma {}
> whereas your subumitted change would be just camss_params_gamma {}

ok!



>
> > +#define CAMSS_PARAMS_OPE_MAX_PAYLOAD         \
> > +     (sizeof(struct camss_params_ope_wb_gain)        +\
> > +      sizeof(struct camss_params_ope_chroma_enhan)   +\
> > +      sizeof(struct camss_params_ope_color_correct)  +\
> > +      sizeof(struct camss_params_ope_gamma))
> > +
> > +#endif /* _UAPI_LINUX_QCOM_CAMSS_CONFIG_H */
> >
>
