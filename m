Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF51CF94;
	Thu, 30 May 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086249; cv=none; b=YPbrfNmijBiJ7QnYaguKxBJaxkCxUSPDNrASTAqoswlXiNywy2bISxQVxxasghy/Xl1Vlj1Ixxz/4m+LvaCrOvcH1gsNXCkFKD45mr2qCLJoNx64f5M8ChGo/+ewVs/zyxLxU40ZNHh0Tc2Ox9MG2F5sU22f1MfbBjA8z0p/SYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086249; c=relaxed/simple;
	bh=aJ20LOEycqgOS0ntOQDxPELsgzP44QuoLfi6WOPQlys=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oNEsq5UcysLROb6xpjjvbA8GOXXEeurrEQCX7D7WEVWybmDDfKrdy0r/Upv54JKgtF7eXwYkqBrQXNU+I5TAs+pg4eeFE4pZtP9WmyePRBSfZXimXlohimgEtztHOqpUd/ANKsRic43Kbfac0pdZf+T7bTmkZaz9murlydIK8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h9H3KcH5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h9H3KcH5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U7anR0005158;
	Thu, 30 May 2024 16:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fOZoNt0z7G/qYqANSDfAaU2dNxrMggq0DIG4LNBIFKE=; b=h9H3KcH5D4cuq494
	y6h0Xjfpxao0mHdUAMtvcoLgXq0HoljKcCKoWWJxosUR3qGXOJtq1aIts4soI+zg
	jlhApJBY93tn6DvfRhYq8SlLA9jU5aWJVW0hlVdBdUWuVwuHAu7oCP39GAWgDazy
	9CX/S2WTjL4WY3R7S5KCmhvTbZKqRxFG/B/G6JDIkc4OciSCVVV5dIImWRxRFCij
	oZ6oN1hunoTSRFfjCbTyTAInYlnIUDAYcM75XlRTPSjsw75JQ3pGczqKVR240Q0I
	mAQ0+adr5yC7UF8aIregIpMKtAGgIpSLLwrkEDUxXQsuI48KSTiALniu0jFLIZLD
	vKPFKg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjcnbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 16:23:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UGNc9p014949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 16:23:38 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 09:23:37 -0700
Message-ID: <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
Date: Thu, 30 May 2024 09:23:36 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Content-Language: en-US
To: Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tGjkCqrB7StA52j-IJboHQcZRhiSojoX
X-Proofpoint-ORIG-GUID: tGjkCqrB7StA52j-IJboHQcZRhiSojoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=817 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300122

On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
> 
> 
> On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
>> As discussed in [1] add a prototype for __fortify_panic() to fix the
>> 'make W=1 C=1' warning:
>>
>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
> 
> Actually doesn't it make sense to have this defined under ../string.h ? 
> Actually given that we don't have any string fortification under the 
> boot/  why have the fortify _* functions at all ?

I'll let Kees answer these questions since I just took guidance from him :)

/jeff
