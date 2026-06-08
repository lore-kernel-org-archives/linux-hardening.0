Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813B3B4EBC
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907920; cv=none; b=Oy1w1s15r6stC/NxiAqd9QMRe3nooTXVAXLnld1/yijr9s7Bce/79QICd3Uxi1fHTs9aKDtPWkz3/4vAY4HUdUkeIvwMVRY53Twi/RCvXJO3x4iYIKBHdKrFoCRFW8AOaqnvRirXcinK8bazrW8NjDXXpx5uhlVZk8VI8mzIM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907920; c=relaxed/simple;
	bh=6n4Qb4GEqDjlYV2pyKoJ9ZSPLj3a0G7DVvtMLoymnpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAtxkoIDqto/gIHwqLMuSMK9hwDDovlf3j6vs2ek7RpyPdkrqfTPv22WJ287ilV5hi6LhV4xkMUTh9Rr/EwuEt7yxgwDu4LYxHbKlVX2LxkC4U5YCHQDYbWjZONGebROWMCLILyD3rcPcc9RR/Uaz6i3WoKA0pOkMiKYr/Y2Ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j2DnW1uW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=feTZgGbM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j2DnW1uW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="feTZgGbM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586OuFJ2832966
	for <linux-hardening@vger.kernel.org>; Mon, 8 Jun 2026 08:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VQFU4ysl+xcr7f2GGoVtCp3ziSn6wU2JjOZ0xdRb2LM=; b=j2DnW1uWvh/I8O6y
	OFnGkZAIjLuAIw5qdTa2rTv15jN2XWu1pR9pmfDSJL4syin3lxE+dLQ3Wy9xE2qV
	yvtoC/735ZiMXioTVDgnH3sl7oPcVWr+Z77+ISzUwkaCMAOBXxF7Fn+HdEkq70Qh
	YxKKLXyHih29QetwaFPoY+5ZeBsyxua/RHq2XkpwAoRPYUkguQPVRmI/XyhFFrEh
	0koKc6GCBJPptuSm3DC7IHL0Pm/N2sU+nQkbiC4v/wYadv6Ae8owxbXnvUczmTn5
	T45/zVPIoYTIdp4alUqN1sew8xXPEuD94Dm3W4anz2T5MWiz7WbaMhpvfz9t/pw6
	+oY3Dg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embmrew73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 08:38:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-517a59cc9cdso32174261cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780907914; x=1781512714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQFU4ysl+xcr7f2GGoVtCp3ziSn6wU2JjOZ0xdRb2LM=;
        b=feTZgGbMbY6+BHIMsQ426trLurQFnPK+Wdivg65easpwdt3Ak4qnNd3xMfcdb3704y
         fKT2RovEQJtscykgi55zFyrqqgeG0jBufXrnVT0lKeqL/DNIy1/N64pYpMLIFONFqvjB
         N/Zn4iFHioN3jXgc1Ro0MnHSDmh72nOK4aHKaqiKRcjAR+XUpk1rAcyFOd0LyxcElAVo
         zvwVyF5mzR54Bc2kYOMpCREFZZUquLPIdYMbHPflDZbTjW5l39+tUfC/eCn469JNnjE1
         2rv0USt1v+3cEYBUhGVf4ikX+PDZJajsjPoyaFxmxenw1k4okQVGQCQe25KbQVdQUvlL
         M+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907914; x=1781512714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQFU4ysl+xcr7f2GGoVtCp3ziSn6wU2JjOZ0xdRb2LM=;
        b=AHCaWEY1vmDU0zi3b2mAldcxgSm2UcCeAXkI2YPkavi6GK2BGCHcdmb/E3n0wkLLSf
         dyCZLJxa6+l89GcO4LzsWr/vRO98gJHXZ4oatIXuHsIF0Zxvv0UHyrbsGYnOczEaiNK6
         JYDJfA997ayzUToIh5Pk1hPrmXv3Fq/wCt3Y//QMnqtLXQt8Gg1UsgBSavrpyw5zk3IH
         DD+jd96wFgkjeQnlyFN8aMDHY1qVkxoRmAayXR6UrqZ/UmNl2K5Dn9vTAXg6eBRYrAjz
         pHjXJcDQXqN3P+B3KqGXWkE/3M6fAjyZ5GBQpK7He55kcPUdq54K/cHTQapmbeSQGtg2
         1m+A==
X-Forwarded-Encrypted: i=1; AFNElJ+O/ahVTASIxW5rqrf0mBHS9UwWbEdj5qrWLBie7ztAsGy4ju82QpVScmHgSfDSlrmXljn/WOBZA6TmLaDG/rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5rD2pbh9GcVFwfkgwc5e/o4U0TQD2Wq/LPYfipQOC3VMOZwC
	2aireOp9pHL8SyP8H+t6ffKvV3Cl7BkZWpI+TFgnIDiQyCm1Ran1YkYSyz4Xnp06AFhRAOzc6PM
	CjknbQoQCmn5HVXazHjdsv+B8VAK8OCBqh31DaxPu3V42zAXtv1nRm3K2PJNO9MI95SC1dfc=
X-Gm-Gg: Acq92OEbOTvrSM+YdeNjfTtzM393YyWtsdTSOGQ5Vn71EFW2EVcBUPvLF1V0pos9k3+
	3J3ZgpTFrIHAwf6Y+Zr4NskXG+jyut4SAXFmPSSQiBexzhFSG3QiGMRbMvXx+7DE/n5KH92WK/J
	3gAJut4N4/kCStHO/pTLM2ecLhBLAheq7j9waALYBb7l/QuFxFVBIt5Z4bRjDZ8ZJg6cU6bzf7X
	8NKI+Bw352n14I+EUKkMeR2xagcUnEDiQhPMn6Y/DdtIhdsakD8jOXp8pnEYiFYvFkjPh8JS590
	lnO65yV9LWXuZG6yWiK7XmdirNnUFKq6uocEPnBivFL3/xrl3c6tmoXvyyt1Zn5mo2GUURP9ZVM
	asJs5Ylnh/5Gbz94jBsh4JC1gx7iFQTuaqaK2LMzeztHWrcrGICuD/V5q3gY=
X-Received: by 2002:ac8:610f:0:b0:517:6804:3732 with SMTP id d75a77b69052e-51795cda4cdmr207815721cf.55.1780907913901;
        Mon, 08 Jun 2026 01:38:33 -0700 (PDT)
X-Received: by 2002:ac8:610f:0:b0:517:6804:3732 with SMTP id d75a77b69052e-51795cda4cdmr207815491cf.55.1780907913464;
        Mon, 08 Jun 2026 01:38:33 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4904:8660:26f:8b6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm383420465e9.7.2026.06.08.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:38:32 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH next] gpiolib: Replace strcpy() with memcpy()
Date: Mon,  8 Jun 2026 10:38:25 +0200
Message-ID: <178090789587.45152.16178139871564031828.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606202633.5018-3-david.laight.linux@gmail.com>
References: <20260606202633.5018-3-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfXzzHUKU7Z7and
 mTQVqHnlJkcyIY8iHNr+jwzZ899FQgbTuA+TkrvBpOaOZ5NmPpue2Wg3k1KaOdfqsBUbk6uw/Rw
 of5uLmowxR7mongiS22BEuCmeJgCOHQ/74Da+XGZ/mf0cqQevC8By6ySkJKxskBCiMH2BGBHK0Q
 rjdZ7XYovwyc83uDekA5BK81BjNefQxKOGnRot/GQUsRF/eetro9VO1U0khAzCzuH1DfbQyH1GN
 3hqyQrfHtwVAVpxtI8OcC0x6tmSZdHEmWtXT2QdA3XqOMCWNu/4lZr04+j1gzM99sTjVOuy5V3H
 kXaHX77P+oRNEV0pePB9Ldydn6llMnytVsPzeoXIlm6wlS+x6SSg3jK3Vc5Gm0WZHQVBw/bXUNd
 x7VX5zglILf71tFBngCMJgSAyTMxfKyYHEIr8T5xKnedWxFw7sYguz0EfUVYuC4EvhRiq4bu/v6
 EoWuRMy+22oBOy2YehQ==
X-Authority-Analysis: v=2.4 cv=B5eJFutM c=1 sm=1 tr=0 ts=6a267f8a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FWiv5dHe_U33kd6G38IA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: HJyR3yh5MyO3QeeAVpIODx7u1FGm5xdz
X-Proofpoint-ORIG-GUID: HJyR3yh5MyO3QeeAVpIODx7u1FGm5xdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079


On Sat, 06 Jun 2026 21:25:57 +0100, david.laight.linux@gmail.com wrote:
> The length of the string is calculated in order to allocate the correct
> sized memory block, use the same length to copy the string.
> 
> 

Applied, thanks!

[1/1] gpiolib: Replace strcpy() with memcpy()
      https://git.kernel.org/brgl/c/25afa211ae336569ddd0043f77e25e1b9b48c4d8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
