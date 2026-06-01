Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483BC21C9EA
	for <linux-hardening@vger.kernel.org>; Mon,  1 Jun 2026 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284305; cv=none; b=I9KBH0/igSr1IhHiYTSJvPE4mSmww1Jen0Jv2g5uf2oM0W2aituYzj1AyuwOdbfHJMI2fSeFNFPAyAtVZXX1rzLwI/zze+hFWEcfPGJmG6WekFOXfthGCVQgds0HKXrhK3SGvN+QWpEypD8z6XkQiY8T+Z0Q51ldTQHl+f/j9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284305; c=relaxed/simple;
	bh=VP6sauZMZwXn4wNr4p0+pZ01/o15I4fRoix/G1TpgKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tfkes4EcEkIlTSZ+1/bEy5N+KDh4MRVer7v4qyoSUnn1sPzHgJ1giZlPogE35hQAQHuI0YK2qiv3pGfFTC73yN42xBsX0ARA95MDGaKnvtbFBZRSYcyp/btRBUxYzBa4W8E3lJ22R2MA6KIOBG1JDQFLIaDZqSe590Ybj/bGyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QH8QI07D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PW/ATQIa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QH8QI07D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PW/ATQIa"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLKAIU1785919
	for <linux-hardening@vger.kernel.org>; Mon, 1 Jun 2026 03:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/JZ5XV2N5cB097839qKqC08HOp1yb7LqFEmLdGxS4dU=; b=QH8QI07DCs4ZZAJb
	AjC9H1rpICoohuuDzltFQCgTkh9khJo9+XOOIwU8iuWlYzAF4cS7UXFTxoG3ikPM
	kr7dWcOQuayaiTwvkUJJgN+BVOIJzEAK/Z+hwPdj/LROPEf5z3mtoNFjLvc3ui/3
	7J0bf92+YYvZrFLRseDYCnJy0AhgB8hDQ5yQdAP31evdRTTod4u4cnIbQB0pS3Q6
	MJIcq5IsOZa/N/C9cPMKcmyTH8lC8ArHZQYkZ75lC/HWyFDyeVAWTOasaKfoJ3rd
	KL3INfwklejBNxmAzOsyupb5ZzANPEst9pbltPRtGuiWo5uxsskJVCpdykqMxNWF
	s008aA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efs66w82f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 01 Jun 2026 03:25:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-842208d5b0eso1296795b3a.3
        for <linux-hardening@vger.kernel.org>; Sun, 31 May 2026 20:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780284303; x=1780889103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JZ5XV2N5cB097839qKqC08HOp1yb7LqFEmLdGxS4dU=;
        b=PW/ATQIaPQwU0M1zYEN4y8rusr9ko9YS5//c1InT5PBQR3BZNfoyuoa5NMnTNeCACm
         xc0EpE/Egizd265lM+KeHQnxL8lMJjd5sjjQ8LkVGy/ZOvsyk2b3uMP6kqw9gnwa1cyz
         oBmEtgRV80Z27Tz2dCpLPZ/nUxaOSgD/7SGHT1h4MpRJWB3yRjBMbdSsh6z7mE4YgX4q
         JSQGsIvbiSHfomQbkLkz07vbPJKKhtlm0ryOsEK7x5rCFLEQjksYbrrR3mco/Vz/WoXz
         oh+NygQjvveGDFar/2Y3a2SWsm5+8j1fNplK2Zb4d5OTipg/mvqz1idQERS1VHIDBPjh
         rBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780284303; x=1780889103;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JZ5XV2N5cB097839qKqC08HOp1yb7LqFEmLdGxS4dU=;
        b=RCzg1YdWUrC3tdVQmbAdZFZoS8Sp7Qzh/bZxDZ7kujNeofdDv7coqXECThUliRkGBV
         JAp4UkuzN2IySYVDhH6Wl2s2D9Hfk4/CjrWvnQd7znD9oa/+AT4tYUFhPK9sNncKNJbb
         shLD4lY0Do03MiEkb/KXXTOcGwsfmMng7u/rXkE1YzRHcwOE2X6ihiVKY8VDbY8vhX6E
         M0d/VpUlvrwDolxsS8CoXKxX3jbe3H//ie6ry0ezp2MsYj8S/XIM2xIhOJx/31rOXN4J
         7mSm0a02uSSuUr2DI3tChN2frvC/94Alp/njgzaFPYCZD3BaHZI3QZNZCdk8iEdsUx1O
         BkNA==
X-Forwarded-Encrypted: i=1; AFNElJ9Jl4eHtQ2+l4Lu1VcVP5azSg0kEicV3wQYExwS8gWhffBeqCqaU8mLBM7VYizpmRecBus4FkQ/F2ozF5hfVmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyBUpWuJRnJ4oC4fD0ttfmKwFBR/ojYOjqGhj2DkPwbWATXuC
	QsYyVYBcjQUuEafBfOCTSrHnm/nG9jNLrPN+UVuhOZML3EmPkZbIOdjbNFmcaH7Ffs9uv/wzWbO
	gYqvqDUMfPG6qJJ97iQNvMuorfmoQKyThTa+DDtaAINQuosiTNOs7pXHznE2UgwuJx3/Yvg0=
X-Gm-Gg: Acq92OGagE+n/JeEnq3NZl8qqwMAMfvP4Z1/cc4ZRePbclPGEN7P9aBSyTMm1mI7Tek
	Wz5w9H1UpH3TbTIV6bM6Ioa6vFCm5nl6iLmu/MGuS/sYWDK8ttUmLjcIpYh2lTIx7dFQC7p3lDc
	BtKcBjEOd9o8YlldLvDYHcy8oVP0zfp942UPRXgcOvxJK76iodGxs0KfkgeBbKQerOod/dcfNOI
	HnWm4A16cx1UtxhXGf1aid+6EyWTWWwQvSlj4MkxbpxwClWIdtv1FeXabn06DYNo+sttY4qycq9
	lGWJw3GitnvMQP9MAEJjyyeuUGvGky3S7ortYA07HVRGW7+P+h3fgqxPRr5Fng9Hs7hxYz6IZIo
	/c3DJxyKpdm4UcPrLyqz+01vppXfMeBTkvXy5zYMTfHp3J2hgtagXLgW5kx6x6y7RvGuc5Sfpvm
	oTWoAd6kPL2VANWYITXuVDeUaQYI8u
X-Received: by 2002:a05:6a00:1598:b0:842:3373:f65c with SMTP id d2e1a72fcca58-84233741221mr4676271b3a.15.1780284302908;
        Sun, 31 May 2026 20:25:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:1598:b0:842:3373:f65c with SMTP id d2e1a72fcca58-84233741221mr4676250b3a.15.1780284302455;
        Sun, 31 May 2026 20:25:02 -0700 (PDT)
Received: from [10.133.33.22] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842263539a3sm6960360b3a.44.2026.05.31.20.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 20:25:02 -0700 (PDT)
Message-ID: <0c3a4a00-8d6d-4432-bc11-12d0c5742286@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:24:57 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260428205017.26288-1-rosenp@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428205017.26288-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAzMiBTYWx0ZWRfX02an01mcZTqy
 6cahveHQSVTKEDd/htG9uxDdAEA0YqGZAmLTlEu8T5PpG1O/65fqe2zS/AW0Bh0psUeJB+9g0jB
 CYi616g/WTzecDiGCRsXnW9T9BfBybSWxZMNpxa4KfTK7FFQa3X/eIqOoLMz+2i4K99OVTjx3xQ
 txAFBy6OjBbYYYFSOGddAmYxWi2DY7wSAb54EftDuuudXD7aiQqANYEW03VOYSURxwUKOQReXdv
 /stFfq35eALCTXD0+CExGUXDlBBuV/mPilT6rb3lsc9FAI/hgDTRTvZvULEytF9rli5TIdPnuIB
 khNnwARTVai0fdYg3VDtJAUXgpTJZxNqkxzKFnuKIzAC2T9ss2ff54f6cj0EjcgFVB8B8GxLVX7
 F+bqudOcWkI5wLSSyo02vX/NUYv71hPmBhOysYwNwq4bwsUanOSuTyPBXAETvGkm+mYFcI9WPLG
 TSgqH27UbY4J0MN87BA==
X-Authority-Analysis: v=2.4 cv=X8di7mTe c=1 sm=1 tr=0 ts=6a1cfb8f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: UST7sdTpghff0OGSWB98libXvQ-c_NNF
X-Proofpoint-GUID: UST7sdTpghff0OGSWB98libXvQ-c_NNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010032



On 4/29/2026 4:50 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
