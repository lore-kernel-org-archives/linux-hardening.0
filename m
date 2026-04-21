Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8410A2DFF04
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812620; cv=none; b=LvOL9xhqHg0ZzVXczKnNCsNET6/9ssan9nmL3/WHYXtLfHgMw1SNULQxKpttAWVoov8yF0v4x4f462yRNl84uhMpiwr65BaIR/iTaVb0P8NwygtQJ3+ct3P6W5Gvg1eYQN93x34eOZYzOsqkBBMDMP3A8/mZ1olHL/pa2qNrkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812620; c=relaxed/simple;
	bh=WeQlN7/klHm/dv0uvUwPM0q8joCUvLWnJ3Sz9EmDYX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGeVifenimT4gTc+iTP67x9+/YRzb4BTmEKIC/E4CoSVWy25qkGaLrzuWKDBeaVRiGPqHSlRkwyRRydMMIckleR3vvQVrUIzKenA77vZg3FmX849RuQU9QZSZs9AgQLly4zvy5rFTaGlDhN/8GvKPOnqs6bcBpOhX0l5b2XYHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C08Wgs/D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHIK0NjT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C08Wgs/D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHIK0NjT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZkOF2000973
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 23:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQZP7gTwR4SY+QJKGb719xKlN345DJF+yiTx3Ot0K6U=; b=C08Wgs/D5BxxsDTG
	uPClNrUhhIVtPGrJtfKL2LUB588QQ8kyDjstsGbE4UXFhsASAYMSh+JZHy5SJ2vB
	aN5NgCAvsYOpIN8NCVVQzct3pAQ6vgiek9Z1JozcJ4v1qU4JsVKQLRYSeU3J8OJj
	ogfCl5FopAB4xHRwv1y7e6G2RHwTOjDVwMeqSxAnBbWp+Qkc+Vg100pm0li5U+cD
	GfDOUcO316dvWAgurOWU/ivbbLjhlvN87AS7Vv486IVRmd99WnnqUzdKGsGnmg+A
	vIPW8FiDoTl6FTo5i1+5q5iWah3MsWL/kOkURIBUNY9g42wysoGYnOlCF5dQrzJ8
	GD2Gaw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenf8r6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 23:03:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12c21dbc9c1so13917833c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776812618; x=1777417418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQZP7gTwR4SY+QJKGb719xKlN345DJF+yiTx3Ot0K6U=;
        b=KHIK0NjTw2nSDeRPS9Tf2RD81Wru29NeE1dlkQLq0tI4K4Z/PAT1GJHkA/kXUfjxoM
         coknaeAwGwlb0pP0KuD9crYctyju3mIBje7fE/5MyuFlzCIwjPa5mRH9FlEFJPvRF6t4
         EUwcdcjT5OK2IEa6vvDSBEC+NYS06FTc7eIFhfckzuG3zZatAneoX9PJc9+ep/z51Tn9
         83lsOiEOdm1NLtwtxQegX3EIIIQn8rb2hYJu75bt5BrqSJ6JtV3wDDbyNpTEtlgHQ7oK
         b8tRFRnJOXDUTpbv52OS/DQDQF9x8DPYPA5xUCU56lgnluRLMhrcm4HHHKzFZ4fnNuwg
         A/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812618; x=1777417418;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQZP7gTwR4SY+QJKGb719xKlN345DJF+yiTx3Ot0K6U=;
        b=Ce1S+b/CG3e9NueCIzn+1PEhfqDxRHqPr5hDXeuWV4711HkDCEXojVZjumDBGfVuBw
         HMviw/C2IDKXnNWhkC69DeSb8f+ViAx5Co5+ASGldVNvR1Ikm3nNLYJX3LkpntodHUXS
         YaXpxAEUyC77n5fkESgZGM5UUP56kNIoS8hLkqyN3FJA5qBGvpzJdC4Y33BsRlCE+3Rf
         5PSCg7CEVCF1GUuyESuRZihHvHAWEywrc30KlMS37/9hK99TfGfrEzH7OEpCDCWd9iLC
         Yakt1LY86aVFwIire/mH4Sne4/eitDfDMzEBc59uy+G54gM0GmpdCYAmd7yVhASRjL8Q
         gjtA==
X-Forwarded-Encrypted: i=1; AFNElJ9LP6RVi8NgR3dosQVAp5qH3Nx2iqy41MIymMsHVoYAubEteu+1EEXSqXZJ1TMYSADHfqLjT+Jsj+1FdTllHws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1CUD06/dt+cdJi/gAUwVcy45VU0PdLNzmzA0Kbq/zSFA3n5H
	6OTg614PShQUhoRF8wmr06ZA5MlQakAYHvk/5HznzPwy570qItCeupCvPETdaxZeoE9XyLAd1Zf
	t4NWX5MVtEFW6yxXejaGMAn9Sh4d7qVqF1rmgvgtf9S/R583p7JvlBUlrEvpcxL1qYVd8QEM=
X-Gm-Gg: AeBDietLeKtMudgeC6N6EVYekwIfcvQ3m0VF8m6yJqpAptazyas8BNMUebiDOlRCKoW
	xlbIX1gtKVNpShkju1JgoGmh7la2vNgRxZ4okxAQ5Ulk2dIUcyMuYBDbWguj4I9nquJ5hKocbpN
	QO/s7JzmEiSby5RE1iWw+tAEISnYn4BxLovUpqy4PChjyJo6HAKmHMESxjiC+tnZppg5yJ7zSV5
	f4c71oEJdc1iV3+E2edZLwzduwqOSTkJPJzTZwHjGj2NFGN80H7BsnOsIHwyl3IHfC/8VySSMtq
	ujt0CzaqC1FDIyszupPOF0tS2ye/3FaM7jlRfpfmweWkHXClhi68b9jmRSLwQKcO14FMza3nQpa
	7D8EV0bFDw0tLoDvvmkYBY6bXYGfMsSW2lx4+iobEUqXFpuEEICUKDU2lL8KNOSeS30EBDyfbW7
	Af8Te8t3gWpv0YmSwouQZqx1m9
X-Received: by 2002:a05:7022:4586:b0:12d:b7bb:4f54 with SMTP id a92af1059eb24-12db7bb5581mr1624408c88.3.1776812618071;
        Tue, 21 Apr 2026 16:03:38 -0700 (PDT)
X-Received: by 2002:a05:7022:4586:b0:12d:b7bb:4f54 with SMTP id a92af1059eb24-12db7bb5581mr1624380c88.3.1776812617542;
        Tue, 21 Apr 2026 16:03:37 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm21141603eec.28.2026.04.21.16.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:03:36 -0700 (PDT)
Message-ID: <ebca61af-7873-4a6a-aae7-151e81b328e5@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 16:03:34 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260313001608.118294-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260313001608.118294-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A0-dErQfC1zH3nrHtRObvKfe10x4H70Y
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e8024a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDIyOSBTYWx0ZWRfX3V6gyY6LzAO9
 OUPjzQWx7i0KBXvdGNe22yF8ZqqrAKZPH4oA6h2qyV74+QsbGm2tvfEoybnHxQ4WjdYIhOCHGq/
 FsHjK2EwtvO/JzW6kQ+PHLzKgYlh5BtGDiiPG9n94YHiO80HxmBCdBW8wik0mZj0qoEWxegf2fi
 Ka9jVbX5+7gIPk1/FjT/zEZR71Iw8Vlp2wpmHKntWPnLrZmFw1Mz//lsTXN5IAm6Y8HsEbrePSh
 GDcqnhGhVF3dSFVy91Kcuo3iqV/EPdfKZbWTHLwL3uVKVQ4v0pzz0mNqprUXYPyOiJmygeIS88D
 BCCH5emc3bAsrw6iPSMeXz/lMXwmT2B2ij3xvfxsZGrvqDejZEU+BO4CylrQdN39DIMOzLo4xH6
 LwFG/Hd/60/Pzv6AJ+4Icq8PnwXFusdUbFm428jHGYwQvnA3WxxjLxwibWClU049NL2pK8qtb3n
 ZFk7wfvrS2CJ6f5zE8w==
X-Proofpoint-GUID: A0-dErQfC1zH3nrHtRObvKfe10x4H70Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604210229

On 3/12/2026 5:16 PM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.

can you update this like you did for the ath12k patch?

