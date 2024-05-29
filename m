Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F011B810
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002591; cv=none; b=ReWguXWouBVprKsSNkDLev4xRxDx5NNwGTCKMAph6eWC+GYH4FEbTy7c9AxcrHCFvppMZm4FNFDod7IQuqTX5jtCTexhEnmifiO5ZbnZFRO/OWHxyOWrH6HtVYpG6jysIheCgR0AkNjlhGVMu1lbM2HBL1MMvaUzw4cAljjryT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002591; c=relaxed/simple;
	bh=TIA6XdquNQhRCkPJe62OcnLN3zmv4ktQFplASsa1O0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qm18nkyyZjlaAgfy7NZc7JXjK/WhOHCf1DihrkUWwzpuXVlcmIn+rgT5uBNfa8CDFI0HtGvqCduVtIoq9yDNeMTRpCgq7rqRtNlx7w/kFdgcpAjjNVJupMKRxxNFs7dm07UCDrXAisG3zzmtx4GbSYqLxBZRYilwPT5pM8PBcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YhG0ialg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YhG0ialg"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TAxlEv024256;
	Wed, 29 May 2024 17:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGxvPFJvxtAiuhAnXml1nml8Ee+E2MAad5eTlXyGCeg=; b=YhG0ialgKnb0DUIf
	BF5FyoI7mXt/J7U0IATQDjkKuVM0LLWfTM2dMzrICLn83B0Oc6emMw10Okd9zLHB
	MUNpELUZzuIeIGmb4P02ZmeL8AkFSxoaffVPsMVTCAUrFymRaXj0KwGKOmh8U9Rr
	OguI4m8hcsfpqhD4eqfF6nwAkSUeJ+5ci6qEmXLG+WK3NcpD4Qp2TWMyPGwKIIe3
	TRVTsPfZ2hZqQKHjdHcXXtHBQInadrVwAKkNeDUI7kLdLzgJ5BcGlBW7gBELCdGU
	/b/H9AFditVrqxL99W4rTEsRXvqmRdLZNZOzuEINGt08qpKS16ZC4GwD3QeopTQq
	uPqCHw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ybadx9mrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 17:09:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TH9kwN020297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 17:09:46 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 10:09:46 -0700
Message-ID: <1c79d692-bd2c-4125-8a47-7593b3229379@quicinc.com>
Date: Wed, 29 May 2024 10:09:45 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: __fortify_panic() question
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
CC: <linux-hardening@vger.kernel.org>
References: <79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com>
 <202405290950.7E61121D80@keescook>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202405290950.7E61121D80@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rTCQzRIUhinzLKM4bmvBmdywbjTiamBY
X-Proofpoint-GUID: rTCQzRIUhinzLKM4bmvBmdywbjTiamBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_13,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405290118

On 5/29/2024 9:55 AM, Kees Cook wrote:
> On Wed, May 29, 2024 at 07:36:25AM -0700, Jeff Johnson wrote:
>> 'make W=1 C=1' on x86 gives the warning:
>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
> 
> Hm, I can't reproduce this currently (but yes, it looks like arm vs x86
> is mismatched). What tree is this?

e0cce98fe279 (linus/master, linux-master) Merge tag 'tpmdd-next-6.10-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd

> 
>> Looking at this I see for ARM there is a prototype for __fortify_panic() in
>> arch/arm/boot/compressed/misc.h
>> And there is a matching implementation in arch/arm/boot/compressed/misc.c
>>
>> But for x86 there is only the implementation in
>> arch/x86/boot/compressed/misc.c
>> There is not a prototype in arch/x86/boot/compressed/misc.h.
>>
>> The easy fix for this would be to add a prototype to
>> arch/x86/boot/compressed/misc.h.
> 
> Yeah, I think this is the right solution.

You want to do this, or should I?

> 
>> But it seems strange to me to add a prototype to a header file that is only 
>> for the benefit of the callee and is not the prototype/header used by the 
>> caller, in this case the one in include/linux/fortify-string.h
> 
> The stuff in boot/ doesn't tend to include fortify-string.h (since it's
> sort of "outside" the kernel), hence the need for additional prototypes.
> 

thanks for the info!

/jeff
