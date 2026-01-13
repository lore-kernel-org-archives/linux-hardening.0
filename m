Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC4221265
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768263775; cv=none; b=WHSpGnN8MLieKGZrq3eJt4vS7vSGwREgKyjxXFxbHgqsVsj2J+HrFIUx3Y1uU9HXIMQAWI4Z0magHanQmon8Oowere8jd8yZhcsAhrnAw0ACeeVLVCcC12yxqpvusF3IN501LFrPrH3C1sXRErmWsPXGnbexulCmhyVD7kWaTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768263775; c=relaxed/simple;
	bh=CFEXDSoX7g0csFSTExby+Zewmxl7mKrvM6xohhBNA6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/HofV8/8jJWVVkatxu+DB9CyK2v0UFqd2jteH0RkuosTmZFZW8Juobgu06zNk0CR3Y/EOvCR5soBv81/5vfCxwTMnYiu9TXelHzwwFHHXDk0GglEQYAm+8nVstYXbTAbD74a9vdzHn8UPFpl4l7TnVQb5FxF4DySWKx67QVOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCpZD0Ap; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q3yXRvTR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCpZD0Ap";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q3yXRvTR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN6OS62607176
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 00:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gleZcckWtKx0wiXdNKBZLi0kdf9nQuuupQziYFH9qYA=; b=CCpZD0ApKBp66S5C
	9VgcGpsrBp8S4gaQwsHphcUSsCUqJbK41/1n2LkIW4c3XY1mPrejZzajssPMT57L
	Yfh2uG6JOCsKBqW6hfpBg5R4G1RWHxSIF0uRbj5XSq5CCAGeFWLj14xlwz1giv43
	P9tpPajlvvBEiNmZJQpvPNK1IVlDbQzzbw95TwyEuhXirXnH2tDkUlkKgkRhV0Fh
	SjelhnG5ALI71DNk9zjHvCm4HAl2+R6oDEDXCY2eHQt4YQsqIfEaorKG9ECUJUN0
	CoLQgK2d/0net6pylET6a/AJ0DgnEWr4N2AwxSNkgStEmw8srREIDjrDyZmmMC/y
	JhYkqw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn7uyrjqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 00:22:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so2242069885a.2
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 16:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768263766; x=1768868566; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gleZcckWtKx0wiXdNKBZLi0kdf9nQuuupQziYFH9qYA=;
        b=Q3yXRvTROcqotOnswyuEH9KQArBC7diMnY7+ejvBjxvFf/1hP++hJAk264St/TBbYz
         DtEXjwtcm6INL+InWpKFlfQhAInEH1FH4f2Q5BGPjaBh5VfbF1X3VvlDTxSUk8j0YMSH
         1XFP4ulijali/ggUc0+51AWIqxmAgFmDV6zEV3XG0tWWS5AwBukA8rGmqZI1ESJnU/0A
         YEL5sJu0pD0wjO8xdAe/bRENxg19xsgp4jZaMQdLQB7YvYdoQS1mTHgOaaHqlwdsc5Lx
         fM5eEZqEBQk41LDyIwVC09/UG/CE0SWsnee43Q4maPMNKt/v90a98o57GZM3ey9CZ/LK
         poEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768263766; x=1768868566;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gleZcckWtKx0wiXdNKBZLi0kdf9nQuuupQziYFH9qYA=;
        b=veDFhKk1/brV0mSa7H3VSVLfPdwJKABMrPWREcR58be+vbBqyCP+mX7v5fPSL6mGsb
         RdibkrB6JM4toG/JOcU199D2tHG2aUaXkrjmc5s1XTOsJoqGrQ0rmGBJ159RZIMLAmA8
         /RWVszbTXmzlk2/oVIxYhRNkRZpLk5UpjHYCsVf46B7/fZIuRRjnAtZc3o66ylpF2MSF
         dnrcyM5+21MBwYALiA25+atMY6sS3k3wuCU36Jgx6EOaDzwPIa5QrOB3YqDswun/TINZ
         RySz+pTMlfnvxwYgAedJhkkBI/LOzaj7Ke0tb804LrNOqOkasE+KTZWN5d/dxfu/gjzN
         oVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm6YQqCaFyw9GlbJ3kI+2G0nizqh6Mt477fGqZEGjlBdeRKSe90HsvZWD1jBoA9rxgg6Im6OjrQYYM7XjwP0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT17o1mjafE4hKkqZJz2KAOWcPvVT6m7SP3FoAHIeJLJ8SrqSW
	qU7DW4aomU0nIe4+rqTqbw8z2VS/geEJMPpvxIPPLpBx4X6PH8cTU06XFrAXN8kX5DRrb+hltiy
	sNynjw4igahlnyEYM7YhvzwoSSNDM5CTM9kVEhYRBIre3czr2tUskOhqT4B5/61y/7/MEKbI=
X-Gm-Gg: AY/fxX6WALrP1aRZaHdKpL4+zxB3MJiMYgTSjeJOdAeu8fhnY4g68FmF7k5nZ2luAU7
	D0g/eYB7JcYW+iQx29fWUU76mQuJ6HX9ECDRDP3EUqjsCC/ci6kcutMhR0F6PcqiKkCa+kXd+z2
	hEiF4UIm2QytMpOZdeOHiD91ZwF5oTDrbp8rA3AngIG5owBpHkwpZyA7hYuh7J+qt7QdBNsp+lv
	hcZ6Kf5F8wBVU8SKQBY5oJNjUjjLNBmdbCbiMelBuoFxYrIfZy+O96kCWiuY0i1MekDRaHWqjqV
	6uUp1APhzD81p8bKTBmdZvWYsy7eMrxrQt1DN9QOz+3U4Xb7raLjeMYjiohjqdrfa8yXJ/oJbte
	derNWtliI6Vazjqv3BwW5rcu/sQfso8zl0hiie8MQUoq3HMgo7U2i+X67dxf8mxV16deJzuxKjK
	KxeLpTzPJnzKUETi//GOx0Egg=
X-Received: by 2002:a05:620a:1710:b0:8b2:6eba:c460 with SMTP id af79cd13be357-8c38938e764mr2857812285a.28.1768263766404;
        Mon, 12 Jan 2026 16:22:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB0pTp18i+dqzRKpwzHRNbw9izTXQcKoLuHijkhHKEsdy1/ojcQBylS+thOWldmFGy9czllg==
X-Received: by 2002:a05:620a:1710:b0:8b2:6eba:c460 with SMTP id af79cd13be357-8c38938e764mr2857809285a.28.1768263765939;
        Mon, 12 Jan 2026 16:22:45 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b739a7349sm3943490e87.8.2026.01.12.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 16:22:44 -0800 (PST)
Date: Tue, 13 Jan 2026 02:22:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: barnabas.czeman@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gabriel Gonzales <semfault@disroot.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Biswapriyo Nath <nathbappai@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux@mainlining.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: Add Redmi Note 8T
Message-ID: <nrudictx64m24ydh265c4ma7txfdmmncjqfl4xq6zxvk75lkzq@wu6vnehc3dqu>
References: <20260112-xiaomi-willow-v1-0-8e4476897638@mainlining.org>
 <20260112-xiaomi-willow-v1-6-8e4476897638@mainlining.org>
 <3d2qboek2kzsnsjmn7rqi6xkfotfchc7vdmyeprivu27l3rw2b@i5lbwsvxfwdb>
 <aa8d5d6f9301d94b56af4580210ffc88@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa8d5d6f9301d94b56af4580210ffc88@mainlining.org>
X-Proofpoint-ORIG-GUID: oRFrZKzr5mUt__fBi55kHyWKm49TiMvD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAwMSBTYWx0ZWRfXxt+5HP+IRi7J
 JONDlJeEBjV/XrZSYSdw9eBWU6iCGKaJmwKNKCSZ+OnzQeJZ3i66tNRe79y6O1DzJ/pgKAXZjx1
 9Q442FzWNKHrMecaJRJAWUWt44DGG56SsTluG3sl+ibjPR36Q6C0GxXsm5TdjIIHNKM/GIfCf1u
 iLJwsRfR1vBg/hIlGnSPlKWUN2WSIH9cRBtiLyWhlKKHrykEubFUPYGPU10JCk2vosZsMyKRIe2
 G99kPJAym76c6LxIIIMoD7S8XLGZyialkiO3WPMnDF4mRqpmSVMQpidxtjHA2CH3HzpYqct/lDB
 T0MaFLldCY9Vn89c+34iyjAeKsR4sQH3hliVH6uYAo/eDGylLqr1V88MFiQHQkjEbFxd1oE+qBm
 dak8zRYoJX55WZvGlrgp7pNjC25OKpnaj7uv6hsAKqX//zpkzvcDvMBY02PpMNgu5Zd3vjP7JzB
 ml83p3qglrbnMm4T4iw==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=69659057 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=LpNgXrTXAAAA:8 a=aXsf02-KSqOFqytllbsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-GUID: oRFrZKzr5mUt__fBi55kHyWKm49TiMvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130001

On Tue, Jan 13, 2026 at 12:41:43AM +0100, barnabas.czeman@mainlining.org wrote:
> On 2026-01-12 23:15, Dmitry Baryshkov wrote:
> > On Mon, Jan 12, 2026 at 09:13:29PM +0100, Barnabás Czémán wrote:
> > > Redmi Note 8T (willow) is very similar to Redmi Note 8 (ginkgo)
> > > the only difference is willow have NFC.
> > > Make a common base from ginkgo devicetree for both device.
> > > 
> > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
> > >  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 302
> > > +++++++++++++++++++++
> > >  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts  | 296
> > > +-------------------
> > >  arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts  |  13 +
> > >  4 files changed, 318 insertions(+), 294 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > index 163ecdc7fd6c..70be19357d11 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > @@ -1,304 +1,12 @@
> > >  // SPDX-License-Identifier: BSD-3-Clause
> > >  /*
> > > - * Copyright (c) 2025, Gabriel Gonzales <semfault@disroot.org>
> > > + * Copyright (c) 2026, Barnabas Czeman
> > 
> > Hmm?
> Original file was renamed to sm6125-xiaomi-ginkgo-common.dtsi this is a new
> file just the file name is same.

Following Konrad's advice:

Would the following addition to .gitconfig help?

[diff]
         renameLimit = 999999
	algorithm = patience

> > 
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
> > > b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
> > > new file mode 100644
> > > index 000000000000..9e3aeb5a9e74
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts
> > > @@ -0,0 +1,13 @@
> > > +// SPDX-License-Identifier: BSD-3-Clause
> > > +/*
> > > + * Copyright (c) 2026, Barnabas Czeman
> > > + */
> > > +/dts-v1/;
> > > +
> > > +#include "sm6125-xiaomi-ginkgo-common.dtsi"
> > > +
> > > +/ {
> > > +	model = "Xiaomi Redmi Note 8T";
> > > +	compatible = "xiaomi,willow", "qcom,sm6125";
> > > +
> > > +};
> > 
> > Please consider adding the comment regarding NFC.
> > 
> > > 
> > > --
> > > 2.52.0
> > > 

-- 
With best wishes
Dmitry
