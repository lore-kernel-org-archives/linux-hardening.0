Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B433AFCE6
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789063; cv=none; b=nV9tECMf8J5bM08mz4hW6NfsDf6FtMDqXNAFI3liNYLm/tSKJHKaHolRVmZIq6vF1phTkpmqvFFIjZ8dM9NeTyB3v2qV/i62s0Io1BIgIbqnE9Kk57Ud4EsnhBUMfCSFRWr8moQjM1rtdkKLrq2+WfIKWv0Ulm+10TMI658hbpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789063; c=relaxed/simple;
	bh=EjfJ/ixJ35QHyIg50lTriMaQBVhrwn33zrAlbnoCLoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhpvFdRFyZdv3G1JAaGJ8Qz7fV5lRiAA29hYahaygfj8RtZ7/Crmq0ZtFi6gpbdnpAXUJzQR/9whZFSu1sncNkm3clOPiFjfRfxB1ZHx6wcJPUAc+xLXlkwQ4OuN10R/Avv7Im1+no60AuBw4yuEHkJ2Yhg5kuksS81RqRcgP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Di+XqVZ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KJe8KD2t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Di+XqVZ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KJe8KD2t"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ICsHcQ4027896
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 13:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J3iEw7Y8XK5/7tKSn+yPX4FO3YXCdVSFl2Te6p2Xagk=; b=Di+XqVZ8b8ncmrev
	XmwFtP1sVz6e5zBdLBnGBVuIZV6DNCOAq4vUIhCRQQ58Iy6AtNYyOiIksOVGGHpD
	pV+FXivTZYh936bDt0LwvagaM22T40J25XzE/PK45B/7PgVy1d20oJ2grWxnE0yc
	ZwqpvZoL1A2s5K1kaMN6vt4vdHE2gUAmuge6j4bMkpZrZaHNQisuCIWCWpSjlaSk
	bec0VFW3761AhMd/TstjA74qSSADSvNKj9SMLjuaclwywidXiw77AbhV2cDX55Rk
	F+tNiTJuezsVd4r7sL+x8IzT2LI9ePBe8yzjtKRu0jQg2b1JDgjlivrM7cnEwqCu
	wYLHvA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk3h5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 13:24:21 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cea06537c5so50865137.2
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781789060; x=1782393860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3iEw7Y8XK5/7tKSn+yPX4FO3YXCdVSFl2Te6p2Xagk=;
        b=KJe8KD2tpD5qchD3cLpa9M0AZGhnGr9mHJbaReuvBFxr31g+wPIaC/AB7G8dn+tKue
         UAt3l7BUNBm/FGKcxytSiWLeadU/+6lxT/6jaNMpqujag7SzYD8aw2ZQpsZIQ2nOjLbR
         pt75/B1RtVPVYySxwHq5DPdPEnp35TdE6z1SIHaKYSeE8Ua1R8x3OmHZsKfhUw9DcQxn
         TiGhQXelAE8X7CmaKYTFDacpZEMHK/V5iEEkJR1mtlZEqOXyVWMmzsdnrXQzHEPuqhnJ
         fdr+9q+b/h4eB9wQDhxUEtWZt/4Fao1VshvXg4Rx49QhDEjqeWHYsI5qDpHVeCekybAW
         KzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789060; x=1782393860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3iEw7Y8XK5/7tKSn+yPX4FO3YXCdVSFl2Te6p2Xagk=;
        b=GTIG6yx1NRqyv3ZFqmogJaIAfmocA38tYug8Ky3CaQLXalTR4hHYHauwkBhMuNQYto
         x2I8NRv3FQ6vb2Np91+Ecz4+4b8y8NLheGs1+TxZ7z+AcSX3qJuWrkwcXtKYtDM3ahLV
         l8U34b4q+MI6WNFoAuIjU6NNyOeDoNhBZK45Rcox618/Y8Yb+ffmyRh9c1J4fiS262Qq
         uDAbT2VASMAeymqejdOJ4kRnXAoV+Vm7AtLiMvzVSymYh1Y5zl/SPUp0mdlYW4c0YgG+
         ymfK9G+FXPfTxbx4JNh+P5uylZgvurPUrKdFz/pBaht0+VY8YQKQ4g13cXRaKSmUq4SW
         QH3g==
X-Forwarded-Encrypted: i=1; AFNElJ8Hej5HzNtQGp4t/vE8Orvjh6fFiiJ1e5zy/6FVpOAS5yPoiclPsra7lRk1xrFid2+sjWY5SMMPpGLo0PLC5YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiaHdnh9s90KIFDwZ1Wc2RMF//se0Il5mw2p5dStEaCSaePmvN
	t2wezurdtPgQqShPuFWJiEhcDpZvFXihQ25FHsulUZy+rT5rxPTpGRMH25uPbwe4K+XjsaGaurD
	YVub5t7cCxNpnwLKQI8Rt/JIaG6VuMWy8AdLEEU3YuZVBq45hyMCVlff6XhD0PmdGdkcG8wA=
X-Gm-Gg: AfdE7ckh1zMx/Cg083XVFXOEwJm4TaPPSR2CH6vK1t1lRr4NplSN7KUi6tI7eDFaZrZ
	Cpt5WPLDvFUc65UfsTQ9nu1we6N/48GbO2EljyLJCMS6h98TThb+JZl6DkwQ8uL5DxX2JtCjE8j
	BFntla5C2DX/HYINPqD2eeq02XMeV/caoE4ltRMgb3hdL6hqBXcucyw2VB39UNDXHu6zMzs53Vl
	UEYCG4xTi8gpEQQ1EB1xpOrijcBq5LLm36/1B+oZUFa8ukvrm26ScIUwELWgKnrWsKJ+YJrUZT2
	dV6IIeC+QMdY/mFjiGvQh+CHpiz0Li6EMy0q1Boh5plzP39tnLc7vhLFHTR3ep7yJgCEK699FB3
	pU8u7MWnqUbefGvEI5zFUoqKT0VdTkkRS0P4=
X-Received: by 2002:a05:6102:334e:b0:631:bcfa:39d2 with SMTP id ada2fe7eead31-727d735f873mr567424137.6.1781789060409;
        Thu, 18 Jun 2026 06:24:20 -0700 (PDT)
X-Received: by 2002:a05:6102:334e:b0:631:bcfa:39d2 with SMTP id ada2fe7eead31-727d735f873mr567417137.6.1781789060032;
        Thu, 18 Jun 2026 06:24:20 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c07a48c7931sm90091466b.21.2026.06.18.06.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:24:19 -0700 (PDT)
Message-ID: <79c1dda2-153e-4b7a-ad18-c72db1cf4a00@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:24:17 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/rpmsg: Fix copy of channel->name into open
 request
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
        linux-hardening@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20260608095523.2606-33-david.laight.linux@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608095523.2606-33-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6_k_nwdKPIqlNg67sEsDLQo4R8cAv1a7
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33f185 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=1-iA5IryhlbGIAVKO8AA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 6_k_nwdKPIqlNg67sEsDLQo4R8cAv1a7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyNSBTYWx0ZWRfX5jujNt6vjf43
 QN6akeOBrPlT8uWI/I7qXSk2+ccBbQ7nmDJmmdOPLhLTqR1ttoJF3j7bxLK37v9vCQ6PBPhVsb7
 dIVTKKPxFLQFalPkc5hW+bmtYiCPGkk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyNSBTYWx0ZWRfX5K5aVLfLSF4G
 QokHSFPQlojFaWzZkVaKHFyjY7zAxmqfmfmTWxYZ/Iv5uYnQ2adhBd99TDf9xUv5m8YH5ObD/Ta
 70Xcp3f9olcv/XqkyLtA5jSa7s84TtINxTz9R+WQPwo/7AUKv/jLpe/N2W6+yjR3zBIizWTp62l
 BVAOw3vlLfEDQ7PpW1xf3uyDFvQGlv4LrabIyxX4K297xJDI0NWRB/BTu47DC6ifMwO3owO5s+r
 vk+1YvAe/hw3zsiRaTUIEFEmZNLRdiope/bnqTotpoPBi2dn6BAVfXRV+fm8xdapxjvdwb88pkQ
 gpMKq5uN8aJiKr59LbNMsyZy4F6baOcjjO0WOVoFXOEQk1A7SfuB9r+TPJkRTK/Ax6oByFFxDah
 oJpht9qzgCq/uwtQ10uR2zq9lxox9SyrlitGOj1cWbu8Yilw+DJHVSoW275JPgtFEojB8eBfxa+
 z5o8t0pr+AgzxJ2e8Pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180125

On 6/8/26 11:55 AM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Nothing obvious ensures that the name is less than GLINK_CMD_OPEN (32)
						     ^ GLINK_NAME_SIZE


[...]

> @@ -481,8 +481,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
>  				    struct glink_channel *channel)
>  {
>  	DEFINE_RAW_FLEX(struct glink_msg, req, data, GLINK_NAME_SIZE);
> -	int name_len = strlen(channel->name) + 1;
> -	int req_len = ALIGN(sizeof(*req) + name_len, 8);
> +	int name_len, req_len;
>  	int ret;
>  	unsigned long flags;
>  
> @@ -498,14 +497,20 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
>  
>  	channel->lcid = ret;
>  
> +	name_len = strscpy_pad(req->data, channel->name, GLINK_NAME_SIZE);
> +	if (name_len < 0)
> +		name_len = GLINK_NAME_SIZE;
> +	else
> +		name_len++;

Should we perhaps do something along the lines of:

WARN_ON(strlen(name) > GLINK_NAME_SIZE)

to prevent silent clipping?

Konrad
