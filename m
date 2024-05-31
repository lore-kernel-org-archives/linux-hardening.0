Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92F17D352;
	Fri, 31 May 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180158; cv=none; b=tdWu//FQInQBHDIn3sVBTMKVlpU+7G/p/i3Zn5BjQV0La2bVFAys2NFc+tfTWqC+AoMOjr9qubwX8YzfFXPFpzdyNx1QuulzYbER+QHvku/utHsJ8Y2p3pwoCZaCvRBD/B3vKFS/JbRmaJzFVCAG+fDCX4G5/dlTziGplVrZeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180158; c=relaxed/simple;
	bh=u9zusHs8iZfduvp0RRZolTeGcxZDFHG8eD1tE59rWqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d//0e0vuMkXRJJHDty6YQ3uAI1CCRQSNKOEbOiJtygsnysaQqjpPStZBHp946mDcV8b9uH2SxijNrJRX7zCa7MdbsNL6ymlV+3QcHosmSdTHOj68/qmlvggZ3ndGXYq/FgJc4eWdSUkgZJ8J47gcWQB0oyG7Hr4oTPGnpzK7P1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mObYwxs7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mObYwxs7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VEUVGd015681;
	Fri, 31 May 2024 18:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MUcVFMrpKY1dztBaKj7dGwSNTpNh6Q/jOBtrF11FzjA=; b=mObYwxs7d204TzJo
	yyfz4m5Szp5Qg9hZ5uJiuzpev6mA+QSaHwEX/41tClFBTeBU/RwEi2VxLsSNr/rG
	OX7k/mwvQW4qov/avwnkF1OPl2J2bQu3Z06kV54OR998AR5FryxRicX6+E/yWDA/
	XmmwfTokXNINGI5iCH/Qa4cQkiw9ZZrhBonT/VlJ0Mo5fWF1doELlSWtSFNl46GF
	EKcaNqKbiKS+FgCEtETzuUfT+ZmR1ZlXOiGMxC9hIDPNLVCwjnb9AJXAXNYIWJ1C
	4cy2pTIuVjKhgjgVkBKxKs0bwpA0uQpGpQsWzOXpNzuDnfOwJdzxFmSmm+nZsgSB
	qsmIkw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ydyws7ksd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:29:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VIT0Zs013830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:29:00 GMT
Received: from [10.110.11.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 11:28:59 -0700
Message-ID: <c19aa2df-adaa-463e-b3a4-843f04538a2b@quicinc.com>
Date: Fri, 31 May 2024 11:28:58 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
CC: Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <202405310923.78257B2B3@keescook>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202405310923.78257B2B3@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8QYmh73Z0jEAn_7gfYKIWx9EKMsE4QDb
X-Proofpoint-GUID: 8QYmh73Z0jEAn_7gfYKIWx9EKMsE4QDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310140

On 5/31/2024 9:28 AM, Kees Cook wrote:
> On Thu, May 30, 2024 at 09:23:36AM -0700, Jeff Johnson wrote:
>> On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
>>>
>>>
>>> On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
>>>> As discussed in [1] add a prototype for __fortify_panic() to fix the
>>>> 'make W=1 C=1' warning:
>>>>
>>>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
>>>
>>> Actually doesn't it make sense to have this defined under ../string.h ? 
>>> Actually given that we don't have any string fortification under the 
>>> boot/  why have the fortify _* functions at all ?
>>
>> I'll let Kees answer these questions since I just took guidance from him :)
> 
> Ah-ha, I see what's happening. When not built with
> CONFIG_FORTIFY_SOURCE, fortify-string.h isn't included. But since misc.c
> has the function definition, we get a warning that the function
> declaration was never seen. This is likely the better solution:
> 
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b70e4a21c15f..3f21a5e218f8 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -532,7 +532,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>  	return output + entry_offset;
>  }
>  
> +#ifdef CONFIG_FORTIFY_SOURCE
>  void __fortify_panic(const u8 reason, size_t avail, size_t size)
>  {
>  	error("detected buffer overflow");
>  }
> +#endif
> 
> 
> Jeff, can you test this? (I still haven't been able to reproduce the
> warning.)

Adding Dan since this comes during:
  CHECK   arch/x86/boot/compressed/misc.c

What version of smatch are you using? I'm using v0.5.0-8639-gff1cc4d453ff

In the build where I'm seeing this issue I have:
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_FORTIFY_KUNIT_TEST=m

So that conditional compilation won't make a difference.

Also note that misc.c doesn't include the standard include/linux/string.h but
instead includes the stripped down arch/x86/boot/string.h, so fortify-string.h
isn't included.

This seems to come back around to the question that Nikolay asked, which part
of the boot code actually needs this?

/jeff

