Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C7268C79
	for <linux-hardening@vger.kernel.org>; Tue,  8 Apr 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112090; cv=none; b=Xwuc7szyq/OglJZ379s+H5/Sp0AlrjGQW3V/Cr1HBSSuS+mLurT5kgZhEWPOJ3D/Aa4u9Sf5zGfCa3zhrNtwcdrtDstpDrxvccsK49ckDZLuFRw4Py3p9FMEHidfYkLNylgOOta318+GRs2xaKN7hU/rI+rzzEa2d3CSC/1mGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112090; c=relaxed/simple;
	bh=SU1tu9za3zKIMyR4DCCKpc/LUgyMBmasXS8NSRu+YQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzJ5Ws6H+dSLx5vxoCMzCPFEkKb9t6gDP2xpYQIbHpFSj52kqzKubg5RQMNHRAQ8ozcWZGU3XnHUeA9NvSCJk8nuu37pe217D43xa4oAbswsxwJd0Yjxw2mjVP1DHLLVuC01PSokrE40C0LikLUXvxfSyJxGE7YWk5cIKogsNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=zPH8B84F; arc=none smtp.client-ip=17.58.23.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="zPH8B84F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=elupXrputsiJWGq9GFuUlFEVg6AtQR2+rD/CZNF0CBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=zPH8B84FXjG2vE0DyIEqwFLa88Ot7VxAM93/8nMPU5EuTAuERjPtnZWPY6dN8S4Tk
	 LqCtnH31bgvRE/pWpuNHKgl/uIrG1gaZ36dsO8bTlqN+S1d5xTRL1WNfd/x8vGgCOO
	 3WFgQ2oeNhipGP2WFpFDG/ATbtFUM2BYPL0tmh+fzGXPWwFb6/C6JzFMby7p9v3kJW
	 V33lKz1k3z6BtdWe/e4S5m29cl+tblSqRuBQEIL1k4N1s8QMMRquAnmtFRbdFZq4cv
	 PjrroAFmnCTb/Ozk5yun7YkvjxKT7pY/BUNMtR3pCrpAigve8+eNpyj58Pv590KZhe
	 Z+WVRScPIXNVg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id 132552793E6B;
	Tue,  8 Apr 2025 11:34:44 +0000 (UTC)
Message-ID: <1d2e9f40-708d-49b2-b0ee-a1d775f6fd23@icloud.com>
Date: Tue, 8 Apr 2025 19:34:41 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
 <202504070912.8BB9AD0AE@keescook>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <202504070912.8BB9AD0AE@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ap5-sVUz9nY5FZREWQ4tl0WybHpSmoAY
X-Proofpoint-GUID: ap5-sVUz9nY5FZREWQ4tl0WybHpSmoAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_04,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=809 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504080082

On 2025/4/8 00:17, Kees Cook wrote:
>> strstarts() is frequently invoked to test if a string has another string
>> as prefix, but its performance is degraded by the strlen() loop contained.
>>
>> Improve its performance by eliminating the strlen() loop.
> So, as Andy already said: no, this is very unlikely to be a performance
> improvement, and if it is, you'll need to show the numbers (and likely
> the reason _why_, in the form of assembly output, etc).
> 

agree.

> The reason this isn't going to be an improvement is because
> strlen($string_constant) is optimized by the compiler into a integral
> constant value. So you'd be replacing a potentially inline constant with

will confirm if strlen() within strstarts() is compile-time constant.

> an explicit function call. That will be much more expensive.

strstarts() has a strncmp() function call as well even if it is inline

> 
> With almost 300 users:
> $ git grep 'strstarts' | wc -l
> 198
> 
> Only 38 are _not_ using a string constant:
> $ git grep 'strstarts' | grep -v '"' | wc -l
> 38
> 
> Additionally, there is no "loop". strlen() of a runtime string would be
> evaluated once.
> 

strlen() contains a loop which has strlen() char comparisons

> -Kees

