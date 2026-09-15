Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B33B47D7
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482350; cv=pass; b=nW6LJPrBU6tvP06gEZCYVQCRvNAVv7W5+/0Li1GREcMysfZ8XrsLuh1ldo/wKuXSJTOTnhygmpOTi/wTF614u1PuNUfCL77HIjolFbicIMm2k1UyiiARAflt8fXBvXq6DN/qxE7lRP3IlT+HUJdw19VCVM5eP6KbbpokA8GxL7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482350; c=relaxed/simple;
	bh=No0mWQjxnIMn2i/NSsT/zifgvjxhuaYHaSGMbGHElZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZQlKY+CkfmroPDqvs1GSi982Po9qjQAqRxkp9OR3Piql+cCjte8dzJE/wfUPrB1DKjXaxqA6bWEwEEH5X4yOSedSeMqqeb1g/Lg+lCgm0nFHXbO58pzLQW8ywgMMXZ3lzGC7ftdQDyc6YvzIyaZp8BjAA9+FfCXRl71YihIdg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CO5/OUFv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GoQDXUXL; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CO5/OUFv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GoQDXUXL"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FCxs803862621
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 14:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cYWuOrF7viImJbzUvBxTVWdVqp6g5+I1fRpnBI/+72o=; b=CO5/OUFvWLE7NN3x
	YllXvB7lqCt6esRLRymAALj5BOz3yWezTXwpqJRXox1ZXxfaGJFrvKSt5bJ82FmD
	sD7fJ/ExJxTv8e2LhO5rRG6VCNQzX/FLVLLEU1gFDz+3ABsvXqtoBIgP4HxRk7ap
	WD9IED0NDB9x39M29adhPBgCqg8+Cgg/kIEu1v+236Cs/J5f+cA8Ke9NjeFv1OK6
	a7M9oSq+HsOWcMq5iVoD+Fm8aip9HplGIOb70T3xxcVDiZSAXbHfDSxGuKB6Xn43
	79b4Z01wK8yKUAHljY1iVPgV8zYd8Bwz7ErgPaI4BDAZtK+KLhQIZypwrvvfuIyB
	LqfxDg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq3hc1j9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 14:25:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ae8e7e546so7314285a.1
        for <linux-hardening@vger.kernel.org>; Tue, 15 Sep 2026 07:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789482334; cv=none;
        d=google.com; s=arc-20260327;
        b=d+dvY7YyDUSyEPHli1kZPBJTS9PsQbqZ4/Td9wcWwSSEiEGXtyagoUGCHYzkp+zihU
         az438DyIf5gi1iBdm1HmNqBa16bxL2MjLzb+c7Oj4znsVI7GGul4zx6a0dadmWpyIWUQ
         +dESePV8H8z8h/qbTDx321vmdG1ajfJOl/oC+yJHrThqERljZaCLmEFo3RUqq7X6+Hv2
         dGRvVRvt37QySfCx2SCb/B4/Ffb7yGlSfvOWIpe4xu0hHyqKEEDmgKfbYohdcPhe0r2Y
         MUYF6zsB+2w02EpijQEoiNZrnP5/7XSvvbVqWgTXL8RInKPFLkEz0Mgn//ohLnb7U4vn
         LZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cYWuOrF7viImJbzUvBxTVWdVqp6g5+I1fRpnBI/+72o=;
        fh=AM7ru0gp4fr2rmduLGSInQrAZWnQcNaU5rmpyEcNX0I=;
        b=fgIwZ/oevzy2RT8Wh0kmJGomk5GGsVGRs7nEvvqmo5kMjkt2e6VqJV+y1vAJn7Rnnm
         VEK+LvvtMtui7FxClJGSwr7bhsJca7l8kW5BTHkCg7UNB/ReyOd1TfjU/hYoMX1Ta/h2
         RPTUd11xBcJ10meK+9x4VHFn68wgKvocr59HSQMNv1+6mEKaXPCl4LzMej0qTBLCMsMt
         zib67D0hsIR5DrnO7EmqPRK9Cj2NxmzJESy2gdkn79zhr3KjdRswYJrqJprDYpJq1C6C
         9Jb5JXnL3/RvuxsYL+FBU4y9JCGvbmPHcdr/k1JcaEGCjYO+pusfhMxC3gghjV+iP1D1
         Pwfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789482334; x=1790087134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cYWuOrF7viImJbzUvBxTVWdVqp6g5+I1fRpnBI/+72o=;
        b=GoQDXUXLRfIBAXQzcQff9/+KvTWFH6liNT4cV1t8u8qqgooazL0Vuyswd1WwH8iPkG
         Bb2PzuZK2Ibhwa5sFJxIFsvurIdf2M41Er11ID025FNzYINYIYb1L2ZrTEJdWgF4P7lV
         1It5dcrfcVSxJa26B8rN79xwoa+CCFScg2y8ywpEI+MhQQblY0b01Kuhf/eW7ESyxpl7
         TFor9YYnZnUjf5rsNL2rGuyVOulGCLTliu5ZzsrHMyuYNoEpR0H2fNOEnbN2kgC3tzXl
         jHk19QFGhuZVCnohKzUhT6Ey6BJNM/bh2CwCXdwh/ZXFCSAOnHl5n3wXiKyq0el8YrCJ
         XJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789482334; x=1790087134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cYWuOrF7viImJbzUvBxTVWdVqp6g5+I1fRpnBI/+72o=;
        b=gh/6hltDcd57Z2YbrjAKYlzu7KTm1eP+5AXAB9gHAsZW+Acw+5XegISKAhXijxqKEV
         bTtJtp4fmoL5bcZwMmJso0adz7XS3g+dqvd0vZU9j823Ww1hD37OIMrXriTadzMkuWjx
         OMG11YoOdZVSqaPlEfKlbwlmD8Lgv/HixunpmPntpv3enVqAfS5UBg+0prgjfQcTwerf
         AZuwfjH47bZQZiE2I6xLbzc7OAvBaWolNUB0ldkPbcxYUb0ldGoeRZAAZOZBruaDtwpr
         FAVA6lTw0lVzsN8nU6F9BdjXxlnZ3HpGcEy37oBpfWjXkvG4pf9h1hPMQPe7vzySlRds
         zQ2w==
X-Forwarded-Encrypted: i=1; AKwUvByIxcMsxMVcSegNjXHmKOcJa3z7x+cniLEg5/LKgNjp7rirTYNEytDDbXqwNpzC0tmmnYHgqbozyqtlICjAfQs=@vger.kernel.org
X-Gm-Message-State: AFuF++lvyH9REdYpvoRc5y+feuH4tabCiTGS7wjn4qnokztwNf86sIXW
	rD/fIWuSusQ7AZSvNHDVlBgGNw1Mijr8yIppM/o6pPDC8drVCsW3SpVcJJz0xH3KjVmtNUiQZz/
	8p4MNdNivwKIINbO6pkLJWuVSW6z83yD+QnT6WV/3D78sUkHuRPwm1HeTyjr4nNhaJlUbeZt1rs
	oWQeYobB/Sn1xkt21MUe68S8tjrxi9lQSTc6epK75W4Ab73Q==
X-Gm-Gg: AYBFou1VsPCd69o6tE1dUEGJM5zteU0dBe63nPKevWou+vgAjf9DJA3zgXv9BYI+NN/
	bKFnmhzcmUjedqzwPGtkKwQUWPQx6O0ksXpGfVYiaaSNYLr8l1wBrwBXK1s3koVTeGbNXqYDBa0
	jWaRbndRIM7d2xjV1kW+c0GQLSeg3kuJOYlaout7K/6/KMf8X1wR4idzojcYneJCQm1bO5Lv3Ip
	WTS4u6kCY4c1OYlmoAmiHATaQl5M+nI3xxjeoFTQxQBKdDp03kkI3oGbNwHS8/CQLzSF+DnxPQ5
X-Received: by 2002:a05:620a:170b:b0:939:d38:3ab8 with SMTP id af79cd13be357-93a297e8fadmr1116145785a.12.1789482330491;
        Tue, 15 Sep 2026 07:25:30 -0700 (PDT)
X-Received: by 2002:a05:620a:170b:b0:939:d38:3ab8 with SMTP id
 af79cd13be357-93a297e8fadmr1116093785a.12.1789482327327; Tue, 15 Sep 2026
 07:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com>
 <20260915-camss-isp-ope-v7-6-77b13d131d3d@oss.qualcomm.com> <b0bab6df-a9e0-46c9-8a41-7ff22dd8f7f9@linaro.org>
In-Reply-To: <b0bab6df-a9e0-46c9-8a41-7ff22dd8f7f9@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 16:25:14 +0200
X-Gm-Features: AcwNN1UF47fM0w7YHW5_qoy5ZLCexvlQeSW9N6msdK-k1hsvczuFV4Qvt4lPkSA
Message-ID: <CAFEp6-1ECZDwOhjuRhwS4G2Ju1B_N+F_uhThYZnmu4MQ9bFLVQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] media: qcom: camss: Add CAMSS Offline Processing
 Engine driver
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
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: c045diosOOzBsyPOXTNqgLUWZWF83VmQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxMCBTYWx0ZWRfX5HoLJB0cIskI
 I2KjVyJm1fUrnpY0ro63vH5JSom5XRvfx1OzajRmZKvZm9zDAxJ5dF6DhPt/VQIGvs+VjNgPHIW
 0qH0IX0xQTtd0NaYCbVO246POyKSwsU=
X-Authority-Analysis: v=2.4 cv=dcUVTnXe c=1 sm=1 tr=0 ts=6aa95563 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=rBzKw5e2ZW0l8xlq0q0A:9 a=EhHrp-zeKprb5xwy:21
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxMCBTYWx0ZWRfX/k+Ohp2+cjrX
 /RlQ409LMI269I7J3MB1VTwLrr1ItL2W5AKWxzdBZuB0eQ2CMbx7PO5yTMfMfaqLSLDV1rBN4WD
 yPPrvipcj2Cp4UsDBzyqMGIrqtyxhGPYf+0jkWb87+LFVZXBKJ0lng1Akp2SZzhenPITqqKmG3L
 KZ0+t7vTMQp3w5cgusP2mvmwfsRkrEHnm+WNfIAdnt0oelq2RiYhWfOoXqkUkNB4nh+G2x/89I8
 azANOwnIgBF7Vuxm3RJrEJ6Li+1FELFGZEV4Ub0OvQgiLW4Az19Z11tCrhatEvmnp9/zDk0UHG5
 pJ9i5lgSZbcKKOWMnBdCM+GZZgdVaRgrmvpOuWUoVilPkBaqWRTv/VPhx1p4fYq2oXR9PsPhU/u
 mJfl/62lv7w/h7abOQEPnNKy/g4/JTuTQj2UCdZUV4Mbxyr9aWFRQDVyV0qwk+sxonBmj9ZERuV
 csahwK4e3SIuXGwi8hQ==
X-Proofpoint-GUID: c045diosOOzBsyPOXTNqgLUWZWF83VmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150210

On Tue, Sep 15, 2026 at 12:19=E2=80=AFPM Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 15/09/2026 09:11, Loic Poulain wrote:
> > Add an image processing driver for the Qualcomm Offline Processing Engi=
ne
> > (OPE). OPE is a memory-to-memory ISP block that converts raw Bayer
> > frames to YUV, performing white balance, demosaic, chroma enhancement,
> > color correction and downscaling.
> >
> > The hardware architecture consists of Fetch Engines and Write Engines,
> > connected through intermediate pipeline modules for pix processing.
> >
> > The driver exposes three video nodes per pipeline instance:
> >    - ope_input: Bayer RAW input (V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> >    - ope_disp_output: YUV output     (V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLAN=
E)
> >    - ope_params: ISP parameters (V4L2_BUF_TYPE_META_OUTPUT)
> >
> > Hardware features:
> >    - Stripe-based processing (up to 336 pixels wide per stripe)
> >    - White balance (CLC_WB)
> >    - Demosaic / Bayer-to-RGB (CLC_DEMO)
> >    - Color correction matrix (CLC_CC)
> >    - Gamma LUT (CLC_GAMMA)
> >    - RGB-to-YUV conversion (CLC_CHROMA_ENHAN)
> >    - MN downscaler for chroma and luma planes
> >
> > Default configuration values are based on public standards such as BT.6=
01.
> >
> > Processing Model:
> > OPE processes frames in stripes of up to 336 pixels. Therefore, frames
> > must be split into stripes for processing. Each stripe is configured af=
ter
> > the previous one has been acquired (double buffered registers). To mini=
mize
> > inter-stripe latency, stripe configurations are generated ahead of time=
.
> >
> > The driver is split into three source files under the ope/ directory:
> >
> >    - core.c: the OPE m2m driver itself: probe, power management, V4L2/m=
edia
> >      device setup, format handling, stripe generation and hardware
> >      programming.
> >
> >    - pipeline.c/.h: a small declarative media-controller topology build=
er.
> >      Drivers describe their entire media graph, entities (video devices=
,
> >      subdevs, or base entities), their pads, and the links between them=
, in
> >      a static descriptor table. The builder validates the table, alloca=
tes
> >      and registers all entities, and creates all MC pad links. It is ke=
pt
> >      generic but currently only used by OPE.
> >
> >    - params.c/.h: V4L2 ISP parameter buffer validation and dispatch. It
> >      wraps the extensible V4L2 ISP parameters buffer format, validating
> >      the buffer size and each per-block header before forwarding every
> >      block to its driver-supplied handler.
> >
> > A userspace libcamera support can be found at:
> > https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2.1/
> >
> > A test tool, camss-isp-m2m, can be found at:
> > https://github.com/loicpoulain/camss-isp-m2m-test
> >
> > Co-developed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> > Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> > Link: https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2=
.1/
> > Link: https://github.com/loicpoulain/camss-isp-m2m-test
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> Should there be an Assisted-by here ?

Yes, over the versions, I have been leveraging LLM to support
refactoring efforts and address reported patchwise/sashiko issues.
I'll add it.

>
> > ---
> >   MAINTAINERS                                      |    1 +
> >   drivers/media/platform/qcom/camss/Kconfig        |    2 +
> >   drivers/media/platform/qcom/camss/Makefile       |    2 +
> >   drivers/media/platform/qcom/camss/ope/Kconfig    |   16 +
> >   drivers/media/platform/qcom/camss/ope/Makefile   |    9 +
> >   drivers/media/platform/qcom/camss/ope/core.c     | 3658 +++++++++++++=
+++++++++
> >   drivers/media/platform/qcom/camss/ope/params.c   |   78 +
> >   drivers/media/platform/qcom/camss/ope/params.h   |   95 +
> >   drivers/media/platform/qcom/camss/ope/pipeline.c |  412 +++
> >   drivers/media/platform/qcom/camss/ope/pipeline.h |  239 ++
> >   10 files changed, 4512 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b5593f814b60fcbcd88f4b4aad25880d19825dc0..a165b356e81d5cb36283124=
5c18382452bac12ff 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22365,6 +22365,7 @@ F:    Documentation/admin-guide/media/qcom_cams=
s.rst
> >   F:  Documentation/devicetree/bindings/media/qcom,*camss*
> >   F:  Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
> >   F:  drivers/media/platform/qcom/camss/
> > +F:   include/uapi/linux/qcom-camss-config.h
> >
> >   QUALCOMM CLOCK DRIVERS
> >   M:  Bjorn Andersson <andersson@kernel.org>
> > diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/=
platform/qcom/camss/Kconfig
> > index 4eda48cb1adf049a7fb6cb59b9da3c0870fe57f4..414dfd3d0ecea0d0c575f5a=
2aba31846d10deb11 100644
> > --- a/drivers/media/platform/qcom/camss/Kconfig
> > +++ b/drivers/media/platform/qcom/camss/Kconfig
> > @@ -7,3 +7,5 @@ config VIDEO_QCOM_CAMSS
> >       select VIDEO_V4L2_SUBDEV_API
> >       select VIDEOBUF2_DMA_SG
> >       select V4L2_FWNODE
> > +
> > +source "drivers/media/platform/qcom/camss/ope/Kconfig"
> > diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media=
/platform/qcom/camss/Makefile
> > index 27898b3cc7d3c8f275567f81f0952e2a0e18f189..b79c40626c401767fe31b3a=
2fc68c1db38a5a11d 100644
> > --- a/drivers/media/platform/qcom/camss/Makefile
> > +++ b/drivers/media/platform/qcom/camss/Makefile
> > @@ -31,3 +31,5 @@ qcom-camss-objs +=3D \
> >               camss-video.o
> >
> >   obj-$(CONFIG_VIDEO_QCOM_CAMSS) +=3D qcom-camss.o
> > +
> > +obj-$(CONFIG_VIDEO_QCOM_CAMSS_OPE) +=3D ope/
> > diff --git a/drivers/media/platform/qcom/camss/ope/Kconfig b/drivers/me=
dia/platform/qcom/camss/ope/Kconfig
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..822ca2188c6244eba736356=
5afd635e145effe50
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/Kconfig
> > @@ -0,0 +1,16 @@
> > +config VIDEO_QCOM_CAMSS_OPE
> > +     tristate "Qualcomm Offline Processing Engine (OPE) driver"
> > +     depends on V4L_PLATFORM_DRIVERS
> > +     depends on VIDEO_DEV
> > +     depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
> > +     select V4L2_ISP
> > +     select VIDEOBUF2_DMA_CONTIG
> > +     select VIDEOBUF2_VMALLOC
> > +     help
> > +       Enable support for the Qualcomm Offline Processing Engine (OPE)=
.
> > +       OPE is a memory-to-memory ISP block that converts raw Bayer fra=
mes
> > +       to YUV, performing white balance, demosaic, chroma enhancement =
and
> > +       downscaling. Found on QCM2290 and related SoCs.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called qcom-camss-ope.
> > diff --git a/drivers/media/platform/qcom/camss/ope/Makefile b/drivers/m=
edia/platform/qcom/camss/ope/Makefile
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..02599a7b46e17640cbdda86=
00c95bb268ef8ab31
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +# Makefile for Qualcomm CAMSS Offline Processing Engine (OPE) driver
> > +
> > +qcom-camss-ope-objs :=3D \
> > +             core.o \
> > +             pipeline.o \
> > +             params.o
> > +
> > +obj-$(CONFIG_VIDEO_QCOM_CAMSS_OPE) +=3D qcom-camss-ope.o
> > diff --git a/drivers/media/platform/qcom/camss/ope/core.c b/drivers/med=
ia/platform/qcom/camss/ope/core.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c9d3e3910b443fc265b23e3=
a2b1007d23d9717bc
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/core.c
> > @@ -0,0 +1,3658 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ope/core.c
> > + *
> > + * Qualcomm MSM Camera Subsystem - Offline Processing Engine
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +/*
> > + * This driver provides driver implementation for the Qualcomm Offline
> > + * Processing Engine (OPE). OPE is a memory-to-memory hardware block
> > + * designed for image processing on a source frame. Typically, the inp=
ut
> > + * frame originates from the SoC CSI capture path, though not limited =
to.
> > + *
> > + * The hardware architecture consists of Fetch Engines and Write Engin=
es,
> > + * connected through intermediate pipeline modules:
> > + *   [FETCH ENGINES] =3D> [Pipeline Modules] =3D> [WRITE ENGINES]
> > + *
> > + * Current Configuration:
> > + *     Fetch Engine: One fetch engine is used for Bayer frame input.
> > + *     Write Engines: Two display write engines for Y and UV planes ou=
tput.
> > + *
> > + * Only a subset of the pipeline modules are enabled:
> > + *   WB: White balance for channel gain configuration
> > + *   DEMO: Demosaic for Bayer to RGB conversion
> > + *   CC: Color Correct, coefficient based RGB correction
> > + *   GLUT: Gamma LUT, redistributes brightness levels
> > + *   CHROMA_ENHAN: for RGB to YUV conversion
> > + *   DOWNSCALE*: Downscaling for UV (YUV444 -> YUV422/YUV420) and YUV =
planes
> > + *
> > + * Default configuration values are based on public standards such as =
BT.601.
> > + *
> > + * Processing Model:
> > + * OPE processes frames in stripes of up to 336 pixels. Therefore, fra=
mes must
> > + * be split into stripes for processing. Each stripe is configured aft=
er the
> > + * previous one has been acquired (double buffered registers). To mini=
mize
> > + * inter-stripe latency, the stripe configurations are generated ahead=
 of time.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_clock.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/units.h>
> > +
> > +#include <media/v4l2-device.h>
> > +#include <media/media-device.h>
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-fh.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-rect.h>
> > +
> > +#include "pipeline.h"
> > +
> > +#include <media/videobuf2-dma-contig.h>
> > +#include <media/videobuf2-vmalloc.h>
> > +
> > +#include <uapi/linux/qcom-camss-config.h>
> > +
> > +#include "params.h"
> > +
> > +#define OPE_NAME     "qcom-camss-ope"
> > +
> > +/* Format descriptor */
> > +struct ope_fmt {
> > +     u32             fourcc;
> > +     unsigned int    depth;
> > +     unsigned int    align;
> > +     unsigned int    num_planes;
> > +     u32             mbus_code;
> > +     unsigned int    c_hsub;
> > +     unsigned int    c_vsub;
> > +};
> > +
> > +/* Per-queue format state */
> > +struct ope_fmt_state {
> > +     const struct ope_fmt    *fmt;
> > +     unsigned int            width;
> > +     unsigned int            height;
> > +     struct v4l2_rect        crop;
> > +     unsigned int            bytesperline;
> > +     unsigned int            sizeimage;
> > +     enum v4l2_colorspace    colorspace;
> > +     enum v4l2_xfer_func     xfer_func;
> > +     enum v4l2_ycbcr_encoding        ycbcr_enc;
> > +     enum v4l2_quantization  quantization;
> > +     unsigned int            sequence;
> > +     struct v4l2_fract       timeperframe;
> > +};
> > +
> > +/* -------- Register layout -------- */
> > +
> > +#define OPE_TOP_HW_VERSION                                   0x000
> > +#define              OPE_TOP_HW_VERSION_STEP         GENMASK(15, 0)
> > +#define              OPE_TOP_HW_VERSION_REV          GENMASK(27, 16)
> > +#define              OPE_TOP_HW_VERSION_GEN          GENMASK(31, 28)
> > +#define OPE_TOP_RESET_CMD                                    0x004
> > +#define              OPE_TOP_RESET_CMD_HW            BIT(0)
> > +#define              OPE_TOP_RESET_CMD_SW            BIT(1)
> > +#define OPE_TOP_IRQ_STATUS                                   0x014
> > +#define OPE_TOP_IRQ_MASK                                     0x018
> > +#define              OPE_TOP_IRQ_STATUS_RST_DONE     BIT(0)
> > +#define              OPE_TOP_IRQ_STATUS_WE           BIT(1)
> > +#define              OPE_TOP_IRQ_STATUS_FE           BIT(2)
> > +#define              OPE_TOP_IRQ_STATUS_VIOL         BIT(3)
> > +#define              OPE_TOP_IRQ_STATUS_IDLE         BIT(4)
> > +#define OPE_TOP_IRQ_CLEAR                                    0x01c
> > +#define OPE_TOP_IRQ_CMD                                              0=
x024
> > +#define              OPE_TOP_IRQ_CMD_CLEAR           BIT(0)
> > +#define OPE_TOP_VIOLATION_STATUS                             0x028
> > +
> > +/* Fetch engine */
> > +#define OPE_BUS_RD_INPUT_IF_IRQ_MASK                         0x00c
> > +#define OPE_BUS_RD_INPUT_IF_IRQ_CLEAR                                0=
x010
> > +#define OPE_BUS_RD_INPUT_IF_IRQ_CMD                          0x014
> > +#define              OPE_BUS_RD_INPUT_IF_IRQ_CMD_CLEAR       BIT(0)
> > +#define OPE_BUS_RD_INPUT_IF_IRQ_STATUS                               0=
x018
> > +#define              OPE_BUS_RD_INPUT_IF_IRQ_STATUS_RST_DONE         B=
IT(0)
> > +#define              OPE_BUS_RD_INPUT_IF_IRQ_STATUS_RUP_DONE         B=
IT(1)
> > +#define              OPE_BUS_RD_INPUT_IF_IRQ_STATUS_BUF_DONE         G=
ENMASK(3, 2)
> > +#define              OPE_BUS_RD_INPUT_IF_IRQ_STATUS_CCIF_VIOL        G=
ENMASK(17, 16)
> > +#define OPE_BUS_RD_INPUT_IF_CMD                                      0=
x01c
> > +#define              OPE_BUS_RD_INPUT_IF_CMD_GO_CMD          BIT(0)
> > +#define OPE_BUS_RD_CLIENT_0_CORE_CFG                         0x050
> > +#define              OPE_BUS_RD_CLIENT_0_CORE_CFG_EN BIT(0)
> > +#define OPE_BUS_RD_CLIENT_0_CCIF_META_DATA                   0x054
> > +#define              OPE_BUS_RD_CLIENT_0_CCIF_MD_PIX_PATTERN GENMASK(7=
, 2)
> > +#define OPE_BUS_RD_CLIENT_0_ADDR_IMAGE                               0=
x058
> > +#define OPE_BUS_RD_CLIENT_0_RD_BUFFER_SIZE                   0x05c
> > +#define OPE_BUS_RD_CLIENT_0_RD_STRIDE                                0=
x060
> > +#define OPE_BUS_RD_CLIENT_0_UNPACK_CFG_0                     0x064
> > +
> > +/* Write engines */
> > +#define OPE_BUS_WR_INPUT_IF_IRQ_MASK_0                               0=
x018
> > +#define OPE_BUS_WR_INPUT_IF_IRQ_MASK_1                               0=
x01c
> > +#define OPE_BUS_WR_INPUT_IF_IRQ_CLEAR_0                              0=
x020
> > +#define OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0                     0x028
> > +#define              OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_RUP_DONE       B=
IT(0)
> > +#define              OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_BUF_DONE       B=
IT(8)
> > +#define              OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_CONS_VIOL      B=
IT(28)
> > +#define              OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_VIOL           B=
IT(30)
> > +#define              OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_IMG_SZ_VIOL    B=
IT(31)
> > +#define OPE_BUS_WR_INPUT_IF_IRQ_CMD                          0x030
> > +#define              OPE_BUS_WR_INPUT_IF_IRQ_CMD_CLEAR       BIT(0)
> > +#define OPE_BUS_WR_VIOLATION_STATUS                          0x064
> > +#define OPE_BUS_WR_IMAGE_SIZE_VIOLATION_STATUS                       0=
x070
> > +#define OPE_BUS_WR_CLIENT_CFG(c)                             (0x200 + =
(c) * 0x100)
> > +#define              OPE_BUS_WR_CLIENT_CFG_EN                BIT(0)
> > +#define              OPE_BUS_WR_CLIENT_CFG_AUTORECOVER       BIT(4)
> > +#define OPE_BUS_WR_CLIENT_ADDR_IMAGE(c)                              (=
0x204 + (c) * 0x100)
> > +#define OPE_BUS_WR_CLIENT_IMAGE_CFG_0(c)                     (0x20c + =
(c) * 0x100)
> > +#define OPE_BUS_WR_CLIENT_IMAGE_CFG_1(c)                     (0x210 + =
(c) * 0x100)
> > +#define OPE_BUS_WR_CLIENT_IMAGE_CFG_2(c)                     (0x214 + =
(c) * 0x100)
> > +#define OPE_BUS_WR_CLIENT_PACKER_CFG(c)                              (=
0x218 + (c) * 0x100)
> > +
> > +/* Pipeline modules */
> > +
> > +#define OPE_PP_HW_VERSION(base)                              ((base) +=
 0x00)
> > +#define OPE_PP_HW_STATUS(base)                               ((base) +=
 0x04)
> > +#define OPE_HW_VERSION_GEN(v)        ((u32)FIELD_GET(OPE_TOP_HW_VERSIO=
N_GEN, (v)))
> > +#define OPE_HW_VERSION_REV(v)        ((u32)FIELD_GET(OPE_TOP_HW_VERSIO=
N_REV, (v)))
> > +#define OPE_HW_VERSION_STEP(v)       ((u32)FIELD_GET(OPE_TOP_HW_VERSIO=
N_STEP, (v)))
> > +
> > +#define OPE_PP_WB_GAIN_BASE                  0x200
> > +#define OPE_PP_WB_GAIN_MODULE_CFG                    (OPE_PP_WB_GAIN_B=
ASE + 0x60)
> > +#define              OPE_PP_WB_GAIN_MODULE_CFG_EN    BIT(0)
> > +#define OPE_PP_WB_GAIN_WB_CFG(ch)                    (OPE_PP_WB_GAIN_B=
ASE + 0x68 + 4 * (ch))
> > +#define              OPE_PP_WB_GAIN_WB_CFG_GAIN      GENMASK(14, 0)
> > +#define OPE_PP_WB_GAIN_WB_SUB_CFG(ch)                        (OPE_PP_W=
B_GAIN_BASE + 0x74 + 4 * (ch))
> > +#define              OPE_PP_WB_GAIN_WB_SUB_CFG_VAL   GENMASK(31, 20)
> > +#define OPE_PP_WB_GAIN_WB_ADD_CFG(ch)                        (OPE_PP_W=
B_GAIN_BASE + 0x80 + 4 * (ch))
> > +#define              OPE_PP_WB_GAIN_WB_ADD_CFG_VAL   GENMASK(31, 20)
> > +
> > +#define OPE_PP_CC_BASE                               0xa00
> > +#define OPE_PP_CC_MODULE_CFG                         (OPE_PP_CC_BASE +=
 0x60)
> > +#define              OPE_PP_CC_MODULE_CFG_EN         BIT(0)
> > +#define OPE_PP_CC_COEFF_A_CFG_0                              (OPE_PP_C=
C_BASE + 0x68)
> > +#define              OPE_PP_CC_COEFF_A_CFG_0_A0      GENMASK(11, 0)
> > +#define              OPE_PP_CC_COEFF_A_CFG_0_A1      GENMASK(27, 16)
> > +#define OPE_PP_CC_COEFF_A_CFG_1                              (OPE_PP_C=
C_BASE + 0x6c)
> > +#define              OPE_PP_CC_COEFF_A_CFG_1_A2      GENMASK(11, 0)
> > +#define OPE_PP_CC_COEFF_B_CFG_0                              (OPE_PP_C=
C_BASE + 0x70)
> > +#define              OPE_PP_CC_COEFF_B_CFG_0_B0      GENMASK(11, 0)
> > +#define              OPE_PP_CC_COEFF_B_CFG_0_B1      GENMASK(27, 16)
> > +#define OPE_PP_CC_COEFF_B_CFG_1                              (OPE_PP_C=
C_BASE + 0x74)
> > +#define              OPE_PP_CC_COEFF_B_CFG_1_B2      GENMASK(11, 0)
> > +#define OPE_PP_CC_COEFF_C_CFG_0                              (OPE_PP_C=
C_BASE + 0x78)
> > +#define              OPE_PP_CC_COEFF_C_CFG_0_C0      GENMASK(11, 0)
> > +#define              OPE_PP_CC_COEFF_C_CFG_0_C1      GENMASK(27, 16)
> > +#define OPE_PP_CC_COEFF_C_CFG_1                              (OPE_PP_C=
C_BASE + 0x7c)
> > +#define              OPE_PP_CC_COEFF_C_CFG_1_C2      GENMASK(11, 0)
> > +#define OPE_PP_CC_COEFF_K_CFG_0                              (OPE_PP_C=
C_BASE + 0x80)
> > +#define              OPE_PP_CC_COEFF_K_CFG_0_K0      GENMASK(31, 21)
> > +#define OPE_PP_CC_COEFF_K_CFG_1                              (OPE_PP_C=
C_BASE + 0x84)
> > +#define              OPE_PP_CC_COEFF_K_CFG_1_K1      GENMASK(31, 21)
> > +#define OPE_PP_CC_COEFF_K_CFG_2                              (OPE_PP_C=
C_BASE + 0x88)
> > +#define              OPE_PP_CC_COEFF_K_CFG_2_K2      GENMASK(31, 21)
> > +#define OPE_PP_CC_COEFF_M_CFG                                (OPE_PP_C=
C_BASE + 0x8c)
> > +#define              OPE_PP_CC_COEFF_M_CFG_M         GENMASK(1, 0)
> > +
> > +#define OPE_PP_GLUT_BASE                     0x1000
> > +#define OPE_PP_GLUT_DMI_CFG                          (OPE_PP_GLUT_BASE=
 + 0x08)
> > +#define              OPE_PP_GLUT_DMI_CFG_AUTO_LOAD_EN        BIT(20)
> > +#define              OPE_PP_GLUT_DMI_CFG_ADDR        GENMASK(7, 0)
> > +#define OPE_PP_GLUT_DMI_LUT_CFG                              (OPE_PP_G=
LUT_BASE + 0x0c)
> > +#define              OPE_PP_GLUT_DMI_LUT_CFG_SEL     GENMASK(1, 0)
> > +#define OPE_PP_GLUT_DMI_DATA                         (OPE_PP_GLUT_BASE=
 + 0x10)
> > +#define OPE_PP_GLUT_DMI_LUT_BANK_CFG                 (OPE_PP_GLUT_BASE=
 + 0x58)
> > +#define              OPE_PP_GLUT_DMI_LUT_BANK_CFG_SEL        BIT(0)
> > +#define OPE_PP_GLUT_MODULE_LUT_BANK_CFG                      (OPE_PP_G=
LUT_BASE + 0x5c)
> > +#define              OPE_PP_GLUT_MODULE_LUT_BANK_CFG_SEL     BIT(0)
> > +#define OPE_PP_GLUT_MODULE_CFG                               (OPE_PP_G=
LUT_BASE + 0x60)
> > +#define              OPE_PP_GLUT_MODULE_CFG_EN       BIT(0)
> > +
> > +#define OPE_PP_DEMO_BASE                             0x800
> > +#define OPE_PP_DEMO_MODULE_CFG                                       (=
OPE_PP_DEMO_BASE + 0x60)
> > +#define              OPE_PP_DEMO_MODULE_CFG_EN               BIT(0)
> > +#define              OPE_PP_DEMO_MODULE_CFG_DYN_G_CLAMP_EN   BIT(14)
> > +#define              OPE_PP_DEMO_MODULE_CFG_DYN_RB_CLAMP_EN  BIT(15)
> > +#define OPE_PP_DEMO_INTERP_COEFF_CFG                         (OPE_PP_D=
EMO_BASE + 0x68)
> > +#define              OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_G   GENMASK(7=
, 0)
> > +#define              OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_RB  GENMASK(2=
3, 16)
> > +#define OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0                  (OPE_PP_D=
EMO_BASE + 0x6c)
> > +#define              OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0_AK  GENMASK(3=
1, 20)
> > +#define OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1                  (OPE_PP_D=
EMO_BASE + 0x70)
> > +#define              OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1_WK  GENMASK(9=
, 0)
> > +
> > +#define OPE_PP_DOWNSCALE_MN_DS_C_PRE_BASE            0x1c00
> > +#define OPE_PP_DOWNSCALE_MN_DS_Y_DISP_BASE           0x3000
> > +#define OPE_PP_DOWNSCALE_MN_DS_C_DISP_BASE           0x3200
> > +#define OPE_PP_CROP_RND_CLAMP_Y_DISP_BASE            0x3400
> > +#define OPE_PP_CROP_RND_CLAMP_C_DISP_BASE            0x3600
> > +#define OPE_PP_CROP_RND_CLAMP_HW_STATUS(base)                        O=
PE_PP_HW_STATUS(base)
> > +#define              OPE_PP_CROP_RND_CLAMP_HEIGHT_VIOL       BIT(2)
> > +#define              OPE_PP_CROP_RND_CLAMP_WIDTH_VIOL        BIT(1)
> > +#define OPE_PP_CROP_RND_CLAMP_MODULE_CFG(base)                       (=
(base) + 0x60)
> > +#define              OPE_PP_CROP_RND_CLAMP_EN                BIT(0)
> > +#define              OPE_PP_CROP_RND_CLAMP_CROP_EN           BIT(9)
> > +#define OPE_PP_CROP_RND_CLAMP_CROP_LINE_CFG(base)            ((base) +=
 0x68)
> > +#define OPE_PP_CROP_RND_CLAMP_CROP_PIXEL_CFG(base)           ((base) +=
 0x6c)
> > +#define              OPE_PP_CROP_RND_CLAMP_CROP_FIRST        GENMASK(2=
9, 16)
> > +#define              OPE_PP_CROP_RND_CLAMP_CROP_LAST         GENMASK(1=
3, 0)
> > +#define OPE_PP_DOWNSCALE_MN_CFG(ds)                          ((ds) + 0=
x60)
> > +#define              OPE_PP_DOWNSCALE_MN_CFG_EN              BIT(0)
> > +#define OPE_PP_DOWNSCALE_MN_DS_CFG(ds)                               (=
(ds) + 0x64)
> > +#define              OPE_PP_DOWNSCALE_MN_DS_CFG_H_SCALE_EN   BIT(9)
> > +#define              OPE_PP_DOWNSCALE_MN_DS_CFG_V_SCALE_EN   BIT(10)
> > +#define OPE_PP_DOWNSCALE_MN_DS_IMAGE_SIZE_CFG(ds)            ((ds) + 0=
x68)
> > +#define OPE_PP_DOWNSCALE_MN_DS_MN_H_CFG(ds)                  ((ds) + 0=
x6c)
> > +#define OPE_PP_DOWNSCALE_MN_DS_MN_H_PHASE_CFG(ds)            ((ds) + 0=
x70)
> > +#define OPE_PP_DOWNSCALE_MN_DS_MN_V_CFG(ds)                  ((ds) + 0=
x74)
> > +#define OPE_PP_DOWNSCALE_MN_DS_MN_V_PHASE_CFG(ds)            ((ds) + 0=
x78)
> > +
> > +#define OPE_PP_CHROMA_ENHAN_BASE                     0x1200
> > +#define OPE_PP_CHROMA_ENHAN_MODULE_CFG                               (=
OPE_PP_CHROMA_ENHAN_BASE + 0x60)
> > +#define              OPE_PP_CHROMA_ENHAN_MODULE_CFG_EN       BIT(0)
> > +#define OPE_PP_CHROMA_ENHAN_LUMA_CFG_0                               (=
OPE_PP_CHROMA_ENHAN_BASE + 0x68)
> > +#define              OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V0       GENMASK(1=
1, 0)
> > +#define              OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V1       GENMASK(2=
7, 16)
> > +#define OPE_PP_CHROMA_ENHAN_LUMA_CFG_1                               (=
OPE_PP_CHROMA_ENHAN_BASE + 0x6c)
> > +#define              OPE_PP_CHROMA_ENHAN_LUMA_CFG_1_K        GENMASK(3=
1, 23)
> > +#define OPE_PP_CHROMA_ENHAN_LUMA_CFG_2                               (=
OPE_PP_CHROMA_ENHAN_BASE + 0x70)
> > +#define              OPE_PP_CHROMA_ENHAN_LUMA_CFG_2_V2       GENMASK(1=
1, 0)
> > +#define OPE_PP_CHROMA_ENHAN_COEFF_A_CFG                              (=
OPE_PP_CHROMA_ENHAN_BASE + 0x74)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AP      GENMASK(1=
1, 0)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AM      GENMASK(2=
7, 16)
> > +#define OPE_PP_CHROMA_ENHAN_COEFF_B_CFG                              (=
OPE_PP_CHROMA_ENHAN_BASE + 0x78)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BP      GENMASK(1=
1, 0)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BM      GENMASK(2=
7, 16)
> > +#define OPE_PP_CHROMA_ENHAN_COEFF_C_CFG                              (=
OPE_PP_CHROMA_ENHAN_BASE + 0x7C)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CP      GENMASK(1=
1, 0)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CM      GENMASK(2=
7, 16)
> > +#define OPE_PP_CHROMA_ENHAN_COEFF_D_CFG                              (=
OPE_PP_CHROMA_ENHAN_BASE + 0x80)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DP      GENMASK(1=
1, 0)
> > +#define              OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DM      GENMASK(2=
7, 16)
> > +#define OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0                     (OPE_PP_C=
HROMA_ENHAN_BASE + 0x84)
> > +#define              OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0_KCB GENMASK(31, =
21)
> > +#define OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1                     (OPE_PP_C=
HROMA_ENHAN_BASE + 0x88)
> > +#define              OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1_KCR GENMASK(31, =
21)
> > +
> > +/* -------- OPE-specific constants -------- */
> > +
> > +#define OPE_STRIPE_MAX_W     336
> > +#define OPE_STRIPE_MAX_H     8192
> > +#define OPE_STRIPE_MIN_W     16
> > +#define OPE_STRIPE_MIN_H     OPE_STRIPE_MIN_W
> > +#define OPE_MAX_STRIPE               16
> > +#define OPE_ALIGN_H          1
> > +#define OPE_ALIGN_W          1
> > +#define OPE_MIN_W            24
> > +#define OPE_MIN_H            16
> > +#define OPE_MAX_W            (OPE_STRIPE_MAX_W * OPE_MAX_STRIPE)
> > +#define OPE_MAX_H            OPE_STRIPE_MAX_H
> > +#define OPE_MAX_STRIDE               0xffff
> > +#define OPE_RESET_TIMEOUT_MS 100
> > +#define DEFAULT_FRAMERATE    60
> > +#define OPE_MAX_FRAMERATE    1000
> > +
> > +/*
> > + * AXI clock is shared across CAMSS blocks and not dynamically scaled,
> > + * just request the highest supported rate.
> > + */
> > +#define OPE_AXI_CLK_RATE     (300 * HZ_PER_MHZ)
> > +
> > +/* Downscaler fixed-point helpers */
> > +#define Q21(v)                       (((uint64_t)(v)) << 21)
> > +#define DS_Q21(n, d)         ((uint32_t)(((uint64_t)(n) << 21) / (d)))
> > +#define DS_RESOLUTION(in, out) \
> > +     (((out) * 128 <=3D (in)) ? 0x0 : \
> > +      ((out) * 16  <=3D (in)) ? 0x1 : \
> > +      ((out) * 8   <=3D (in)) ? 0x2 : 0x3)
> > +#define DS_OUTPUT_PIX(in, phase_init, phase_step) \
> > +     ((Q21(in) - (phase_init)) / (phase_step))
> > +#define OPE_WB(n, d)         (((n) << 10) / (d))
> > +
> > +enum ope_downscaler {
> > +     OPE_DS_C_PRE,
> > +     OPE_DS_C_DISP,
> > +     OPE_DS_Y_DISP,
> > +     OPE_DS_MAX,
> > +};
> > +
> > +enum ope_glut_sel {
> > +     OPE_GLUT_SEL_NONE,
> > +     OPE_GLUT_SEL_G,
> > +     OPE_GLUT_SEL_B,
> > +     OPE_GLUT_SEL_R,
> > +};
> > +
> > +static const u32 ope_ds_base[OPE_DS_MAX] =3D {
> > +     OPE_PP_DOWNSCALE_MN_DS_C_PRE_BASE,
> > +     OPE_PP_DOWNSCALE_MN_DS_C_DISP_BASE,
> > +     OPE_PP_DOWNSCALE_MN_DS_Y_DISP_BASE,
> > +};
> > +
> > +enum ope_wr_client {
> > +     OPE_WR_CLIENT_VID_Y,
> > +     OPE_WR_CLIENT_VID_C,
> > +     OPE_WR_CLIENT_DISP_Y,
> > +     OPE_WR_CLIENT_DISP_C,
> > +     OPE_WR_CLIENT_MAX,
> > +};
> > +
> > +enum ope_pixel_pattern {
> > +     OPE_PIXEL_PATTERN_RGRGRG,
> > +     OPE_PIXEL_PATTERN_GRGRGR,
> > +     OPE_PIXEL_PATTERN_BGBGBG,
> > +     OPE_PIXEL_PATTERN_GBGBGB,
> > +     OPE_PIXEL_PATTERN_YCBYCR,
> > +     OPE_PIXEL_PATTERN_YCRYCB,
> > +     OPE_PIXEL_PATTERN_CBYCRY,
> > +     OPE_PIXEL_PATTERN_CRYCBY,
> > +};
> > +
> > +enum ope_stripe_location {
> > +     OPE_STRIPE_LOCATION_FULL,
> > +     OPE_STRIPE_LOCATION_LEFT,
> > +     OPE_STRIPE_LOCATION_RIGHT,
> > +     OPE_STRIPE_LOCATION_MIDDLE,
> > +};
> > +
> > +enum ope_unpacker_format {
> > +     OPE_UNPACKER_FMT_PLAIN_8        =3D 1,
> > +     OPE_UNPACKER_FMT_PLAIN_16_10BPP =3D 2,
> > +     OPE_UNPACKER_FMT_MIPI_10        =3D 13,
> > +};
> > +
> > +enum ope_packer_format {
> > +     OPE_PACKER_FMT_PLAIN_8          =3D 1,
> > +     OPE_PACKER_FMT_PLAIN_8_ODD_EVEN =3D 2,
> > +     OPE_PACKER_FMT_MIPI_10          =3D 12,
> > +};
> > +
> > +struct ope_hw_fmt {
> > +     u32                     fourcc;
> > +     enum ope_pixel_pattern  pattern;
> > +     enum ope_unpacker_format        unpacker;
> > +     enum ope_packer_format  packer;
> > +};
> > +
> > +static const struct ope_hw_fmt ope_hw_fmts[] =3D {
> > +     { V4L2_PIX_FMT_SBGGR10P, OPE_PIXEL_PATTERN_BGBGBG,
> > +       OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
> > +     { V4L2_PIX_FMT_SGBRG10P, OPE_PIXEL_PATTERN_GBGBGB,
> > +       OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
> > +     { V4L2_PIX_FMT_SGRBG10P, OPE_PIXEL_PATTERN_GRGRGR,
> > +       OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
> > +     { V4L2_PIX_FMT_SRGGB10P, OPE_PIXEL_PATTERN_RGRGRG,
> > +       OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
> > +     { V4L2_PIX_FMT_SRGGB8,   OPE_PIXEL_PATTERN_RGRGRG,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_SBGGR8,   OPE_PIXEL_PATTERN_BGBGBG,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_SGBRG8,   OPE_PIXEL_PATTERN_GBGBGB,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_SGRBG8,   OPE_PIXEL_PATTERN_GRGRGR,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_NV24,     OPE_PIXEL_PATTERN_YCBYCR,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_NV42,     OPE_PIXEL_PATTERN_YCRYCB,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8_ODD_EVEN },
> > +     { V4L2_PIX_FMT_NV16,     OPE_PIXEL_PATTERN_CBYCRY,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_NV61,     OPE_PIXEL_PATTERN_CBYCRY,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8_ODD_EVEN },
> > +     { V4L2_PIX_FMT_NV12,     OPE_PIXEL_PATTERN_CBYCRY,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +     { V4L2_PIX_FMT_NV21,     OPE_PIXEL_PATTERN_CBYCRY,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8_ODD_EVEN },
> > +     { V4L2_PIX_FMT_GREY,     OPE_PIXEL_PATTERN_RGRGRG,
> > +       OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
> > +};
> > +
> > +static const struct ope_hw_fmt *ope_find_hw_fmt(u32 fourcc)
> > +{
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(ope_hw_fmts); i++)
> > +             if (ope_hw_fmts[i].fourcc =3D=3D fourcc)
> > +                     return &ope_hw_fmts[i];
> > +
> > +     return NULL;
> > +}
> > +
> > +static const struct ope_fmt ope_input_fmts[] =3D {
> > +     { V4L2_PIX_FMT_SBGGR10P, 10, 2, 1, MEDIA_BUS_FMT_SBGGR10_1X10 },
> > +     { V4L2_PIX_FMT_SGBRG10P, 10, 2, 1, MEDIA_BUS_FMT_SGBRG10_1X10 },
> > +     { V4L2_PIX_FMT_SGRBG10P, 10, 2, 1, MEDIA_BUS_FMT_SGRBG10_1X10 },
> > +     { V4L2_PIX_FMT_SRGGB10P, 10, 2, 1, MEDIA_BUS_FMT_SRGGB10_1X10 },
> > +     { V4L2_PIX_FMT_SRGGB8,    8, 0, 1, MEDIA_BUS_FMT_SRGGB8_1X8 },
> > +     { V4L2_PIX_FMT_SBGGR8,    8, 0, 1, MEDIA_BUS_FMT_SBGGR8_1X8 },
> > +     { V4L2_PIX_FMT_SGBRG8,    8, 0, 1, MEDIA_BUS_FMT_SGBRG8_1X8 },
> > +     { V4L2_PIX_FMT_SGRBG8,    8, 0, 1, MEDIA_BUS_FMT_SGRBG8_1X8 },
> > +};
> > +
> > +static const struct ope_fmt ope_output_fmts[] =3D {
> > +     { V4L2_PIX_FMT_NV24,  24, 0, 1, MEDIA_BUS_FMT_YUV8_1X24,   1, 1 }=
,
> > +     { V4L2_PIX_FMT_NV42,  24, 0, 1, MEDIA_BUS_FMT_YUV8_1X24,   1, 1 }=
,
> > +     { V4L2_PIX_FMT_NV16,  16, 1, 1, MEDIA_BUS_FMT_YUYV8_2X8,   2, 1 }=
,
> > +     { V4L2_PIX_FMT_NV61,  16, 1, 1, MEDIA_BUS_FMT_YUYV8_2X8,   2, 1 }=
,
> > +     { V4L2_PIX_FMT_NV12,  12, 1, 1, MEDIA_BUS_FMT_YUYV8_1_5X8, 2, 2 }=
,
> > +     { V4L2_PIX_FMT_NV21,  12, 1, 1, MEDIA_BUS_FMT_YUYV8_1_5X8, 2, 2 }=
,
> > +     { V4L2_PIX_FMT_GREY,   8, 0, 1, MEDIA_BUS_FMT_Y8_1X8,      1, 1 }=
,
> > +};
> > +
> > +struct ope_dsc_config {
> > +     u32 input_width;
> > +     u32 input_height;
> > +     u32 output_width;
> > +     u32 output_height;
> > +     u32 phase_step_h;
> > +     u32 phase_step_v;
> > +     u32 crop_last_pixel;
> > +     u32 crop_last_line;
> > +};
> > +
> > +struct ope_stripe {
> > +     struct {
> > +             dma_addr_t addr;
> > +             u32 width;
> > +             u32 height;
> > +             u32 stride;
> > +             enum ope_stripe_location location;
> > +             enum ope_pixel_pattern  pattern;
> > +             enum ope_unpacker_format format;
> > +     } src;
> > +     struct {
> > +             dma_addr_t addr;
> > +             u32 width;
> > +             u32 height;
> > +             u32 stride;
> > +             u32 x_init;
> > +             enum ope_packer_format format;
> > +             bool enabled;
> > +     } dst[OPE_WR_CLIENT_MAX];
> > +     struct ope_dsc_config dsc[OPE_DS_MAX];
> > +};
> > +
> > +/* OPE tuning parameter state */
> > +
> > +/* Demosaic (CLC_DEMO) coefficients, internal only, not user-configura=
ble. */
> > +#define CAMSS_PARAMS_INTERNAL        (-1)
> > +
> > +struct ope_params_demo {
> > +     struct v4l2_isp_params_block_header header;
> > +     u8 lambda_rb;
> > +     u8 lambda_g;
> > +     u16 a_k;
> > +     u16 w_k;
> > +     u16 _pad;
> > +};
> > +
> > +/* OPE tuning parameter state */
> > +struct ope_config {
> > +     struct camss_params_ope_wb_gain         wb_gain;
> > +     struct camss_params_ope_chroma_enhan    chroma_enhan;
> > +     struct camss_params_ope_color_correct   color_correct;
> > +     struct camss_params_ope_gamma           gamma;
> > +     struct ope_params_demo                  demo;
> > +};
> > +
> > +enum ope_entity {
> > +     OPE_ENTITY_FRAME_IN,
> > +     OPE_ENTITY_PARAMS,
> > +     OPE_ENTITY_PROC,
> > +     OPE_ENTITY_DISP,
> > +     OPE_ENTITY_DISP_OUT,
> > +     OPE_ENTITY_COUNT
> > +};
> > +
> > +enum ope_queue_idx {
> > +     OPE_QUEUE_FRAME_IN,
> > +     OPE_QUEUE_DISP_OUT,
> > +     OPE_QUEUE_PARAMS,
> > +     OPE_QUEUE_COUNT
> > +};
> > +
> > +struct camss_isp_buf {
> > +     struct vb2_v4l2_buffer  vb;     /* must be first */
> > +     struct list_head        list;
> > +};
> > +
> > +struct ope_queue {
> > +     struct vb2_queue        vq;
> > +     struct list_head        rdy_queue;
> > +     spinlock_t              rdy_spinlock;
> > +};
> > +
> > +enum ope_proc_pad {
> > +     OPE_PROC_PAD_SINK_IN,
> > +     OPE_PROC_PAD_SINK_PAR,
> > +     OPE_PROC_PAD_SOURCE,
> > +     OPE_PROC_PADS_NUM,
> > +};
> > +
> > +enum ope_disp_pad {
> > +     OPE_DISP_PAD_SINK,
> > +     OPE_DISP_PAD_SOURCE,
> > +     OPE_DISP_PADS_NUM,
> > +};
> > +
> > +/* per-context state */
> > +struct ope_ctx {
> > +     bool                    queued;
> > +     struct ope_dev          *ope;
> > +     struct mutex            vbq_lock;
> > +     struct ope_queue        queues[OPE_QUEUE_COUNT];
> > +
> > +     unsigned int            framerate;
> > +     struct ope_fmt_state    fmt_in;
> > +     struct ope_fmt_state    fmt_out;
> > +
> > +     struct list_head        list;
> > +     bool                    started;
> > +     bool                    first_start;
> > +
> > +     struct ope_config       config;
> > +     u8                      current_stripe;
> > +     struct ope_stripe       stripe[OPE_MAX_STRIPE];
> > +
> > +     struct v4l2_isp_params_buffer *params_buf;
> > +};
> > +
> > +/* Per OPE device state */
> > +struct ope_dev {
> > +     struct device           *dev;
> > +     struct v4l2_device      v4l2_dev;
> > +     struct media_device     mdev;
> > +     struct camss_isp_pipeline *pipeline;
> > +     struct mutex            mutex;
> > +     struct work_struct      run_work;
> > +     struct ope_ctx          *curr_ctx;
> > +     struct ope_ctx          *prev_ctx;
> > +     spinlock_t              sched_lock;
> > +     int                     irq;
> > +     u32                     hw_version;
> > +
> > +     struct icc_path         *icc_data;
> > +     struct icc_path         *icc_config;
> > +
> > +     void __iomem            *base;
> > +     void __iomem            *base_rd;
> > +     void __iomem            *base_wr;
> > +     void __iomem            *base_pp;
> > +
> > +     struct completion       reset_complete;
> > +
> > +     struct list_head        ctx_list;
> > +     spinlock_t              ctx_lock;
> > +     struct ope_ctx          *shared_ctx;
> > +     unsigned int            open_count;
> > +
> > +     /* Currently active hardware context (set at job start) */
> > +     struct ope_ctx          *hw_ctx;
> > +
> > +     /* Gamma LUTs handling */
> > +     struct {
> > +             struct ope_ctx  *owner;
> > +             bool            valid;
> > +     } glut_bank[2];
> > +     u8                      glut_cur_bank;
> > +     u8                      glut_mru_bank;
> > +};
> > +
> > +/* -------- Register accessors -------- */
> > +
> > +static inline u32 ope_read(struct ope_dev *ope, u32 reg)
> > +{
> > +     return readl(ope->base + reg);
> > +}
> > +
> > +static inline void ope_write(struct ope_dev *ope, u32 reg, u32 val)
> > +{
> > +     writel(val, ope->base + reg);
> > +}
> > +
> > +static inline void ope_write_wr(struct ope_dev *ope, u32 reg, u32 val)
> > +{
> > +     writel_relaxed(val, ope->base_wr + reg);
> > +}
> > +
> > +static inline u32 ope_read_wr(struct ope_dev *ope, u32 reg)
> > +{
> > +     return readl_relaxed(ope->base_wr + reg);
> > +}
> > +
> > +static inline void ope_write_rd(struct ope_dev *ope, u32 reg, u32 val)
> > +{
> > +     writel_relaxed(val, ope->base_rd + reg);
> > +}
> > +
> > +static inline void ope_write_pp(struct ope_dev *ope, u32 reg, u32 val)
> > +{
> > +     writel_relaxed(val, ope->base_pp + reg);
> > +}
> > +
> > +static inline u32 ope_read_pp(struct ope_dev *ope, u32 reg)
> > +{
> > +     return readl_relaxed(ope->base_pp + reg);
> > +}
> > +
> > +static inline void ope_start(struct ope_dev *ope)
> > +{
> > +     wmb(); /* ensure all register writes are visible before GO_CMD */
> > +     ope_write_rd(ope, OPE_BUS_RD_INPUT_IF_CMD, OPE_BUS_RD_INPUT_IF_CM=
D_GO_CMD);
> > +}
> > +
> > +static inline bool ope_hw_available(struct ope_dev *ope)
> > +{
> > +     /* v4l2_device_unregister() clear the dev pointer */
> > +     return !!ope->v4l2_dev.dev;
> > +}
> > +
> > +/* -------- Stripe helpers -------- */
> > +
> > +static inline enum ope_stripe_location ope_stripe_location(unsigned in=
t idx, unsigned int count)
> > +{
> > +     if (count =3D=3D 1)
> > +             return OPE_STRIPE_LOCATION_FULL;
> > +     if (idx =3D=3D 0)
> > +             return OPE_STRIPE_LOCATION_LEFT;
> > +     if (idx =3D=3D count - 1)
> > +             return OPE_STRIPE_LOCATION_RIGHT;
> > +
> > +     return OPE_STRIPE_LOCATION_MIDDLE;
> > +}
> > +
> > +static inline bool ope_stripe_is_last(const struct ope_stripe *s)
> > +{
> > +     return s && (s->src.location =3D=3D OPE_STRIPE_LOCATION_RIGHT ||
> > +                  s->src.location =3D=3D OPE_STRIPE_LOCATION_FULL);
> > +}
> > +
> > +static inline struct ope_stripe *ope_current_stripe(struct ope_ctx *ct=
x)
> > +{
> > +     if (ctx->current_stripe >=3D OPE_MAX_STRIPE)
> > +             return NULL;
> > +
> > +     return &ctx->stripe[ctx->current_stripe];
> > +}
> > +
> > +static inline unsigned int ope_stripe_index(struct ope_ctx *ctx, const=
 struct ope_stripe *stripe)
> > +{
> > +     return stripe - &ctx->stripe[0];
> > +}
> > +
> > +static inline struct ope_stripe *ope_prev_stripe(struct ope_ctx *ctx, =
struct ope_stripe *stripe)
> > +{
> > +     unsigned int idx =3D ope_stripe_index(ctx, stripe);
> > +
> > +     return idx ? &ctx->stripe[idx - 1] : NULL;
> > +}
> > +
> > +
> > +static inline unsigned int ope_last_stripe_width(unsigned int src_widt=
h, unsigned int nstripes)
> > +{
> > +     unsigned int last_sw =3D src_width - (nstripes - 1) * OPE_STRIPE_=
MAX_W;
> > +
> > +     if (last_sw < OPE_STRIPE_MIN_W)
> > +             last_sw +=3D OPE_STRIPE_MIN_W * 2;
> > +
> > +     return last_sw;
> > +}
> > +
> > +static unsigned int ope_calc_h_scale(unsigned int src, unsigned int ds=
t,
> > +                                  unsigned int nstripes, unsigned int =
c_hsub,
> > +                                  unsigned int sw_align)
> > +{
> > +     unsigned int last_sw =3D ope_last_stripe_width(src, nstripes);
> > +     unsigned int denom;
> > +
> > +     if (src =3D=3D dst)
> > +             return DS_Q21(src, src);
> > +
> > +     /* Find the smallest h_scale denominator >=3D dst such that the
> > +      * last-stripe adjustment can satisfy both Y and C pixel counts.
> > +      */
> > +     for (denom =3D dst; denom <=3D dst + 16 * nstripes; denom++) {
> > +             unsigned int hs =3D DS_Q21(src, denom);
> > +             unsigned int tw =3D (nstripes - 1) * DS_OUTPUT_PIX(OPE_ST=
RIPE_MAX_W, 0, hs);
> > +             unsigned int tc =3D (nstripes - 1) * DS_OUTPUT_PIX(OPE_ST=
RIPE_MAX_W / c_hsub, 0, hs);
> > +             unsigned int ry =3D dst - tw;
> > +             unsigned int rc =3D dst / c_hsub - tc;
> > +             unsigned int s_y =3D DIV_ROUND_UP((u64)ry * hs, Q21(1));
> > +             unsigned int s_c =3D DIV_ROUND_UP((u64)rc * hs, Q21(1)) *=
 c_hsub;
> > +             unsigned int s =3D ALIGN(max(s_y, s_c), sw_align);
> > +
> > +             s =3D clamp(s, OPE_STRIPE_MIN_W, last_sw);
> > +             tw +=3D DS_OUTPUT_PIX(s, 0, hs);
> > +             tc +=3D DS_OUTPUT_PIX(s / c_hsub, 0, hs);
> > +
> > +             if (tw =3D=3D dst && tc * c_hsub =3D=3D dst)
> > +                     return hs;
> > +     }
> > +
> > +     return DS_Q21(src, dst);
> > +}
> > +
> > +static unsigned int ope_calc_v_scale(unsigned int src, unsigned int ds=
t)
> > +{
> > +     return DS_Q21(src, dst);
> > +}
> > +
> > +static void ope_gen_stripe_chroma_dsc(struct ope_ctx *ctx,
> > +                                   struct ope_stripe *stripe)
> > +{
> > +     struct ope_dsc_config *dsc =3D &stripe->dsc[OPE_DS_C_PRE];
> > +     const struct ope_fmt *fmt =3D ctx->fmt_out.fmt;
> > +
> > +     dsc->input_width  =3D stripe->src.width;
> > +     dsc->input_height =3D stripe->src.height;
> > +
> > +     dsc->output_width  =3D dsc->input_width  / fmt->c_hsub;
> > +     dsc->output_height =3D dsc->input_height / fmt->c_vsub;
> > +
> > +     dsc->phase_step_h =3D DS_Q21(dsc->input_width, dsc->output_width)=
;
> > +     dsc->phase_step_v =3D DS_Q21(dsc->input_height, dsc->output_heigh=
t);
> > +}
> > +
> > +static void ope_gen_stripe_dsc(struct ope_ctx *ctx, struct ope_stripe =
*stripe,
> > +                            unsigned int h_scale, unsigned int v_scale=
)
> > +{
> > +     struct ope_dsc_config *dsc_c =3D &stripe->dsc[OPE_DS_C_DISP];
> > +     struct ope_dsc_config *dsc_y =3D &stripe->dsc[OPE_DS_Y_DISP];
> > +     unsigned int sw =3D stripe->src.width;
> > +     unsigned int sw_c =3D stripe->dsc[OPE_DS_C_PRE].output_width;
> > +
> > +     dsc_c->phase_step_h =3D dsc_y->phase_step_h =3D h_scale;
> > +     dsc_c->phase_step_v =3D dsc_y->phase_step_v =3D v_scale;
> > +
> > +     dsc_c->input_width  =3D stripe->dsc[OPE_DS_C_PRE].output_width;
> > +     dsc_c->input_height =3D stripe->dsc[OPE_DS_C_PRE].output_height;
> > +     dsc_y->input_width  =3D stripe->src.width;
> > +     dsc_y->input_height =3D stripe->src.height;
> > +
> > +     /* Clip the output so the WE always receives the expected count *=
/
> > +     dsc_y->output_width  =3D DS_OUTPUT_PIX(sw, 0, h_scale);
> > +     dsc_y->output_height =3D DS_OUTPUT_PIX(stripe->src.height, 0, v_s=
cale);
> > +     dsc_c->output_width  =3D DS_OUTPUT_PIX(sw_c, 0, h_scale);
> > +     dsc_c->output_height =3D DS_OUTPUT_PIX(stripe->dsc[OPE_DS_C_PRE].=
output_height, 0, v_scale);
> > +
> > +     dsc_y->output_width  =3D max_t(unsigned int, dsc_y->output_width,=
 1);
> > +     dsc_y->output_height =3D max_t(unsigned int, dsc_y->output_height=
, 1);
> > +     dsc_c->output_width  =3D max_t(unsigned int, dsc_c->output_width,=
 1);
> > +     dsc_c->output_height =3D max_t(unsigned int, dsc_c->output_height=
, 1);
> > +
> > +     dsc_y->crop_last_pixel =3D dsc_y->output_width  - 1;
> > +     dsc_y->crop_last_line  =3D dsc_y->output_height - 1;
> > +     dsc_c->crop_last_pixel =3D dsc_c->output_width  - 1;
> > +     dsc_c->crop_last_line  =3D dsc_c->output_height - 1;
> > +}
> > +
> > +static void ope_gen_stripe_yuv_dst(struct ope_ctx *ctx, struct ope_str=
ipe *stripe,
> > +                                dma_addr_t dst, const struct v4l2_rect=
 *compose)
> > +{
> > +     const struct ope_fmt_state *fo =3D &ctx->fmt_out;
> > +     const struct ope_hw_fmt *hw =3D ope_find_hw_fmt(fo->fmt->fourcc);
> > +     struct ope_stripe *prev =3D ope_prev_stripe(ctx, stripe);
> > +     unsigned int bpl =3D fo->bytesperline;
> > +     unsigned int img_h =3D fo->height;
> > +     unsigned int c_stride;
> > +     unsigned int x_init;
> > +     dma_addr_t base;
> > +
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].enabled =3D true;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_C].enabled =3D true;
> > +
> > +     /* Y plane */
> > +     base =3D dst + compose->top * bpl;
> > +
> > +     if (prev)
> > +             x_init =3D prev->dst[OPE_WR_CLIENT_DISP_Y].x_init +
> > +                      prev->dst[OPE_WR_CLIENT_DISP_Y].width;
> > +     else
> > +             x_init =3D compose->left;
> > +
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].addr   =3D base;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].x_init =3D x_init;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].width  =3D stripe->dsc[OPE_DS_Y=
_DISP].output_width;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].height =3D stripe->dsc[OPE_DS_Y=
_DISP].output_height;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].stride =3D bpl;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_Y].format =3D OPE_PACKER_FMT_PLAIN=
_8;
> > +
> > +     /* UV plane (appended to Y plane)*/
> > +     c_stride =3D bpl * 2 / fo->fmt->c_hsub;
> > +     base =3D dst + bpl * img_h + (compose->top / fo->fmt->c_vsub) * c=
_stride;
> > +
> > +     if (prev)
> > +             x_init =3D prev->dst[OPE_WR_CLIENT_DISP_C].x_init +
> > +                      prev->dst[OPE_WR_CLIENT_DISP_C].width;
> > +     else
> > +             x_init =3D compose->left * 2 / fo->fmt->c_hsub;
> > +
> > +     stripe->dst[OPE_WR_CLIENT_DISP_C].addr   =3D base;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_C].x_init =3D x_init;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_C].format =3D hw ? hw->packer : OP=
E_PACKER_FMT_PLAIN_8;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_C].width  =3D stripe->dsc[OPE_DS_C=
_DISP].output_width * 2;
> > +     stripe->dst[OPE_WR_CLIENT_DISP_C].height =3D stripe->dsc[OPE_DS_C=
_DISP].output_height;
> > +
> > +     switch (fo->fmt->fourcc) {
> > +     case V4L2_PIX_FMT_GREY:
> > +             stripe->dst[OPE_WR_CLIENT_DISP_C].enabled =3D false;
> > +             break;
> > +     default:
> > +             stripe->dst[OPE_WR_CLIENT_DISP_C].stride =3D c_stride;
> > +             break;
> > +     }
> > +}
> > +
> > +static void ope_gen_stripes(struct ope_ctx *ctx, dma_addr_t src, dma_a=
ddr_t dst)
> > +{
> > +     const struct ope_fmt_state *fi =3D &ctx->fmt_in;
> > +     const struct ope_hw_fmt *src_hw =3D ope_find_hw_fmt(fi->fmt->four=
cc);
> > +     unsigned int num_stripes, width, x_out, x_out_c, i;
> > +     const struct ope_fmt_state *fo =3D &ctx->fmt_out;
> > +     unsigned int c_hsub =3D fo->fmt->c_hsub;
> > +     struct v4l2_subdev_state *sd_state;
> > +     const struct v4l2_rect *compose;
> > +     const struct v4l2_rect *crop;
> > +     struct v4l2_subdev *proc_sd;
> > +     unsigned int h_scale, v_scale;
> > +
> > +     proc_sd =3D camss_isp_pipeline_get_subdev(ctx->ope->pipeline, OPE=
_ENTITY_PROC);
> > +     sd_state =3D v4l2_subdev_lock_and_get_active_state(proc_sd);
> > +     crop =3D v4l2_subdev_state_get_crop(sd_state, OPE_PROC_PAD_SINK_I=
N);
> > +     compose =3D v4l2_subdev_state_get_compose(sd_state, OPE_PROC_PAD_=
SOURCE);
> > +
> > +     /* Advance source pointer to the crop origin */
> > +     src +=3D crop->top * fi->bytesperline + crop->left * fi->fmt->dep=
th / 8;
> > +     width =3D crop->width;
> > +     num_stripes =3D DIV_ROUND_UP(crop->width, OPE_STRIPE_MAX_W);
> > +     h_scale =3D ope_calc_h_scale(crop->width,  compose->width, num_st=
ripes, c_hsub,
> > +                                max(2u, 1u << fi->fmt->align));
> > +     v_scale =3D ope_calc_v_scale(crop->height, compose->height);
> > +
> > +     x_out =3D x_out_c =3D 0;
> > +
> > +     for (i =3D 0; i < num_stripes; i++) {
> > +             struct ope_stripe *stripe =3D &ctx->stripe[i];
> > +
> > +             memset(stripe, 0, sizeof(*stripe));
> > +
> > +             stripe->src.addr =3D src;
> > +             stripe->src.width =3D width;
> > +             stripe->src.height =3D crop->height;
> > +             stripe->src.stride =3D fi->bytesperline;
> > +             stripe->src.location =3D ope_stripe_location(i, num_strip=
es);
> > +             stripe->src.pattern =3D src_hw ? src_hw->pattern : 0;
> > +             stripe->src.format =3D src_hw ? src_hw->unpacker : 0;
> > +
> > +             /* Ensure last stripe is wide enough */
> > +             if (width > OPE_STRIPE_MAX_W && width < OPE_STRIPE_MAX_W =
+ OPE_STRIPE_MIN_W)
> > +                     stripe->src.width -=3D OPE_STRIPE_MIN_W * 2;
> > +
> > +             v4l_bound_align_image(&stripe->src.width,
> > +                                   OPE_STRIPE_MIN_W, OPE_STRIPE_MAX_W,
> > +                                   fi->fmt->align,
> > +                                   &stripe->src.height,
> > +                                   OPE_STRIPE_MIN_H, OPE_STRIPE_MAX_H,
> > +                                   OPE_ALIGN_H, 0);
> > +
> > +             width -=3D stripe->src.width;
> > +             src +=3D stripe->src.width * fi->fmt->depth / 8;
> > +
> > +             /* Last-stripe adjustment: compute the minimum input widt=
h that
> > +              * delivers exactly the remaining output pixels for Y and=
 C.
> > +              */
> > +             if (ope_stripe_is_last(stripe)) {
> > +                     unsigned int rem_y =3D compose->width - x_out;
> > +                     unsigned int rem_c =3D compose->width / c_hsub - =
x_out_c;
> > +                     unsigned int s_y =3D DIV_ROUND_UP((u64)rem_y * h_=
scale, Q21(1));
> > +                     unsigned int s_c =3D DIV_ROUND_UP((u64)rem_c * h_=
scale, Q21(1)) * c_hsub;
> > +                     unsigned int s =3D ALIGN(max(s_y, s_c), max(2u, 1=
u << fi->fmt->align));
> > +
> > +                     stripe->src.width =3D clamp(s, OPE_STRIPE_MIN_W, =
stripe->src.width);
> > +             }
> > +
> > +             ope_gen_stripe_chroma_dsc(ctx, stripe);
> > +             ope_gen_stripe_dsc(ctx, stripe, h_scale, v_scale);
> > +             ope_gen_stripe_yuv_dst(ctx, stripe, dst, compose);
> > +
> > +             x_out +=3D stripe->dsc[OPE_DS_Y_DISP].output_width;
> > +             x_out_c +=3D stripe->dsc[OPE_DS_C_DISP].output_width;
> > +
> > +             /* Width in bytes for the fetch engine */
> > +             stripe->src.width =3D stripe->src.width * fi->fmt->depth =
/ 8;
> > +     }
> > +
> > +     v4l2_subdev_unlock_state(sd_state);
> > +}
> > +
> > +/* -------- Pipeline IQ module programming -------- */
> > +
> > +static bool ope_module_update(struct ope_ctx *ctx, u32 module_cfg_reg,=
 u32 enable_mask,
> > +                           struct v4l2_isp_params_block_header *hdr, b=
ool force)
> > +{
> > +     bool enable =3D !(hdr->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE);
> > +     bool dirty  =3D hdr->flags & CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
> > +
> > +     /* skip if neither forced (new context) nor dirty (updated params=
) */
> > +     if (!force && !dirty)
> > +             return false;
> > +
> > +     hdr->flags &=3D ~CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
> > +
> > +     ope_write_pp(ctx->ope, module_cfg_reg, enable ? enable_mask : 0);
> > +
> > +     /* If module is disabled, not need to update content */
> > +     if (!enable)
> > +             return false;
> > +
> > +     dev_dbg(ctx->ope->dev, "IQ module (%u) update (flags:0x%x)\n", hd=
r->type, hdr->flags);
> > +
> > +     return true;
> > +}
> > +
> > +static void ope_prog_wb(struct ope_ctx *ctx, bool force)
> > +{
> > +     struct camss_params_ope_wb_gain *wb =3D &ctx->config.wb_gain;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     if (!ope_module_update(ctx, OPE_PP_WB_GAIN_MODULE_CFG,
> > +                            OPE_PP_WB_GAIN_MODULE_CFG_EN,
> > +                            &wb->header, force))
> > +             return;
> > +
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_CFG(0),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_CFG_GAIN, wb->g_gain));
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_CFG(1),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_CFG_GAIN, wb->b_gain));
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_CFG(2),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_CFG_GAIN, wb->r_gain));
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_SUB_CFG(0),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_SUB_CFG_VAL, wb->g_sub)=
);
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_SUB_CFG(1),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_SUB_CFG_VAL, wb->b_sub)=
);
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_SUB_CFG(2),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_SUB_CFG_VAL, wb->r_sub)=
);
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_ADD_CFG(0),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_ADD_CFG_VAL, wb->g_add)=
);
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_ADD_CFG(1),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_ADD_CFG_VAL, wb->b_add)=
);
> > +     ope_write_pp(ope, OPE_PP_WB_GAIN_WB_ADD_CFG(2),
> > +                  FIELD_PREP(OPE_PP_WB_GAIN_WB_ADD_CFG_VAL, wb->r_add)=
);
> > +}
> > +
> > +static void ope_prog_bayer2rgb(struct ope_ctx *ctx, bool force)
> > +{
> > +     struct ope_params_demo *demo =3D &ctx->config.demo;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     if (!ope_module_update(ctx, OPE_PP_DEMO_MODULE_CFG,
> > +                            OPE_PP_DEMO_MODULE_CFG_EN |
> > +                            OPE_PP_DEMO_MODULE_CFG_DYN_G_CLAMP_EN |
> > +                            OPE_PP_DEMO_MODULE_CFG_DYN_RB_CLAMP_EN,
> > +                            &demo->header, force))
> > +             return;
> > +
> > +     ope_write_pp(ope, OPE_PP_DEMO_INTERP_COEFF_CFG,
> > +                  FIELD_PREP(OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_G,  d=
emo->lambda_g) |
> > +                  FIELD_PREP(OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_RB, d=
emo->lambda_rb));
> > +     ope_write_pp(ope, OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0,
> > +                  FIELD_PREP(OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0_AK, d=
emo->a_k));
> > +     ope_write_pp(ope, OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1,
> > +                  FIELD_PREP(OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1_WK, d=
emo->w_k));
> > +}
> > +
> > +static void ope_prog_rgb2yuv(struct ope_ctx *ctx, bool force)
> > +{
> > +     struct camss_params_ope_chroma_enhan *cc =3D &ctx->config.chroma_=
enhan;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     if (!ope_module_update(ctx, OPE_PP_CHROMA_ENHAN_MODULE_CFG,
> > +                            OPE_PP_CHROMA_ENHAN_MODULE_CFG_EN,
> > +                            &cc->header, force))
> > +             return;
> > +
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_LUMA_CFG_0,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V0, cc->lu=
ma_v0) |
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V1, cc->lu=
ma_v1));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_LUMA_CFG_1,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_1_K, cc->lum=
a_k));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_LUMA_CFG_2,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_2_V2, cc->lu=
ma_v2));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_A_CFG,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AP, cc->c=
oeff_ap) |
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AM, cc->c=
oeff_am));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_B_CFG,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BP, cc->c=
oeff_bp) |
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BM, cc->c=
oeff_bm));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_C_CFG,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CP, cc->c=
oeff_cp) |
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CM, cc->c=
oeff_cm));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_D_CFG,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DP, cc->c=
oeff_dp) |
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DM, cc->c=
oeff_dm));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0_KCB, cc-=
>kcb));
> > +     ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1,
> > +                  FIELD_PREP(OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1_KCR, cc-=
>kcr));
> > +}
> > +
> > +static void ope_prog_color_correct(struct ope_ctx *ctx, bool force)
> > +{
> > +     struct camss_params_ope_color_correct *cc =3D &ctx->config.color_=
correct;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     if (!ope_module_update(ctx, OPE_PP_CC_MODULE_CFG,
> > +                            OPE_PP_CC_MODULE_CFG_EN,
> > +                            &cc->header, force))
> > +             return;
> > +
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_A_CFG_0,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_A_CFG_0_A0, cc->a[0]) |
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_A_CFG_0_A1, cc->a[1]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_A_CFG_1,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_A_CFG_1_A2, cc->a[2]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_B_CFG_0,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_B_CFG_0_B0, cc->b[0]) |
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_B_CFG_0_B1, cc->b[1]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_B_CFG_1,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_B_CFG_1_B2, cc->b[2]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_C_CFG_0,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_C_CFG_0_C0, cc->c[0]) |
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_C_CFG_0_C1, cc->c[1]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_C_CFG_1,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_C_CFG_1_C2, cc->c[2]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_K_CFG_0,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_K_CFG_0_K0, cc->k[0]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_K_CFG_1,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_K_CFG_1_K1, cc->k[1]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_K_CFG_2,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_K_CFG_2_K2, cc->k[2]));
> > +     ope_write_pp(ope, OPE_PP_CC_COEFF_M_CFG,
> > +                  FIELD_PREP(OPE_PP_CC_COEFF_M_CFG_M, cc->qfactor));
> > +}
> > +
> > +static void ope_glut_load_lut(struct ope_dev *ope, enum ope_glut_sel c=
h,
> > +                           u8 bank, const u16 *lut)
> > +{
> > +     ope_write_pp(ope, OPE_PP_GLUT_DMI_LUT_BANK_CFG,
> > +                  FIELD_PREP(OPE_PP_GLUT_DMI_LUT_BANK_CFG_SEL, bank));
> > +     ope_write_pp(ope, OPE_PP_GLUT_DMI_LUT_CFG,
> > +                  FIELD_PREP(OPE_PP_GLUT_DMI_LUT_CFG_SEL, ch));
> > +     ope_write_pp(ope, OPE_PP_GLUT_DMI_CFG,
> > +                  OPE_PP_GLUT_DMI_CFG_AUTO_LOAD_EN |
> > +                  FIELD_PREP(OPE_PP_GLUT_DMI_CFG_ADDR, 0));
> > +     for (unsigned int i =3D 0; i < CAMSS_OPE_GAMMA_LUT_SIZE; i++)
> > +             ope_write_pp(ope, OPE_PP_GLUT_DMI_DATA, lut[i]);
> > +}
> > +
> > +static void ope_glut_upload(struct ope_ctx *ctx, u8 bank)
> > +{
> > +     struct camss_params_ope_gamma *gamma =3D &ctx->config.gamma;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     ope_glut_load_lut(ope, OPE_GLUT_SEL_R, bank, gamma->rlut);
> > +     ope_glut_load_lut(ope, OPE_GLUT_SEL_G, bank, gamma->glut);
> > +     ope_glut_load_lut(ope, OPE_GLUT_SEL_B, bank, gamma->blut);
> > +
> > +     ope_write_pp(ope, OPE_PP_GLUT_DMI_LUT_CFG,
> > +                  FIELD_PREP(OPE_PP_GLUT_DMI_LUT_CFG_SEL,
> > +                             OPE_GLUT_SEL_NONE));
> > +
> > +     ope->glut_bank[bank].owner =3D ctx;
> > +     ope->glut_bank[bank].valid =3D true;
> > +}
> > +
> > +static bool ope_glut_bank_resident(struct ope_dev *ope, u8 bank,
> > +                                 struct ope_ctx *ctx)
> > +{
> > +     return ope->glut_bank[bank].valid &&
> > +            ope->glut_bank[bank].owner =3D=3D ctx;
> > +}
> > +
> > +static void ope_prog_gamma(struct ope_ctx *ctx, bool force)
> > +{
> > +     struct camss_params_ope_gamma *gamma =3D &ctx->config.gamma;
> > +     bool enable =3D !(gamma->header.flags & V4L2_ISP_PARAMS_FL_BLOCK_=
DISABLE);
> > +     bool dirty =3D gamma->header.flags & CAMSS_ISP_PARAMS_FL_BLOCK_DI=
RTY;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +     u8 bank;
> > +
> > +     if (!force && !dirty)
> > +             return;
> > +
> > +     gamma->header.flags &=3D ~CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
> > +
> > +     if (!enable) {
> > +             ope_write_pp(ope, OPE_PP_GLUT_MODULE_CFG, 0);
> > +             return;
> > +     }
> > +
> > +     if (!dirty && ope_glut_bank_resident(ope, ope->glut_cur_bank, ctx=
)) {
> > +             /* Already active in the read bank: only (re)enable the m=
odule. */
> > +             bank =3D ope->glut_cur_bank;
> > +     } else if (!dirty && ope_glut_bank_resident(ope, !ope->glut_cur_b=
ank, ctx)) {
> > +             /* Resident in the other bank: flip to it, no upload. */
> > +             bank =3D !ope->glut_cur_bank;
> > +     } else {
> > +             /* Dirty, or miss in both banks: upload into the LRU bank=
. */
> > +             bank =3D !ope->glut_mru_bank;
> > +             ope_glut_upload(ctx, bank);
> > +     }
> > +
> > +     ope->glut_mru_bank =3D bank;
> > +
> > +     dev_dbg(ope->dev,
> > +             "IQ module (%u) update (flags:0x%x) glut bank %u->%u)\n",
> > +             gamma->header.type, gamma->header.flags,
> > +             ope->glut_cur_bank, bank);
> > +
> > +     ope_write_pp(ope, OPE_PP_GLUT_MODULE_LUT_BANK_CFG,
> > +                  FIELD_PREP(OPE_PP_GLUT_MODULE_LUT_BANK_CFG_SEL, bank=
));
> > +     ope->glut_cur_bank =3D bank;
> > +
> > +     ope_write_pp(ope, OPE_PP_GLUT_MODULE_CFG, OPE_PP_GLUT_MODULE_CFG_=
EN);
> > +}
> > +
> > +static void ope_glut_cache_invalidate(struct ope_dev *ope)
> > +{
> > +     ope->glut_bank[0].valid =3D false;
> > +     ope->glut_bank[1].valid =3D false;
> > +     ope->glut_cur_bank =3D 0;
> > +     ope->glut_mru_bank =3D 0;
> > +}
> > +
> > +static void ope_prog_crop_rnd_clamp(struct ope_dev *ope, const struct =
ope_stripe *stripe)
> > +{
> > +     static const u32 crop_bases[] =3D {
> > +             OPE_PP_CROP_RND_CLAMP_Y_DISP_BASE,
> > +             OPE_PP_CROP_RND_CLAMP_C_DISP_BASE,
> > +     };
> > +     static const enum ope_downscaler ds_idx[] =3D {
> > +             OPE_DS_Y_DISP,
> > +             OPE_DS_C_DISP,
> > +     };
> > +
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(crop_bases); i++) {
> > +             const struct ope_dsc_config *dsc =3D &stripe->dsc[ds_idx[=
i]];
> > +             u32 cbase =3D crop_bases[i];
> > +
> > +             if (!dsc->output_width || !dsc->output_height) {
> > +                     ope_write_pp(ope,  OPE_PP_CROP_RND_CLAMP_MODULE_C=
FG(cbase), 0);
> > +                     continue;
> > +             }
> > +
> > +             ope_write_pp(ope, OPE_PP_CROP_RND_CLAMP_CROP_PIXEL_CFG(cb=
ase),
> > +                          FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_FIRST,=
 0) |
> > +                          FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_LAST,
> > +                                     dsc->crop_last_pixel));
> > +             ope_write_pp(ope, OPE_PP_CROP_RND_CLAMP_CROP_LINE_CFG(cba=
se),
> > +                          FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_FIRST,=
 0) |
> > +                          FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_LAST, =
dsc->crop_last_line));
> > +             ope_write_pp(ope, OPE_PP_CROP_RND_CLAMP_MODULE_CFG(cbase)=
,
> > +                          OPE_PP_CROP_RND_CLAMP_EN | OPE_PP_CROP_RND_C=
LAMP_CROP_EN);
> > +     }
> > +}
> > +
> > +static void ope_prog_stripe(struct ope_ctx *ctx, struct ope_stripe *st=
ripe)
> > +{
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     dev_dbg(ope->dev, "ctx=3D%p programming stripe %u\n",
> > +             ctx, (unsigned int)(stripe - ctx->stripe));
> > +
> > +     /* Fetch Engine */
> > +     ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_UNPACK_CFG_0, stripe->src.f=
ormat);
> > +     ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_RD_BUFFER_SIZE,
> > +                  (stripe->src.width << 16) | stripe->src.height);
> > +     ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_ADDR_IMAGE, stripe->src.add=
r);
> > +     ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_RD_STRIDE, stripe->src.stri=
de);
> > +     ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_CCIF_META_DATA,
> > +                  FIELD_PREP(OPE_BUS_RD_CLIENT_0_CCIF_MD_PIX_PATTERN,
> > +                             stripe->src.pattern));
> > +     ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_CORE_CFG,
> > +                  OPE_BUS_RD_CLIENT_0_CORE_CFG_EN);
> > +
> > +     /* Write Engines */
> > +     for (int i =3D 0; i < OPE_WR_CLIENT_MAX; i++) {
> > +             if (!stripe->dst[i].enabled) {
> > +                     ope_write_wr(ope, OPE_BUS_WR_CLIENT_CFG(i), 0);
> > +                     continue;
> > +             }
> > +
> > +             ope_write_wr(ope, OPE_BUS_WR_CLIENT_ADDR_IMAGE(i),
> > +                          stripe->dst[i].addr);
> > +             ope_write_wr(ope, OPE_BUS_WR_CLIENT_IMAGE_CFG_0(i),
> > +                          (stripe->dst[i].height << 16) | stripe->dst[=
i].width);
> > +             ope_write_wr(ope, OPE_BUS_WR_CLIENT_IMAGE_CFG_1(i),
> > +                          stripe->dst[i].x_init);
> > +             ope_write_wr(ope, OPE_BUS_WR_CLIENT_IMAGE_CFG_2(i),
> > +                          stripe->dst[i].stride);
> > +             ope_write_wr(ope, OPE_BUS_WR_CLIENT_PACKER_CFG(i),
> > +                          stripe->dst[i].format);
> > +             ope_write_wr(ope, OPE_BUS_WR_CLIENT_CFG(i),
> > +                          OPE_BUS_WR_CLIENT_CFG_EN |
> > +                          OPE_BUS_WR_CLIENT_CFG_AUTORECOVER);
> > +     }
> > +
> > +     /* Downscalers */
> > +     for (int i =3D 0; i < OPE_DS_MAX; i++) {
> > +             struct ope_dsc_config *dsc =3D &stripe->dsc[i];
> > +             u32 base =3D ope_ds_base[i];
> > +             u32 cfg =3D 0;
> > +
> > +             if (dsc->input_width !=3D dsc->output_width) {
> > +                     dsc->phase_step_h |=3D
> > +                             DS_RESOLUTION(dsc->input_width,
> > +                                           dsc->output_width) << 30;
> > +                     cfg |=3D OPE_PP_DOWNSCALE_MN_DS_CFG_H_SCALE_EN;
> > +             }
> > +             if (dsc->input_height !=3D dsc->output_height) {
> > +                     dsc->phase_step_v |=3D
> > +                             DS_RESOLUTION(dsc->input_height,
> > +                                           dsc->output_height) << 30;
> > +                     cfg |=3D OPE_PP_DOWNSCALE_MN_DS_CFG_V_SCALE_EN;
> > +             }
> > +
> > +             ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_CFG(base), cfg);
> > +             ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_IMAGE_SIZE_CFG(b=
ase),
> > +                          ((dsc->input_width - 1) << 16) | (dsc->input=
_height - 1));
> > +             ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_MN_H_CFG(base),
> > +                          dsc->phase_step_h);
> > +             ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_MN_V_CFG(base),
> > +                          dsc->phase_step_v);
> > +             ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_CFG(base),
> > +                          cfg ? OPE_PP_DOWNSCALE_MN_CFG_EN : 0);
> > +
> > +             dev_dbg(ope->dev, "DS[%d] cfg=3D0x%x in=3D%ux%u out=3D%ux=
%u\n",
> > +                     i, cfg, dsc->input_width, dsc->input_height,
> > +                     dsc->output_width, dsc->output_height);
> > +     }
> > +
> > +     ope_prog_crop_rnd_clamp(ope, stripe);
> > +}
> > +
> > +static void ope_params_apply_wb(void *priv, const union camss_isp_para=
ms_block *block)
> > +{
> > +     struct ope_ctx *ctx =3D priv;
> > +
> > +     if (!camss_isp_params_copy_block(&ctx->config.wb_gain, block, siz=
eof(ctx->config.wb_gain)))
> > +             return;
> > +
> > +     ctx->config.wb_gain.g_sub =3D block->wb_gain.g_sub >> 4;
> > +     ctx->config.wb_gain.b_sub =3D block->wb_gain.b_sub >> 4;
> > +     ctx->config.wb_gain.r_sub =3D block->wb_gain.r_sub >> 4;
> > +     ctx->config.wb_gain.g_add =3D block->wb_gain.g_add >> 4;
> > +     ctx->config.wb_gain.b_add =3D block->wb_gain.b_add >> 4;
> > +     ctx->config.wb_gain.r_add =3D block->wb_gain.r_add >> 4;
> > +}
> > +
> > +static void ope_params_apply_chroma_enhan(void *priv, const union cams=
s_isp_params_block *block)
> > +{
> > +     struct ope_ctx *ctx =3D priv;
> > +
> > +     camss_isp_params_copy_block(&ctx->config.chroma_enhan, block,
> > +                                 sizeof(ctx->config.chroma_enhan));
> > +}
> > +
> > +static void ope_params_apply_color_correct(void *priv, const union cam=
ss_isp_params_block *block)
> > +{
> > +     struct ope_ctx *ctx =3D priv;
> > +
> > +     camss_isp_params_copy_block(&ctx->config.color_correct, block,
> > +                                 sizeof(ctx->config.color_correct));
> > +}
> > +
> > +static void ope_params_apply_gamma(void *priv, const union camss_isp_p=
arams_block *block)
> > +{
> > +     struct ope_ctx *ctx =3D priv;
> > +
> > +     camss_isp_params_copy_block(&ctx->config.gamma, block, sizeof(ctx=
->config.gamma));
> > +}
> > +
> > +static const struct v4l2_isp_params_block_type_info ope_params_type_in=
fo[] =3D {
> > +     [CAMSS_PARAMS_OPE_WB_GAIN]       =3D { sizeof(struct camss_params=
_ope_wb_gain) },
> > +     [CAMSS_PARAMS_OPE_CHROMA_ENHAN]  =3D { sizeof(struct camss_params=
_ope_chroma_enhan) },
> > +     [CAMSS_PARAMS_OPE_COLOR_CORRECT] =3D { sizeof(struct camss_params=
_ope_color_correct) },
> > +     [CAMSS_PARAMS_OPE_GAMMA]         =3D { sizeof(struct camss_params=
_ope_gamma) },
> > +};
> > +
> > +static const camss_isp_params_handler_fn ope_params_handlers[] =3D {
> > +     [CAMSS_PARAMS_OPE_WB_GAIN]       =3D ope_params_apply_wb,
> > +     [CAMSS_PARAMS_OPE_CHROMA_ENHAN]  =3D ope_params_apply_chroma_enha=
n,
> > +     [CAMSS_PARAMS_OPE_COLOR_CORRECT] =3D ope_params_apply_color_corre=
ct,
> > +     [CAMSS_PARAMS_OPE_GAMMA]         =3D ope_params_apply_gamma,
> > +};
> > +
> > +static struct vb2_v4l2_buffer *ope_queue_remove(struct ope_ctx *ctx,
> > +                                      unsigned int idx)
> > +{
> > +     struct ope_queue *q =3D &ctx->queues[idx];
> > +     struct camss_isp_buf *buf;
> > +
> > +     scoped_guard(spinlock_irqsave, &q->rdy_spinlock) {
> > +             buf =3D list_first_entry_or_null(&q->rdy_queue, struct ca=
mss_isp_buf, list);
> > +             if (buf)
> > +                     list_del(&buf->list);
> > +     }
> > +
> > +     return buf ? &buf->vb : NULL;
> > +}
> > +
> > +static struct vb2_v4l2_buffer *ope_queue_peek(struct ope_ctx *ctx,
> > +                                            unsigned int idx)
> > +{
> > +     struct ope_queue *q =3D &ctx->queues[idx];
> > +     struct camss_isp_buf *buf;
> > +
> > +     scoped_guard(spinlock_irqsave, &q->rdy_spinlock)
> > +             buf =3D list_first_entry_or_null(&q->rdy_queue, struct ca=
mss_isp_buf, list);
> > +
> > +     return buf ? &buf->vb : NULL;
> > +}
> > +
> > +static void ope_queue_drain(struct ope_ctx *ctx, unsigned int idx,
> > +                         enum vb2_buffer_state state)
> > +{
> > +     struct vb2_v4l2_buffer *vbuf;
> > +
> > +     while ((vbuf =3D ope_queue_remove(ctx, idx)))
> > +             vb2_buffer_done(&vbuf->vb2_buf, state);
> > +}
> > +
> > +static int ope_apply_params(struct ope_ctx *ctx)
> > +{
> > +     struct vb2_v4l2_buffer *vbuf;
> > +
> > +     vbuf =3D ope_queue_peek(ctx, OPE_QUEUE_PARAMS);
> > +     if (!vbuf)
> > +             return 0;
> > +
> > +     return camss_isp_params_apply(ctx->ope->dev, &vbuf->vb2_buf,
> > +                                   ctx->params_buf,
> > +                                   ope_params_type_info,
> > +                                   ope_params_handlers,
> > +                                   ARRAY_SIZE(ope_params_handlers),
> > +                                   ctx);
> > +}
> > +
> > +/* Default/initial tuning parameters */
> > +static const struct ope_config ope_default_config =3D {
> > +     .wb_gain =3D {
> > +             .header.type =3D CAMSS_PARAMS_OPE_WB_GAIN,
> > +             .header.flags =3D V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> > +                             CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
> > +             .g_gain =3D OPE_WB(1, 1),
> > +             .b_gain =3D OPE_WB(3, 2),
> > +             .r_gain =3D OPE_WB(3, 2),
> > +     },
> > +     .demo =3D {
> > +             .header.type =3D CAMSS_PARAMS_INTERNAL,
> > +             .header.flags =3D V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> > +                             CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
> > +             .lambda_rb =3D 0,
> > +             .lambda_g  =3D 128,
> > +             .a_k       =3D 128,
> > +             .w_k       =3D 102,
> > +     },
> > +     .chroma_enhan =3D { /* RGB -> YUV values from BT.601/Full-Range *=
/
> > +             .header.type =3D CAMSS_PARAMS_OPE_CHROMA_ENHAN,
> > +             .header.flags =3D V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> > +                             CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
> > +             .luma_v0  =3D 0x04d, /* 0.299 */
> > +             .luma_v1  =3D 0x096, /* 0.587 */
> > +             .luma_v2  =3D 0x01d, /* 0.114 */
> > +             .luma_k   =3D 0,
> > +             .coeff_ap =3D 0x077, /* 0.464  */
> > +             .coeff_am =3D 0x070, /* 0.438  */
> > +             .coeff_bp =3D 0xfac, /* -0.329 */
> > +             .coeff_bm =3D 0xfc4, /* -0.234 */
> > +             .coeff_cp =3D 0x086, /* 0.524  */
> > +             .coeff_cm =3D 0x089, /* 0.535  */
> > +             .coeff_dp =3D 0xfff, /* -0.004 */
> > +             .coeff_dm =3D 0xfdf, /* -0.130 */
> > +             .kcb      =3D 128,
> > +             .kcr      =3D 128,
> > +     },
> > +     .color_correct =3D {
> > +             .header.type =3D CAMSS_PARAMS_OPE_COLOR_CORRECT,
> > +             .header.flags =3D V4L2_ISP_PARAMS_FL_BLOCK_DISABLE |
> > +                             CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
> > +     },
> > +     .gamma =3D {
> > +             .header.type =3D CAMSS_PARAMS_OPE_GAMMA,
> > +             .header.flags =3D V4L2_ISP_PARAMS_FL_BLOCK_DISABLE |
> > +                             CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
> > +     },
> > +};
> > +
> > +static void ope_try_schedule(struct ope_ctx *ctx);
> > +
> > +/* -------- Job scheduling -------- */
> > +static bool ope_job_ready(void *priv)
> > +{
> > +     struct ope_ctx *ctx =3D priv;
> > +
> > +     return ctx->started &&
> > +            !list_empty(&ctx->queues[OPE_QUEUE_FRAME_IN].rdy_queue) &&
> > +            !list_empty(&ctx->queues[OPE_QUEUE_DISP_OUT].rdy_queue);
> > +}
> > +
> > +static void ope_job_finish(struct ope_ctx *ctx, enum vb2_buffer_state =
state)
> > +{
> > +     struct vb2_v4l2_buffer *src, *dst, *params;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     src    =3D ope_queue_remove(ctx, OPE_QUEUE_FRAME_IN);
> > +     dst    =3D ope_queue_remove(ctx, OPE_QUEUE_DISP_OUT);
> > +     params =3D ope_queue_remove(ctx, OPE_QUEUE_PARAMS);
> > +
> > +     if (dst) {
> > +             dst->sequence =3D ctx->fmt_in.sequence++;
> > +             if (src)
> > +                     dst->vb2_buf.timestamp =3D src->vb2_buf.timestamp=
;
> > +     }
> > +
> > +     if (dst)
> > +             vb2_buffer_done(&dst->vb2_buf, state);
> > +     if (src)
> > +             vb2_buffer_done(&src->vb2_buf, state);
> > +     if (params)
> > +             vb2_buffer_done(&params->vb2_buf, state);
> > +
> > +     scoped_guard(spinlock_irqsave, &ope->sched_lock) {
> > +             ope->hw_ctx =3D NULL;
> > +             ope->curr_ctx =3D NULL;
> > +             ctx->queued =3D false;
> > +
> > +             if (state !=3D VB2_BUF_STATE_DONE)
> > +                     ope->prev_ctx =3D NULL;
> > +     }
> > +
> > +     dev_dbg(ctx->ope->dev, "done ctx=3D%p state=3D%u\n", ctx, state);
> > +
> > +     ope_try_schedule(ctx);
> > +}
> > +
> > +static dma_addr_t ope_buf_dma_addr(struct ope_ctx *ctx, unsigned int q=
ueue_idx)
> > +{
> > +     struct vb2_v4l2_buffer *vbuf =3D ope_queue_peek(ctx, queue_idx);
> > +
> > +     if (!vbuf)
> > +             return 0;
> > +
> > +     return vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> > +}
> > +
> > +static void ope_run_job(void *priv, bool ctx_changed)
> > +{
> > +     struct ope_ctx *ctx =3D priv;
> > +     struct ope_dev *ope =3D ctx->ope;
> > +     dma_addr_t src, dst;
> > +
> > +     src =3D ope_buf_dma_addr(ctx, OPE_QUEUE_FRAME_IN);
> > +     dst =3D ope_buf_dma_addr(ctx, OPE_QUEUE_DISP_OUT);
>
> ope_hw_reset_sync() can schedule this function with !src && dst ->
> ope_job_finish() runs with dst true.
>
> ope_sched_cancel() and ope_v4l2_unregister() call ope_hw_reset_sync();
>
> ->
>
> ope_job_finish() will rescind the buffer with the hardware thinking it
> still owns them ?
>
> You should proably do a OPE_TOP_RESET_CMD
>
> > +     if (!src || !dst) {
> > +             dev_warn(ope->dev, "Job cannot run, missing buffer\n");
> > +             ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
> > +             return;
> > +     }
> > +
> > +     dev_dbg(ope->dev, "start ctx=3D%p->%p src=3D%pad dst=3D%pad\n",
> > +             ope->hw_ctx, ctx, &src, &dst);
> > +
> > +     if (ope_apply_params(ctx))
> > +             dev_warn_ratelimited(ope->dev, "Invalid parameters\n");
> > +
> > +     if (ctx->first_start) {
> > +             ctx_changed =3D true;
> > +             ctx->first_start =3D false;
> > +     }
> > +
> > +     ope_gen_stripes(ctx, src, dst);
> > +
> > +     ope_prog_wb(ctx, ctx_changed);
> > +     ope_prog_bayer2rgb(ctx, ctx_changed);
> > +     ope_prog_color_correct(ctx, ctx_changed);
> > +     ope_prog_gamma(ctx, ctx_changed);
> > +     ope_prog_rgb2yuv(ctx, ctx_changed);
> > +
> > +     ctx->current_stripe =3D 0;
> > +     ope->hw_ctx =3D ctx;
> > +     ope_prog_stripe(ctx, &ctx->stripe[0]);
> > +
> > +     ope_start(ope);
> > +}
> > +
> > +static int ope_hw_reset_sync(struct ope_dev *ope)
> > +{
> > +     reinit_completion(&ope->reset_complete);
> > +     ope_write(ope, OPE_TOP_RESET_CMD, OPE_TOP_RESET_CMD_SW);
> > +
> > +     if (!wait_for_completion_timeout(&ope->reset_complete,
> > +                                      msecs_to_jiffies(OPE_RESET_TIMEO=
UT_MS)))
> > +             return -ETIMEDOUT;
> > +
> > +     return 0;
> > +}
> > +
> > +static void ope_sched_cancel(struct ope_ctx *ctx)
> > +{
> > +     struct ope_dev *ope =3D ctx->ope;
> > +     bool running;
> > +
> > +     disable_work_sync(&ope->run_work);
> > +
> > +     scoped_guard(spinlock_irqsave, &ope->sched_lock)
> > +             running =3D (ope->curr_ctx =3D=3D ctx);
> > +
> > +     if (running && ope_hw_reset_sync(ope)) {
> > +             dev_err(ope->dev, "reset timeout during cancel\n");
> > +             synchronize_irq(ope->irq);
> > +             ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
> > +     }
> > +
> > +     scoped_guard(spinlock_irqsave, &ope->sched_lock)
> > +             ctx->queued =3D false;
> > +}
> > +
> > +static void ope_sched_resume(struct ope_ctx *ctx)
> > +{
> > +     if (enable_work(&ctx->ope->run_work))
> > +             ope_try_schedule(ctx);
> > +}
> > +
> > +static void ope_run_work(struct work_struct *work)
> > +{
> > +     struct ope_dev *ope =3D container_of(work, struct ope_dev, run_wo=
rk);
> > +     struct ope_ctx *ctx;
> > +     bool ctx_changed;
> > +
> > +     if (unlikely(!ope_hw_available(ope)))
> > +             return;
> > +
> > +     scoped_guard(spinlock_irqsave, &ope->sched_lock) {
> > +             ctx =3D ope->shared_ctx;
>
> shared_ctx is written holding ope->mutex but read holding sched_lock
>   > +           if (!ctx || !ctx->queued || ope->curr_ctx)
> > +                     return;
> > +             if (!ope_job_ready(ctx))
> > +                     return;
> > +             ctx_changed =3D (ope->prev_ctx !=3D ctx);
> > +             ope->prev_ctx =3D ctx;
> > +             ope->curr_ctx =3D ctx;
> > +     }
> > +
> > +     ope_run_job(ctx, ctx_changed);
> > +}
> > +
> > +static void ope_try_schedule(struct ope_ctx *ctx)
> > +{
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     if (!ope_job_ready(ctx))
> > +             return;
> > +
> > +     scoped_guard(spinlock_irqsave, &ope->sched_lock) {
> > +             if (ctx->queued || ope->curr_ctx)
> > +                     return;
> > +             ctx->queued =3D true;
>
>
> > +     }
> > +
> > +     schedule_work(&ope->run_work);
>
>
> > +}
> > +
> > +/* -------- Interrupt handlers -------- */
> > +
> > +static void ope_fe_irq(struct ope_dev *ope)
> > +{
> > +     u32 status =3D readl_relaxed(ope->base_rd + OPE_BUS_RD_INPUT_IF_I=
RQ_STATUS);
> > +
> > +     writel_relaxed(status, ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_CLE=
AR);
> > +     writel_relaxed(OPE_BUS_RD_INPUT_IF_IRQ_CMD_CLEAR,
> > +                    ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_CMD);
> > +
> > +     if (status & OPE_BUS_RD_INPUT_IF_IRQ_STATUS_CCIF_VIOL)
> > +             dev_err_ratelimited(ope->dev, "FE: CCIF violation (status=
=3D0x%08x)\n", status);
> > +}
> > +
> > +static bool ope_we_irq(struct ope_dev *ope, struct ope_ctx *ctx)
> > +{
> > +     bool reset =3D false;
> > +     u32 status;
> > +
> > +     status =3D ope_read_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0);
> > +     ope_write_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_CLEAR_0, status);
> > +     ope_write_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_CMD, OPE_BUS_WR_INPUT_I=
F_IRQ_CMD_CLEAR);
> > +
> > +     if (!ctx)
> > +             return false;
> > +
> > +     if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_CONS_VIOL) {
> > +             u32 viol =3D ope_read_wr(ope, OPE_BUS_WR_VIOLATION_STATUS=
);
> > +
> > +             dev_err_ratelimited(ope->dev, "constraint violation (clie=
nts=3D0x%x)\n", viol);
> > +             reset =3D true;
> > +     }
> > +
> > +     if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_IMG_SZ_VIOL) {
> > +             u32 viol =3D ope_read_wr(ope, OPE_BUS_WR_IMAGE_SIZE_VIOLA=
TION_STATUS);
> > +
> > +             for (int i =3D 0; i < OPE_WR_CLIENT_MAX; i++) {
> > +                     if (BIT(i) & viol)
> > +                             dev_err_ratelimited(ope->dev, "WE%d: imag=
e size violation\n", i);
> > +             }
> > +             reset =3D true;
> > +     }
> > +
> > +     if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_VIOL) {
> > +             u32 viol =3D ope_read_wr(ope, OPE_BUS_WR_VIOLATION_STATUS=
);
> > +
> > +             dev_err_ratelimited(ope->dev, "fatal violation (status=3D=
0x%08x)\n", viol);
> > +             reset =3D true;
> > +     }
> > +
> > +     if (reset) {
> > +             ope_write(ctx->ope, OPE_TOP_RESET_CMD, OPE_TOP_RESET_CMD_=
SW);
> > +             return true;
> > +     }
> > +
> > +     if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_RUP_DONE) {
> > +             /* Register update done: program next stripe (double-buff=
ered) */
> > +             struct ope_stripe *stripe =3D ope_current_stripe(ctx);
> > +
> > +             if (stripe && !ope_stripe_is_last(stripe))
> > +                     ope_prog_stripe(ctx, stripe + 1);
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +
> > +static void __ope_irq_init(struct ope_dev *ope)
> > +{
> > +     ope_write(ope, OPE_TOP_IRQ_MASK,
> > +               OPE_TOP_IRQ_STATUS_RST_DONE |
> > +               OPE_TOP_IRQ_STATUS_WE |
> > +               OPE_TOP_IRQ_STATUS_FE |
> > +               OPE_TOP_IRQ_STATUS_VIOL |
> > +               OPE_TOP_IRQ_STATUS_IDLE);
> > +     ope_write_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_MASK_0,
> > +                  OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_RUP_DONE |
> > +                  OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_CONS_VIOL |
> > +                  OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_VIOL |
> > +                  OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_IMG_SZ_VIOL);
> > +     /* The fetch engine only needs to report bus errors */
> > +     writel_relaxed(OPE_BUS_RD_INPUT_IF_IRQ_STATUS_CCIF_VIOL,
> > +                    ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_MASK);
> > +}
> > +
> > +static irqreturn_t ope_irq(int irq, void *dev_id)
> > +{
> > +     struct ope_dev *ope =3D dev_id;
> > +     struct ope_ctx *ctx;
> > +     u32 status;
> > +
> > +     /*
> > +      * hw_ctx is safe to read here without a lock: ope_run_job() sets=
 it
> > +      * before calling ope_start(), so the hardware cannot raise an IR=
Q
> > +      * before hw_ctx is visible. ope_job_finish() clears it in IRQ co=
ntext
> > +      * here, so the clear is serialised with this read by the IRQ its=
elf.
> > +      */
> > +     ctx =3D ope->hw_ctx;
> > +
> > +     status =3D ope_read(ope, OPE_TOP_IRQ_STATUS);
>
> if (!status)
>         return IRQ_NONE;
>
> > +     ope_write(ope, OPE_TOP_IRQ_CLEAR, status);
> > +     ope_write(ope, OPE_TOP_IRQ_CMD, OPE_TOP_IRQ_CMD_CLEAR);
> > +
> > +     if (status & OPE_TOP_IRQ_STATUS_RST_DONE) {
> > +             dev_dbg(ope->dev, "reset done ctx=3D%p\n", ctx);
> > +             ope_glut_cache_invalidate(ope);
> > +             if (ctx)
> > +                     ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
> > +
> > +             complete(&ope->reset_complete);
> > +
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     if (status & OPE_TOP_IRQ_STATUS_VIOL)
> > +             dev_warn(ope->dev, "OPE violation: 0x%08x\n",
> > +                      ope_read(ope, OPE_TOP_VIOLATION_STATUS));
> > +
> > +     if (status & OPE_TOP_IRQ_STATUS_FE)
> > +             ope_fe_irq(ope);
> > +
> > +     if (status & OPE_TOP_IRQ_STATUS_WE) {
> > +             if (ope_we_irq(ope, ctx))
> > +                     return IRQ_HANDLED;
> > +     }
> > +
> > +     if ((status & OPE_TOP_IRQ_STATUS_IDLE) && ctx) {
> > +             struct ope_stripe *stripe =3D ope_current_stripe(ctx);
> > +
> > +             dev_dbg(ope->dev, "stripe %u done ctx=3D%p\n", ctx->curre=
nt_stripe, ctx);
> > +
> > +             if (unlikely(!stripe)) {
> > +                     dev_err(ope->dev, "stripe index %u out of range\n=
", ctx->current_stripe);
> > +                     ctx->current_stripe =3D 0;
> > +                     ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
> > +             } else if (ope_stripe_is_last(stripe)) {
> > +                     ctx->current_stripe =3D 0;
> > +                     ope_job_finish(ctx, VB2_BUF_STATE_DONE);
> > +             } else {
> > +                     ctx->current_stripe++;
> > +                     ope_start(ope);
> > +             }
> > +     }
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/* -------- vb2 queue private data -------- */
> > +
> > +struct ope_vq_priv {
> > +     struct ope_ctx          *ctx;
> > +     unsigned int            queue_idx;
> > +     struct video_device     *vdev;
> > +};
> > +
> > +static inline struct ope_ctx *ope_ctx_from_vq(struct vb2_queue *q)
> > +{
> > +     return ((struct ope_vq_priv *)vb2_get_drv_priv(q))->ctx;
> > +}
> > +
> > +static inline unsigned int ope_idx_from_vq(struct vb2_queue *q)
> > +{
> > +     return ((struct ope_vq_priv *)vb2_get_drv_priv(q))->queue_idx;
> > +}
> > +
> > +static inline struct video_device *ope_vdev_from_vq(struct vb2_queue *=
q)
> > +{
> > +     return ((struct ope_vq_priv *)vb2_get_drv_priv(q))->vdev;
> > +}
> > +
> > +/* -------- vb2 ops -------- */
> > +
> > +static int ope_queue_setup(struct vb2_queue *q, unsigned int *nbuffers=
,
> > +                        unsigned int *nplanes, unsigned int sizes[],
> > +                        struct device *alloc_devs[])
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_vq(q);
> > +     unsigned int idx =3D ope_idx_from_vq(q);
> > +     unsigned int size;
> > +
> > +     if (idx =3D=3D OPE_QUEUE_FRAME_IN)
> > +             size =3D ctx->fmt_in.sizeimage ? ctx->fmt_in.sizeimage : =
PAGE_SIZE;
> > +     else if (idx =3D=3D OPE_QUEUE_DISP_OUT)
> > +             size =3D ctx->fmt_out.sizeimage ? ctx->fmt_out.sizeimage =
: PAGE_SIZE;
> > +     else
> > +             size =3D v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOA=
D);
> > +
> > +     if (*nplanes) {
> > +             if (*nplanes !=3D 1 || sizes[0] < size)
> > +                     return -EINVAL;
> > +     } else {
> > +             *nplanes =3D 1;
> > +             sizes[0] =3D size;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_buf_prepare(struct vb2_buffer *vb)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_vq(vb->vb2_queue);
> > +     unsigned int idx =3D ope_idx_from_vq(vb->vb2_queue);
> > +     struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > +     unsigned int sizeimage;
> > +
> > +     if (idx =3D=3D OPE_QUEUE_FRAME_IN)
> > +             sizeimage =3D ctx->fmt_in.sizeimage;
> > +     else if (idx =3D=3D OPE_QUEUE_DISP_OUT)
> > +             sizeimage =3D ctx->fmt_out.sizeimage;
> > +     else
> > +             sizeimage =3D v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_P=
AYLOAD);
> > +
> > +     if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type)) {
> > +             if (vb->vb2_queue->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT=
_MPLANE) {
> > +                     if (vbuf->field =3D=3D V4L2_FIELD_ANY)
> > +                             vbuf->field =3D V4L2_FIELD_NONE;
> > +                     if (vbuf->field !=3D V4L2_FIELD_NONE)
> > +                             return -EINVAL;
> > +             }
> > +     }
> > +
> > +     if (vb2_plane_size(vb, 0) < sizeimage)
> > +             return -EINVAL;
> > +
> > +     if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type))
> > +             vb2_set_plane_payload(vb, 0, sizeimage);
> > +
> > +     return 0;
> > +}
> > +
> > +static void ope_buf_queue(struct vb2_buffer *vb)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_vq(vb->vb2_queue);
> > +     unsigned int idx =3D ope_idx_from_vq(vb->vb2_queue);
> > +     struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > +     struct ope_queue *q =3D &ctx->queues[idx];
> > +     struct camss_isp_buf *buf =3D container_of(vbuf, struct camss_isp=
_buf, vb);
> > +
> > +     guard(spinlock_irqsave)(&q->rdy_spinlock);
> > +     list_add_tail(&buf->list, &q->rdy_queue);
> > +
> > +     ope_try_schedule(ctx);
> > +}
> > +
> > +/* -------- Power scaling -------- */
> > +
> > +static inline unsigned long ope_pixclk(const struct ope_fmt_state *fs,=
 unsigned int fps)
> > +{
> > +     return (unsigned long)fs->width * fs->height * fps;
> > +}
> > +
> > +static inline unsigned int ope_load_avg(const struct ope_fmt_state *fs=
, unsigned int fps)
> > +{
> > +     return mult_frac(ope_pixclk(fs, fps), fs->fmt->depth, 1000) / 8;
> > +}
> > +
> > +static inline unsigned int ope_load_peak(const struct ope_fmt_state *f=
s, unsigned int fps)
> > +{
> > +     return ope_load_avg(fs, fps) * 2;
> > +}
> > +
> > +static inline unsigned int ope_load_config(const struct ope_fmt_state =
*fs, unsigned int fps)
> > +{
> > +     unsigned int stripe_count =3D fs->width / OPE_STRIPE_MAX_W + 1;
> > +
> > +     /* In worst case we have ~50 32-bit registers to write */
> > +     return mult_frac(stripe_count * 50 * 4, fps, 1000);
> > +}
> > +
> > +static void ope_adjust_power(struct ope_dev *ope)
> > +{
> > +     unsigned int loadavg =3D 0, loadpeak =3D 0, loadconfig =3D 0;
> > +     unsigned long pixclk =3D 0;
> > +     struct dev_pm_opp *opp;
> > +     struct ope_ctx *ctx;
> > +     int ret;
> > +
> > +     if (unlikely(!ope_hw_available(ope)))
> > +             return;
> > +
> > +     scoped_guard(spinlock, &ope->ctx_lock) {
> > +             list_for_each_entry(ctx, &ope->ctx_list, list) {
> > +                     unsigned int fps;
> > +
> > +                     if (!ctx->started)
> > +                             continue;
> > +
> > +                     fps =3D ctx->framerate ? ctx->framerate : DEFAULT=
_FRAMERATE;
> > +
> > +                     pixclk     +=3D ope_pixclk(&ctx->fmt_in, fps);
> > +                     loadavg    +=3D ope_load_avg(&ctx->fmt_in,  fps);
> > +                     loadavg    +=3D ope_load_avg(&ctx->fmt_out, fps);
> > +                     loadpeak   +=3D ope_load_peak(&ctx->fmt_in,  fps)=
;
> > +                     loadpeak   +=3D ope_load_peak(&ctx->fmt_out, fps)=
;
> > +                     loadconfig +=3D ope_load_config(&ctx->fmt_in, fps=
);
> > +             }
> > +     }
> > +
> > +     /* 30% margin for overhead */
> > +     pixclk =3D mult_frac(pixclk, 13, 10);
> > +
> > +     dev_dbg(ope->dev, "adjust power: clk=3D%luHz avg=3D%uKBps peak=3D=
%uKBps cfg=3D%uKBps\n",
> > +             pixclk, loadavg, loadpeak, loadconfig);
> > +
> > +     opp =3D dev_pm_opp_find_freq_ceil(ope->dev, &pixclk);
> > +     if (IS_ERR(opp))
> > +             dev_warn(ope->dev, "Requested pixel clock %luHz exceeds h=
ardware limit\n", pixclk);
> > +     else
> > +             dev_pm_opp_put(opp);
> > +
> > +     ret =3D dev_pm_opp_set_rate(ope->dev, pixclk);
> > +     if (ret)
> > +             dev_warn(ope->dev, "Failed to set OPP rate: %d\n", ret);
> > +
> > +     ret =3D icc_set_bw(ope->icc_data, loadavg, loadpeak);
> > +     if (ret)
> > +             dev_warn(ope->dev, "Failed to set data path BW: %d\n", re=
t);
> > +
> > +     ret =3D icc_set_bw(ope->icc_config, loadconfig, loadconfig * 5);
> > +     if (ret)
> > +             dev_warn(ope->dev, "Failed to set config path BW: %d\n", =
ret);
> > +}
> > +
> > +static int ope_start_streaming(struct vb2_queue *q, unsigned int count=
)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_vq(q);
> > +     struct video_device *vdev =3D ope_vdev_from_vq(q);
> > +     unsigned int idx =3D ope_idx_from_vq(q);
> > +     int ret;
> > +
> > +     dev_dbg(ctx->ope->dev, "streaming start ctx=3D%p queue=3D%u\n", c=
tx, idx);
> > +
> > +     if (!ope_hw_available(ctx->ope)) {
> > +             ret =3D -ENODEV;
> > +             goto err_drain;
> > +     }
> > +
> > +     ret =3D video_device_pipeline_alloc_start(vdev);
> > +     if (ret)
> > +             goto err_drain;
> > +
> > +     ret =3D pm_runtime_resume_and_get(ctx->ope->dev);
> > +     if (ret) {
> > +             dev_err(ctx->ope->dev, "resume failed (%d)\n", ret);
> > +             goto err_pipeline_stop;
> > +     }
> > +
> > +     if (idx =3D=3D OPE_QUEUE_FRAME_IN) {
> > +             ctx->fmt_in.sequence =3D 0;
> > +             ctx->started =3D true;
> > +             ctx->first_start =3D true;
> > +             ope_adjust_power(ctx->ope);
> > +             __ope_irq_init(ctx->ope);
> > +     }
> > +
> > +     ope_try_schedule(ctx);
> > +
> > +     return 0;
> > +
> > +err_pipeline_stop:
> > +     video_device_pipeline_stop(vdev);
> > +err_drain:
> > +     ope_queue_drain(ctx, idx, VB2_BUF_STATE_QUEUED);
> > +     return ret;
> > +}
> > +
> > +static void ope_stop_streaming(struct vb2_queue *q)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_vq(q);
> > +     struct video_device *vdev =3D ope_vdev_from_vq(q);
> > +     unsigned int idx =3D ope_idx_from_vq(q);
> > +
> > +     dev_dbg(ctx->ope->dev, "streaming stop ctx=3D%p queue=3D%u\n", ct=
x, idx);
> > +
> > +     if (idx =3D=3D OPE_QUEUE_FRAME_IN) {
> > +             ctx->started =3D false;
> > +             ope_adjust_power(ctx->ope);
> > +     }
> > +
> > +     /* Drain with the scheduler held off, so no job can pick up a buf=
fer */
> > +     ope_sched_cancel(ctx);
> > +     ope_queue_drain(ctx, idx, VB2_BUF_STATE_ERROR);
> > +     ope_sched_resume(ctx);
>
> ope->hw_ctx =3D NULL;
> ope->curr_ctx =3D NULL;
> ctx->queued =3D false;
> ope->prev_ctx =3D NULL; ?
>
> > +
> > +     pm_runtime_put(ctx->ope->dev);
> > +
> > +     if (ope_hw_available(ctx->ope))
> > +             video_device_pipeline_stop(vdev);
> > +}
> > +
> > +static const struct vb2_ops ope_vb2_ops =3D {
> > +     .queue_setup     =3D ope_queue_setup,
> > +     .buf_prepare     =3D ope_buf_prepare,
> > +     .buf_queue       =3D ope_buf_queue,
> > +     .start_streaming =3D ope_start_streaming,
> > +     .stop_streaming  =3D ope_stop_streaming,
> > +};
> > +
> > +static const unsigned int ope_queue_to_entity[] =3D {
> > +     [OPE_QUEUE_FRAME_IN] =3D OPE_ENTITY_FRAME_IN,
> > +     [OPE_QUEUE_DISP_OUT] =3D OPE_ENTITY_DISP_OUT,
> > +     [OPE_QUEUE_PARAMS]   =3D OPE_ENTITY_PARAMS,
> > +};
> > +
> > +static int ope_init_vq(struct ope_ctx *ctx, unsigned int idx)
> > +{
> > +     struct ope_dev *ope =3D ctx->ope;
> > +     struct ope_vq_priv *qpriv;
> > +     struct vb2_queue *q =3D &ctx->queues[idx].vq;
> > +     int ret;
> > +
> > +     qpriv =3D kzalloc_obj(*qpriv);
> > +     if (!qpriv)
> > +             return -ENOMEM;
> > +
> > +     qpriv->ctx =3D ctx;
> > +     qpriv->queue_idx =3D idx;
> > +     qpriv->vdev =3D camss_isp_pipeline_get_vdev(ope->pipeline, ope_qu=
eue_to_entity[idx]);
> > +     q->drv_priv =3D qpriv;
> > +     q->ops =3D &ope_vb2_ops;
> > +     q->lock =3D &ctx->vbq_lock;
> > +     q->dev =3D ope->dev;
> > +     q->buf_struct_size    =3D sizeof(struct camss_isp_buf);
> > +     q->timestamp_flags    =3D V4L2_BUF_FLAG_TIMESTAMP_COPY;
> > +     q->min_queued_buffers =3D (idx =3D=3D OPE_QUEUE_PARAMS) ? 0 : 1;
> > +
> > +     if (idx =3D=3D OPE_QUEUE_PARAMS) {
> > +             q->type =3D V4L2_BUF_TYPE_META_OUTPUT;
> > +             q->mem_ops =3D &vb2_vmalloc_memops;
> > +             q->io_modes =3D VB2_MMAP | VB2_USERPTR;
> > +     } else if (idx =3D=3D OPE_QUEUE_DISP_OUT) {
> > +             q->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> > +             q->mem_ops =3D &vb2_dma_contig_memops;
> > +             q->io_modes =3D VB2_MMAP | VB2_DMABUF;
> > +     } else {
> > +             q->type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> > +             q->mem_ops =3D &vb2_dma_contig_memops;
> > +             q->io_modes =3D VB2_MMAP | VB2_DMABUF;
> > +     }
> > +
> > +     ret =3D vb2_queue_init(q);
> > +     if (ret) {
> > +             q->drv_priv =3D NULL;
> > +             kfree(qpriv);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/* -------- Format helpers -------- */
> > +
> > +static const struct ope_fmt *ope_find_fmt(const struct ope_fmt *fmts,
> > +                               unsigned int n, u32 fourcc)
> > +{
> > +     for (unsigned int i =3D 0; i < n; i++)
> > +             if (fmts[i].fourcc =3D=3D fourcc)
> > +                     return &fmts[i];
> > +
> > +     return NULL;
> > +}
> > +
> > +static const struct ope_fmt *ope_fmt_try(struct ope_dev *ope, bool is_=
output,
> > +                                      struct v4l2_pix_format_mplane *p=
ix)
> > +{
> > +     const struct ope_fmt *fmts =3D is_output ? ope_output_fmts : ope_=
input_fmts;
> > +     unsigned int n =3D is_output ? ARRAY_SIZE(ope_output_fmts) : ARRA=
Y_SIZE(ope_input_fmts);
> > +     unsigned int max_w =3D OPE_MAX_W, max_h =3D OPE_MAX_H;
> > +     const struct ope_fmt *fmt;
> > +     unsigned int bytesperline;
> > +     unsigned int align;
> > +
> > +     fmt =3D ope_find_fmt(fmts, n, pix->pixelformat);
> > +     if (!fmt) {
> > +             fmt =3D &fmts[0];
> > +             pix->pixelformat =3D fmt->fourcc;
> > +     }
> > +
> > +     v4l_bound_align_image(&pix->width,  OPE_MIN_W, max_w, fmt->align,
> > +                           &pix->height, OPE_MIN_H, max_h, 0, 0);
> > +
> > +     pix->num_planes =3D 1;
> > +     pix->field =3D V4L2_FIELD_NONE;
> > +     if (!pix->colorspace)
> > +             pix->colorspace =3D is_output ? V4L2_COLORSPACE_SRGB : V4=
L2_COLORSPACE_RAW;
> > +     if (is_output) {
> > +             pix->ycbcr_enc =3D V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colors=
pace);
> > +             pix->quantization =3D V4L2_QUANTIZATION_FULL_RANGE;
> > +     }
> > +
> > +     /*
> > +      * Output formats are semi-planar or grey-scale (Y plane only) al=
ways
> > +      * using 1 byte per Y value. pix->bytesperline stores the Y-plane=
 bpl.
> > +      * Depth tracks the total storage size including the second combi=
ned
> > +      * Cb + Cr plane which directly follows the Y plane and is used f=
or
> > +      * sizeimage calculations rather then for bytesperline.
> > +      */
> > +     if (is_output)
> > +             bytesperline =3D pix->width;
> > +     else
> > +             bytesperline =3D pix->width * fmt->depth / 8;
> > +
> > +     if (pix->plane_fmt[0].bytesperline > bytesperline)
> > +             bytesperline =3D pix->plane_fmt[0].bytesperline;
> > +
> > +     /*
> > +      * The WE requires the C plane base address to be 16-byte aligned=
.
> > +      * c_base =3D bpl * img_h + (compose_top / c_vsub) * c_stride whe=
re
> > +      * c_stride =3D bpl * 2 / c_hsub.  To guarantee alignment for any
> > +      * compose_top, bpl must be a multiple of 16 / c_hsub:
> > +      *   NV12/NV16 (c_hsub=3D2): bpl must be multiple of 8... but c_s=
tride=3Dbpl
> > +      *   so we need bpl % 16 =3D=3D 0.
> > +      *   NV24/NV42 (c_hsub=3D1): c_stride=3Dbpl*2, need bpl*2 % 16 =
=3D=3D 0,
> > +      *   so bpl must be a multiple of 8.
> > +      *   GREY: no C plane, no constraint.
> > +      */
> > +     if (is_output && fmt->fourcc !=3D V4L2_PIX_FMT_GREY)
> > +             align =3D 8 * fmt->c_hsub;
> > +     else
> > +             align =3D 1;
> > +
> > +     bytesperline =3D min(bytesperline, ALIGN_DOWN(OPE_MAX_STRIDE, ali=
gn));
> > +     bytesperline =3D ALIGN(bytesperline, align);
> > +
> > +     pix->plane_fmt[0].bytesperline =3D bytesperline;
> > +
> > +     if (is_output)
> > +             pix->plane_fmt[0].sizeimage =3D (u64)bytesperline * pix->=
height * fmt->depth / 8;
> > +     else
> > +             pix->plane_fmt[0].sizeimage =3D (u64)bytesperline * pix->=
height;
> > +
> > +     return fmt;
> > +}
> > +
> > +/* -------- ioctl helpers/ops -------- */
> > +
> > +static inline unsigned int ope_queue_idx_from_file(struct file *file)
> > +{
> > +     return (unsigned int)(uintptr_t)video_get_drvdata(video_devdata(f=
ile));
> > +}
> > +
> > +static struct vb2_queue *ope_vq_from_file(struct file *file, struct op=
e_ctx *ctx)
> > +{
> > +     unsigned int idx =3D ope_queue_idx_from_file(file);
> > +
> > +     if (idx >=3D OPE_QUEUE_COUNT)
> > +             return NULL;
> > +
> > +     return &ctx->queues[idx].vq;
> > +}
> > +
> > +static struct ope_ctx *ope_ctx_from_file(struct file *file)
> > +{
> > +     struct ope_dev *ope =3D container_of(video_devdata(file)->v4l2_de=
v,
> > +                                        struct ope_dev, v4l2_dev);
>
> lockdep_assert_held(ope->mutex);
>
> > +     return ope->shared_ctx;
> > +}
> > +
> > +static int ope_querycap(struct file *file, void *priv, struct v4l2_cap=
ability *cap)
> > +{
> > +     strscpy(cap->driver, OPE_NAME, sizeof(cap->driver));
> > +     strscpy(cap->card, "Qualcomm CAMSS OPE", sizeof(cap->card));
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_enum_fmt_vid_out(struct file *file, void *priv, struct =
v4l2_fmtdesc *f)
> > +{
> > +     unsigned int i, n =3D 0;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ope_input_fmts); i++) {
> > +             if (f->mbus_code && ope_input_fmts[i].mbus_code !=3D f->m=
bus_code)
> > +                     continue;
> > +             if (n++ =3D=3D f->index) {
> > +                     f->pixelformat =3D ope_input_fmts[i].fourcc;
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int ope_g_fmt_vid_out(struct file *file, void *priv, struct v4l=
2_format *f)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct ope_fmt_state *fs =3D &ctx->fmt_in;
> > +     struct v4l2_pix_format_mplane *pix =3D &f->fmt.pix_mp;
> > +
> > +     pix->pixelformat                =3D fs->fmt->fourcc;
> > +     pix->width                      =3D fs->width;
> > +     pix->height                     =3D fs->height;
> > +     pix->num_planes                 =3D 1;
> > +     pix->field                      =3D V4L2_FIELD_NONE;
> > +     pix->colorspace                 =3D fs->colorspace;
> > +     pix->xfer_func                  =3D fs->xfer_func;
> > +     pix->ycbcr_enc                  =3D fs->ycbcr_enc;
> > +     pix->quantization               =3D fs->quantization;
> > +     pix->plane_fmt[0].bytesperline  =3D fs->bytesperline;
> > +     pix->plane_fmt[0].sizeimage     =3D fs->sizeimage;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_try_fmt_vid_out(struct file *file, void *priv, struct v=
4l2_format *f)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +
> > +     ope_fmt_try(ctx->ope, false, &f->fmt.pix_mp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_s_fmt_vid_out(struct file *file, void *priv, struct v4l=
2_format *f)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     const struct ope_fmt *fmt;
> > +
> > +     if (vb2_is_busy(&ctx->queues[OPE_QUEUE_FRAME_IN].vq))
> > +             return -EBUSY;
> > +
> > +     fmt =3D ope_fmt_try(ctx->ope, false, &f->fmt.pix_mp);
> > +     ctx->fmt_in.fmt             =3D fmt;
> > +     ctx->fmt_in.width           =3D f->fmt.pix_mp.width;
> > +     ctx->fmt_in.height          =3D f->fmt.pix_mp.height;
> > +     ctx->fmt_in.bytesperline    =3D f->fmt.pix_mp.plane_fmt[0].bytesp=
erline;
> > +     ctx->fmt_in.sizeimage       =3D f->fmt.pix_mp.plane_fmt[0].sizeim=
age;
> > +     ctx->fmt_in.colorspace      =3D f->fmt.pix_mp.colorspace;
> > +     ctx->fmt_in.xfer_func       =3D f->fmt.pix_mp.xfer_func;
> > +     ctx->fmt_in.ycbcr_enc       =3D f->fmt.pix_mp.ycbcr_enc;
> > +     ctx->fmt_in.quantization    =3D f->fmt.pix_mp.quantization;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_enum_fmt_vid_cap(struct file *file, void *priv, struct =
v4l2_fmtdesc *f)
> > +{
> > +     unsigned int i, n =3D 0;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(ope_output_fmts); i++) {
> > +             if (f->mbus_code && ope_output_fmts[i].mbus_code !=3D f->=
mbus_code)
> > +                     continue;
> > +             if (n++ =3D=3D f->index) {
> > +                     f->pixelformat =3D ope_output_fmts[i].fourcc;
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int ope_g_fmt_vid_cap(struct file *file, void *priv, struct v4l=
2_format *f)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct ope_fmt_state *fs =3D &ctx->fmt_out;
> > +     struct v4l2_pix_format_mplane *pix =3D &f->fmt.pix_mp;
> > +
> > +     pix->pixelformat                =3D fs->fmt->fourcc;
> > +     pix->width                      =3D fs->width;
> > +     pix->height                     =3D fs->height;
> > +     pix->num_planes                 =3D 1;
> > +     pix->field                      =3D V4L2_FIELD_NONE;
> > +     pix->colorspace                 =3D fs->colorspace;
> > +     pix->xfer_func                  =3D fs->xfer_func;
> > +     pix->ycbcr_enc                  =3D fs->ycbcr_enc;
> > +     pix->quantization               =3D fs->quantization;
> > +     pix->plane_fmt[0].bytesperline  =3D fs->bytesperline;
> > +     pix->plane_fmt[0].sizeimage     =3D fs->sizeimage;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_try_fmt_vid_cap(struct file *file, void *priv, struct v=
4l2_format *f)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +
> > +     ope_fmt_try(ctx->ope, true, &f->fmt.pix_mp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_s_fmt_vid_cap(struct file *file, void *priv, struct v4l=
2_format *f)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     const struct ope_fmt *fmt;
> > +
> > +     if (vb2_is_busy(&ctx->queues[OPE_QUEUE_DISP_OUT].vq))
> > +             return -EBUSY;
> > +
> > +     fmt =3D ope_fmt_try(ctx->ope, true, &f->fmt.pix_mp);
> > +
> > +     ctx->fmt_out.fmt            =3D fmt;
> > +     ctx->fmt_out.width          =3D f->fmt.pix_mp.width;
> > +     ctx->fmt_out.height         =3D f->fmt.pix_mp.height;
> > +     ctx->fmt_out.bytesperline   =3D f->fmt.pix_mp.plane_fmt[0].bytesp=
erline;
> > +     ctx->fmt_out.sizeimage      =3D f->fmt.pix_mp.plane_fmt[0].sizeim=
age;
> > +     ctx->fmt_out.colorspace     =3D f->fmt.pix_mp.colorspace;
> > +     ctx->fmt_out.xfer_func      =3D f->fmt.pix_mp.xfer_func;
> > +     ctx->fmt_out.ycbcr_enc      =3D f->fmt.pix_mp.ycbcr_enc;
> > +     ctx->fmt_out.quantization   =3D f->fmt.pix_mp.quantization;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_g_fmt_meta(struct file *file, void *priv, struct v4l2_f=
ormat *f)
> > +{
> > +     f->fmt.meta.dataformat =3D V4L2_META_FMT_QCOM_ISP_PARAMS;
> > +     f->fmt.meta.buffersize =3D v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_=
MAX_PAYLOAD);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_enum_fmt_meta_out(struct file *file, void *priv, struct=
 v4l2_fmtdesc *f)
> > +{
> > +     if (f->index > 0)
> > +             return -EINVAL;
> > +
> > +     f->pixelformat =3D V4L2_META_FMT_QCOM_ISP_PARAMS;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_g_parm(struct file *file, void *priv, struct v4l2_strea=
mparm *sp)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +
> > +     if (!V4L2_TYPE_IS_OUTPUT(sp->type))
> > +             return -EINVAL;
> > +
> > +     sp->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
> > +     sp->parm.output.timeperframe =3D ctx->fmt_in.timeperframe;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_s_parm(struct file *file, void *priv, struct v4l2_strea=
mparm *sp)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct v4l2_fract *tpf =3D &sp->parm.output.timeperframe;
> > +
> > +     if (!V4L2_TYPE_IS_OUTPUT(sp->type))
> > +             return -EINVAL;
> > +
> > +     if (vb2_is_busy(&ctx->queues[OPE_QUEUE_FRAME_IN].vq))
> > +             return -EBUSY;
> > +
> > +     if (!tpf->denominator)
> > +             tpf->denominator =3D 1;
> > +     if (!tpf->numerator)
> > +             tpf->numerator =3D 1;
> > +
> > +     ctx->framerate =3D clamp(tpf->denominator / tpf->numerator, 1U, (=
u32)OPE_MAX_FRAMERATE);
> > +     tpf->numerator =3D 1;
> > +     tpf->denominator =3D ctx->framerate;
> > +
> > +     ctx->fmt_in.timeperframe =3D *tpf;
> > +     sp->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
> > +
> > +     ope_adjust_power(ctx->ope);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_enum_framesizes(struct file *file, void *priv, struct v=
4l2_frmsizeenum *fsize)
> > +{
> > +     unsigned int idx =3D ope_queue_idx_from_file(file);
> > +     const struct ope_fmt *fmts;
> > +     unsigned int n;
> > +
> > +     if (idx =3D=3D OPE_QUEUE_FRAME_IN) {
> > +             fmts =3D ope_input_fmts;
> > +             n =3D ARRAY_SIZE(ope_input_fmts);
> > +     } else {
> > +             fmts =3D ope_output_fmts;
> > +             n =3D ARRAY_SIZE(ope_output_fmts);
> > +     }
> > +
> > +     if (fsize->index > 0 || !ope_find_fmt(fmts, n, fsize->pixel_forma=
t))
> > +             return -EINVAL;
> > +
> > +     fsize->type =3D V4L2_FRMSIZE_TYPE_STEPWISE;
> > +     fsize->stepwise.min_width =3D OPE_MIN_W;
> > +     fsize->stepwise.max_width =3D OPE_MAX_W;
> > +     fsize->stepwise.step_width =3D 1;
> > +     fsize->stepwise.min_height =3D OPE_MIN_H;
> > +     fsize->stepwise.max_height =3D OPE_MAX_H;
> > +     fsize->stepwise.step_height =3D 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_reqbufs(struct file *file, void *priv, struct v4l2_requ=
estbuffers *rb)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +     int ret;
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +
> > +     ret =3D vb2_reqbufs(vq, rb);
> > +     if (!ret)
> > +             vq->owner =3D rb->count ? file->private_data : NULL;
> > +
> > +     return ret;
> > +}
> > +
> > +static int ope_querybuf(struct file *file, void *priv, struct v4l2_buf=
fer *buf)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     return vq ? vb2_querybuf(vq, buf) : -EINVAL;
> > +}
> > +
> > +static int ope_qbuf(struct file *file, void *priv, struct v4l2_buffer =
*buf)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct video_device *vdev =3D video_devdata(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +
> > +     return vb2_qbuf(vq, vdev->v4l2_dev->mdev, buf);
> > +}
> > +
> > +static int ope_dqbuf(struct file *file, void *priv, struct v4l2_buffer=
 *buf)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     return vq ? vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK) : -EIN=
VAL;
> > +}
> > +
> > +static int ope_prepare_buf(struct file *file, void *priv, struct v4l2_=
buffer *buf)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct video_device *vdev =3D video_devdata(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +
> > +     return vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
> > +}
> > +
> > +static int ope_create_bufs(struct file *file, void *priv, struct v4l2_=
create_buffers *create)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +     int ret;
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +     ret =3D vb2_create_bufs(vq, create);
> > +     if (!ret && create->count)
> > +             vq->owner =3D file->private_data;
> > +
> > +     return ret;
> > +}
> > +
> > +static int ope_expbuf(struct file *file, void *priv, struct v4l2_expor=
tbuffer *eb)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +
> > +     return vb2_expbuf(vq, eb);
> > +}
> > +
> > +static int ope_streamon(struct file *file, void *priv, enum v4l2_buf_t=
ype type)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +
> > +     return vb2_streamon(vq, type);
> > +}
> > +
> > +static int ope_streamoff(struct file *file, void *priv, enum v4l2_buf_=
type type)
> > +{
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct vb2_queue *vq =3D ope_vq_from_file(file, ctx);
> > +
> > +     if (!vq)
> > +             return -EINVAL;
> > +
> > +     if (vb2_queue_is_busy(vq, file))
> > +             return -EBUSY;
> > +
> > +     return vb2_streamoff(vq, type);
> > +}
> > +
> > +/* -------- proc subdev ops -------- */
> > +
> > +static const struct v4l2_rect ope_sd_min_rect =3D {
> > +     .width =3D OPE_MIN_W,
> > +     .height =3D OPE_MIN_H,
> > +};
> > +
> > +static void ope_sd_adjust_crop_rect(struct v4l2_rect *crop, const stru=
ct v4l2_rect *bounds)
> > +{
> > +     v4l2_rect_set_min_size(crop, &ope_sd_min_rect);
> > +     v4l2_rect_map_inside(crop, bounds);
> > +}
> > +
> > +static void ope_sd_adjust_crop(struct v4l2_rect *crop, const struct v4=
l2_mbus_framefmt *bounds)
> > +{
> > +     struct v4l2_rect crop_bounds =3D {
> > +             .left =3D 0, .top =3D 0,
> > +             .width =3D bounds->width, .height =3D bounds->height,
> > +     };
> > +
> > +     ope_sd_adjust_crop_rect(crop, &crop_bounds);
> > +}
> > +
> > +static void ope_proc_set_src_fmt(struct v4l2_subdev_state *state,
> > +                      struct v4l2_mbus_framefmt *format)
> > +{
> > +     struct v4l2_mbus_framefmt *src_fmt;
> > +     const struct v4l2_rect *compose;
> > +
> > +     src_fmt =3D v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SOUR=
CE);
> > +     compose =3D v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOU=
RCE);
> > +
> > +     src_fmt->code =3D MEDIA_BUS_FMT_YUYV8_1_5X8;
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(ope_output_fmts); i++) =
{
> > +             if (ope_output_fmts[i].mbus_code =3D=3D format->code) {
> > +                     src_fmt->code =3D format->code;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     src_fmt->width      =3D compose->width;
> > +     src_fmt->height     =3D compose->height;
> > +     src_fmt->field      =3D V4L2_FIELD_NONE;
> > +     src_fmt->colorspace =3D V4L2_COLORSPACE_SRGB;
> > +     *format =3D *src_fmt;
> > +}
> > +
> > +static void ope_proc_set_src_compose(struct v4l2_subdev_state *state, =
struct v4l2_rect *r)
> > +{
> > +     struct v4l2_rect *compose =3D v4l2_subdev_state_get_compose(state=
, OPE_PROC_PAD_SOURCE);
> > +     struct v4l2_rect bounds;
> > +
> > +     const struct v4l2_rect *sink_crop =3D
> > +             v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
> > +
> > +     bounds =3D (struct v4l2_rect){ 0, 0, sink_crop->width, sink_crop-=
>height };
> > +     *compose =3D *r;
> > +     ope_sd_adjust_crop_rect(compose, &bounds);
> > +     *r =3D *compose;
> > +
> > +     /* Propagate to out format */
> > +     ope_proc_set_src_fmt(state, v4l2_subdev_state_get_format(state, O=
PE_PROC_PAD_SOURCE));
> > +}
> > +
> > +static void ope_proc_set_sink_crop(struct v4l2_subdev_state *state, st=
ruct v4l2_rect *r)
> > +{
> > +     struct v4l2_rect *crop;
> > +
> > +     crop =3D v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
> > +
> > +     *crop =3D *r;
> > +     ope_sd_adjust_crop(crop, v4l2_subdev_state_get_format(state, OPE_=
PROC_PAD_SINK_IN));
> > +     *r =3D *crop;
> > +
> > +     /* Propagate to out format */
> > +     ope_proc_set_src_compose(state, v4l2_subdev_state_get_compose(sta=
te, OPE_PROC_PAD_SOURCE));
> > +}
> > +
> > +static void ope_proc_set_sink_fmt(struct v4l2_subdev_state *state,
> > +                               struct v4l2_mbus_framefmt *format)
> > +{
> > +     struct v4l2_mbus_framefmt *sink_fmt;
> > +     struct v4l2_rect *crop;
> > +
> > +     sink_fmt =3D v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SIN=
K_IN);
> > +     crop =3D v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
> > +
> > +     sink_fmt->code =3D ope_input_fmts[0].mbus_code;
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(ope_input_fmts); i++) {
> > +             if (ope_input_fmts[i].mbus_code =3D=3D format->code) {
> > +                     sink_fmt->code =3D format->code;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     sink_fmt->width =3D clamp(format->width,  (u32)OPE_MIN_W, (u32)OP=
E_MAX_W);
> > +     sink_fmt->height =3D clamp(format->height, (u32)OPE_MIN_H, (u32)O=
PE_MAX_H);
> > +     sink_fmt->field =3D V4L2_FIELD_NONE;
> > +     sink_fmt->colorspace =3D V4L2_COLORSPACE_RAW;
> > +     *format =3D *sink_fmt;
> > +
> > +     /* Propagate to in crop */
> > +     ope_proc_set_sink_crop(state, crop);
> > +}
> > +
> > +static int ope_proc_init_state(struct v4l2_subdev *sd,
> > +                            struct v4l2_subdev_state *state)
> > +{
> > +     struct v4l2_mbus_framefmt fmt =3D {
> > +             .width  =3D OPE_MIN_W,
> > +             .height =3D OPE_MIN_H,
> > +             .code   =3D MEDIA_BUS_FMT_SRGGB8_1X8,
> > +     };
> > +
> > +     /* Params sink: fixed format, width carries the payload size in b=
ytes */
> > +     *v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SINK_PAR) =3D
> > +             (struct v4l2_mbus_framefmt){
> > +                     .code       =3D MEDIA_BUS_FMT_FIXED,
> > +                     .width      =3D v4l2_isp_buffer_size(CAMSS_PARAMS=
_OPE_MAX_PAYLOAD),
> > +                     .height     =3D 1,
> > +                     .field      =3D V4L2_FIELD_NONE,
> > +                     .colorspace =3D V4L2_COLORSPACE_DEFAULT,
> > +             };
> > +
> > +     /* Initialise source compose default before cascade */
> > +     *v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOURCE) =3D
> > +             (struct v4l2_rect){ 0, 0, OPE_MIN_W, OPE_MIN_H };
> > +     v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SOURCE)->code =
=3D
> > +             MEDIA_BUS_FMT_YUYV8_1_5X8;
> > +
> > +     /* Drive the full cascade from sink-in fmt */
> > +     ope_proc_set_sink_fmt(state, &fmt);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_proc_set_fmt(struct v4l2_subdev *sd,
> > +                         struct v4l2_subdev_state *state,
> > +                         struct v4l2_subdev_format *fmt)
> > +{
> > +     if (fmt->pad =3D=3D OPE_PROC_PAD_SINK_PAR)
> > +             return v4l2_subdev_get_fmt(sd, state, fmt);
> > +
> > +     if (fmt->pad =3D=3D OPE_PROC_PAD_SINK_IN) {
> > +             ope_proc_set_sink_fmt(state, &fmt->format);
> > +             return 0;
> > +     }
> > +
> > +     ope_proc_set_src_fmt(state, &fmt->format);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_proc_enum_mbus_code(struct v4l2_subdev *sd,
> > +                                struct v4l2_subdev_state *state,
> > +                                struct v4l2_subdev_mbus_code_enum *cod=
e)
> > +{
> > +     const struct ope_fmt *fmts;
> > +     unsigned int nfmts;
> > +     unsigned int n =3D 0;
> > +
> > +     if (code->pad =3D=3D OPE_PROC_PAD_SINK_PAR) {
> > +             if (code->index)
> > +                     return -EINVAL;
> > +             code->code =3D MEDIA_BUS_FMT_FIXED;
> > +             return 0;
> > +     }
> > +
> > +     if (code->pad =3D=3D OPE_PROC_PAD_SOURCE) {
> > +             fmts  =3D ope_output_fmts;
> > +             nfmts =3D ARRAY_SIZE(ope_output_fmts);
> > +     } else {
> > +             fmts  =3D ope_input_fmts;
> > +             nfmts =3D ARRAY_SIZE(ope_input_fmts);
> > +     }
> > +
> > +     for (unsigned int i =3D 0; i < nfmts; i++) {
> > +             u32 mc =3D fmts[i].mbus_code;
> > +             bool seen =3D false;
> > +
> > +             for (unsigned int j =3D 0; j < i; j++) {
> > +                     if (fmts[j].mbus_code =3D=3D mc) {
> > +                             seen =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +             if (!seen && n++ =3D=3D code->index) {
> > +                     code->code =3D mc;
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int ope_proc_get_selection(struct v4l2_subdev *sd,
> > +                               struct v4l2_subdev_state *state,
> > +                               struct v4l2_subdev_selection *sel)
> > +{
> > +     if (sel->pad =3D=3D OPE_PROC_PAD_SINK_IN) {
> > +             const struct v4l2_mbus_framefmt *sink_fmt =3D
> > +                     v4l2_subdev_state_get_format(state, OPE_PROC_PAD_=
SINK_IN);
> > +
> > +             switch (sel->target) {
> > +             case V4L2_SEL_TGT_CROP:
> > +                     sel->r =3D *v4l2_subdev_state_get_crop(state, OPE=
_PROC_PAD_SINK_IN);
> > +                     return 0;
> > +             case V4L2_SEL_TGT_CROP_DEFAULT:
> > +             case V4L2_SEL_TGT_CROP_BOUNDS:
> > +                     sel->r =3D (struct v4l2_rect){ 0, 0, sink_fmt->wi=
dth, sink_fmt->height };
> > +                     return 0;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     if (sel->pad =3D=3D OPE_PROC_PAD_SOURCE) {
> > +             const struct v4l2_rect *crop =3D
> > +                     v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SI=
NK_IN);
> > +
> > +             switch (sel->target) {
> > +             case V4L2_SEL_TGT_COMPOSE:
> > +                     sel->r =3D *v4l2_subdev_state_get_compose(state, =
OPE_PROC_PAD_SOURCE);
> > +                     return 0;
> > +             case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> > +             case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> > +                     sel->r =3D *crop;
> > +                     return 0;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int ope_proc_set_selection(struct v4l2_subdev *sd,
> > +                               struct v4l2_subdev_state *state,
> > +                               struct v4l2_subdev_selection *sel)
> > +{
> > +     if (sel->pad =3D=3D OPE_PROC_PAD_SINK_IN) {
> > +             if (sel->target !=3D V4L2_SEL_TGT_CROP)
> > +                     return -EINVAL;
> > +             ope_proc_set_sink_crop(state, &sel->r);
> > +             return 0;
> > +     }
> > +
> > +     if (sel->pad =3D=3D OPE_PROC_PAD_SOURCE) {
> > +             if (sel->target !=3D V4L2_SEL_TGT_COMPOSE)
> > +                     return -EINVAL;
> > +             ope_proc_set_src_compose(state, &sel->r);
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct v4l2_subdev_pad_ops ope_proc_pad_ops =3D {
> > +     .get_fmt        =3D v4l2_subdev_get_fmt,
> > +     .set_fmt        =3D ope_proc_set_fmt,
> > +     .enum_mbus_code =3D ope_proc_enum_mbus_code,
> > +     .get_selection  =3D ope_proc_get_selection,
> > +     .set_selection  =3D ope_proc_set_selection,
> > +};
> > +
> > +static const struct v4l2_subdev_internal_ops ope_proc_internal_ops =3D=
 {
> > +     .init_state =3D ope_proc_init_state,
> > +};
> > +
> > +static const struct v4l2_subdev_ops ope_proc_ops =3D {
> > +     .pad =3D &ope_proc_pad_ops,
> > +};
> > +
> > +/* -------- disp subdev ops -------- */
> > +
> > +static int ope_disp_set_fmt(struct v4l2_subdev *sd,
> > +                         struct v4l2_subdev_state *state,
> > +                         struct v4l2_subdev_format *fmt)
> > +{
> > +     struct v4l2_mbus_framefmt *pad_fmt;
> > +     u32 code =3D fmt->format.code;
> > +
> > +     /* The disp subdev is pass-through: the source pad always mirrors=
 the
> > +      * sink pad, so source format is read-only and derived from the s=
ink.
> > +      */
> > +     if (fmt->pad =3D=3D OPE_DISP_PAD_SOURCE)
> > +             return v4l2_subdev_get_fmt(sd, state, fmt);
> > +
> > +     fmt->format.code =3D MEDIA_BUS_FMT_YUYV8_1_5X8;
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(ope_output_fmts); i++) =
{
> > +             if (ope_output_fmts[i].mbus_code =3D=3D code) {
> > +                     fmt->format.code =3D code;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     v4l_bound_align_image(&fmt->format.width,  OPE_MIN_W, OPE_MAX_W, =
0,
> > +                           &fmt->format.height, OPE_MIN_H, OPE_MAX_H, =
0, 0);
> > +     fmt->format.field      =3D V4L2_FIELD_NONE;
> > +     fmt->format.colorspace =3D V4L2_COLORSPACE_SRGB;
> > +
> > +     pad_fmt  =3D v4l2_subdev_state_get_format(state, fmt->pad);
> > +     *pad_fmt =3D fmt->format;
> > +
> > +     /* Propagate to source */
> > +     *v4l2_subdev_state_get_format(state, OPE_DISP_PAD_SOURCE) =3D fmt=
->format;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_disp_init_state(struct v4l2_subdev *sd,
> > +                            struct v4l2_subdev_state *state)
> > +{
> > +     struct v4l2_mbus_framefmt def =3D {
> > +             .width      =3D OPE_MIN_W,
> > +             .height     =3D OPE_MIN_H,
> > +             .code       =3D MEDIA_BUS_FMT_YUYV8_1_5X8,
> > +             .field      =3D V4L2_FIELD_NONE,
> > +             .colorspace =3D V4L2_COLORSPACE_SRGB,
> > +     };
> > +
> > +     *v4l2_subdev_state_get_format(state, OPE_DISP_PAD_SINK)   =3D def=
;
> > +     *v4l2_subdev_state_get_format(state, OPE_DISP_PAD_SOURCE) =3D def=
;
> > +     return 0;
> > +}
> > +
> > +static const struct v4l2_subdev_pad_ops ope_disp_pad_ops =3D {
> > +     .get_fmt       =3D v4l2_subdev_get_fmt,
> > +     .set_fmt       =3D ope_disp_set_fmt,
> > +     .link_validate =3D v4l2_subdev_link_validate_default,
> > +};
> > +
> > +static const struct media_entity_operations ope_disp_entity_ops =3D {
> > +     .link_validate =3D v4l2_subdev_link_validate,
> > +};
> > +
> > +static const struct v4l2_subdev_internal_ops ope_disp_internal_ops =3D=
 {
> > +     .init_state =3D ope_disp_init_state,
> > +};
> > +
> > +static const struct v4l2_subdev_ops ope_disp_ops =3D {
> > +     .pad =3D &ope_disp_pad_ops,
> > +};
> > +
> > +/* -------- disp-output video ops -------- */
> > +
> > +static int ope_disp_output_link_validate(struct media_link *link)
> > +{
> > +     struct video_device *vdev =3D media_entity_to_video_device(link->=
sink->entity);
> > +     struct v4l2_subdev *sd =3D media_entity_to_v4l2_subdev(link->sour=
ce->entity);
> > +     struct ope_dev *ope =3D container_of(vdev->v4l2_dev, struct ope_d=
ev, v4l2_dev);
>
> lockdep_assert_held(ope->mutex);
>
> > +     struct ope_ctx *ctx =3D ope->shared_ctx;
> > +     struct v4l2_subdev_state *sd_state;
> > +     struct v4l2_subdev_format sd_fmt =3D {
> > +             .which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
> > +             .pad   =3D link->source->index,
> > +     };
> > +     int ret;
> > +
> > +     if (!ctx)
> > +             return 0;
> > +
> > +     sd_state =3D v4l2_subdev_lock_and_get_active_state(sd);
> > +     ret =3D v4l2_subdev_call(sd, pad, get_fmt, sd_state, &sd_fmt);
> > +     v4l2_subdev_unlock_state(sd_state);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ctx->fmt_out.fmt->mbus_code !=3D sd_fmt.format.code) {
> > +             dev_dbg(ctx->ope->dev, "link validate: mbus 0x%04x incomp=
atible with %p4cc\n",
> > +                     sd_fmt.format.code, &ctx->fmt_out.fmt->fourcc);
> > +             return -EPIPE;
> > +     }
> > +
> > +     if (sd_fmt.format.width > ctx->fmt_out.width ||
> > +         sd_fmt.format.height > ctx->fmt_out.height) {
> > +             dev_dbg(ctx->ope->dev,
> > +                     "link validate: compose %ux%u exceeds output buff=
er %ux%u\n",
> > +                     sd_fmt.format.width, sd_fmt.format.height,
> > +                     ctx->fmt_out.width, ctx->fmt_out.height);
> > +             return -EPIPE;
> > +     }
> > +
> > +     /* Check compose rect (including offset) fits within output buffe=
r */
> > +     {
> > +             struct v4l2_subdev *proc_sd =3D
> > +                     camss_isp_pipeline_get_subdev(ctx->ope->pipeline,
> > +                                                   OPE_ENTITY_PROC);
> > +             struct v4l2_subdev_state *proc_state =3D
> > +                     v4l2_subdev_lock_and_get_active_state(proc_sd);
> > +             const struct v4l2_rect *compose =3D
> > +                     v4l2_subdev_state_get_compose(proc_state,
> > +                                                   OPE_PROC_PAD_SOURCE=
);
> > +
> > +             if (compose->left + compose->width  > ctx->fmt_out.width =
||
> > +                 compose->top  + compose->height > ctx->fmt_out.height=
) {
> > +                     dev_dbg(ctx->ope->dev,
> > +                             "link: compose %ux%u+%u+%u overflows outp=
ut buffer %ux%u\n",
> > +                             compose->width, compose->height,
> > +                             compose->left, compose->top,
> > +                             ctx->fmt_out.width, ctx->fmt_out.height);
> > +                     v4l2_subdev_unlock_state(proc_state);
> > +                     return -EPIPE;
> > +             }
> > +             v4l2_subdev_unlock_state(proc_state);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct media_entity_operations ope_disp_output_entity_ops=
 =3D {
> > +     .link_validate =3D ope_disp_output_link_validate,
> > +};
> > +
> > +static int ope_input_link_validate(struct media_link *link)
> > +{
> > +     struct video_device *vdev =3D media_entity_to_video_device(link->=
source->entity);
> > +     struct v4l2_subdev *sd =3D media_entity_to_v4l2_subdev(link->sink=
->entity);
> > +     struct ope_dev *ope =3D container_of(vdev->v4l2_dev, struct ope_d=
ev, v4l2_dev);
>
> lockdep_assert_held(ope->mutex);
>
> > +     struct ope_ctx *ctx =3D ope->shared_ctx;
>
> > +     struct v4l2_subdev_state *sd_state;
> > +     struct v4l2_subdev_format sd_fmt =3D {
> > +             .which =3D V4L2_SUBDEV_FORMAT_ACTIVE,
> > +             .pad   =3D link->sink->index,
> > +     };
> > +     int ret;
> > +
> > +     if (!ctx)
> > +             return 0;
> > +
> > +     sd_state =3D v4l2_subdev_lock_and_get_active_state(sd);
> > +     ret =3D v4l2_subdev_call(sd, pad, get_fmt, sd_state, &sd_fmt);
> > +     v4l2_subdev_unlock_state(sd_state);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (ctx->fmt_in.fmt->mbus_code !=3D sd_fmt.format.code ||
> > +         ctx->fmt_in.width !=3D sd_fmt.format.width ||
> > +         ctx->fmt_in.height !=3D sd_fmt.format.height) {
> > +             dev_dbg(ctx->ope->dev,
> > +                     "link validate: input %dx%d/0x%04x !=3D pad %dx%d=
/0x%04x\n",
> > +                     ctx->fmt_in.width, ctx->fmt_in.height,
> > +                     ctx->fmt_in.fmt->mbus_code,
> > +                     sd_fmt.format.width, sd_fmt.format.height,
> > +                     sd_fmt.format.code);
> > +             return -EPIPE;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct media_entity_operations ope_input_entity_ops =3D {
> > +     .link_validate =3D ope_input_link_validate,
> > +};
> > +
> > +static const struct v4l2_ioctl_ops ope_video_ioctl_ops =3D {
> > +     .vidioc_querycap                =3D ope_querycap,
> > +     .vidioc_enum_fmt_vid_out        =3D ope_enum_fmt_vid_out,
> > +     .vidioc_g_fmt_vid_out_mplane    =3D ope_g_fmt_vid_out,
> > +     .vidioc_try_fmt_vid_out_mplane  =3D ope_try_fmt_vid_out,
> > +     .vidioc_s_fmt_vid_out_mplane    =3D ope_s_fmt_vid_out,
> > +     .vidioc_enum_fmt_vid_cap        =3D ope_enum_fmt_vid_cap,
> > +     .vidioc_g_fmt_vid_cap_mplane    =3D ope_g_fmt_vid_cap,
> > +     .vidioc_try_fmt_vid_cap_mplane  =3D ope_try_fmt_vid_cap,
> > +     .vidioc_s_fmt_vid_cap_mplane    =3D ope_s_fmt_vid_cap,
> > +     .vidioc_enum_framesizes         =3D ope_enum_framesizes,
> > +     .vidioc_g_parm                  =3D ope_g_parm,
> > +     .vidioc_s_parm                  =3D ope_s_parm,
> > +     .vidioc_reqbufs                 =3D ope_reqbufs,
> > +     .vidioc_querybuf                =3D ope_querybuf,
> > +     .vidioc_qbuf                    =3D ope_qbuf,
> > +     .vidioc_dqbuf                   =3D ope_dqbuf,
> > +     .vidioc_prepare_buf             =3D ope_prepare_buf,
> > +     .vidioc_create_bufs             =3D ope_create_bufs,
> > +     .vidioc_expbuf                  =3D ope_expbuf,
> > +     .vidioc_streamon                =3D ope_streamon,
> > +     .vidioc_streamoff               =3D ope_streamoff,
> > +     .vidioc_subscribe_event         =3D v4l2_ctrl_subscribe_event,
> > +     .vidioc_unsubscribe_event       =3D v4l2_event_unsubscribe,
> > +};
> > +
> > +static const struct v4l2_ioctl_ops ope_meta_ioctl_ops =3D {
> > +     .vidioc_querycap                =3D ope_querycap,
> > +     .vidioc_enum_fmt_meta_out       =3D ope_enum_fmt_meta_out,
> > +     .vidioc_g_fmt_meta_out          =3D ope_g_fmt_meta,
> > +     .vidioc_s_fmt_meta_out          =3D ope_g_fmt_meta,
> > +     .vidioc_try_fmt_meta_out        =3D ope_g_fmt_meta,
> > +     .vidioc_reqbufs                 =3D ope_reqbufs,
> > +     .vidioc_querybuf                =3D ope_querybuf,
> > +     .vidioc_qbuf                    =3D ope_qbuf,
> > +     .vidioc_dqbuf                   =3D ope_dqbuf,
> > +     .vidioc_prepare_buf             =3D ope_prepare_buf,
> > +     .vidioc_create_bufs             =3D ope_create_bufs,
> > +     .vidioc_expbuf                  =3D ope_expbuf,
> > +     .vidioc_streamon                =3D ope_streamon,
> > +     .vidioc_streamoff               =3D ope_streamoff,
> > +};
> > +
> > +/* -------- File/Context ops -------- */
> > +
> > +static struct ope_ctx *ope_ctx_create(struct ope_dev *ope)
> > +{
> > +     struct v4l2_pix_format_mplane pix_in =3D { .pixelformat =3D ope_i=
nput_fmts[0].fourcc };
> > +     struct v4l2_pix_format_mplane pix_out =3D { .pixelformat =3D ope_=
output_fmts[0].fourcc };
>
> lockdep_assert_held(ope->mutex);
>
> > +     struct ope_ctx *ctx;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ctx =3D kvzalloc_obj(*ctx);
> > +     if (!ctx)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     ctx->ope =3D ope;
> > +
> > +     mutex_init(&ctx->vbq_lock);
> > +
> > +     ctx->params_buf =3D kvzalloc(v4l2_isp_buffer_size(CAMSS_PARAMS_OP=
E_MAX_PAYLOAD),
> > +                                GFP_KERNEL);
> > +     if (!ctx->params_buf) {
> > +             ret =3D -ENOMEM;
> > +             goto err_destroy_lock;
> > +     }
> > +
> > +     ctx->config =3D ope_default_config;
> > +
> > +     ctx->fmt_in.fmt          =3D ope_fmt_try(ope, false, &pix_in);
> > +     ctx->fmt_in.width        =3D pix_in.width;
> > +     ctx->fmt_in.height       =3D pix_in.height;
> > +     ctx->fmt_in.bytesperline =3D pix_in.plane_fmt[0].bytesperline;
> > +     ctx->fmt_in.sizeimage    =3D pix_in.plane_fmt[0].sizeimage;
> > +     ctx->fmt_in.colorspace   =3D pix_in.colorspace;
> > +     ctx->fmt_in.xfer_func    =3D pix_in.xfer_func;
> > +     ctx->fmt_in.ycbcr_enc    =3D pix_in.ycbcr_enc;
> > +     ctx->fmt_in.quantization =3D pix_in.quantization;
> > +     ctx->fmt_in.timeperframe.numerator =3D 1;
> > +     ctx->fmt_in.timeperframe.denominator =3D DEFAULT_FRAMERATE;
> > +
> > +     ctx->fmt_out.fmt          =3D ope_fmt_try(ope, true, &pix_out);
> > +     ctx->fmt_out.width        =3D pix_out.width;
> > +     ctx->fmt_out.height       =3D pix_out.height;
> > +     ctx->fmt_out.bytesperline =3D pix_out.plane_fmt[0].bytesperline;
> > +     ctx->fmt_out.sizeimage    =3D pix_out.plane_fmt[0].sizeimage;
> > +     ctx->fmt_out.colorspace   =3D pix_out.colorspace;
> > +     ctx->fmt_out.xfer_func    =3D pix_out.xfer_func;
> > +     ctx->fmt_out.ycbcr_enc    =3D pix_out.ycbcr_enc;
> > +     ctx->fmt_out.quantization =3D pix_out.quantization;
> > +
> > +     for (i =3D 0; i < OPE_QUEUE_COUNT; i++) {
> > +             INIT_LIST_HEAD(&ctx->queues[i].rdy_queue);
> > +             spin_lock_init(&ctx->queues[i].rdy_spinlock);
> > +             ret =3D ope_init_vq(ctx, i);
> > +             if (ret)
> > +                     goto err_release_vq;
> > +     }
> > +
> > +     INIT_LIST_HEAD(&ctx->list);
> > +
> > +     scoped_guard(spinlock, &ope->ctx_lock)
> > +             list_add(&ctx->list, &ope->ctx_list);
> > +
> > +     ope->shared_ctx =3D ctx;
>
> > +
> > +     return ctx;
> > +
> > +err_release_vq:
> > +     while (i--) {
> > +             vb2_queue_release(&ctx->queues[i].vq);
> > +             kfree(ctx->queues[i].vq.drv_priv);
> > +     }
> > +     kvfree(ctx->params_buf);
> > +err_destroy_lock:
> > +     mutex_destroy(&ctx->vbq_lock);
> > +     kvfree(ctx);
> > +     return ERR_PTR(ret);
> > +}
> > +
> > +static void ope_ctx_destroy(struct ope_ctx *ctx)
> > +{
> > +     ctx->started =3D false;
> > +
> > +     ope_sched_cancel(ctx);
> > +     for (unsigned int i =3D 0; i < OPE_QUEUE_COUNT; i++) {
> > +             vb2_queue_release(&ctx->queues[i].vq);
> > +             kfree(ctx->queues[i].vq.drv_priv);
> > +     }
> > +     ope_sched_resume(ctx);
>
> ope->hw_ctx =3D NULL;
> ope->curr_ctx =3D NULL;
> ctx->queued =3D false;
> ctx->prev_ctx =3D NULL;
>
> > +
> > +     /* Do not leave the LUT cache pointing at a context about to be f=
reed */
> > +     ope_glut_cache_invalidate(ctx->ope);
> > +
> > +     kvfree(ctx->params_buf);
> > +     mutex_destroy(&ctx->vbq_lock);
> > +     kvfree(ctx);
> > +}
> > +
> > +static int ope_open(struct file *file)
> > +{
> > +     struct video_device *vdev =3D video_devdata(file);
> > +     struct ope_dev *ope =3D container_of(vdev->v4l2_dev, struct ope_d=
ev, v4l2_dev);
> > +     struct v4l2_fh *fh;
> > +     int ret =3D 0;
> > +
> > +     fh =3D kzalloc_obj(*fh);
> > +     if (!fh)
> > +             return -ENOMEM;
> > +
> > +     if (mutex_lock_interruptible(&ope->mutex)) {
> > +             kfree(fh);
> > +             return -ERESTARTSYS;
> > +     }
> > +
> > +     v4l2_fh_init(fh, vdev);
> > +     v4l2_fh_add(fh, file);
> > +
> > +     /*
> > +      * For now, only a single shared context is supported,
> > +      * until media multi-context support is available.
> > +      */
> > +     if (!ope->shared_ctx) {
> > +             struct ope_ctx *ctx =3D ope_ctx_create(ope);
> > +
> > +             if (IS_ERR(ctx)) {
> > +                     ret =3D PTR_ERR(ctx);
> > +                     goto err_fh_del;
> > +             }
> > +     }
> > +
> > +     ope->open_count++;
> > +     mutex_unlock(&ope->mutex);
> > +
> > +     return 0;
> > +
> > +err_fh_del:
> > +     v4l2_fh_del(fh, file);
> > +     v4l2_fh_exit(fh);
> > +     kfree(fh);
> > +     mutex_unlock(&ope->mutex);
>
> This is not in the same order as allocation/lock above.
>
> > +     return ret;
> > +}
> > +
> > +static int ope_release(struct file *file)
> > +{
> > +     struct v4l2_fh *fh =3D file_to_v4l2_fh(file);
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct ope_dev *ope =3D ctx->ope;
> > +
> > +     v4l2_fh_del(fh, file);
> > +     v4l2_fh_exit(fh);
> > +     kfree(fh);
> > +
> > +     scoped_guard(mutex, &ope->mutex) {
> > +             if (--ope->open_count !=3D 0)
> > +                     return 0;
> > +             ope->shared_ctx =3D NULL;
> > +             scoped_guard(spinlock, &ope->ctx_lock)
> > +                     list_del(&ctx->list);
> > +     }
> > +
> > +     ope_ctx_destroy(ctx);
> > +
> > +     return 0;
> > +}
> > +
> > +static __poll_t ope_poll(struct file *file, poll_table *wait)
> > +{
> > +     unsigned int idx =3D ope_queue_idx_from_file(file);
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +     struct v4l2_fh *fh =3D file_to_v4l2_fh(file);
> > +     struct vb2_queue *vq;
> > +     unsigned long flags;
> > +     __poll_t rc =3D 0;
> > +
> > +     if (idx >=3D OPE_QUEUE_COUNT)
> > +             return EPOLLERR;
> > +
> > +     vq =3D &ctx->queues[idx].vq;
> > +
> > +     poll_wait(file, &vq->done_wq, wait);
> > +     poll_wait(file, &fh->wait, wait);
> > +
> > +     spin_lock_irqsave(&vq->done_lock, flags);
> > +     if (!list_empty(&vq->done_list)) {
> > +             if (V4L2_TYPE_IS_OUTPUT(vq->type))
> > +                     rc |=3D EPOLLOUT | EPOLLWRNORM;
> > +             else
> > +                     rc |=3D EPOLLIN | EPOLLRDNORM;
> > +     }
> > +     spin_unlock_irqrestore(&vq->done_lock, flags);
> > +
> > +     if (v4l2_event_pending(fh))
> > +             rc |=3D EPOLLPRI;
> > +
> > +     return rc;
> > +}
> > +
> > +static int ope_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +     unsigned int idx =3D ope_queue_idx_from_file(file);
> > +     struct ope_ctx *ctx =3D ope_ctx_from_file(file);
> > +
> > +     if (idx >=3D OPE_QUEUE_COUNT)
> > +             return -EINVAL;
> > +
> > +     return vb2_mmap(&ctx->queues[idx].vq, vma);
> > +}
> > +
> > +static const struct v4l2_file_operations ope_fops =3D {
> > +     .owner          =3D THIS_MODULE,
> > +     .open           =3D ope_open,
> > +     .release        =3D ope_release,
> > +     .poll           =3D ope_poll,
> > +     .unlocked_ioctl =3D video_ioctl2,
> > +     .mmap           =3D ope_mmap,
> > +};
> > +
> > +/* Pipeline descriptor  */
> > +static const struct camss_isp_entity_desc ope_entity_descs[] =3D {
> > +     [OPE_ENTITY_FRAME_IN] =3D {
> > +             .name      =3D "ope_input",
> > +             .obj_type  =3D MEDIA_ENTITY_TYPE_VIDEO_DEVICE,
> > +             .function  =3D MEDIA_ENT_F_IO_V4L,
> > +             .vdev.caps =3D V4L2_CAP_VIDEO_OUTPUT_MPLANE | V4L2_CAP_ST=
REAMING,
> > +             .vdev.drvdata =3D (void *)(uintptr_t)OPE_QUEUE_FRAME_IN,
> > +             .vdev.fops =3D &ope_fops,
> > +             .vdev.ioctl_ops =3D &ope_video_ioctl_ops,
> > +             .vdev.entity_ops =3D &ope_input_entity_ops,
> > +             .pads =3D (const struct camss_isp_pad_desc[]) {
> > +                     { MEDIA_PAD_FL_SOURCE, OPE_ENTITY_PROC, OPE_PROC_=
PAD_SINK_IN, 0 },
> > +                     { }
> > +             },
> > +     },
> > +     [OPE_ENTITY_DISP_OUT] =3D {
> > +             .name      =3D "ope_disp_output",
> > +             .obj_type  =3D MEDIA_ENTITY_TYPE_VIDEO_DEVICE,
> > +             .function  =3D MEDIA_ENT_F_IO_V4L,
> > +             .vdev.caps =3D V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_S=
TREAMING,
> > +             .vdev.drvdata =3D (void *)(uintptr_t)OPE_QUEUE_DISP_OUT,
> > +             .vdev.fops =3D &ope_fops,
> > +             .vdev.ioctl_ops =3D &ope_video_ioctl_ops,
> > +             .vdev.entity_ops =3D &ope_disp_output_entity_ops,
> > +             .pads =3D (const struct camss_isp_pad_desc[]) {
> > +                     { MEDIA_PAD_FL_SINK, OPE_ENTITY_DISP, OPE_DISP_PA=
D_SOURCE, 0 },
> > +                     { }
> > +             },
> > +     },
> > +     [OPE_ENTITY_PARAMS] =3D {
> > +             .name      =3D "ope_params",
> > +             .obj_type  =3D MEDIA_ENTITY_TYPE_VIDEO_DEVICE,
> > +             .function  =3D MEDIA_ENT_F_IO_V4L,
> > +             .vdev.caps =3D V4L2_CAP_META_OUTPUT | V4L2_CAP_STREAMING,
> > +             .vdev.drvdata =3D (void *)(uintptr_t)OPE_QUEUE_PARAMS,
> > +             .vdev.fops =3D &ope_fops,
> > +             .vdev.ioctl_ops =3D &ope_meta_ioctl_ops,
> > +             .pads =3D (const struct camss_isp_pad_desc[]) {
> > +                     { MEDIA_PAD_FL_SOURCE, OPE_ENTITY_PROC, OPE_PROC_=
PAD_SINK_PAR, 0 },
> > +                     { }
> > +             },
> > +     },
> > +     [OPE_ENTITY_PROC] =3D {
> > +             .name       =3D "ope_proc",
> > +             .obj_type   =3D MEDIA_ENTITY_TYPE_V4L2_SUBDEV,
> > +             .function   =3D MEDIA_ENT_F_PROC_VIDEO_ISP,
> > +             .subdev.ops =3D &ope_proc_ops,
> > +             .subdev.internal_ops =3D &ope_proc_internal_ops,
> > +             .pads =3D (const struct camss_isp_pad_desc[]) {
> > +                     { MEDIA_PAD_FL_SINK,   OPE_ENTITY_FRAME_IN, 0, 0 =
},
> > +                     { MEDIA_PAD_FL_SINK,   OPE_ENTITY_PARAMS, 0, 0 },
> > +                     { MEDIA_PAD_FL_SOURCE, OPE_ENTITY_DISP, OPE_DISP_=
PAD_SINK,
> > +                             MEDIA_LNK_FL_ENABLED },
> > +                     { }
> > +             },
> > +     },
> > +     [OPE_ENTITY_DISP] =3D {
> > +             .name     =3D "ope_disp",
> > +             .obj_type =3D MEDIA_ENTITY_TYPE_V4L2_SUBDEV,
> > +             .function =3D MEDIA_ENT_F_PROC_VIDEO_SCALER,
> > +             .subdev.ops          =3D &ope_disp_ops,
> > +             .subdev.internal_ops =3D &ope_disp_internal_ops,
> > +             .subdev.entity_ops   =3D &ope_disp_entity_ops,
> > +             .pads =3D (const struct camss_isp_pad_desc[]) {
> > +                     { MEDIA_PAD_FL_SINK,   OPE_ENTITY_PROC, OPE_PROC_=
PAD_SOURCE, 0 },
> > +                     { MEDIA_PAD_FL_SOURCE, OPE_ENTITY_DISP_OUT, 0, 0 =
},
> > +                     { }
> > +             },
> > +     },
> > +};
> > +
> > +static void ope_v4l2_dev_release(struct v4l2_device *v4l2_dev)
> > +{
> > +     struct ope_dev *ope =3D container_of(v4l2_dev, struct ope_dev, v4=
l2_dev);
> > +
> > +     /* Reached once the V4L2 core has released every video and subdev=
 node */
> > +     camss_isp_pipeline_free(ope->pipeline);
> > +     media_device_cleanup(&ope->mdev);
> > +     mutex_destroy(&ope->mutex);
> > +     kfree(ope);
> > +}
> > +
> > +static int ope_v4l2_register(struct ope_dev *ope)
> > +{
> > +     int ret;
> > +
> > +     ope->mdev.dev =3D ope->dev;
> > +     strscpy(ope->mdev.model, OPE_NAME, sizeof(ope->mdev.model));
> > +     ope->mdev.hw_revision =3D ope->hw_version;
> > +     media_device_init(&ope->mdev);
> > +     ope->v4l2_dev.mdev =3D &ope->mdev;
> > +     ope->v4l2_dev.release =3D ope_v4l2_dev_release;
> > +
> > +     ret =3D v4l2_device_register(ope->dev, &ope->v4l2_dev);
> > +     if (ret) {
> > +             /* No v4l2_device reference exists yet, so release @ope d=
irectly */
> > +             ope_v4l2_dev_release(&ope->v4l2_dev);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D media_device_register(&ope->mdev);
> > +     if (ret)
> > +             goto err_v4l2;
> > +
> > +     ope->pipeline =3D camss_isp_pipeline_alloc(OPE_ENTITY_COUNT);
> > +     if (IS_ERR(ope->pipeline)) {
> > +             ret =3D PTR_ERR(ope->pipeline);
> > +             ope->pipeline =3D NULL;
> > +             goto err_media;
> > +     }
> > +
> > +     ret =3D camss_isp_pipeline_register(ope->pipeline, &ope->v4l2_dev=
, ope_entity_descs,
> > +                                       ARRAY_SIZE(ope_entity_descs));
> > +     if (ret)
> > +             goto err_media;
> > +
> > +     ope->pipeline->drv_priv =3D ope;
> > +     return 0;
> > +
> > +err_media:
> > +     media_device_unregister(&ope->mdev);
> > +err_v4l2:
> > +     /* Rely on v4l2 dev release callback to free ope/resources */
> > +     v4l2_device_unregister(&ope->v4l2_dev);
> > +     v4l2_device_put(&ope->v4l2_dev);
> > +     return ret;
> > +}
> > +
> > +static void ope_v4l2_unregister(struct ope_dev *ope)
> > +{
> > +     struct ope_ctx *ctx;
> > +
> > +     if (ope->pipeline)
> > +             camss_isp_pipeline_unregister(ope->pipeline);
> > +
> > +     media_device_unregister(&ope->mdev);
> > +
> > +     /* Clears v4l2_dev.dev, after which no new job can reach the hard=
ware */
> > +     v4l2_device_unregister(&ope->v4l2_dev);
> > +
> > +     scoped_guard(spinlock_irqsave, &ope->sched_lock)
> > +             ctx =3D ope->curr_ctx;
>
> Its either ope->mutex that owns this pointer or sched_lock not both.
>
> > +
> > +     /* A job may still be in flight. */
> > +     if (ctx && ope_hw_reset_sync(ope)) {
> > +             dev_err(ope->dev, "reset timeout on unbind\n");
> > +             synchronize_irq(ope->irq);
> > +             ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
> > +     }
>
> You should finish the jobs before unregistering the pipeline not the
> reverse ..
>
> > +
> > +     synchronize_irq(ope->irq);
> > +     cancel_work_sync(&ope->run_work);
> > +
> > +     /* media_device_cleanup() is deferred to ope_v4l2_dev_release() *=
/
> > +}
> > +
> > +static void ope_dump_pipeline(struct ope_dev *ope)
> > +{
> > +     static const struct {
> > +             const char      *name;
> > +             u32             base;
> > +     } blocks[] =3D {
> > +             { "wb_gain",    OPE_PP_WB_GAIN_BASE },
> > +             { "demo",       OPE_PP_DEMO_BASE },
> > +             { "cc",         OPE_PP_CC_BASE },
> > +             { "glut",       OPE_PP_GLUT_BASE },
> > +             { "chroma_enhan", OPE_PP_CHROMA_ENHAN_BASE },
> > +             { "ds_c_pre",   OPE_PP_DOWNSCALE_MN_DS_C_PRE_BASE },
> > +             { "ds_y_disp",  OPE_PP_DOWNSCALE_MN_DS_Y_DISP_BASE },
> > +             { "ds_c_disp",  OPE_PP_DOWNSCALE_MN_DS_C_DISP_BASE },
> > +             { "crop_y_disp", OPE_PP_CROP_RND_CLAMP_Y_DISP_BASE },
> > +             { "crop_c_disp", OPE_PP_CROP_RND_CLAMP_C_DISP_BASE },
> > +     };
> > +
> > +     for (unsigned int i =3D 0; i < ARRAY_SIZE(blocks); i++) {
> > +             u32 version =3D ope_read_pp(ope, OPE_PP_HW_VERSION(blocks=
[i].base));
> > +
> > +             dev_dbg(ope->dev, "pipeline %-13s HW version %u.%u.%u\n",
> > +                     blocks[i].name,
> > +                     OPE_HW_VERSION_GEN(version),
> > +                     OPE_HW_VERSION_REV(version),
> > +                     OPE_HW_VERSION_STEP(version));
> > +     }
> > +}
> > +
> > +static int ope_soft_reset(struct ope_dev *ope)
> > +{
> > +     u32 version;
> > +     int ret;
> > +
> > +     ret =3D pm_runtime_resume_and_get(ope->dev);
> > +     if (ret)
> > +             return dev_err_probe(ope->dev, ret, "resume failed\n");
> > +
> > +     version =3D ope_read(ope, OPE_TOP_HW_VERSION);
> > +     ope->hw_version =3D version;
> > +     dev_dbg(ope->dev, "HW version %u.%u.%u\n",
> > +             OPE_HW_VERSION_GEN(version),
> > +             OPE_HW_VERSION_REV(version),
> > +             OPE_HW_VERSION_STEP(version));
> > +
> > +     ope_dump_pipeline(ope);
> > +
> > +     __ope_irq_init(ope);
> > +
> > +     ret =3D ope_hw_reset_sync(ope);
> > +     if (ret)
> > +             dev_err(ope->dev, "Reset timeout\n");
> > +
> > +     pm_runtime_put_sync(ope->dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static const char * const ope_pds[] =3D { "camss" };
> > +static const char * const ope_opp_pds[] =3D { "cx" };
> > +
> > +static const struct dev_pm_domain_attach_data ope_pd_data =3D {
> > +     .pd_names =3D ope_pds,
> > +     .num_pd_names =3D ARRAY_SIZE(ope_pds),
> > +};
> > +
> > +static const struct dev_pm_domain_attach_data ope_opp_pd_data =3D {
> > +     .pd_names =3D ope_opp_pds,
> > +     .num_pd_names =3D ARRAY_SIZE(ope_opp_pds),
> > +     .pd_flags =3D PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
> > +};
> > +
> > +static int ope_init_power(struct ope_dev *ope)
> > +{
> > +     struct device *dev =3D ope->dev;
> > +     struct dev_pm_domain_list *pmdomains;
> > +     struct dev_pm_domain_list *opp_pmdomains;
> > +     struct clk *axi_clk;
> > +     int ret;
> > +
> > +     ope->icc_data =3D devm_of_icc_get(dev, "data");
> > +     if (IS_ERR(ope->icc_data))
> > +             return dev_err_probe(dev, PTR_ERR(ope->icc_data),
> > +                                  "failed to get interconnect data pat=
h\n");
> > +
> > +     ope->icc_config =3D devm_of_icc_get(dev, "config");
> > +     if (IS_ERR(ope->icc_config))
> > +             return dev_err_probe(dev, PTR_ERR(ope->icc_config),
> > +                                  "failed to get interconnect config p=
ath\n");
> > +
> > +     ret =3D devm_pm_domain_attach_list(dev, &ope_pd_data, &pmdomains)=
;
> > +     if (ret < 0 && ret !=3D -EEXIST)
> > +             return dev_err_probe(dev, ret, "failed to attach power do=
mains\n");
> > +
> > +     ret =3D devm_pm_domain_attach_list(dev, &ope_opp_pd_data, &opp_pm=
domains);
> > +     if (ret < 0 && ret !=3D -EEXIST)
> > +             return dev_err_probe(dev, ret, "failed to attach OPP powe=
r domain\n");
> > +
> > +     axi_clk =3D devm_clk_get_optional(dev, "axi");
> > +     if (IS_ERR(axi_clk))
> > +             return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to ge=
t AXI clock\n");
> > +
> > +     ret =3D clk_set_rate(axi_clk, OPE_AXI_CLK_RATE);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set AXI clock r=
ate\n");
> > +
> > +     ret =3D devm_pm_opp_set_clkname(dev, "core");
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_pm_opp_of_add_table(dev);
> > +     if (ret && ret !=3D -ENODEV)
> > +             return dev_err_probe(dev, ret, "invalid OPP table\n");
> > +
> > +     ret =3D devm_pm_runtime_enable(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_pm_clk_create(dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D of_pm_clk_add_clks(dev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_init_mmio(struct ope_dev *ope)
> > +{
> > +     struct platform_device *pdev =3D to_platform_device(ope->dev);
> > +
> > +     ope->base =3D devm_platform_ioremap_resource_byname(pdev, "top");
> > +     if (IS_ERR(ope->base))
> > +             return PTR_ERR(ope->base);
> > +
> > +     ope->base_rd =3D devm_platform_ioremap_resource_byname(pdev, "bus=
_read");
> > +     if (IS_ERR(ope->base_rd))
> > +             return PTR_ERR(ope->base_rd);
> > +
> > +     ope->base_wr =3D devm_platform_ioremap_resource_byname(pdev, "bus=
_write");
> > +     if (IS_ERR(ope->base_wr))
> > +             return PTR_ERR(ope->base_wr);
> > +
> > +     ope->base_pp =3D devm_platform_ioremap_resource_byname(pdev, "pip=
eline");
> > +     if (IS_ERR(ope->base_pp))
> > +             return PTR_ERR(ope->base_pp);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ope_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct ope_dev *ope;
> > +     int ret, irq;
> > +
> > +     /* OPE lifetime is refcounted through the embedded v4l2_device */
> > +     ope =3D kzalloc_obj(*ope);
> > +     if (!ope)
> > +             return -ENOMEM;
> > +
> > +     ope->dev =3D dev;
> > +     init_completion(&ope->reset_complete);
> > +     mutex_init(&ope->mutex);
> > +     INIT_LIST_HEAD(&ope->ctx_list);
> > +     spin_lock_init(&ope->ctx_lock);
> > +     spin_lock_init(&ope->sched_lock);
> > +     INIT_WORK(&ope->run_work, ope_run_work);
> > +
> > +     ret =3D dma_set_mask(dev, DMA_BIT_MASK(32));
> > +     if (ret) {
> > +             ret =3D dev_err_probe(dev, ret, "Failed to set DMA mask\n=
");
> > +             goto err_free;
> > +     }
> > +
> > +     ret =3D ope_init_power(ope);
> > +     if (ret) {
> > +             ret =3D dev_err_probe(dev, ret, "Power init failed\n");
> > +             goto err_free;
> > +     }
> > +
> > +     ret =3D ope_init_mmio(ope);
> > +     if (ret) {
> > +             ret =3D dev_err_probe(dev, ret, "MMIO init failed\n");
> > +             goto err_free;
> > +     }
> > +
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             ret =3D dev_err_probe(dev, irq, "Unable to get IRQ\n");
> > +             goto err_free;
> > +     }
> > +
> > +     ret =3D devm_request_irq(dev, irq, ope_irq, 0, "camss-ope", ope);
> > +     if (ret < 0) {
> > +             ret =3D dev_err_probe(dev, ret, "Requesting IRQ failed\n"=
);
> > +             goto err_free;
> > +     }
> > +
> > +     ope->irq =3D irq;
> > +
> > +     ret =3D ope_soft_reset(ope);
> > +     if (ret)
> > +             goto err_free;
>
>
> > +
> > +     /* ope ownership is transferred to ope_v4l2_register(), even on f=
ailure */
> > +     ret =3D ope_v4l2_register(ope);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "V4L2 registration failed\=
n");
> > +
> > +     platform_set_drvdata(pdev, ope);
> > +
> > +     return 0;
> > +
> > +err_free:
>
> I believe *ope as passed to opq_irq is racy with your reset here - why
> not just devm_ the ope pointer allocation.
>
> devm_free_irq();
>
> > +     mutex_destroy(&ope->mutex);
> > +     kfree(ope);
> > +     return ret;
> > +}
> > +
> > +static void ope_remove(struct platform_device *pdev)
> > +{
> > +     struct ope_dev *ope =3D platform_get_drvdata(pdev);
> > +
> > +     ope_v4l2_unregister(ope);
> > +     v4l2_device_put(&ope->v4l2_dev);
> > +}
> > +
> > +static const struct of_device_id ope_dt_ids[] =3D {
> > +     { .compatible =3D "qcom,qcm2290-camss-ope" },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, ope_dt_ids);
> > +
> > +static const struct dev_pm_ops ope_pm_ops =3D {
> > +     SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> > +};
> > +
> > +static struct platform_driver ope_driver =3D {
> > +     .probe  =3D ope_probe,
> > +     .remove =3D ope_remove,
> > +     .driver =3D {
> > +             .name           =3D OPE_NAME,
> > +             .of_match_table =3D ope_dt_ids,
> > +             .pm             =3D pm_ptr(&ope_pm_ops),
> > +     },
> > +};
> > +
> > +module_platform_driver(ope_driver);
> > +
> > +MODULE_DESCRIPTION("CAMSS Offline Processing Engine");
> > +MODULE_AUTHOR("Loic Poulain <loic.poulain@oss.qualcomm.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/media/platform/qcom/camss/ope/params.c b/drivers/m=
edia/platform/qcom/camss/ope/params.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..55f9a9002e34818e828ce51=
f5cde25955926018c
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/params.c
> > @@ -0,0 +1,78 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ope/params.c
> > + *
> > + * CAMSS ISP parameter buffer parser.
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <media/videobuf2-core.h>
> > +#include <media/v4l2-isp.h>
> > +
> > +#include "params.h"
> > +
> > +int camss_isp_params_apply(struct device *dev,
> > +                        struct vb2_buffer *vb,
> > +                        struct v4l2_isp_params_buffer *scratch,
> > +                        const struct v4l2_isp_params_block_type_info *=
type_info,
> > +                        const camss_isp_params_handler_fn *handlers,
> > +                        unsigned int num_handlers,
> > +                        void *priv)
> > +{
> > +     const struct v4l2_isp_params_buffer *buf =3D scratch;
> > +     const void *src;
> > +     unsigned int remaining;
> > +     unsigned int offset =3D 0;
> > +     int ret;
> > +
> > +     ret =3D v4l2_isp_params_validate_buffer_size(dev, vb,
> > +                                     v4l2_isp_buffer_size(CAMSS_PARAMS=
_OPE_MAX_PAYLOAD));
> > +     if (ret)
> > +             return ret;
> > +
> > +     src =3D vb2_plane_vaddr(vb, 0);
> > +
> > +     if (!src) {
> > +             dev_dbg(dev, "params: buffer has no kernel mapping\n");
> > +             return -EFAULT;
> > +     }
> > +
> > +     /*
> > +      * The payload lives in a vmalloc'd buffer that userspace keeps m=
apped
> > +      * while the buffer is queued, so it must not be validated in pla=
ce:
> > +      * copy it into kernel-only memory first, then work exclusively o=
n the
> > +      * copy.  See the v4l2_isp_params_validate_buffer() documentation=
.
> > +      */
> > +     memcpy(scratch, src, vb2_get_plane_payload(vb, 0));
> > +
> > +     ret =3D v4l2_isp_params_validate_buffer(dev, vb, buf, type_info, =
num_handlers);
> > +     if (ret)
> > +             return ret;
> > +
> > +     dev_dbg(dev, "params: version=3D%u data_size=3D%u\n", buf->versio=
n, buf->data_size);
> > +
> > +     remaining =3D buf->data_size;
> > +
> > +     while (remaining >=3D sizeof(struct v4l2_isp_params_block_header)=
) {
> > +             const union camss_isp_params_block *block =3D
> > +                     (const union camss_isp_params_block *)&buf->data[=
offset];
> > +             u16 type  =3D block->header.type;
> > +             u32 bsize =3D block->header.size;
>
> You should bounds check this against remaining and as non-zero.
>
> > +
> > +             if (type < num_handlers && handlers[type])
> > +                     handlers[type](priv, block);
> > +             else
> > +                     dev_dbg(dev, "params: no handler for block type %=
u\n", type);
> > +
> > +             offset +=3D bsize;
> > +             remaining -=3D bsize;
> > +     }
> > +
> > +     dev_dbg(dev, "params: buffer parsed successfully\n");
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/media/platform/qcom/camss/ope/params.h b/drivers/m=
edia/platform/qcom/camss/ope/params.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..5bc1984a67b8d31e5c84238=
cf93076158f367032
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/params.h
> > @@ -0,0 +1,95 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * ope/params.h
> > + *
> > + * CAMSS ISP parameter buffer parser.
> > + *
> > + * Wraps the upstream v4l2_isp_params_validate_buffer() validation and=
 adds
> > + * a dispatch layer: after validation each block is forwarded to a
> > + * driver-supplied handler.
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#ifndef CAMSS_PARAMS_H
> > +#define CAMSS_PARAMS_H
> > +
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <media/v4l2-isp.h>
> > +#include <uapi/linux/qcom-camss-config.h>
> > +
> > +#define CAMSS_ISP_PARAMS_FMT_INIT \
> > +     { .fourcc =3D V4L2_META_FMT_QCOM_ISP_PARAMS, .depth =3D 8, .align=
 =3D 0, .num_planes =3D 1 }
> > +
> > +#define CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY   (1U << V4L2_ISP_FL_DRIVER_FL=
AGS(0))
> > +
> > +struct device;
> > +struct vb2_buffer;
> > +struct camss_isp_fmt;
> > +
> > +union camss_isp_params_block {
> > +     struct v4l2_isp_params_block_header header;
> > +     struct camss_params_ope_wb_gain         wb_gain;
> > +     struct camss_params_ope_chroma_enhan   chroma_enhan;
> > +     struct camss_params_ope_color_correct  color_correct;
> > +     struct camss_params_ope_gamma          gamma;
> > +};
> > +
> > +typedef void (*camss_isp_params_handler_fn)(void *priv, const union ca=
mss_isp_params_block *block);
> > +
> > +/**
> > + * camss_isp_params_copy_block - copy one validated block into driver =
state
> > + *
> > + * @dst:   destination block in the driver's shadow configuration
> > + * @block: validated source block
> > + * @size:  size of the destination block
> > + *
> > + * Returns true if the payload was copied, false if only the header wa=
s.
> > + */
> > +static inline bool camss_isp_params_copy_block(void *dst,
> > +                                            const union camss_isp_para=
ms_block *block,
> > +                                            size_t size)
> > +{
> > +     struct v4l2_isp_params_block_header *hdr =3D dst;
> > +     bool header_only =3D block->header.size =3D=3D sizeof(block->head=
er);
> > +
> > +     if (header_only)
> > +             *hdr =3D block->header;
> > +     else
> > +             memcpy(dst, block, size);
> > +
> > +     hdr->flags |=3D CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
> > +
> > +     return !header_only;
> > +}
> > +
> > +/**
> > + * camss_isp_params_apply - validate and dispatch a params buffer
> > + *
> > + * @dev:          device for error logging
> > + * @vb:           the vb2 buffer (used for size validation)
> > + * @scratch:      kernel-only bounce buffer, at least
> > + *                v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD) b=
ytes
> > + * @type_info:    per-block-type validation info, indexed by block typ=
e
> > + * @handlers:     per-block-type handlers, indexed by block type
> > + * @num_handlers: number of entries in @type_info and @handlers
> > + * @priv:         opaque pointer forwarded to each handler
> > + *
> > + * Copies the buffer payload into @scratch, calls
> > + * v4l2_isp_params_validate_buffer_size(), then
> > + * v4l2_isp_params_validate_buffer(), then walks the validated block s=
tream
> > + * dispatching each block to its handler.  Validation and dispatch ope=
rate
> > + * only on @scratch, never on the userspace-visible mapping.
> > + *
> > + * Returns 0 on success, negative errno on validation failure.
> > + */
> > +int camss_isp_params_apply(struct device *dev,
> > +                        struct vb2_buffer *vb,
> > +                        struct v4l2_isp_params_buffer *scratch,
> > +                        const struct v4l2_isp_params_block_type_info *=
type_info,
> > +                        const camss_isp_params_handler_fn *handlers,
> > +                        unsigned int num_handlers,
> > +                        void *priv);
> > +
> > +#endif /* CAMSS_PARAMS_H */
> > diff --git a/drivers/media/platform/qcom/camss/ope/pipeline.c b/drivers=
/media/platform/qcom/camss/ope/pipeline.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..bbb076717ef77718045b6ac=
0008b4dc6ed84673a
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/pipeline.c
> > @@ -0,0 +1,412 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * CAMSS ISP pipeline helper =E2=80=94 declarative MC topology builder
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#include <linux/slab.h>
> > +
> > +#include <media/media-device.h>
> > +#include <media/media-entity.h>
> > +#include <media/v4l2-dev.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-subdev.h>
> > +#include "pipeline.h"
> > +
> > +#if !IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> > +static inline int media_entity_pads_init(struct media_entity *e, u16 n=
,
> > +                                      struct media_pad *p) { return 0;=
 }
> > +static inline void media_entity_remove_links(struct media_entity *e) {=
}
> > +static inline int media_create_pad_link(struct media_entity *src, u16 =
sp,
> > +                                     struct media_entity *sink, u16 dp=
,
> > +                                     u32 flags) { return 0; }
> > +#endif
> > +
> > +/* -------- Internal elpers -------- */
> > +
> > +static enum vfl_devnode_direction isp_caps_to_vfl_dir(u32 caps)
> > +{
> > +     if (caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
> > +             return VFL_DIR_M2M;
> > +     if (caps & (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE =
|
> > +                 V4L2_CAP_META_OUTPUT | V4L2_CAP_VBI_OUTPUT | V4L2_CAP=
_SDR_OUTPUT))
> > +             return VFL_DIR_TX;
> > +     return VFL_DIR_RX;
> > +}
> > +
> > +static unsigned int isp_count_pads(const struct camss_isp_pad_desc *pa=
ds)
> > +{
> > +     unsigned int n =3D 0;
> > +
> > +     if (!pads)
> > +             return 0;
> > +     while (pads[n].flags)
> > +             n++;
> > +     return n;
> > +}
> > +
> > +static struct media_entity *isp_pipeline_media_entity(struct camss_isp=
_pipeline *pipeline,
> > +                                                   unsigned int idx)
> > +{
> > +     struct camss_isp_pipeline_entity *slot =3D &pipeline->entities[id=
x];
> > +
> > +     switch (slot->obj_type) {
> > +     case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
> > +             return &slot->vdev.entity;
> > +     case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
> > +             return &slot->subdev.entity;
> > +     default:
> > +             return &slot->entity;
> > +     }
> > +}
> > +
> > +/* -------- Validation -------- */
> > +
> > +static int isp_pipeline_validate(struct device *dev,
> > +                              const struct camss_isp_entity_desc *desc=
s,
> > +                              unsigned int num_entities)
> > +{
> > +     unsigned int i, pi;
> > +
> > +     for (i =3D 0; i < num_entities; i++) {
> > +             const struct camss_isp_pad_desc *pads =3D descs[i].pads;
> > +             unsigned int num_pads =3D isp_count_pads(pads);
> > +
> > +             for (pi =3D 0; pi < num_pads; pi++) {
> > +                     const struct camss_isp_pad_desc *pad =3D &pads[pi=
];
> > +                     const struct camss_isp_pad_desc *peer_pad;
> > +                     unsigned int peer_num_pads;
> > +                     int peer_ent =3D pad->peer_entity;
> > +
> > +                     if (peer_ent < 0)
> > +                             continue;
> > +
> > +                     if ((unsigned int)peer_ent >=3D num_entities) {
> > +                             dev_err(dev, "entity[%u].p%u: peer_entity=
 %d out of range\n",
> > +                                     i, pi, peer_ent);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     peer_num_pads =3D isp_count_pads(descs[peer_ent].=
pads);
> > +                     if (pad->peer_pad >=3D peer_num_pads) {
> > +                             dev_err(dev, "entity[%u].p%u: peer_pad %u=
 out of range\n",
> > +                                     i, pi, pad->peer_pad);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     peer_pad =3D &descs[peer_ent].pads[pad->peer_pad]=
;
> > +
> > +                     /* Links are SOURCE->SINK; reject SOURCE->SOURCE =
or SINK->SINK */
> > +                     if (((pad->flags & MEDIA_PAD_FL_SOURCE) &&
> > +                          (peer_pad->flags & MEDIA_PAD_FL_SOURCE)) ||
> > +                         ((pad->flags & MEDIA_PAD_FL_SINK) &&
> > +                          (peer_pad->flags & MEDIA_PAD_FL_SINK))) {
> > +                             dev_err(dev, "entity[%u].p%u -> entity[%d=
].p%u: invalid\n",
> > +                                     i, pi, peer_ent, pad->peer_pad);
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     /* A link must be described symmetrically from bo=
th ends */
> > +                     if ((unsigned int)peer_pad->peer_entity !=3D i ||
> > +                         peer_pad->peer_pad !=3D pi) {
> > +                             dev_err(dev, "entity[%u].p%u <-> entity[%=
d].p%u: mismatch\n",
> > +                                     i, pi, peer_ent, pad->peer_pad);
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/* -------- Allocation / Release -------- */
> > +
> > +struct camss_isp_pipeline *camss_isp_pipeline_alloc(unsigned int num_e=
ntities)
> > +{
> > +     struct camss_isp_pipeline *pipeline;
> > +
> > +     pipeline =3D kzalloc(struct_size(pipeline, entities, num_entities=
),
> > +                        GFP_KERNEL);
> > +     if (!pipeline)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     pipeline->num_entities =3D num_entities;
> > +     mutex_init(&pipeline->vdev_lock);
> > +     return pipeline;
> > +}
> > +
> > +void camss_isp_pipeline_free(struct camss_isp_pipeline *pipeline)
> > +{
> > +     unsigned int i;
> > +
> > +     if (!pipeline)
> > +             return;
> > +
> > +     /* Release pads and subdevs state */
> > +     for (i =3D 0; i < pipeline->num_entities; i++) {
> > +             struct camss_isp_pipeline_entity *slot =3D &pipeline->ent=
ities[i];
> > +
> > +             if (slot->obj_type =3D=3D MEDIA_ENTITY_TYPE_V4L2_SUBDEV)
> > +                     v4l2_subdev_cleanup(&slot->subdev);
> > +
> > +             kfree(slot->pads);
> > +             slot->pads =3D NULL;
> > +     }
> > +
> > +     mutex_destroy(&pipeline->vdev_lock);
> > +     kfree(pipeline);
> > +}
> > +
> > +/* -------- Registration -------- */
> > +
> > +void camss_isp_pipeline_unregister(struct camss_isp_pipeline *pipeline=
)
> > +{
> > +     int i;
> > +
> > +     /* Unregister entities in reverse order. */
> > +     for (i =3D (int)pipeline->num_entities - 1; i >=3D 0; i--) {
> > +             struct camss_isp_pipeline_entity *slot =3D &pipeline->ent=
ities[i];
> > +
> > +             if (slot->registered) {
> > +                     switch (slot->obj_type) {
> > +                     case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
> > +                             video_unregister_device(&slot->vdev);
> > +                             break;
> > +                     case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
> > +                             v4l2_device_unregister_subdev(&slot->subd=
ev);
> > +                             break;
> > +                     case MEDIA_ENTITY_TYPE_BASE:
> > +                             media_entity_remove_links(&slot->entity);
> > +                             media_device_unregister_entity(&slot->ent=
ity);
> > +                             slot->entity.name =3D NULL;
> > +                             break;
> > +                     }
> > +
> > +                     slot->registered =3D false;
> > +             }
> > +     }
> > +
> > +     pipeline->v4l2_dev =3D NULL;
> > +}
> > +
> > +static int isp_register_vdev(struct camss_isp_pipeline *pipeline,
> > +                          struct camss_isp_pipeline_entity *slot,
> > +                          const struct camss_isp_entity_desc *desc,
> > +                          struct v4l2_device *v4l2_dev)
> > +{
> > +     struct video_device *vdev =3D &slot->vdev;
> > +     int ret;
> > +
> > +     if (!desc->name || !desc->name[0] || !desc->vdev.fops)
> > +             return -EINVAL;
> > +
> > +     strscpy(vdev->name, desc->name, sizeof(vdev->name));
> > +     vdev->vfl_dir     =3D isp_caps_to_vfl_dir(desc->vdev.caps);
> > +     vdev->v4l2_dev    =3D v4l2_dev;
> > +     vdev->device_caps =3D desc->vdev.caps | V4L2_CAP_IO_MC;
> > +     vdev->release     =3D video_device_release_empty;
> > +     vdev->fops        =3D desc->vdev.fops;
> > +     vdev->lock        =3D &pipeline->vdev_lock;
> > +     if (desc->vdev.ioctl_ops)
> > +             vdev->ioctl_ops =3D desc->vdev.ioctl_ops;
> > +     if (desc->vdev.entity_ops)
> > +             vdev->entity.ops =3D desc->vdev.entity_ops;
> > +
> > +     vdev->entity.obj_type =3D MEDIA_ENTITY_TYPE_VIDEO_DEVICE;
> > +     vdev->entity.function =3D desc->function ? desc->function : MEDIA=
_ENT_F_IO_V4L;
> > +
> > +     ret =3D media_entity_pads_init(&vdev->entity, slot->num_pads, slo=
t->pads);
> > +     if (ret)
> > +             return ret;
> > +
> > +     video_set_drvdata(vdev, desc->vdev.drvdata);
> > +
> > +     ret =3D video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int isp_register_subdev(struct camss_isp_pipeline_entity *slot,
> > +                            const struct camss_isp_entity_desc *desc,
> > +                            struct v4l2_device *v4l2_dev)
> > +{
> > +     struct v4l2_subdev *sd =3D &slot->subdev;
> > +     int ret;
> > +
> > +     if (!desc->name || !desc->name[0] || !desc->subdev.ops)
> > +             return -EINVAL;
> > +
> > +     v4l2_subdev_init(sd, desc->subdev.ops);
> > +     strscpy(sd->name, desc->name, sizeof(sd->name));
> > +     sd->entity.function =3D desc->function ?
> > +                           desc->function : MEDIA_ENT_F_V4L2_SUBDEV_UN=
KNOWN;
> > +     /* Create a /dev/v4l-subdevN node so userspace can query pad form=
ats */
> > +     sd->flags |=3D V4L2_SUBDEV_FL_HAS_DEVNODE;
> > +     if (desc->subdev.internal_ops)
> > +             sd->internal_ops =3D desc->subdev.internal_ops;
> > +     if (desc->subdev.entity_ops)
> > +             sd->entity.ops =3D desc->subdev.entity_ops;
> > +
> > +     ret =3D media_entity_pads_init(&sd->entity, slot->num_pads, slot-=
>pads);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D v4l2_subdev_init_finalize(sd);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D v4l2_device_register_subdev(v4l2_dev, sd);
> > +     if (ret) {
> > +             v4l2_subdev_cleanup(sd);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int isp_register_base_entity(struct camss_isp_pipeline_entity *=
slot,
> > +                                 const struct camss_isp_entity_desc *d=
esc,
> > +                                 struct v4l2_device *v4l2_dev)
> > +{
> > +     struct media_entity *entity =3D &slot->entity;
> > +     int ret;
> > +
> > +     if (!desc->name || !desc->name[0])
> > +             return -EINVAL;
> > +
> > +     entity->obj_type =3D MEDIA_ENTITY_TYPE_BASE;
> > +     entity->name     =3D desc->name;
> > +     entity->function =3D desc->function;
> > +
> > +     ret =3D media_entity_pads_init(entity, slot->num_pads, slot->pads=
);
> > +     if (ret) {
> > +             entity->name =3D NULL;
> > +             return ret;
> > +     }
> > +
> > +     ret =3D media_device_register_entity(v4l2_dev->mdev, entity);
> > +     if (ret) {
> > +             entity->name =3D NULL;
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int isp_alloc_pads(struct camss_isp_pipeline_entity *slot,
> > +                       const struct camss_isp_entity_desc *desc)
> > +{
> > +     unsigned int num_pads =3D isp_count_pads(desc->pads);
> > +     unsigned int i;
> > +
> > +     if (!num_pads)
> > +             goto done;
> > +
> > +     slot->pads =3D kcalloc(num_pads, sizeof(*slot->pads), GFP_KERNEL)=
;
> > +     if (!slot->pads)
> > +             return -ENOMEM;
> > +
> > +     for (i =3D 0; i < num_pads; i++)
> > +             slot->pads[i].flags =3D desc->pads[i].flags;
> > +done:
> > +     slot->num_pads =3D num_pads;
> > +     return 0;
> > +}
> > +
> > +int camss_isp_pipeline_register(struct camss_isp_pipeline *pipeline,
> > +                             struct v4l2_device *v4l2_dev,
> > +                             const struct camss_isp_entity_desc *descs=
,
> > +                             unsigned int num_entities)
> > +{
> > +     unsigned int i, pi;
> > +     int ret;
> > +
> > +     if (WARN_ON(num_entities !=3D pipeline->num_entities))
> > +             return -EINVAL;
> > +
> > +     if (WARN_ON(!v4l2_dev || !v4l2_dev->mdev))
> > +             return -EINVAL;
> > +
> > +     ret =3D isp_pipeline_validate(v4l2_dev->dev, descs, num_entities)=
;
> > +     if (ret)
> > +             return ret;
> > +
> > +     pipeline->v4l2_dev =3D v4l2_dev;
> > +
> > +     /* Register each entity */
> > +     for (i =3D 0; i < num_entities; i++) {
> > +             const struct camss_isp_entity_desc *desc =3D &descs[i];
> > +             struct camss_isp_pipeline_entity *slot =3D &pipeline->ent=
ities[i];
> > +
> > +             slot->obj_type =3D desc->obj_type;
> > +
> > +             ret =3D isp_alloc_pads(slot, desc);
> > +             if (ret)
> > +                     goto err_unregister;
> > +
> > +             switch (desc->obj_type) {
> > +             case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
> > +                     ret =3D isp_register_vdev(pipeline, slot, desc, v=
4l2_dev);
> > +                     break;
> > +             case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
> > +                     ret =3D isp_register_subdev(slot, desc, v4l2_dev)=
;
> > +                     break;
> > +             case MEDIA_ENTITY_TYPE_BASE:
> > +             default:
> > +                     ret =3D isp_register_base_entity(slot, desc, v4l2=
_dev);
> > +                     break;
> > +             }
> > +             if (ret)
> > +                     goto err_unregister;
> > +
> > +             slot->registered =3D true;
> > +     }
> > +
> > +     /* Create links =E2=80=94 only from SOURCE side to avoid duplicat=
es */
> > +     for (i =3D 0; i < num_entities; i++) {
> > +             const struct camss_isp_entity_desc *desc =3D &descs[i];
> > +             unsigned int num_pads =3D isp_count_pads(desc->pads);
> > +
> > +             for (pi =3D 0; pi < num_pads; pi++) {
> > +                     const struct camss_isp_pad_desc *pad =3D &desc->p=
ads[pi];
> > +                     struct media_entity *src_entity, *sink_entity;
> > +                     unsigned int src_pad_idx, sink_pad_idx;
> > +                     u32 lflags;
> > +
> > +                     if (!(pad->flags & MEDIA_PAD_FL_SOURCE))
> > +                             continue;
> > +                     if (pad->peer_entity < 0)
> > +                             continue;
> > +
> > +                     src_entity   =3D isp_pipeline_media_entity(pipeli=
ne, i);
> > +                     sink_entity  =3D isp_pipeline_media_entity(pipeli=
ne,
> > +                                                              (unsigne=
d int)pad->peer_entity);
> > +                     src_pad_idx  =3D pi;
> > +                     sink_pad_idx =3D pad->peer_pad;
> > +
> > +                     lflags =3D pad->link_flags ?
> > +                              pad->link_flags :
> > +                              (MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_E=
NABLED);
> > +
> > +                     ret =3D media_create_pad_link(src_entity,  src_pa=
d_idx,
> > +                                                 sink_entity, sink_pad=
_idx,
> > +                                                 lflags);
> > +                     if (ret)
> > +                             goto err_unregister;
> > +             }
> > +     }
> > +
> > +     /* Create /dev/v4l-subdevN nodes for all registered subdevs */
> > +     ret =3D v4l2_device_register_subdev_nodes(v4l2_dev);
> > +     if (ret)
> > +             goto err_unregister;
> > +
> > +     return 0;
> > +
> > +err_unregister:
> > +     camss_isp_pipeline_unregister(pipeline);
> > +     return ret;
> > +}
> > diff --git a/drivers/media/platform/qcom/camss/ope/pipeline.h b/drivers=
/media/platform/qcom/camss/ope/pipeline.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f7d50734ed61f45e988328d=
e980ac5793f7d38dd
> > --- /dev/null
> > +++ b/drivers/media/platform/qcom/camss/ope/pipeline.h
> > @@ -0,0 +1,239 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * CAMSS ISP pipeline helper =E2=80=94 declarative MC topology builder
> > + *
> > + * Drivers describe their entire media graph =E2=80=94 entities (video=
 devices,
> > + * subdevs, or base entities), their pads, and the links between them =
=E2=80=94
> > + * in a single static descriptor table.  The builder validates the tab=
le,
> > + * allocates and registers all entities, and creates all MC links.
> > + *
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#ifndef _CAMSS_PIPELINE_H
> > +#define _CAMSS_PIPELINE_H
> > +
> > +#include <linux/mutex.h>
> > +#include <media/media-device.h>
> > +#include <media/media-entity.h>
> > +#include <media/v4l2-dev.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-subdev.h>
> > +
> > +/**
> > + * struct camss_isp_pad_desc - descriptor for one pad and its optional=
 link
> > + *
> > + * @flags:       Pad flags: MEDIA_PAD_FL_SINK, MEDIA_PAD_FL_SOURCE,
> > + *               MEDIA_PAD_FL_MUST_CONNECT.  A zero @flags value acts =
as
> > + *               the sentinel that terminates the pad list.
> > + * @peer_entity: Index of the peer entity in the descriptor array, or =
-1
> > + *               if this pad has no link.
> > + * @peer_pad:    Pad index on the peer entity to link to.
> > + * @link_flags:  MC link flags (MEDIA_LNK_FL_*).  Defaults to
> > + *               MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED when ze=
ro.
> > + *
> > + * Links are described from both sides (each endpoint references the o=
ther),
> > + * but the builder only creates each link once =E2=80=94 from the SOUR=
CE side.
> > + */
> > +struct camss_isp_pad_desc {
> > +     u32          flags;
> > +     int          peer_entity;
> > +     unsigned int peer_pad;
> > +     u32          link_flags;
> > +};
> > +
> > +/**
> > + * struct camss_isp_entity_desc - descriptor for one entity in the pip=
eline
> > + *
> > + * @name:      Human-readable entity name (also used as video device n=
ame
> > + *             suffix when @obj_type is MEDIA_ENTITY_TYPE_VIDEO_DEVICE=
).
> > + *             Mandatory and must be non-empty.
> > + * @obj_type:  MEDIA_ENTITY_TYPE_VIDEO_DEVICE, MEDIA_ENTITY_TYPE_V4L2_=
SUBDEV,
> > + *             or MEDIA_ENTITY_TYPE_BASE.
> > + * @function:  MEDIA_ENT_F_* function identifier.
> > + * @pads:      Sentinel-terminated (flags =3D=3D 0) array of pad descr=
iptors.
> > + *
> > + * Fields used only for MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
> > + * @vdev.caps: V4L2_CAP_* device capabilities.
> > + *             The video device direction (VFL_DIR_RX/TX/M2M) is deriv=
ed
> > + *             automatically from @caps by the builder.
> > + * @vdev.drvdata: Opaque pointer set via video_set_drvdata() after reg=
istration.
> > + * @vdev.fops:      File operations (mandatory).
> > + * @vdev.ioctl_ops: ioctl operations (may be NULL).
> > + *
> > + * Fields used only for MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
> > + * @subdev.ops: Subdev operations (mandatory).
> > + * @subdev.internal_ops: Internal subdev operations (may be NULL).
> > + */
> > +struct camss_isp_entity_desc {
> > +     const char                              *name;
> > +     u32                                     obj_type;
> > +     u32                                     function;
> > +     const struct camss_isp_pad_desc         *pads;
> > +
> > +     union {
> > +             /* MEDIA_ENTITY_TYPE_VIDEO_DEVICE */
> > +             struct {
> > +                     u32                                     caps;
> > +                     void                                    *drvdata;
> > +                     const struct v4l2_file_operations       *fops;
> > +                     const struct v4l2_ioctl_ops             *ioctl_op=
s;
> > +                     const struct media_entity_operations    *entity_o=
ps;
> > +             } vdev;
> > +             /* MEDIA_ENTITY_TYPE_V4L2_SUBDEV */
> > +             struct {
> > +                     const struct v4l2_subdev_ops            *ops;
> > +                     const struct v4l2_subdev_internal_ops   *internal=
_ops;
> > +                     const struct media_entity_operations    *entity_o=
ps;
> > +             } subdev;
> > +     };
> > +};
> > +
> > +/**
> > + * struct camss_isp_pipeline_entity - one registered entity slot
> > + *
> > + * Internal to the pipeline; drivers access entities via the accessor =
helpers.
> > + *
> > + * @obj_type: mirrors the descriptor's @obj_type.
> > + * @registered: set once the entity has been successfully registered, =
so that
> > + *              teardown only undoes what actually succeeded.
> > + * @pads:     allocated pad array for this entity.
> > + * @num_pads: number of entries in @pads.
> > + * @vdev:     valid when @obj_type =3D=3D MEDIA_ENTITY_TYPE_VIDEO_DEVI=
CE.
> > + * @subdev:   valid when @obj_type =3D=3D MEDIA_ENTITY_TYPE_V4L2_SUBDE=
V.
> > + * @entity:   valid when @obj_type =3D=3D MEDIA_ENTITY_TYPE_BASE.
> > + */
> > +struct camss_isp_pipeline_entity {
> > +     u32                      obj_type;
> > +     bool                     registered;
> > +     struct media_pad        *pads;
> > +     unsigned int             num_pads;
> > +     union {
> > +             struct video_device  vdev;
> > +             struct v4l2_subdev   subdev;
> > +             struct media_entity  entity;
> > +     };
> > +};
> > +
> > +/**
> > + * struct camss_isp_pipeline - registered ISP pipeline topology
> > + *
> > + * Allocate with camss_isp_pipeline_alloc(), register with
> > + * camss_isp_pipeline_register(), tear down with
> > + * camss_isp_pipeline_unregister(), free with camss_isp_pipeline_free(=
).
> > + *
> > + * @v4l2_dev:     Pointer to the caller-provided V4L2 device.
> > + * @drv_priv:     Driver-private pointer; not touched by the framework=
.
> > + * @vdev_lock:    Pipeline-wide mutex assigned to video_device.lock of=
 every
> > + *                registered video device, so the V4L2 core serialises=
 ioctl2
> > + *                handlers across all of the pipeline's video nodes.
> > + * @num_entities: Number of entries in @entities.
> > + * @entities:     Per-entity state; flexible array.
> > + */
> > +struct camss_isp_pipeline {
> > +     struct v4l2_device      *v4l2_dev;
> > +     void                    *drv_priv;
> > +     struct mutex             vdev_lock;
> > +
> > +     unsigned int             num_entities;
> > +     struct camss_isp_pipeline_entity entities[] __counted_by(num_enti=
ties);
> > +};
> > +
> > +/**
> > + * camss_isp_pipeline_alloc() - allocate a pipeline for @num_entities =
entities
> > + *
> > + * Returns a pointer to the new pipeline or ERR_PTR on failure.
> > + * Free with camss_isp_pipeline_free().
> > + */
> > +struct camss_isp_pipeline *camss_isp_pipeline_alloc(unsigned int num_e=
ntities);
> > +
> > +/**
> > + * camss_isp_pipeline_free() - free a pipeline
> > + * @pipeline: pipeline to free (may be NULL)
> > + */
> > +void camss_isp_pipeline_free(struct camss_isp_pipeline *pipeline);
> > +
> > +/**
> > + * camss_isp_pipeline_register() - validate descriptors and register t=
he graph
> > + * @pipeline:    pipeline (allocated with camss_isp_pipeline_alloc())
> > + * @v4l2_dev:    caller-owned and already-registered V4L2 device; its
> > + *               associated media_device (v4l2_dev->mdev) must also be
> > + *               initialised and registered before this call.
> > + * @descs:       array of @num_entities entity descriptors
> > + * @num_entities: number of entities; must equal pipeline->num_entitie=
s
> > + *
> > + * Validates the descriptor table (link direction consistency, index b=
ounds),
> > + * then registers all entities into the provided v4l2_device / media_d=
evice
> > + * and creates all MC pad links.
> > + *
> > + * Returns 0 on success or a negative error code.
> > + */
> > +int camss_isp_pipeline_register(struct camss_isp_pipeline *pipeline,
> > +                             struct v4l2_device *v4l2_dev,
> > +                             const struct camss_isp_entity_desc *descs=
,
> > +                             unsigned int num_entities);
> > +
> > +/**
> > + * camss_isp_pipeline_unregister() - tear down a registered pipeline
> > + * @pipeline: pipeline to unregister.
> > + */
> > +void camss_isp_pipeline_unregister(struct camss_isp_pipeline *pipeline=
);
> > +
> > +/**
> > + * camss_isp_pipeline_get_vdev() - return the video_device for entity =
@idx
> > + * @pipeline: registered pipeline
> > + * @idx:      entity index (must be MEDIA_ENTITY_TYPE_VIDEO_DEVICE)
> > + *
> > + * Returns NULL if @idx is out of range or the entity is not a video d=
evice.
> > + */
> > +static inline struct video_device *
> > +camss_isp_pipeline_get_vdev(struct camss_isp_pipeline *pipeline,
> > +                         unsigned int idx)
> > +{
> > +     if (WARN_ON(idx >=3D pipeline->num_entities))
> > +             return NULL;
> > +     if (WARN_ON(pipeline->entities[idx].obj_type !=3D
> > +                 MEDIA_ENTITY_TYPE_VIDEO_DEVICE))
> > +             return NULL;
> > +     return &pipeline->entities[idx].vdev;
> > +}
> > +
> > +/**
> > + * camss_isp_pipeline_get_subdev() - return the v4l2_subdev for entity=
 @idx
> > + * @pipeline: registered pipeline
> > + * @idx:      entity index (must be MEDIA_ENTITY_TYPE_V4L2_SUBDEV)
> > + *
> > + * Returns NULL if @idx is out of range or the entity is not a subdev.
> > + */
> > +static inline struct v4l2_subdev *
> > +camss_isp_pipeline_get_subdev(struct camss_isp_pipeline *pipeline,
> > +                           unsigned int idx)
> > +{
> > +     if (WARN_ON(idx >=3D pipeline->num_entities))
> > +             return NULL;
> > +     if (WARN_ON(pipeline->entities[idx].obj_type !=3D
> > +                 MEDIA_ENTITY_TYPE_V4L2_SUBDEV))
> > +             return NULL;
> > +     return &pipeline->entities[idx].subdev;
> > +}
> > +
> > +/**
> > + * camss_isp_pipeline_get_entity() - return the media_entity for entit=
y @idx
> > + * @pipeline: registered pipeline
> > + * @idx:      entity index (must be MEDIA_ENTITY_TYPE_BASE)
> > + *
> > + * Returns NULL if @idx is out of range or the entity is not a base en=
tity.
> > + */
> > +static inline struct media_entity *
> > +camss_isp_pipeline_get_entity(struct camss_isp_pipeline *pipeline,
> > +                           unsigned int idx)
> > +{
> > +     if (WARN_ON(idx >=3D pipeline->num_entities))
> > +             return NULL;
> > +     if (WARN_ON(pipeline->entities[idx].obj_type !=3D
> > +                 MEDIA_ENTITY_TYPE_BASE))
> > +             return NULL;
> > +     return &pipeline->entities[idx].entity;
> > +}
> > +
> > +#endif /* _CAMSS_PIPELINE_H */
> >
>
