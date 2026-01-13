Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F1223DCE
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267118; cv=none; b=WWqL6PDr3mYzPWA9rHAnl2j2IFC7cbKX30Huf/zCw4A5bnGJ+vxw68zdx5qNi7wGTakPzZwv5yjaE1Xj3XOZ5VPKdYNVyXTkPAb6QELojBHMdZyxIhsCfuCGOjf3DjE5hInzEgJIR4+4LMuDbITWTtWiksViuLthuRwJJHtVV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267118; c=relaxed/simple;
	bh=DcdBU8InJgMguQ2iTSiZxsVXaoWbbEYqvuCyyEOFkOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrlmUU+8/Ue1+uwTfOH9HqCMzRIKUyg22sDzh8D0UE3Tqv8UyQ0gd26q+wChyimYOXiIDvjYuN4BWc+VMT/0yeZ16cafjvNbloaf3nTFWeYvoSEvx/lhosPStrj6kzZ37qU1ukTQSmYRdxjwh6LzYeZW93WPUg1qLR5ZR1U2Cbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aGPl4eRX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=htjowIl4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGPl4eRX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htjowIl4"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN5AFa2513676
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 01:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTkdGQ8kKP6sKFT1qADeBrtyvC4PpVNNcTkxvZ/+Y4k=; b=aGPl4eRXZXe11A6r
	UgI45mqq3dzacSv9kaXo90migfZsXmnytU+6nwHiX3xV05eFH29N149Jf6qFpse6
	MYULFic3ATw5ArZHf2+/x2sYF9f210JV6UsGcHAJNdOJgAoJ/mGYpEsaRimbILQ1
	Fj2kgqZFPwRxR2ixlhqC7RkC+w7btd9HQ62R9v2Itkue7JowqAu4AOdsFjYWCPAv
	QHiN87hxzISUuy03dm2ovZt4UOedQ3loSEtVc95h58n8ml44W7ZxWU/6+cbC2MKF
	3adhwbDsYLmbJbmw3exBj4hMavaZZkCpnqihk+r6Ei28QruSnwNXHPqslTz1CXrq
	HpowZg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6y8rucf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 13 Jan 2026 01:18:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2217a9c60so2208088885a.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768267115; x=1768871915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTkdGQ8kKP6sKFT1qADeBrtyvC4PpVNNcTkxvZ/+Y4k=;
        b=htjowIl404LE6kxmYJqSDVsFz7w50gV6bLcgVujurhKWDQXXBIB/RxQNnLFREX8pEc
         U7N3Izn7PR7KnnzG6b416DDZWT194qV1pI7QRvP7zJkZyh+J6XgItn19HstxWdJQonTI
         DxRjbi8z7ZsCKZdXXPNjQdvcRssGkzh1Gqt4PMUnDFxnRUAX9O64Z99PFvugtBko/eiS
         UsDznJs0QOUhFdGAuw16Xr/q4WtfCF94t9O44u+LxyEGMdgapNgPfdfQPJMoO1JhC8rQ
         srRjP0xhAV39/K9s8KsdAPwCFeJLBU4rgGt51amwq75owAv9rh7Sil+KQoTTkYFJnESF
         4jHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768267115; x=1768871915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTkdGQ8kKP6sKFT1qADeBrtyvC4PpVNNcTkxvZ/+Y4k=;
        b=YoqvFjYo4qti9LAOoy2rPNU++TrWzkn70S9unkL4L01PP9u7m551/cPwnJuUjRvCEt
         csfWwYKUpWogc5wKF0lSuv6NFOQRxbhBniT/vdJ0j1EcBD2QR9p5Hxbocd/axh08HqMD
         SGtp6UoZh/6h+JTM+kWWzXNVmEPb/VXmmWvtOHsCcefLSLsdPP+5DTH41YfX567fvUVq
         sWPFFeYSQquKdnv3ULczmm4J+xFg0mE9uEvADe5p2f0/CePMct+w6sjhL5buVbluoOGG
         APP81YK5Ux5YYkOpa7y6tWje0zSaGZ+HDv9UP9Yc8iqzV9m6TGvdS2iVN71modNrN4jv
         I0mw==
X-Forwarded-Encrypted: i=1; AJvYcCXeUst8duBJPOBAmxaImtH0iLB9HNqUzNU+DhBsAmp5L4Lswn8d/ddBgC925BLAXi3a0uCtkozeKracMqJIG0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0aQ2nIuvJ5ajUuASteHXmTS38LaQKtQFb0B7cQ6XzeOjbfvcW
	ogh2HX9kyh4qOcfNnXYe+vBwEXssi2gh1S1LPpNOPKnqVVCXAgKZnvGbpxTPBpRyxA/56WhMs6I
	A+99A+0JWpo439Ewcl5coi4OB9iFHO+KJR4w3rt4XtiQOfJDYB4/tUxl96L4uCs2rVZv1LAE=
X-Gm-Gg: AY/fxX6jPumcT+uM0B7UQLkGqLbaRxKO0sr63iYUg/l1TKcMIEpFKBRYj1LrWopPhm5
	kksqZEQdqq66v1qMpdtOX5vEbBFjt1qrMFcScIpGurH06L+cdoKoB61XITg4NuM5N5l+6qiKQLa
	zjnThGSb/IcBdB+poiHBMXNYOgSZckEvAfV8k9Vm7SWox/zYMyIx8+2bf0Tp0wKbPxKeJaIxvm2
	5lRGnsHd0Kme8fRd4UVpuUezD6rgWGNCJGe3V++Rv2mgVt6CUgxYb0tdtF1BNeE8XlfsRLV2el/
	vsfCxIoaSnX3/iMu0+/fyXKkut0fsPXixJiCj6AKx0DYHBSeSF59TaHNurKjya60phzBryP/hE9
	HAtsLxjeG6SMEnYfIZUwrwS9FagoQcdeTDScvB1w67Htcn3O6NUPgQNWFbFgAQy1Pxti75yBrRO
	ViMF4T2BhHnTUB27u+WdRbyK0=
X-Received: by 2002:a05:620a:290c:b0:8b2:a0cd:90ef with SMTP id af79cd13be357-8c389407515mr2700221185a.70.1768267115377;
        Mon, 12 Jan 2026 17:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLZI1hd4woXlXq+FYN7ag5gwJwSjpT2Ga+pQiFR32NkRsBGaCGTDamRbr7UbZnimayaujyqQ==
X-Received: by 2002:a05:620a:290c:b0:8b2:a0cd:90ef with SMTP id af79cd13be357-8c389407515mr2700218085a.70.1768267114909;
        Mon, 12 Jan 2026 17:18:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea275sm5094320e87.1.2026.01.12.17.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 17:18:34 -0800 (PST)
Date: Tue, 13 Jan 2026 03:18:32 +0200
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
Message-ID: <2da7ufltv6xfek62j7r33lrgppd2zm6oahhhiwz57w3ckcs3fn@xcclze4oalo4>
References: <20260112-xiaomi-willow-v1-0-8e4476897638@mainlining.org>
 <20260112-xiaomi-willow-v1-6-8e4476897638@mainlining.org>
 <3d2qboek2kzsnsjmn7rqi6xkfotfchc7vdmyeprivu27l3rw2b@i5lbwsvxfwdb>
 <aa8d5d6f9301d94b56af4580210ffc88@mainlining.org>
 <nrudictx64m24ydh265c4ma7txfdmmncjqfl4xq6zxvk75lkzq@wu6vnehc3dqu>
 <abd31188336b3322b9322f1e6791320e@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abd31188336b3322b9322f1e6791320e@mainlining.org>
X-Proofpoint-GUID: Jaiw2bCGsgrPAdSmyjr81qj_5qHcKPaa
X-Authority-Analysis: v=2.4 cv=dK6rWeZb c=1 sm=1 tr=0 ts=69659d6c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OuZLqq7tAAAA:8 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=GsNEW2zrF1RCk_DmH1QA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=AKGiAy9iJ-JzxKVHQNES:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-ORIG-GUID: Jaiw2bCGsgrPAdSmyjr81qj_5qHcKPaa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAwOSBTYWx0ZWRfX7AcUz8lsPJts
 LBIeSIGITte9aJTJgVyp3a/DE8xW/sRjodHc9AqJ7bu8iPm+BuRNzhf5enFz0vRn9aza08Ww71l
 FzoofJ3BZA/zBZAXItq/OBpsy/Z7icnjCNaV3yv3jrshZDyfoLhkSV5ZTCv1xNNnGnLA8qLiLnJ
 O18WMQ7BK85wghXVZgN0rvjkHybxHLBmosdic0uEd1FNu5vsKBYNm4ARikDqUkIgIu6Kjnoigix
 hftidV+vHm7vX4C9HDpnOYJiidcnwoPa2tb6QccMTTgGL/PXDLZXztv3G1vvgjjiH9bgOvIlYpW
 EySNAlf7iYyFknwsqxsY9fpHqcu5O3iDZE3NFHuHP9bVBA4fhmiheyi4ZiVI7yNx0IxyS62oK6V
 Qb7w3lXiLs/MuvqEPLIxdTzcr9szKa06mIKWqJcbZ9ntbmDuqPkY8vKJGcd8iikRmge9kjuaQYZ
 W0NseHULgvpUQHiQ+Rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130009

On Tue, Jan 13, 2026 at 01:49:58AM +0100, barnabas.czeman@mainlining.org wrote:
> On 2026-01-13 01:22, Dmitry Baryshkov wrote:
> > On Tue, Jan 13, 2026 at 12:41:43AM +0100, barnabas.czeman@mainlining.org
> > wrote:
> > > On 2026-01-12 23:15, Dmitry Baryshkov wrote:
> > > > On Mon, Jan 12, 2026 at 09:13:29PM +0100, Barnabás Czémán wrote:
> > > > > Redmi Note 8T (willow) is very similar to Redmi Note 8 (ginkgo)
> > > > > the only difference is willow have NFC.
> > > > > Make a common base from ginkgo devicetree for both device.
> > > > >
> > > > > Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
> > > > >  .../boot/dts/qcom/sm6125-xiaomi-ginkgo-common.dtsi | 302
> > > > > +++++++++++++++++++++
> > > > >  arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts  | 296
> > > > > +-------------------
> > > > >  arch/arm64/boot/dts/qcom/sm6125-xiaomi-willow.dts  |  13 +
> > > > >  4 files changed, 318 insertions(+), 294 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > > > b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > > > index 163ecdc7fd6c..70be19357d11 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
> > > > > @@ -1,304 +1,12 @@
> > > > >  // SPDX-License-Identifier: BSD-3-Clause
> > > > >  /*
> > > > > - * Copyright (c) 2025, Gabriel Gonzales <semfault@disroot.org>
> > > > > + * Copyright (c) 2026, Barnabas Czeman
> > > >
> > > > Hmm?
> > > Original file was renamed to sm6125-xiaomi-ginkgo-common.dtsi this
> > > is a new
> > > file just the file name is same.
> > 
> > Following Konrad's advice:
> > 
> > Would the following addition to .gitconfig help?
> No, only until i am not creating the sm6125-xiaomi-ginkgo.dts and adding it
> to the stage.
> > 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
