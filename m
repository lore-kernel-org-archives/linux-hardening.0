Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793822432;
	b=XcLkESp0arBc2hqgfozGSNDany42fvrpuAVFDY6ujPjFZnoHrmbebmfiWb3f69iO71Cw
	 A7y9J7vCuOWVe25/8DnOBc0Dm01kNC94SgIQpIA26AC62T4xhalUpITNHcltcmGCEHlKS
	 VxDX4VjV8+Rh6Iu+6tpIDYP9rwGY1SQD+QY2eRX83sSVQjEL9Ut2IeVtfqRxb6HvgWR5s
	 PZuMWMOj/jHGwcnpFW2nIL8wgDu9IVTDZ5c3UMMaBNqFY3YjXXWQn0EvV1y/wKUYvI+6+
	 EGfaC6hbCy2H4tA9IWORxUmXsay3IC5PTv8JEnbZWvzhosKD/mN40L+Jr67S75PMQQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822432;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TMnySzlrF1cZN34xVjF7wTP6vo3g2RmbATZOHHltXIo=;
	b=Gnqp46sEq92mW29I69kriwLOrDT2PwgpoufXj1yHRbczps60vdpM3C3R7Bfv2fH5/YDL
	 ImCkocfjypiPkStbbSllrLLINvbXIxUkI6YB4ttP6NUHhTUnSGOo1/BlPLcvhg31JVyho
	 0H/xScKAS5/gpnxpvk8KWwnMX2zWNzFvvw6psXm4gMmFrUqgdtearHI9SpTjJWPq56JWU
	 n26N6KFf55wxF6dVB+0n6vUijVhMyxo0GGeJEFxrCdRtw6KhL2dCxWnwssJlS7UNBT9GJ
	 eWMufHQNh8FuyQu2cm1BY8/v/CwRkWSbVqlVmE6ruwgJmrlyKh5D5iDeybEaEwdNT9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iS6L0nCV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ROR1pZAN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2286079F88
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 20:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2286079F88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iS6L0nCV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ROR1pZAN
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Fiop61292199
	for <linux-hardening@vger.kernel.org>; Wed, 4 Nov 2026 20:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TMnySzlrF1cZN34xVjF7wTP6vo3g2RmbATZOHHltXIo=; b=iS6L0nCVeV1D+aJw
	3qBT1y6cbxTEKXlvzCaWTv0EXABqsQeU8uIJPgQyUTx5G1rjJE5FjpV/6r67W+YJ
	rG8tih0dXx2e8dDa38nx9+6TEkbV1ITN+xIBBhJElVj5rjvz6I5plV2tL0u65qtU
	rFWvV5fBkNENIX7uyj2xUu2FlCOMoT72yUOcAWmNorLtPJm6rIAnJ4TOajEoxjk9
	ztd+hd5HGb8mzWXk4eM0RrUMsBe7Rt/TG+/8ZzhMbVnnJh/tVD8LwHxmi0rq6fS9
	E3iVRCctZNV0gwz9KrCalZWk8LmWqDu6gj80RcgKc4+Q1xO2lNa9jPWK2CwRTlHZ
	78QNsA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163ju5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 20:00:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9440b27c1feso235071085a.2
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 12:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793822429; cv=none;
        d=google.com; s=arc-20260327;
        b=W9/VOfg7sgAG+xsGnX4rdXukgmVbuutL5yWgrUqZOwtXJ2Kw3Mk+6s22hs/B6jcTFX
         ky8MFSZL1a5sZkLBE8GaB7sk+Fb5p5G6IY8POolZYH+vZYb4RtFdHMm9bauGyDrJ+Crp
         tVZajltyV4tP4OnXT9ikLSjvGMGZO56qA+JW2KMKDe8x7Y96upqaTJsvV4R8WpyQh9C3
         j6wF3TAiwSAKUtQUdXVD+4NjnU40J2/Sg/GyilPqZCxkgkoObiqigbQpVjI/sHswjUUL
         432wGnxSYueZobjDtBF1X0xqfMKgp2Q9t+JUKciQ96/k+JNKBJNNoN63r9Y8DEsTeQP/
         dlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMnySzlrF1cZN34xVjF7wTP6vo3g2RmbATZOHHltXIo=;
        fh=EwCFgIW1cKfNEPDtIkvVIoSSzURQGnXEGZlHarRqZaU=;
        b=KCBBjir9zChCxjbYNjr7aTjZJ0elmI3+l0NWeiuAYZ8MUFT0Fz/VBxEAm1PUQopxt7
         YdnHX2ijDCJaNbA4y9Vx+93KoRlaRgUWtl4BfEZh8xJEZCkJUW8EjPcgPtEfoOuWi7p4
         y7yjRbvdVL7U5tmOzsAyMjjFzcShJi/sLCjDqRQHj8VjiW6zDtLEe1jh2ExTfoET8Ckr
         CFw8xFuH79ffZmnYq4SDLmIHGu8jkA3EpU/X9xfVE5k4VX2f+3Rs/0BZGQ/2usIcI+Nc
         6FyPLQuYa386lkGmgBTo2smWrGAEn+hFpXaO33mTAyDI7A2zdpZXMYh37VpWkGy13KgD
         XeFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793822429; x=1794427229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMnySzlrF1cZN34xVjF7wTP6vo3g2RmbATZOHHltXIo=;
        b=ROR1pZAN3U28paNr99llR2FQOu4iWyXYH28N8PHd1zcNMtzt7K7CdjmeacyR1lcO5l
         1k8k/80Sf67i6ChVjrWrsGGlobxshKEf/zWcTBwca0gle0zFqwfB4azVDDZYKaSWwepE
         mRX1/21pRdfhNiboVODgexpPd1yff5JJnbjNr9BE3HGwwfnaqhmzwb+PmGmYm/268qu0
         vwcuCGVopJBdy6mefYturPhFzsQHgkLZihKjsCnf5B/rl9aNzw68pH/PynZazhtsoGgp
         F5dZyctZjIZ0U/6GEnnS4RXMe+G4iOuJ9oDHfLQlq8XRPMoT3vcIX42fABRve1HMyA43
         BZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822429; x=1794427229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMnySzlrF1cZN34xVjF7wTP6vo3g2RmbATZOHHltXIo=;
        b=xQQ0BO9WDv0tCpRMmDcyk8Ud476WvpEzZdzPS5hpm9/pRMnPKPq1KHLhVqpVYeYsC1
         Wqaj1aNrTFs1umkUEDZi9yMM4bVLS2aJyCInogI00z7RV9pToNhvDFbGXyS3wAuW7mVK
         gImh1tj4zv0lQa9KHzvQhJgDuSQlCUf1XFyJLIY1xMFuy0J/7V2XabqblpgGuLuT0LzP
         hXXN4d99OExusSyYMFwKHMuONiFK2qPmslva8Dt18UHMsudwgOUVoaO6Nlqii250TuZZ
         pMprHXJOgmn//uCOH65hNRuZTGDFf+rToOGHXC4bvinvbE7J6ngcRrgaFUE9E7s9bhxh
         836w==
X-Forwarded-Encrypted: i=1; AKwUvByO5aS/AsZMXonFF5y38B5kC5hAAu4PsJjjy4qwWGn0EW7T+SfM1KqFYsbpk6NbNRROsIJjyn7iS2qNJuER3cw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ErASa+KFYYRtNLCchW49dfATddE+2QxG8zscYpLkmyqhFDz9a
	XqA/6obSM7ByzCRhQy+t/xWm93KLFGi/esQOwLVd4MOZPi8O08thF8KMR4uc6yV0+UdTQtFZiIX
	DKERNLl3vASHo/yHmhEk9vxp4jeEsKm4PfOm35fFMeXgE8/ny0n/mE4wGTsL48GvSa7Q6mqadHs
	PWV9yj7u7zvB+8bcsYmAZEtJeUJgCK1d2n0K+snql/LYpMUA==
X-Gm-Gg: AYBFou27oZOvVJTBLH05SdWPRfF/0h3m1iFwCAB5FKCbJBQM/2xtObcpz9h7Q79NZD/
	J6QF9R2N3ilWabrmecCesY54hDjK/EZ8kNHbSBR1t+oHgyNdfwl+EfxEvukgw8xkU0KFArJaT3F
	PArWRjbOoxFbvCTe37kRs9g/mcvSFgn0PIeBpf4oBH4yJBwOXgzfB/abhjk1/py7faHB5VkFmyz
	AWAI75sR8lK0wTKbwMRmlCZROW5dyrqw6FbxL9To120yEmkR2iCh8rt4Yqxyw+Zh2tzeDoao8U=
X-Received: by 2002:a05:620a:472b:b0:93f:1ed3:a9cc with SMTP id af79cd13be357-9442171a086mr2894451385a.17.1793822429053;
        Wed, 04 Nov 2026 12:00:29 -0800 (PST)
X-Received: by 2002:a05:620a:472b:b0:93f:1ed3:a9cc with SMTP id
 af79cd13be357-9442171a086mr2894440885a.17.1793822428459; Wed, 04 Nov 2026
 12:00:28 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
 <20261103-camss-isp-ope-v13-4-c2cbf15a39b1@oss.qualcomm.com> <autlc2AfB8AZfb2H@zed>
In-Reply-To: <autlc2AfB8AZfb2H@zed>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 21:00:16 +0100
X-Gm-Features: AclHuK9N33CIyZcbZ2UGvyj25S6IIKINlhYmXcHoaT0FNmanaG6JsRfW5JzTXZ4
Message-ID: <CAFEp6-1qs-HmxYWcombWxyuPRACg5cQVrJs47rwrP8AL6xDrEQ@mail.gmail.com>
Subject: Re: [PATCH v13 4/9] media: uapi: Add CAMSS ISP configuration definition
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Bryan O'Donoghue" <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zBK8o_frcr-6653lSxz8u61BHAk9QmY8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3OSBTYWx0ZWRfX0Xzhfta88dFx
 rVvbrM5cAnao/KB4yH55Q3DC3P6SVbpuWvZvtFiWSZEg/tE2jdgck7YXGleoYqyDkYuaXCx1XOJ
 KBOeShdv08IrXdnk9/IzpcZiOER3mE4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3OSBTYWx0ZWRfX0s04impQ47vh
 a+5IUojd1aFoMH9x/U/VUTXMhxIEWtBwXi2Tl2dsDCJYVMy8Pi7+bKqqVZe/2PO6caf1FXr0nqu
 A90Du+ZZNpZt7lDsgTmlqJs9XEziX2oUE7IkFPrDPHVgXlOtjVMx+6KuetMQjMyn9Re+LWxZdrn
 XLxX/c0ws/JjSYtqHN8cNo3XEifLP/tk2LWvskPKeK/gnRYIaBoemJ6jM/PwAmcw45484AZRJ05
 UlRjwXmOWdiJ7+3CDWboUSqtJXmKKZ5rXTXyAbdCh7gWyt66XR+VER+cvX9ocFViv4Ky8q0xC7A
 Fx3T1Npp1rywKFS19kHWv8rO2ldeQKnb+CU64QGijAxrJfvyVrGXQlCWlheAc9GRpS37uvnYkuV
 TEVN/AcWsw8rXwhqt/ByZcoaa/PNBdDjS6yDvYq8ZjSQC3dGGevkwYjWP3PqJVAuSUHg4CiRfpq
 9P/IzIrz4/1qq7h3+8w==
X-Proofpoint-GUID: zBK8o_frcr-6653lSxz8u61BHAk9QmY8
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb8ede cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=P1BnusSwAAAA:8 a=EUspDBNiAAAA:8
 a=IEpJfH1-mEoR4trvuzYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040079

Hi Jacopo,

On Wed, Nov 4, 2026 at 6:05=E2=80=AFPM Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Loic
>
> On Tue, Nov 03, 2026 at 09:05:48PM +0100, Loic Poulain wrote:
> > Add the uapi header qcom-camss-config.h defining the ISP parameter
> > structures used by the CAMSS Offline Processing Engine (OPE) driver.
> > This includes structures for white balance, chroma enhancement and
> > color correction configuration.
> >
> > The block type enum is shared across CAMSS ISPs so that userspace only
> > has to deal with a single set of block identifiers.
> >
> > Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> > Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  include/uapi/linux/qcom-camss-config.h | 217 +++++++++++++++++++++++++=
++++++++
> >  1 file changed, 217 insertions(+)
> >
> > diff --git a/include/uapi/linux/qcom-camss-config.h b/include/uapi/linu=
x/qcom-camss-config.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..543c1682f8aed3b07d7085f=
54a24eb632ea190a8
> > --- /dev/null
> > +++ b/include/uapi/linux/qcom-camss-config.h
>
> We have (kind of) recently introduced include/uapi/linux/media
>
> This file should probably be:
> include/uapi/linux/media/qcom/camss-config.h

Thanks for pointing this out. I'll move it according to your suggestion.

Regards,
Loic

>
> > @@ -0,0 +1,217 @@
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
> > + * the @type field of &struct v4l2_isp_block_header.
> > + *
> > + * @CAMSS_PARAMS_WB_GAIN: white balance gains and offsets (CLC_WB),
> > + *   &struct camss_params_wb_gain
> > + * @CAMSS_PARAMS_CHROMA_ENHAN: RGB to YUV colour transfer matrix
> > + *   (CLC_CHROMA_ENHAN), &struct camss_params_chroma_enhan
> > + * @CAMSS_PARAMS_COLOR_CORRECT: colour correction matrix (CLC_CC),
> > + *   &struct camss_params_color_correct
> > + * @CAMSS_PARAMS_GAMMA: per-channel gamma correction curves (CLC_GLUT)=
,
> > + *   &struct camss_params_gamma
> > + */
> > +enum camss_params_block_type {
> > +     CAMSS_PARAMS_WB_GAIN =3D 1,
> > +     CAMSS_PARAMS_CHROMA_ENHAN =3D 2,
> > +     CAMSS_PARAMS_COLOR_CORRECT =3D 3,
> > +     CAMSS_PARAMS_GAMMA =3D 4,
> > +};
> > +
> > +/* Number of entries in each gamma channel LUT. */
> > +#define CAMSS_GAMMA_LUT_SIZE 256
> > +
> > +/**
> > + * struct camss_params_wb_gain - White Balance gains
> > + *
> > + * Implements the CLC_WB pipeline module.  The pipeline applies three
> > + * sequential operations per channel::
> > + *
> > + *   1. Subtract sub-offset (black-level subtraction)
> > + *   2. Multiply by gain    (colour balance)
> > + *   3. Add add-offset      (output pedestal)
> > + *
> > + * Gains are 15uQ10 (15-bit unsigned, 10 fractional bits). Offsets
> > + * are 16-bit unsigned, normalised to full input scale (65535 =3D 1.0)
> > + *
> > + * @header:   block header; @header.type =3D CAMSS_PARAMS_WB_GAIN
> > + * @g_gain:   green channel gain (15uQ10, 1024 =3D 1.0)
> > + * @b_gain:   blue  channel gain (15uQ10, 1024 =3D 1.0)
> > + * @r_gain:   red   channel gain (15uQ10, 1024 =3D 1.0)
> > + * @g_sub:    green sub-offset, subtracted before gain (16u)
> > + * @b_sub:    blue  sub-offset, subtracted before gain (16u)
> > + * @r_sub:    red   sub-offset, subtracted before gain (16u)
> > + * @g_add:    green add-offset, added after gain (16u)
> > + * @b_add:    blue  add-offset, added after gain (16u)
> > + * @r_add:    red   add-offset, added after gain (16u)
> > + * @_pad:     padding for 64-bit alignment, must be zero
> > + */
> > +struct camss_params_wb_gain {
> > +     struct v4l2_isp_block_header header;
> > +     __u16 g_gain;
> > +     __u16 b_gain;
> > +     __u16 r_gain;
> > +     __u16 g_sub;
> > +     __u16 b_sub;
> > +     __u16 r_sub;
> > +     __u16 g_add;
> > +     __u16 b_add;
> > +     __u16 r_add;
> > +     __u16 _pad[3];
> > +} __attribute__((aligned(8)));
> > +
> > +/**
> > + * struct camss_params_chroma_enhan - RGB to YUV colour transfer matri=
x
> > + *
> > + * Implements the CLC_CHROMA_ENHAN pipeline module. All coefficients a=
re
> > + * signed 12-bit fixed-point Q3.8 (range roughly -8.0 to +7.996).
> > + *
> > + * RGB2Y - Luma (Y) coefficients::
> > + *
> > + *   Y =3D v0 * R + v1 * G + v2 * B
> > + *
> > + * RGB2Cb - Chroma (Cb) coefficients::
> > + *
> > + *   Cb =3D a x ((B - G) + b(R - G)) + KCb
> > + *   with:
> > + *     a =3D ap, when (B-G) + b(R-G) > 0; a =3D am, when (B-G) + b(R-G=
) =E2=89=A4 0;
> > + *     b =3D bp when (R-G) > 0; b =3D bm when (R-G) =E2=89=A4 0
> > + *
> > + * RGB2Cr - Chroma (Cr) coefficients::
> > + *
> > + *   Cr =3D c x ((R - G) + d(B - G)) + KCr
> > + *   with:
> > + *     c =3D cp, when (R-G) + d(B-G) > 0; c =3D cm, when (R-G) + d(B-G=
) =E2=89=A4 0
> > + *     d =3D dp when (B-G) > 0; d =3D dm when (B-G) =E2=89=A4 0
> > + *
> > + * @header:   generic block header; @header.type =3D CAMSS_PARAMS_CHRO=
MA_ENHAN
> > + * @luma_v0:  R-to-Y coefficient (12sQ8)
> > + * @luma_v1:  G-to-Y coefficient (12sQ8)
> > + * @luma_v2:  B-to-Y coefficient (12sQ8)
> > + * @luma_k:   Y output offset    (9s,  0 =3D no offset)
> > + * @coeff_ap: Cb positive coefficient (12sQ8)
> > + * @coeff_am: Cb negative coefficient (12sQ8)
> > + * @coeff_bp: Cb positive coefficient (12sQ8)
> > + * @coeff_bm: Cb negative coefficient (12sQ8)
> > + * @coeff_cp: Cr positive coefficient (12sQ8)
> > + * @coeff_cm: Cr negative coefficient (12sQ8)
> > + * @coeff_dp: Cr positive coefficient (12sQ8)
> > + * @coeff_dm: Cr negative coefficient (12sQ8)
> > + * @kcb:      Cb output offset        (11s)
> > + * @kcr:      Cr output offset        (11s)
> > + * @_pad:     padding for 64-bit alignment, must be zero
> > + */
> > +struct camss_params_chroma_enhan {
> > +     struct v4l2_isp_block_header header;
> > +     __s16 luma_v0;
> > +     __s16 luma_v1;
> > +     __s16 luma_v2;
> > +     __s16 luma_k;
> > +     __s16 coeff_ap;
> > +     __s16 coeff_am;
> > +     __s16 coeff_bp;
> > +     __s16 coeff_bm;
> > +     __s16 coeff_cp;
> > +     __s16 coeff_cm;
> > +     __s16 coeff_dp;
> > +     __s16 coeff_dm;
> > +     __s16 kcb;
> > +     __s16 kcr;
> > +     __u16 _pad[2];
> > +} __attribute__((aligned(8)));
> > +
> > +/**
> > + * struct camss_params_color_correct - colour correction matrix
> > + *
> > + * Implements the CLC_CC pipeline module.  The matrix computes::
> > + *
> > + *   Out_ch0 (G) =3D a0*G + b0*B + c0*R + k0
> > + *   Out_ch1 (B) =3D a1*G + b1*B + c1*R + k1
> > + *   Out_ch2 (R) =3D a2*G + b2*B + c2*R + k2
> > + *
> > + * The @qfactor member selects the fixed-point format of all coefficie=
nts::
> > + *
> > + *   0 =3D 12sQ7  (range ~-16.0 .. +15.992)
> > + *   1 =3D 12sQ8  (range  ~-8.0 ..  +7.996)
> > + *   2 =3D 12sQ9  (range  ~-4.0 ..  +3.998)
> > + *   3 =3D 12sQ10 (range  ~-2.0 ..  +1.999)
> > + *
> > + * @header:  block header; @header.type =3D CAMSS_PARAMS_COLOR_CORRECT
> > + * @a:       G-input coefficients per output channel (12s;
> > + *           a[0]=3DOut_G, a[1]=3DOut_B, a[2]=3DOut_R)
> > + * @b:       B-input coefficients (12s)
> > + * @c:       R-input coefficients (12s)
> > + * @k:       per-output-channel offsets (typically 9s effective)
> > + * @qfactor: Q-format selector (2u), see above
> > + * @_pad:    padding for 64-bit alignment, must be zero
> > + */
> > +struct camss_params_color_correct {
> > +     struct v4l2_isp_block_header header;
> > +     __s16 a[3];
> > +     __s16 b[3];
> > +     __s16 c[3];
> > +     __s16 k[3];
> > +     __u16 qfactor;
> > +     __u16 _pad[3];
> > +} __attribute__((aligned(8)));
> > +
> > +/**
> > + * struct camss_params_gamma - per-channel gamma correction curves
> > + *
> > + * Implements the CLC_GLUT pipeline module, applied in the RGB domain.=
  It
> > + * holds one independent lookup table per colour channel. Each table i=
s a
> > + * direct (not segmented) map of input level to output level.
> > + *
> > + * Each table has @CAMSS_GAMMA_LUT_SIZE (256) entries of 16-bit unsign=
ed
> > + * output. The number of significant output bits follows the width of =
the
> > + * engine's internal bus; the upper bits are ignored by the hardware.
> > + *
> > + * The module maps a 12-bit input to an 8-bit output: the top 8 input =
bits
> > + * index the table and the low 4 bits are used to linearly interpolate
> > + * between adjacent entries. Entry i therefore represents the output f=
or
> > + * input level i/255 of full scale.
> > + * Output range: 0x00 =3D black, 0xFF =3D white.
> > + *
> > + * How to fill a curve (same on all three channels for pure luminance
> > + * gamma; different curves per channel additionally shift colour balan=
ce)::
> > + *
> > + *   Identity (pass-through, gamma 1.0):
> > + *     lut[i] =3D i;                                // i =3D 0..255
> > + *
> > + *   Encode with gamma g (e.g. sRGB-like, g =3D 2.2):
> > + *     lut[i] =3D round(pow(i / 255.0, 1.0 / g) * 255.0);
> > + *
> > + * @header:  block header; @header.type =3D CAMSS_PARAMS_GAMMA
> > + * @glut:    green channel gamma curve
> > + * @blut:    blue  channel gamma curve
> > + * @rlut:    red   channel gamma curve
> > + */
> > +struct camss_params_gamma {
> > +     struct v4l2_isp_block_header header;
> > +     __u16 glut[CAMSS_GAMMA_LUT_SIZE];
> > +     __u16 blut[CAMSS_GAMMA_LUT_SIZE];
> > +     __u16 rlut[CAMSS_GAMMA_LUT_SIZE];
> > +} __attribute__((aligned(8)));
> > +
> > +#define CAMSS_PARAMS_OPE_MAX_PAYLOAD         \
> > +     (sizeof(struct camss_params_wb_gain)    +\
> > +      sizeof(struct camss_params_chroma_enhan)       +\
> > +      sizeof(struct camss_params_color_correct)      +\
> > +      sizeof(struct camss_params_gamma))
> > +
> > +#endif /* _UAPI_LINUX_QCOM_CAMSS_CONFIG_H */
> >
> > --
> > 2.34.1
> >
> >
