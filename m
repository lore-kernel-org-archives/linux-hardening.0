Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3191B29C9;
	Thu, 20 Jun 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901908; cv=none; b=jPYUM7FrELbldn5DcnYWXzhmrJobGHWX/BRZEASr3Z+r2X9f866kZ86Zd6Ry+Tc0GKG64yre8DL7qgVv/7smVN0vqJVI3qg2uCzfxiCccNHxkpzhJiDbJr83X+LVQGDxKLHjhZArs8DOKb2glFnH7SOpXAISzIbyWErN5wsNu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901908; c=relaxed/simple;
	bh=vVAQVLcIYSa9eKUMNQkbbxD4BD0WbXW8qmYkhqRBZDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VR+/WNLOr0+dAg0la+NS/AXpn6dpUOK4L3bje58v2BCTHY1Som8fPIAhrChgt5KURjGwmwwtXZojSFEkzuOP3WqXQR+pZmiJJgckCmMsShHcrRofvEOcrWj16CTljlJga8Z9ZE63MZqxDQA1n9Hb8Ak05QCmpJK1OFThzAi4DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PJ1h6khn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PJ1h6khn"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KDmVKX024469;
	Thu, 20 Jun 2024 16:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D4y4wSWdSO3Oxbz63so7MxqnXDBzW59kH6MAtjsENG0=; b=PJ1h6khn2lRI90zS
	vgcjuxRfqsorMYx3vjRFy/2T9tI2tu38bnE7DWghGq0psMBD/jf9oZ+IUdhIAb8Y
	N2U2bVEbMEMbk4jMravy+Wc0wclt3K6LQwNzOExXEJk3N/DMMOEt5QrbjiW4UW6A
	oWtZJAsO6gFRh2rLnPZ8E3K6I8Aqdg71x7OkbtU+y7GJy/szYd/lktQvka0haBNm
	L6khRJYxNgGoXzkaNuLa/sf3bYzrQfS9Uts5z3cgKnnulQMsCK3esC6gudhNLMHH
	O+gFwcEyDwkZxxlMnHman8xRvlxKdf9vnhEQj0NO9ucNeo6BRvLL7jqluKrXTDzC
	5Ol0sA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvnmh8f49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:45:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGj2fV003704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:45:02 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:45:02 -0700
Message-ID: <bd6c0b05-fe43-4405-bce1-ad765ec6c4d3@quicinc.com>
Date: Thu, 20 Jun 2024 09:45:01 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] string: kunit: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook
	<keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240531-md-lib-string-v1-1-2738cf057d94@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240531-md-lib-string-v1-1-2738cf057d94@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4TpuorCMh3GZwf_EuqVXC_4sQCc6DPXm
X-Proofpoint-GUID: 4TpuorCMh3GZwf_EuqVXC_4sQCc6DPXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200120

On 5/31/2024 4:07 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_kunit.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/string_helpers_kunit.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  lib/string_helpers_kunit.c | 1 +
>  lib/string_kunit.c         | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/lib/string_helpers_kunit.c b/lib/string_helpers_kunit.c
> index f88e39fd68d6..c853046183d2 100644
> --- a/lib/string_helpers_kunit.c
> +++ b/lib/string_helpers_kunit.c
> @@ -625,4 +625,5 @@ static struct kunit_suite string_helpers_test_suite = {
>  
>  kunit_test_suites(&string_helpers_test_suite);
>  
> +MODULE_DESCRIPTION("Test cases for string helpers module");
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/lib/string_kunit.c b/lib/string_kunit.c
> index 2a812decf14b..c919e3293da6 100644
> --- a/lib/string_kunit.c
> +++ b/lib/string_kunit.c
> @@ -633,4 +633,5 @@ static struct kunit_suite string_test_suite = {
>  
>  kunit_test_suites(&string_test_suite);
>  
> +MODULE_DESCRIPTION("Test cases for string functions");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240531-md-lib-string-d987d813b344
> 

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.
