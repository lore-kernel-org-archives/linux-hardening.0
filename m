Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1ED1F4193
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037649; cv=none; b=Qlaq9bVqMwECbqDNEq2XXExOaoBLXKxwsk+nyx0QRSHvDm3o1wr1nUEHefBcYAZhjKpwFODaZ8r0f7zdCPYYnmu0JCN4A/9jtKq5K/Re6qzOfQZG98xbOAPJG2Fr/aNRylJVDzCLoF5lrcA1poRWhCnIrjvsDYiNvyKM/lIcdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037649; c=relaxed/simple;
	bh=QAesDj3v6u3ehenwoAk9hWCfcO8KmBnO5zo1Q3bIMTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+vDJJCiBiG6ytInkQEA8YBOlR8S8OCJsBkbTGq5nPleI4A7y7zncoBjhPscHF+bqfKn+1uPWbEvfXNdVFg1FUWmLZCLcxb9S8qOf4t6YFz0NQClVoepVuQ0Us35PwGdOFKz22VCkMQvnpx9uB0/rG7CHkXa3/axvc972RxVGo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xzMy6iR2; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xzMy6iR2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=QAesDj3v6u3ehenwoAk9hWCfcO8KmBnO5zo1Q3bIMTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=xzMy6iR2tD8igtfsxMQcaeAXMLF4IDNY3G92y+FGCA8IUa45JILxxB6Lo8XvDuGpE
	 neER+E0PSnEwDWnW6qEI8j6LDZSv0ie+qVLSaLcDjgX6Uz4AFXPR9rMJs7dAD+xiFH
	 3onYMNfWWwWcT5IFZ1fvNbquiupWYaF4HBfW4+lPkMbKuO9kcdCALkmYhOGFAKHnj7
	 lhFnwCZwKsmfRXwiZQah3Yw1lGEsb3cXyt85TlRngr4oifyZW8jDEPLJAjthuAzQSv
	 XtqVTJTkMQ49SHx5NR9oRLpQVcZDqQ8eZomUzVgUfH+IikDaYmIKKhUHUmbHvX4j6p
	 M2xCLfv/u6zQQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 7F56B8E0512;
	Mon,  7 Apr 2025 14:54:02 +0000 (UTC)
Message-ID: <1bdaad61-5267-4cba-bd6b-373d0fee57f4@icloud.com>
Date: Mon, 7 Apr 2025 22:53:58 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lib/string: Improve strstarts() performance
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>, "Rob Herring (Arm)" <robh@kernel.org>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
 <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
 <Z_PYdARMy0_iW4wD@smile.fi.intel.com>
 <0e603b02-b272-4bcc-8b86-1a3dca9477d7@icloud.com>
 <Z_PjksaIc0B2AQhs@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z_PjksaIc0B2AQhs@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u6PUHjcpmtzM8hmBFZLN8BYDdB-XFIXK
X-Proofpoint-GUID: u6PUHjcpmtzM8hmBFZLN8BYDdB-XFIXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=441 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070104

On 2025/4/7 22:39, Andy Shevchenko wrote:
>> for strstarts(s, "prefix"), strlen("prefix") should *NOT* be compile
>> time constant. it is a loop and unavoidable to have strlen("prefix")
>> iterations.
> What do you mean by that? Compiler uses __builtin_strlen() and it *IS*
> a compile-time constant. Just check it.

thank you Andy for this hints. let me do more investigation about
strlen() within strstarts(s, "prefix").

