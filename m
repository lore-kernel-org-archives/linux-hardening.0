Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490355;
	b=gSzPAvhfs41iG2vXh+m64NzqPNh0/N/z5RCASw06cp+9YzUu1q1ZjaY5zo/PzeEBQJhH
	 ZH11lDtJ2JR5XoIlabwEvqadx0RPJwQPPP8lcV7IbdWfKL6Oi1J4vczp08WfZmUUiCPDO
	 dPBZC28PPKhXl7oPt3mnZ49T/phDxlDAoIQRpJqzrXB/PBAECa6w8piUOaCTUHjdRh+8u
	 mEJ/iC05tVMOePirJOqeLtqcQ2Us7paw7dkAx4x9qFQiVJKwJOaWFDV/Nd605UnAUEPiK
	 EXPJi0JSK2JL0XaMWTSuYQ9m1PoU8E1rJfYTie8Lk7IK5tQNc0D7fNLAqiaYoLtLIEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490355;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=;
	b=WDzab5ynIsqeYwl6cbGWN/VfBuav4wtEBCjyB/0rcrOqbCRbAeJFd0Y0ellHudQn/UnT
	 St6KSZo83fZO95vlmBvMtm5t64bNPvra51OtXlyuZ3k3k7LrcwyF8zLPtzi/7gqICoRw9
	 h93DCJjtEMmtXCD0BcwFe+prGvjCNTKUCp3K70gLXMbsFNsuU4gZfbX3D+Tlj6HzcRH06
	 rhr9g3jSa6S84Twykv3kh5k+PaW0KqHlrJcWrCjMZChXgS4eoJLchxbByvkcieh28BJ4i
	 eIDcOw73eURF5bhzq/inBMm1/ly3EdEzhamv0lIoFLFNRJs7NAQvQSqoG9HZc7L9e4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6RvHYjN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5X6P+jh;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C7606A323
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 13:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 929C7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6RvHYjN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5X6P+jh
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9NedF2514376
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 13:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=; b=H6RvHYjNNjqOJOAi
	M4V6IlTSok0SApN/vq7rMc9JX615Ss4MbGhL5Hwrp8L9+CmiyJWMimzuAQ9ZLNhf
	mugRDTOTe6gQZTn34iVxh3Cg2g1BkNo790ZpN8ePlPZzUOq1IfmTIGV2POF/5dUX
	R+Ki7rRFpIFo4eCWbyPK7hpBp/Nh5hv5xLUKIC4aDpYXrimZo3rIroK8ByHilqS+
	UXNN+kR9MBE5rRIAkSIPNWzIbtvc4krm/uuFJk8OUb1/rAeMgcGiZwXL3n6GEOnj
	IuHVqT3BSaawMNEPcJB/6foUELfmvcGOwNq+BMCrfKQ39KWT8lyBZ52iYu+EhfpA
	/EMonA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvwm1urmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 13:32:33 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ecc172164aso3167231e0c.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 05:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490353; x=1795095153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=;
        b=L5X6P+jhJ1RKuVyG85YpHcptVAQtIU0esAwNJmsdXPUKFNdSedOw4BaIrpEkhkCLR4
         0MggITV2x3OWGouZnvMnOMQBMPwLja2jq1DSVGAAtvNs/X6UGWFLR5t/Zcjf6choEzPO
         T5hTQwRsn8azfeqqedN7IrfXKZUJpxPFxqJHmJ3ro1uUPZrciu7gyVdGkFMNUBg7CijU
         eArnNw3+UhzY63rFtXn2/gkiZaQMfwvrjA5YZkUMrpVwpwpgG9IgXMG8kO1Hbj5E9V0h
         J1nALUKDozoylV1HY1Ru34bxX34I+lr2pOuSq4mRyv/sAuTwA6NFcuAEkCsnPysK7bGm
         0Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490353; x=1795095153;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=;
        b=cIgnQp6Rt+OM3PQGDT+7OX5dhe88kGlSt4AVdRpDa3eNvEmNFaXVQWrLjB7n7m4qdm
         T51HxvuyC2kvY+lyYUWckf4Yr9VbUVi/DdeUWfI+vXx69V+rMu6Eiglu4UxunU7Faupu
         VLZy6J5HgEQVKehivupACzMp0rqAJ+K3+g6SFKm/cO2GEuc6YQPr8YSdVHLllORPRVth
         wQoO+v9caeNo1B9zhuK54bVwi+RHTwbeyP3QBjGgqkIePWlMdMHmr18lnXnj+sVwYeTD
         w1RnHS3sxRs95EqRyGN7Z0b1Q2V0ZawPI/ySl1JXEEgI0ryE+u/LCZqgav4jxc6WDzFh
         0oRg==
X-Forwarded-Encrypted: i=1; AL+hErGRL/bMTtUsgbEOsqbaUloDtmli6JdSgdjQYuzYl5e0/eH2ES8vHFbspS3STheMpRUIO8UDzUqHF+/TVyST474=@vger.kernel.org
X-Gm-Message-State: APuU4Z8p2dgRRkgszhcWq7Ykv0DmWcHOx1ttrNqcvULhon+Z7DcI3HxG
	MeywCajp8AfQciH60DpZGEbWnR8e61iFrHkUokZ+ja3ybarEA8AQ46E7G3bGJoxlNr7CFh/R/6W
	U2dJxMaorckOeTz1AxGXcYXgCOZXbpz9swc7GCq2g88bUA57CUGpm9mQ1UkWouYsLv2JbyAc=
X-Gm-Gg: AYBFou0V0xNnmhEdKfLD0aM41P74+9PAvTR3mPHEQReeZpHf0RK4bVPxjrSSpVZ7nFR
	sjbLH1BMLLPeVIz2jy8X9UqoTcLle0slGka3BaTHSn4KUrPV7lc4chE/EnMrnxiEnSXCdWpJMH2
	SGmUNM1oN4CKkRZX4QAqGqeSQCRKNsNq3T09fqCZf9WJjgPswRNmWGi6fLctG6AAXE+UAl52coV
	oEM2z7yJp93jeJntDNTG5ZhSOtJT7ymKvLLYAToFE2Mr0cuo7NExk7FAoqswKTmcT/q8Zmcivkr
	Bt/vXbvQcW6eq9NiKA23SBz92TBvqpovM3TaOoGSxfddXsgxOvMNNqECYeLoRC8sVWfK1tx6EUZ
	2JqX9xvyeHomLZ7FlsZbjX3H5kLgQYyPsWmKe2rseBRtDDRQCBKs9KQfmw345W8h187U2/2/EXs
	mtzA3T3NeCVDy6Q6bkN6V0YzhYkSA8zGeoYp7jjPfDvlGLAAlLhmtmB9K3hcJViFIwhFFx5O62L
	rWJh2hDDFW2jeQMuiTv/Bgnh0HJp2X9cYDriIGK++KK
X-Received: by 2002:a05:6122:e153:b0:5ec:5f1b:f725 with SMTP id 71dfb90a1353d-5ee1c4862d1mr2361243e0c.23.1794490352751;
        Thu, 12 Nov 2026 05:32:32 -0800 (PST)
X-Received: by 2002:a05:6122:e153:b0:5ec:5f1b:f725 with SMTP id 71dfb90a1353d-5ee1c4862d1mr2361193e0c.23.1794490352219;
        Thu, 12 Nov 2026 05:32:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a6a4195sm339950666b.86.2026.11.12.05.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:32:31 -0800 (PST)
Message-ID: <6876daaa-1e9e-4f69-855f-53dfb2b8a7ee@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:32:30 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
To: Mark Brown <broonie@kernel.org>, Dennis Gilmore <dennis@ausil.us>,
        kees@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, gustavoars@kernel.org,
        linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, dlechner@baylibre.com, linux-spi@vger.kernel.org,
        miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org
References: <20261112025252.71375-1-dennis@ausil.us>
 <179448342405.66517.5463730214277229760.b4-review@b4>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <179448342405.66517.5463730214277229760.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsnYSmWN c=1 sm=1 tr=0 ts=6af5bff1 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=_62txuixjVeDG2zLGvAA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: Cz8hOQzb1Ipr0fMMQlmb1gtbVo-6fIFo
X-Proofpoint-ORIG-GUID: Cz8hOQzb1Ipr0fMMQlmb1gtbVo-6fIFo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX5MUFnSEv2Sgc
 YhrygGnKxDhwj9XN7mLgOxR3T3rDw8cydhoaAAQZGLIjMxZCY/Ts/U17LzHRwDnLLYDLvsRixoP
 4w4mCZGdLTM3A9XrL8q83Siw3OLPmZdfeuNKJyPYStXSp2/15CaYwDkMq8wgOWMP4xnU6HkU6vo
 w9/sNBpxWRAv6Qei8cYnD3ql7dbp5hjWkBw2yaQrdocNfiYuHY5M4ieGHqVgzVPvV/k964O0n/5
 fvicu333ArJpALTHUgxJe1lgBQNMSmhorYf/0Tu64SzIVUy8lUbDdYnno4UUZD8IKiIioaIO4Jq
 eDg/455KRbwG8j7YhCr0FDWS+h//HJ3Ff7/11kaHstbV57NH6AwjjZ2rbjdHVC2UKw1kqSn8AzU
 CfcC2rwlesYMfAuEtAWr3Tl2Au1FQ5zAIN+xnu1jOx6PCSnO1xyb8BHDeg6MslSABN//rAGsEs1
 Q+axwvhVVlIWR2PiNFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX0qIAn9rXkZZJ
 h/tYyb9ccyav+OqGwdSfkNgUFqetNjXM7EPvqIDmPqFjqxAHFs5oGRWmSEU5tqt4Wm+XRyv67Lq
 OjQqk+eBqThseNdINXaijSshb/P3k+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120053

Hi Mark,

I was about to send a regression bug report for 7.4-rc2 but I first
checked the list to see if a fix was already available and I'm happy
to report that this fixes things for me:

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Also the patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

On 12-Nov-26 12:37, Mark Brown wrote:
>> Since the conversion to devm_kzalloc_flex(), the allocator sets the
>> __counted_by() counter num_components to the allocated length
>> (num_cpus + num_codecs + num_platforms). This only happens when the
>> compiler supports __builtin_counted_by_ref() (GCC 16 here). With
>> older compilers the counter stays zero, as before.
> 
> This doesn't apply against current code, I think this is an issue that
> was already fixed.  Please check and resend if it's still needed.

This applies cleanly on 7.4-rc2 and fixes a regression breaking
audio on a lot of different devices there.

If some form of this is already in ASoC-next, then that needs to be
send to Linux as a fix ASAP.



@Kees, have you seen Dennis' remark about the

