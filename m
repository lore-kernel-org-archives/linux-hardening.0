Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794832B138
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675605; cv=none; b=DV3XwijsMpZrnQ94C/YBdQuYE0kxhuY1vSfqRpsNaChyXwa6GrbE+QSWr2Gua6BV90yGMVtnbSx1aFWaMpzV1v9RXZSt+QfxfZWVTvKYxwtYi8IW/Nz5cesA4TJRMCL+QzgyGqHAL/K/feLHNgWS4iLLaV5u/LH6FGzX20DQe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675605; c=relaxed/simple;
	bh=DhHpn1dG9h+QAznsjBCgS7U6iCDto2DAUPjhpFCQdkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvJEwWS7/Jnuq2rrIGSGWdIAx65qVsv0iwpLarjl2bwyRssuuQBImKpyUDE/xNoKkZhRH5uKXUB5QUgUn2HfLXarf8rUdD5paUF1dVRNm6LWzjkGq0w2Ocrk83D1/FJZpL0hWSOprWo6r0ScwHRdsSa2EsQ4c7x6VohMAxeq0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GteNjTA+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KpgN+J8i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GteNjTA+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KpgN+J8i"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZPgX2910844
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AIcAbhd/wTobiEPktqGtOTKTTR1SSJ5H2T2pJNnaoGE=; b=GteNjTA+gWdA9P7R
	w332AUsjtosaLwSa2KjDB0t4pN4hBI0w2+DRnnW1y56mh87hIkQM+gGo68SMfsrD
	XMsOzKGNnTT0P1jwSp04YvKMCcxQUCej2PfH3shWRuFJL4j1GMRIJJGe5uizhxOH
	06ck79BRZnJsoz24Nip1EzW4Pvk8lNuvpow/ns/UUMU/+/AwZK3ikC1EPfXH820Q
	BV4gICQ0ockJ4zMSjdKW3jX92NxzLVi1T23aUxpmBPG8V6MUbbCyCyworCKscjZO
	yQDYRf0gC3tJ9mi0+n2+HYZO1S15Kv6+xpHOWt3F6NaZgaFX1pNnQvfqQ9PXGUlI
	P8Ku+Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9c42gmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 23:13:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5174a23afcbso106613401cf.3
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jul 2026 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675596; x=1785280396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AIcAbhd/wTobiEPktqGtOTKTTR1SSJ5H2T2pJNnaoGE=;
        b=KpgN+J8i1dd8Ai2xI36Fgfg7TNqK4hjVbWumbwoPIbzcy/AGrbgmhD5Ivdujn9MVYF
         sqPq682wPFrGWpxImP/1HcEKwtn06iNqir9YS7eC5J2kdYEkdcSLWUZKMQTe0WAxcmlb
         3JhbRvovr9Y4eC78u5wPGoP/sabzjixRRKOD0podnJ3AtTxx/yjxH2R1cGGUSbGn175U
         Atr1g3ATh6JNZ+3YdG+OITncg3BwxHRd14maPjP2jQA1AaUYxPWL45JrnWFgkJ67zVyP
         +kgwXTaxDbBukHc4BLNgnuz1CqFLRV3TGshXIDXKYC8h1y4onwTm2icEHQm/pciE0RYo
         GF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675596; x=1785280396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AIcAbhd/wTobiEPktqGtOTKTTR1SSJ5H2T2pJNnaoGE=;
        b=dhqk2xBsKjde1naPA6j4OSVubdfsUPNYSp07zJgZUorWhIpt1JaDUPFXfKZVJms2ko
         PHJoUmN+8AkTjnOeHCVvYE5UvtL9yd73GjUZ8+ss0TjKJjKZ2q969F0DH6q8Oztg0QBL
         UaFQOBp8PObCP2q+vQXT1DamnKjfTBKH9JWHlD77eWo5N4kpOkwFPhEtTp3K24EPLUtp
         8+ft88nOvA+kVavnbMljdDPZm36H9VojboYBEiiSWXHIKLHqtj2aznER2mP25DcVRiW4
         Do3YnglthLJAO2ix3CzwAa/xGfPz2jB+yVyxHPDA050sSMzAAB/wahf6kyh4VboqN9bl
         t/MA==
X-Forwarded-Encrypted: i=1; AHgh+RpRBweBptZ7dqM+A2/lrWSwo5BgJVW0n+wDdpPKE21G2NQrtV96CK2yN0dzxY3UP+P7qDOs+DjH2MNvj0lcxGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT5Vjq1KHaUyTgX4HCkSsAm5uG/3gfns1wIVR42bhZ96s5WBB9
	IfvrobFgxMnYcpcEYZiPg7GVocbpxOfKnmm3HrXkRs6TSK7lZ9sUqZye6vcgC7nuHexbdabm5Hq
	e5NcMubWfnlfQb7nGxo/lgiM8fqJ9CheMUsLNr9qNNyMNNBOxBCMfpTySBNFbT22FZDahLNw=
X-Gm-Gg: AR+sD110lL3dEVqK8YZnpiOXS729sctDByIpOw+ScUSrzyWQqUTMYuH4uRhSaiQgKOa
	5/SDicXHPRjjBSn8kl2qRyK/oXv8XDdjfxphpS6IK3gyhE3xI6sKK2BDPuDvgMl+jEAAYa69R4p
	vNWCW7m1b82PZWgxhz613BQbYlIYkAZYsNp3V4HV4P6f1RO8x0+8AEw+D0Rut3ey10yVCL7BSJG
	/5zJgDHA7fOEzvk+fjfGGhyBic6Qi2TrU9cBmb+qDoVIlks2x6bZaF2ii9/OB4hgtoAiQ4EaMSZ
	qof2Napg/ZK5aUmTkSo0qXp30Ex1sNC79ufq0dT+E2pdcZszXSq+Jrki9yV8XoURJgvEgjtUY+l
	HJmyt+WWFFael9/H3qiVLoVLP73438pcdSKerHs9Nzrs6FSewThF7EHLEncTjZo3OEjh0r3WWKP
	IkAlopaenYQrnLkg==
X-Received: by 2002:a05:622a:a13:b0:527:f19c:734d with SMTP id d75a77b69052e-527f19c876cmr6418711cf.7.1784675596409;
        Tue, 21 Jul 2026 16:13:16 -0700 (PDT)
X-Received: by 2002:a05:622a:a13:b0:527:f19c:734d with SMTP id d75a77b69052e-527f19c876cmr6418361cf.7.1784675595889;
        Tue, 21 Jul 2026 16:13:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9f4d42esm148526e87.79.2026.07.21.16.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:13:14 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:13:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
Subject: Re: [PATCH v5 9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
Message-ID: <ymw5womsjuri3okfwmrhlqp42kgio6t7btikarfiolm74fkmjc@brekx7lckr5v>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-9-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-9-99620e07f505@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a5ffd0d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: cRqm1PpR16OI5kVfGTURp41J-RKkQvEB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX/57X9lOHJ7eC
 T3c+QT98/JIB8BcNcP02TKpcPod/X2nTQTTHZmL5X8zv8mzBqWeZpgeUerBN0iAGL5ssxXf0MhQ
 JezG9je62N/mg5Ce85UUr6D3u1zvK5UNYsewhqil1M7ZpycuXh7GKrBdeeIdaFBgfYlBjytUVgb
 qHXFSac9p3w+EMvRo3KemhGoo8c1LeLXZl2o2MR+oSBXE9id+grR5Q9IF6jynXe+GNllEU+SeI7
 YSKumIE0zGJ8zYfZjAk2SSx/+oxz083UJSvrJIApBPwrdPiOU9NU8SfZ09ZTjMxaUdcTNgLI7hd
 hrPLCQEJ0S+8InMft0bfB7dbmSBSqS8X6eM/X6J88gv4BkwIPsU9BTNj/rGiYbhpnOHp1xI4hyx
 fs+Ur7Y1gyQEpx0+n9nzB3yMxfpheigl0P2eb17hPmKaPQHjmwbP+N3Ir/ctLZRLRhAejFgaDmI
 v/SzzQpxrO50bD+/1ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfXyElGFXuw8IA4
 aB4rzFK7XPdzVWl4HfxN/eiIrDgytWUzmNyzPa5yzzBjO59ImU17Z0fxSlzgkO0syDd1AKvSuT4
 fLZlKgXLU5Ss12OV3HYRScYmkuO3RbM=
X-Proofpoint-GUID: cRqm1PpR16OI5kVfGTURp41J-RKkQvEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:06AM +0530, Gaurav Kohli wrote:
> From: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> 
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in hamoa.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 95°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 32 +++++++++++++++
>  arch/arm64/boot/dts/qcom/hamoa.dtsi        | 63 ++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
