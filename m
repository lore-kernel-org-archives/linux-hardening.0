Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF415AD83
	for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993391; cv=none; b=sCXgnDWiNaFFCrOtEWPGPy8mmiXKh0HjtKwrEMNE/AuJpMUm7oDGW0bSEGaY5+1vMi6h1zvWC+Tch0lGEl1k+T+wGTjEKP35Hd+MQQFZNeU9esn+MbA11MyPkVWNmZzzUOLAeriB2l4QwiTJBKF0sdM7pxisnWNALMs9MpummOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993391; c=relaxed/simple;
	bh=iOj7Bpf1p0K3nnTt+A19FYM4Fv+AoQOVtTmZ3wGcNJ4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=a0APCgglXwtHe828izmxGfgKYtdX2qSopiKRZEBqgqaxOpD5+dIKXFQh+TdqbLNVJpcDedpddEM56sahUt/hE/m1kGFANLyKSenN7hf9cUkFpOpD1XnEQz0OecphhlsL60q++38+ACT+xMZGCSyDLdUF8wE0yBvWXHXZQm0zdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TTUND2Wv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TTUND2Wv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TD91ZG000443;
	Wed, 29 May 2024 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=CLuqfUSrEw+axmK7cyxb/w
	EDMnuYqO9huLcD37rrOWQ=; b=TTUND2Wv26b/RW1op/0OBAY1DBIW6CGJGs5Ikz
	zCafofOHx1Q0vd8QWKd2neMnv4RxpWsGiF15b6xLoh300bo2r8RFZwLBs1EDoTA+
	QDXlplLNDj8sTeeGrsKcURLSrAMl+jEs7XQ1ScGswywyhlvP/syFp1+NYcTUqLj0
	QkyH82bd76KNxeki1UKkKxHuleC4Ov7XatQj0D+vdgEZCA43FboJ1xUspeH5YIhe
	X49WAxwVPJOaml4gj5WITL6cbdPxbnHpmm+n2qD4chyQ3JWzwsbW5N0Qh5BXPSOE
	TzPyKdpNl8dRjEiqYqGwyoekrsINa2Tl3TvzKBVZ7rk0Aliw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h94p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 14:36:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TEaRJD023657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 14:36:27 GMT
Received: from [10.110.122.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 07:36:26 -0700
Message-ID: <79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com>
Date: Wed, 29 May 2024 07:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <linux-hardening@vger.kernel.org>
Subject: __fortify_panic() question
CC: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -EiyaXE0So8mxtIHpfshA-oyZ-eBG0ej
X-Proofpoint-ORIG-GUID: -EiyaXE0So8mxtIHpfshA-oyZ-eBG0ej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=348 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290100

'make W=1 C=1' on x86 gives the warning:
arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?

Looking at this I see for ARM there is a prototype for __fortify_panic() in
arch/arm/boot/compressed/misc.h
And there is a matching implementation in arch/arm/boot/compressed/misc.c

But for x86 there is only the implementation in
arch/x86/boot/compressed/misc.c
There is not a prototype in arch/x86/boot/compressed/misc.h.

The easy fix for this would be to add a prototype to
arch/x86/boot/compressed/misc.h.

But it seems strange to me to add a prototype to a header file that is only 
for the benefit of the callee and is not the prototype/header used by the 
caller, in this case the one in include/linux/fortify-string.h

Is there a reason this prototype can't be defined in a single header file that 
is then included by all callers and callees?

/jeff
