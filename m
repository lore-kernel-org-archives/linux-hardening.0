Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7730F53E
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628771; cv=none; b=fQYTNN11i8gzg0GEPKY98EB2oHNcsfV4L5DEDZvSe74bYQQgFlqK0anr1TmDV/zO3ADhKjyCjNkfnsc6x5uBdH3qarnqUlClhUF2m9/8afeWlypMeII1YjqnbnBKc7neKGbUMKMBiOZtnTNAq8MzDYE8A5W/4UvY60cmAMkfGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628771; c=relaxed/simple;
	bh=DphpoI7NXovRpi/mf9M/ugrTSvVQEjkllTxUfrvVcAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmVz+CC/Np7Nz4svKLNkKpzStZ1vkwzcYDCJPxJxN0xL8f08vvt+HoKkH/6Ot6MHCRHPNSUmNPKEQiXirnZhmkKZxQMXdtgo/zlU5Wvz2SkP4alH3KTXEJ53lOoNqhDaRNYrQixB30UiJ3vn+lvlqRzpInQxcfNvf4y/yMuqnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkOEH+DI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkOEH+DI"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JFKsQJ005472
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 18:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lfYBgc3axqIAGUVU7JZyFsZe
	IIPCOJtWH9T/sg37IAw=; b=nkOEH+DI+y1tFw78E+OAqO/2Y28QFKaD0Jaoxznd
	kKsEGK1YG53mSeZ6IiE3ARCozJh4JO8oqH9o/L7bFC02e/RqD4MuGtXeGTgwgM1C
	NQZ9ualhAJMbsAtUuxQ/q7Rhssd/FnN+zWklmFritO61Xyusd26YXzPRj88bzTxt
	hDTUFZ3rlj7I+vRULOZne4wH+7IrzwFB0iFi5dmhNFZPuJSdYX9GGaMqtakn96NB
	4gtvnYN/JxzpL0pHJy9hAGXd2FHhMAO4ohjtlI8JXd3mOCF5oDWn1PDwlV5N5txq
	OofrmDEZ4niezWQxxCryW3/bJfLiJFzPbVZjt+pwB8IoqQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48muu0gmmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 18:39:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88d99c1cso124704986d6.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 11:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628768; x=1756233568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfYBgc3axqIAGUVU7JZyFsZeIIPCOJtWH9T/sg37IAw=;
        b=Gk6MLQo9WMMv+QlB8yYQj5+make9AykwVSWk3Mf1isue4XXOmEdz2eBTALe1RWGc4r
         10Ltw0tY9DNyzbJ6B6sRRBt1iX4abpzF5fKNVhO1RvLVPhM/kCYul7s3A9rsyaJ0otRp
         Sk63DFXIgSRCdNLp5vpTaZnkzaejRJanqdpu0j4d1UQDTBG3T3X392mE+onTJ6FDjBVj
         /p2TceHlFfKQHCMUQKXh0Xc/mExXBFfGM0+6SDoaLm7wokI9DuYuOz26T/EsUBCZTb5W
         DDFs0MrL73UP0U6C0AFD5EoLJWWJHhkHhg/SEFwOtqd3XWz31/89IqMCORJbfleQ/qsB
         cKRA==
X-Forwarded-Encrypted: i=1; AJvYcCWcR3N05fBIG1wy6yTpsOSGtKuxbig5Zhk5ULvfJiZn/Yklq7RdpxZ+2WOYaWQszMk+Q9PxaLoRfFjE2J2cBOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDTFPBtFs9TFSqSaeUI+jt0xk57H41r+PFsVC45HAAj/0K6vK
	4WfUmtBAXIF+AcRo1SrFJEW3CC+gxkwBeH/kVru2/yLCeONQrZMfV+GHyoQzJs3FW5O+6AlZ4e/
	ZiEchsc6aNAN4xm4CPbnZgcWsfXR0jmFnrjQBe9Txu0jdCaPWnWnLyB8FitL1MJD3oVXq5sU=
X-Gm-Gg: ASbGncvPES2zjwf3DiZDk9P7JET3FrAvituRc/o8p+P/mM+/mPNZ16z/+KJtqVjYHDz
	pbwMtFsgPo1f23msh+MtXikVPi9feUk+SqK5SyPYQ5p9xVOHlEmOQ0oSArnE9qWSGzP/OSJsxQx
	LAZriYaZKqfxALJwvbPLSTwyhHz99ofG0co8n3SzcY3wX3p2GsIyo+xAMsXYZuTOFP3ncGKoSOx
	4eIMWzqcPu9PWYPha10ZrCnu3NJLZL37rmRR/xPe0XZQPCRNDGUNUhAttO3dwkNXF1i8b1fsOVL
	NIVhbdZB2CmEopMkbJZEcrtVyCNIAJBv9/SmGsex+BVgoANiu0RkEGvG64UZMRi1jKZIP3zP+u/
	VDrQtN7N6qTFRy0DpGaTByAlGPQJrBz03sItFJUfOMK4QMzlQn/QI
X-Received: by 2002:a05:6214:1cce:b0:70d:6de2:1b35 with SMTP id 6a1803df08f44-70d771c9465mr190396d6.65.1755628768221;
        Tue, 19 Aug 2025 11:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNb7O7hD+Z7kJbkAR9HXYyXCiP/vd3BX+PGDI99g9aEsnVyz9Xn+VwVrQ4K1qsah2RnqEAKw==
X-Received: by 2002:a05:6214:1cce:b0:70d:6de2:1b35 with SMTP id 6a1803df08f44-70d771c9465mr190086d6.65.1755628767607;
        Tue, 19 Aug 2025 11:39:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a4758bfsm25175301fa.32.2025.08.19.11.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:39:25 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:39:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: apq8064-mako: Minor whitespace
 cleanup
Message-ID: <tkbyz4pyvcahoudw3xwnmate5hcba4jqrak5nz5a23kmkhv4yv@y35jv4bzmnce>
References: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: HVGQxA1GLB6MRSDjHS2k8DsYdu2DZbXa
X-Authority-Analysis: v=2.4 cv=YtYPR5YX c=1 sm=1 tr=0 ts=68a4c4e1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EEIZnOjFFfZb4VbM-nYA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE0MyBTYWx0ZWRfXzCPUxOQQG8kG
 bl01II9eSPk+UOcYnFd4WLMYBFFflhI3d/cjEt+wQM/PCNbUZKI1Hj3NakumoSXcfKWG8jRV3LS
 v0Jr70Mf9CApvpQ7AT9+0Bre6GlEJ/z5eAsYxiN99wlgiyiDwvliXWAgnjHERJDAdLD0errOKqR
 NdLJn7TMpgs6WIMXCjxQfpKTMa6DLPBm5v19rHPj8AooRvRbMqViLyOeZjuojg9QIGZBEIcErzR
 2y0tO4vSmMRIc4SLUPGDxLyXiDOgrlhXnAijIE7vf+p6Vn/0iTdj056Kq/QOpcssdNwkeZeYxwL
 67EWTBtHtkCeb5nCF7eX4Orjq7Pc1hdrMhOp0wodOX4/UIAGRMyzfvA9j7zjiHq8DwTiPvc+Wq6
 Rlm53Z1q
X-Proofpoint-ORIG-GUID: HVGQxA1GLB6MRSDjHS2k8DsYdu2DZbXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508190143

On Tue, Aug 19, 2025 at 03:17:18PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '=' or '{'
> characters.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064-lg-nexus4-mako.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
