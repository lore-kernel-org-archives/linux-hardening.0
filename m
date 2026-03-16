Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B63368AE
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773634013; cv=none; b=VlXAAEjw1nSrmbe0ryaYuDSnRacykx9bTejYcWVIC7tFw/fvkYeihCSaS9SHESBDZSjETScBkHqJnv89/n2AJA0c2RJcLRGtWHKuKgkuoj4TKQ82daxBI+4WhVH/5xSMu0Jq2b9Mucnxn8k3SZZ2CPKkvmrePvvlKg1FLZQrG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773634013; c=relaxed/simple;
	bh=JaLgnger58+q+UIWkhi1HwRgoOKLN5fnyd11JV87dsA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kntjZ4ZSAPmgL3yz4V2+XqNFLO9XigJYw3SkiRLjSOYDiqKD4JTCgnYEoOy4gBcIXATt09/fYFHMOT0L6vql5bO4MV3MRjpiHxMziJJGBWTlRA4oyHzCo4zEw6xRqIy8LeAGfS9CjZrld0OYfYjq6adLb7ZrdDIK55tj0xE89ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=irvJfoL3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TCYwGPHJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="irvJfoL3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TCYwGPHJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G2n5K13967578
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 04:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ndkr0+Bc2XuTO21elnXe8eizYrsuKcsqBqzlOnvzrDI=; b=irvJfoL3+jiwweR1
	KxZ3VyTgLmfgKetpXxDVJyozeGUuXaqrG9e5sLeFtBCVvZDvNnfOLQxQpHWbW0ST
	YALzvy3VrGCIne911UGY3lylsV2fXNUWoOr6tZNA0Dsf1Y0ksPCe1rqSj93moPQ2
	Sq6Cl/R+AfjqApnA/xzG3CpAXeCKk1dTuBakNwUWJlTrcLHSZmogk2XXmS6rOTgU
	kZfJEf/5fT/hiDli9yBC1gkFwAyMD8Gv1q8MpMZ10KVYc91iTvOi6nl+bPm21eg/
	d1NXWXLIrSbwrz43bUtQFknxzEHzQ3RNHugrcBVIYWASrnrz6h8PX0/bSd+vD33L
	U+KZPA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xm3vd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 04:06:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829a535ad50so1925372b3a.2
        for <linux-hardening@vger.kernel.org>; Sun, 15 Mar 2026 21:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773634010; x=1774238810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ndkr0+Bc2XuTO21elnXe8eizYrsuKcsqBqzlOnvzrDI=;
        b=TCYwGPHJURno2LZgvV3PAomMGrGVk1v8OvpUlvf8eLvrtA0tEZQx4cQ3+7b/cv5riO
         FhyLYjm32sYO4vFvp4b2947Q2Gzhw1k6PrwpFPgqud/pxx77muc/hj5X+/r16WAbV9or
         3LRjb262l+VPxD6JUz9fmbK9LhIgG/+erMCE6KVKxHf3w82FUIFuRlyyTRmI45N5rMN4
         6VaZ2CiN05ryEBetpExrvwmMr7nUymEaIYSQd6wuI1lYlaA5ZenT7s4CsAh8zg4BC7FD
         NjiUFgylTXy6txR2tqFXooQnIWBIczbFjr6352Qzfs5fCW2bEHrwL71SJvZA1jQxy9rE
         Ee8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773634010; x=1774238810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ndkr0+Bc2XuTO21elnXe8eizYrsuKcsqBqzlOnvzrDI=;
        b=aic5MFlxFwHIbPqQOg/MrgrzhwMmWuMwnFnGVeX2I2dSUt1beDzKXz2MvRXYGf3+Zu
         8MQqsouTuomai0/XvI3+3bq5sJNg7hGy2EuRk7+7AreCoJ7C9/pbIB25G+eWMLpU9oUb
         U0tin1h8OjHCbXL4HL81AiNTBC38rs5/QAiXLeA/hNBFxGegKL+1hbvKnOvYBmU7PfCR
         9KzppV5AjUg5+sQ4+1xYziOrts7AQNB/UtX4SHUR3puhn0mi8HFIv7ftoqT07Dw17sMF
         gYqRTVMNjDEnLgSsBOQno1828Opq4wnFHbG6Q76piIEMbRfwanCyvBwdwRZCW5pLVydh
         F9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVUbiFeuv/5RXpdkhX1FuHHri607y4uqdJA7AMfaH6X0lBSZaJLJ/7hPUfcwzhHa3JRxFJjR8ti0V60kW8Jumg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRj7OmW+0ZxKlnAOtLg/mnLLM/Heql+esJ+gxEVrrkMvrgNu6c
	TWQGf30nHuPmpvJGGYbTo+UeFz05qQxu8P1hlZJa7/uVvflKfHMo7Ts8OYfpb+0h8OXuQTDzC0r
	JoL9jWpVcBggPrriaFXRXpC+ogclyp2vBAR7PJ4sCUOH4/EE5s4gUtIbxfRYNVyOqFVhLxzU=
X-Gm-Gg: ATEYQzyxqgdQd2d/rurD30kJxnvLAB5qZLobMYm8Z5sreDp/c4brgBdDSuQz2AyCgUO
	nM+KK5avunXk2YNfggGoW5FTDhGoOoq5HgIfMlQA+44/uRNibbie4+VQJHfk67iD35FZiYnU1nH
	O+4+BbznvsvRyVEyOjr9eW4jYX29egbOnv/jJEazQ+aSh+kWe3VwFU8GdukPJrl6/i2T/0mk/+f
	0B2wEkg/ZDH2U3bvou5R+yRCZ2qgxx6QqqxMP+GS7sfOptvz2IvtwYbYOQAiVq/nCOaiV5300Kb
	jgb5u7FL3ckswq1mGPeOpMSKGALyWpfUUWnUAnbDhc/zdc/CuTRjcp8Z9rueAP+2Uf/LBWf6iy+
	VAjlN8z4ceLAFaY9dgaAtRUV25oNlpa0hFH4PrGZnpXMgxidAcA==
X-Received: by 2002:a05:6a00:c84:b0:7ff:ecbb:1c28 with SMTP id d2e1a72fcca58-82a197298dfmr9631228b3a.16.1773634010169;
        Sun, 15 Mar 2026 21:06:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:c84:b0:7ff:ecbb:1c28 with SMTP id d2e1a72fcca58-82a197298dfmr9631201b3a.16.1773634009597;
        Sun, 15 Mar 2026 21:06:49 -0700 (PDT)
Received: from [10.92.199.113] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725bfd0sm14339943b3a.14.2026.03.15.21.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 21:06:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: mhi@lists.linux.dev, Rosen Penev <rosenp@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20260312045921.7663-1-rosenp@gmail.com>
References: <20260312045921.7663-1-rosenp@gmail.com>
Subject: Re: [PATCH] bus: mhi: use kzalloc_flex
Message-Id: <177363400652.6449.17696320046026788438.b4-ty@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 09:36:46 +0530
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAyOSBTYWx0ZWRfX+pUvxy7bIWiS
 9CDW3CI+jVfsHX4+ibnBLXw+6Zz53peqC6OPdTCnNHlRHsluCy9vYiwMI+KlYKRudF6nDKBbrSA
 gCVpqW3oOiI/97JFGOQkgAFeufiKKGjhV5ERRHpjLX/X2AEfWUSz5K663S0++R+VjhNZ39QMiLC
 56Uqt3q4A+SkhCEoSho7L5CVZ2d8oIa1NqvNrifd2YoCce7osCUY7lB8blBI/yPiKch49r4ZULf
 ht5tuThPw7cd0yQp4r4QPX0ONMU1b/NGh1PpNr5fnGGf3uNVsFr9W+eWFSkwHOQwr26FFmQ+r2X
 djTf5pUPnEY5Uh3/wsKW4UMS3uh43zzqbGAsXTeTQIjujacYLn4ogGhqzefUiqnbzvFcVjaupYH
 bTLHmoaKwuCBV2MbPMwh73aB7UpTNXwjtuBKoP4ZQSz4OdogI14+uxFMLxMlty16KnVPhQuh6og
 cDbdF1Km2AQAR5prTYA==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b781db cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=K8mwyqB7UndrMnxzXikA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 3eI3lYcN2k-qaT_FKb-0fTrZOsVLlQpX
X-Proofpoint-GUID: 3eI3lYcN2k-qaT_FKb-0fTrZOsVLlQpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160029


On Wed, 11 Mar 2026 21:59:21 -0700, Rosen Penev wrote:
> Change kzalloc + kcalloc to just kzalloc with a flexible array member.
> 
> Add __counted_by for extra runtime analysis when requested.
> 
> Move counting assignment immediately after allocation as required by
> __counted_by.
> 
> [...]

Applied, thanks!

[1/1] bus: mhi: use kzalloc_flex
      commit: 2f5ae4827e94955ad3a9757e06da90a5ebc4cc6b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

