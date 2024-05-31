Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33747200B7;
	Fri, 31 May 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194037; cv=none; b=QpHbhAOdYzm8FM6DMsVk21fdDHtcdbyHjVZayzwhiG1QknVucMYSgLxcevW3z3RGloSuFCfVTNGxuTeHoMxftT00y8TmNnDgReXlyc98I5chQI7gG3saUh+9P9R0yJEcYBjUKc339gu49p7/IF45+N6QRj/0MYpGIHX7kbTHJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194037; c=relaxed/simple;
	bh=3c0IvTL5z3oMH0RomYMrTIOJkyINupn1llC2QZEzO9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fFnpYeVMkBe7hsRII1B65YMWQNVtCsdwXmBuPUOoBBYP2ne7BuPfkFQVWTrnT348v52o3iYk1B0c5UAm4bwzSScgOH46iK8Hafy3L+ADejDQY6cPx568oyhabH5L9WADR5qybC3XBKkzLG+64+i8awjZYXxrSVWCQy05Uqqv/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JfJhcFCz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JfJhcFCz"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VGcPfI012130;
	Fri, 31 May 2024 22:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8EeTbS7V3xBsQQmjVucu5lZPJSlCH65R118shwfNRWY=; b=JfJhcFCzXmYvV5Z4
	VqZJX2qNTG0MAx1onO3i1MgMlaXcwgY+D13AIYIi79y5d1BJIeMWzPA6v76RUAAS
	BTMhurTyaPth9zrIvxgnYpheG6ROwK9sMM9UXyP5ngC94iaKRD1jcCXjaukkOYYw
	x4wvfTAsxVe/Jd32TKf4i45zMYv47l8C+PsRJB7EjAs0r2hYG1UeATEc3CgMo72w
	HbOHggHyxy22bdvifVHT3f4F1f0llO9AeGLGZdh7eL+7uCUg8tXoE7AXdDGywHDl
	yVVxcPJk6MfoMZWs63h5PfC/uhL/0M1tmDQ83IbWkya/2BnxJmDKdqp5sJemMaR8
	ifQglw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0ggnke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:20:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VMK4IA024521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 22:20:04 GMT
Received: from [10.48.241.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 15:20:03 -0700
Message-ID: <45b0265c-8aaa-42cf-959f-04583269cf99@quicinc.com>
Date: Fri, 31 May 2024 15:20:03 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Kees Cook <kees@kernel.org>
CC: Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
 <202405311345.D91BF6E9@keescook>
 <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>
 <202405311359.EFC7345EC@keescook>
 <20240531212009.GOZlo_CV0lxZ1xviQW@fat_crate.local>
 <202405311431.BF9FE3F7A7@keescook>
 <20240531214545.GPZlpFCaXtTGinbcfl@fat_crate.local>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240531214545.GPZlpFCaXtTGinbcfl@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UYU71hobyl1PCXp2JziDIHJZy_Y-f7xE
X-Proofpoint-ORIG-GUID: UYU71hobyl1PCXp2JziDIHJZy_Y-f7xE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=857 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310169

On 5/31/2024 2:45 PM, Borislav Petkov wrote:
> On Fri, May 31, 2024 at 02:34:07PM -0700, Kees Cook wrote:
>> On Fri, May 31, 2024 at 11:20:09PM +0200, Borislav Petkov wrote:
>>> So I get an allergic reaction everytime we wag the dog - i.e., fix the
>>> code because some tool or option can't handle it even if it is
>>> a perfectly fine code. In that case it is an unused symbol.
>>>
>>> And frankly, I'd prefer the silly warning to denote that fortify doesn't
>>> need to do any checking there vs shutting it up just because.
>>
>> If we want to declare that x86 boot will never perform string handling
>> on strings with unknown lengths, we could just delete the boot/
>> implementation of __fortify_panic(), and make it a hard failure if such
>> cases are introduced in the future. This hasn't been a particularly
>> friendly solution in the past, though, as the fortify routines do tend
>> to grow additional coverage over time, so there may be future cases that
>> do trip the runtime checking...
> 
> Yes, and we should not do anything right now either.
> 
> As said, I'd prefer the warning which actually says that fortify
> routines are not used, which in itself is useful information vs shutting
> it up.
> 

I'm ok with whatever you want to do. I was just following the example from ARM
where they have a prototype in arch/arm/boot/compressed/misc.h to match the
implementation in arch/arm/boot/compressed/misc.c

/jeff
