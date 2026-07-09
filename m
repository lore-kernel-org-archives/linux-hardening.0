Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97F410D34
	for <linux-hardening@vger.kernel.org>; Thu,  9 Jul 2026 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596261; cv=none; b=S0bYyNgFqKdxVKDLOfeCEbl4rDhvHuW4e8StYZTwDvuasQCFKJBxQvR8bV/tpkMOBfdCf+eCHtTvHF6mPG4iEgq61m5iq1tGz061dMMANtDeNdmNhe786TVkQJGl/MOtGBoNJwxvrWuts0Y7lkBrtCeuQ+653I2YFG5zOTU+qdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596261; c=relaxed/simple;
	bh=CN5h3TyOwEIznSft0b8xErmSRMFj5sNT+X4d3LzCde4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv7S+vYPXlwDqamEDbFQEG8AG7/bNfL3YIZUyBgybeuuCBOrps7VEgZJm+MvitifWPGCSEzn/iQ/tLmdooSxR8fSM/9Jp1kTRZJAeLSwPSwlfjSUlqZJ6MM/dfZUi0snm06R1wTqslYDzg/ae4b/Os29oN8HW26fbZwjSBsNUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=je4FqlXd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NxVqN75Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="je4FqlXd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NxVqN75Q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669BO5WS1674731
	for <linux-hardening@vger.kernel.org>; Thu, 9 Jul 2026 11:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TwEVV0cJXSPJJj4UNs7yhLlyqJbVus2sdd9Q6EnUG1c=; b=je4FqlXdnHKAyBSa
	rdZB8gfHe70pTHbPgRgOG9sP8j3x5sts4MwxSNQT7bXIsIM1uGpk3GgjAcVY7c6l
	3vH1ty293v5pcSZyvTNChSWhVeppFflSyFp7/Q/kqCrdABwf35CmVcCIZGRxIF5j
	gCNvYeF71p14zRkKw2kmo7VbxxyR7L1xrilY1OQJmR0RbMBM2JY+JXhw0uUfQayX
	sdmEJgBOnUc99YaSFcxwqEPfyy1LUG9YKsq5FGeHTBSkoVxKwbvCKdq0+EYySPIk
	srGLRZnvyvlPmqntq2/2ehf0M4qDbZcWoRislMk9rseudcHUtj2h2lH/Bn6YFQCa
	F2zmGw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsbybk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 11:24:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21be5bb4so9532061cf.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 Jul 2026 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596256; x=1784201056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TwEVV0cJXSPJJj4UNs7yhLlyqJbVus2sdd9Q6EnUG1c=;
        b=NxVqN75QFzInA6sCLgA+zEndUK9tiJ8dXVmB6y/ospDk8RSfmaegCf2bRILn/e9lRV
         jI2DDN7CEe0wNZe7uq0fKLMqAC4CW8w8niY4CWHHYP9y467RFSV2x/W4LgGW3BhPFY3N
         onBYTxgJcC+lcyX2mY939783f+62O72Qh/XxsSw7xfAisRXnqYtuZ4Uy3QChDKDTiLKL
         Hb8ivpks6TB/Mr/BKFs7ZawdfmV03zpVSm9LMOWtQ7uATC6CQayM9UQaUIOtz7xqSiAl
         EQ81vjM09PfXbu8WWlQBhGzwf1KMKWN6JS4GY7I2uPcOTtfTZSwxr08Itmv/TTMU7gG/
         eEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596256; x=1784201056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TwEVV0cJXSPJJj4UNs7yhLlyqJbVus2sdd9Q6EnUG1c=;
        b=jRg4qurVmeWVV0ZK4kNsbcgLT4NV9Seq7tSc+sg+zvJrfdgbvFIrPJ6rKoF9IVCZjA
         KXwpMFYdY5fmI5SHvI5zWk+lByEHHF2T4IeDKJVztNTTXMT3p91pD9FGlaAZOfBb8rfx
         lLxjz63NwoP2CfRKZTn2FLccyoQaApJbeptw7fF/ZUpZmwChpL2/LN9yzWSS7X2m7NWb
         9hnQkonzkn+3mf4ZMDxJFs/EcOA4pjqbw2l6W7ae2HZG987sHq7RA8p2rgnrwYQeHpWX
         jtpEAvTHvwJjEqQ5L/ZLIhjLjw8VSKcu+voV2X7ETvDA8jHDI36H1nsWK31YSa+6PluU
         T/kQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzKJltnBTCP5Ht6zoWb8lgqVNqpW8nO4aMi5UXht0RQD1frZnPrAqm7eQCK+0s6Yq6cAWxx3e3TRTQ3Cik2Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5Yh/zevfepIoJKKAp6xaDwEGFHMCoshB1w2S1eDswkfV8xDg
	/XDbqWT8JQQ+nk9w/4YQkNy3jKqPeleLMjW/klAoWVy2zkSwuxhsMwU3T7QAWztZJ2Vn99Yuo6q
	0bi7cBJi7ZJ8tvn3ihxAcky6mXPWUeYhdZd3wDoHiTr2E4tu6OZ57JiY2ZlTE4WL3jhitEIU=
X-Gm-Gg: AfdE7cmJSVSqnsOszHUzOV/mb2mIEEl42p8Zlg49XplS17EEg6vGqR/0RPOapxDNMeN
	J72+1/k8vzkb7CKD/HmrjQDEBfxPtEa6aS2EXNFz0mljEV2tvyVpIuC/ZdpxALmsRAU7KiSTJkX
	+SoPjVuPRjfxlDYSorxnvZSa8HfahzX+vpgsywe7g3VlMDdkHKugaBuK4Brxf/cpiA2ejYfNn8X
	hMfFMjgvBsKozTTGXxFK3DF8WHZj2ZaXfHDrU/DpCTa3kkLeaTW8obrxS3EbHvlBoCjPE8Ts4Li
	MKWW1vgmkzCnrsBjKVTs6dgncW6rqjHWWYcowhyGssjpsYb7bq1zfe62bZgWq9r2/9Y1U8iWzrp
	0CKsv29iA+4/cWpkVy+hAPTZAHGIHDpq0E4s=
X-Received: by 2002:a05:622a:101:b0:517:8999:6c50 with SMTP id d75a77b69052e-51c8b512840mr54792411cf.8.1783596255910;
        Thu, 09 Jul 2026 04:24:15 -0700 (PDT)
X-Received: by 2002:a05:622a:101:b0:517:8999:6c50 with SMTP id d75a77b69052e-51c8b512840mr54792201cf.8.1783596255474;
        Thu, 09 Jul 2026 04:24:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c3f5ca3fsm291927166b.51.2026.07.09.04.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:24:14 -0700 (PDT)
Message-ID: <97ee8a04-6278-45a4-80ff-29f1b38e0ddb@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:24:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator
 support
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das
 <taniya.das@oss.qualcomm.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20260708-tcsr_qref_0708-v8-0-62c42b5fa269@oss.qualcomm.com>
 <20260708-tcsr_qref_0708-v8-5-62c42b5fa269@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708-tcsr_qref_0708-v8-5-62c42b5fa269@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDExMCBTYWx0ZWRfX03fnKCxZIb3H
 XrweTTdxJZuefGV7ICFcmO9uEzeFnGM8HJspS9gZEGbYV9vgVOO4PBmVj7RnohUKAujMMWGiDVL
 H/MXCIQP2ENDFpu+SRbUUl/a4wL0JYA=
X-Proofpoint-GUID: S6EQVyQKZiyq_JFFGFicFivtIEIVR9Ec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDExMCBTYWx0ZWRfX+rAisH9jLu1d
 QiSM4iW/L/+zeR9B3u/VpxlUcf3y9XJBBxzdaDE4ea7KbTwPArO17LSZGO4myJVKvU1HbQ8+7o9
 9MO7HeeyvaR90nutxP9ypXueBS8RI/mayH+cBBYx/fWW9XBG/+0S4RN5J63303aSJYQHMkJ9dU+
 oWX5wnB7GwZkO27+HaA+D1VeV3tzhw7EX4WDYsrDiFc93SbYRjppZNmvG2YJslxH8o7HOnvLJP2
 4Na+1ssgMYEatQCf+MzNofocAER9fsJ9s8R0IYKNqA6YVVKjW/VTrFIJ473CAMdvK0nRTeyG9f3
 OIAKZbHUhgDU8FpXUA9CtZyA9S27gsaxsflK6dyKwoKbv9UrG4BMxRINGSshSU4nv8K0MQiyKGJ
 Lv1lQm3PXLrtm/vum+GBnib2JH7BRTFSQYHL2c1H22y3jhrQtK5LPttRK+Z7JJ1nHmdBcZ6+bAe
 cywmjgvBittTnLrJYwg==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f84e0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=B6dnFezVkazQL_yb00wA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: S6EQVyQKZiyq_JFFGFicFivtIEIVR9Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090110

On 7/8/26 12:02 PM, Qiang Yu wrote:
> Mahua is based on Glymur but uses a different QREF topology, requiring
> distinct regulator lists and clock descriptors for its PCIe clock
> references.
> 
> Add mahua-specific regulator arrays and clk descriptor table, and use
> match_data to select the correct descriptor table per compatible string at
> probe time.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
