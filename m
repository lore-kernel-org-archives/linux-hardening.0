Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EC2C237E;
	Tue, 30 Jun 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858633; cv=none; b=o5r6ZrFjq2fzMQeW72LOeLZd8DFF9tbDMtOInmcwIRIwDBJ6yngw+nOrQfEYPNzlWzyhj/EcbS9DVPKRgfb4ygJghgYjLfY2xUzvUFfT13Gn4K84sVku9V7GG32Vm+adrI45rCuWsILaHdL4WuzPk0079C/4dRYa5kYTZHM+D1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858633; c=relaxed/simple;
	bh=/KpcX1aZjAvLJR2Xr2cKCzso/oBzdylfniMZK8fXSmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T85n/VY0pQZoC35P1Zq3e1Hx98R9tO5EBHBFtEtvAsjtZpCH5/nOQdgvYXeldYh8J3BgvJ3eXNq4VcLOl7Zc4nfvIk8aXOTrUHp0cs3B+GUuI0D7Hl99kt7RJSj758ANYIAq2k43/uCm8QUPY1WGBrsm3iMSQA8sjCO2OO3TMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Le3gGuua; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Le3gGuua"
Received: from [10.124.221.63] ([192.55.55.46])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 65UME0h43868545
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 30 Jun 2026 15:14:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 65UME0h43868545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782857649;
	bh=WRAReKFHVDRGS4isJ32YVCLo/+68kLt6VkxwNq2bQEI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Le3gGuua4QujchktITkW78RVVX/pciaMDX+V4ewXrvem4cEKDcRHD8/vnw23DlKfa
	 T2dLkYtbU5PineWlU6if8Hq4SFVNjwap+LKMcAVXKfIqPRc+bupAm6MVrxKbTG5Q/s
	 +50YCU+/ZHCfZNHdQGj/lJIAcVpAfNuAhRtElFwAthYOvbWicz45cYE3/cnNbvh902
	 XWG2CLsXwBwoabcJ1tqfI4v7xH8EkG02J66Y7yuvA26XfXfCoiHIzF7fJOwgynL2BO
	 fmECy8fAjZ25wurQs8oPrysAOu+xPCYiZUWNDiicky2BP2jl/rd1rQAAHJew1wB5J5
	 9D9VJBSMWpVew==
Message-ID: <86e805c9-ede0-473c-b8a4-8b20439eaa6b@zytor.com>
Date: Tue, 30 Jun 2026 15:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Dave Hansen <dave.hansen@intel.com>, Xiang Mei <xmei5@asu.edu>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
        Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
        Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
        Yan Shoshitaishvili <yans@asu.edu>
References: <20260629214712.1198680-1-xmei5@asu.edu>
 <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com>
 <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com>
 <CAPpSM+QVOwhmwspjaUg+FqKsHjiEn7C+gYPEcpJ_UZA=JMj7zw@mail.gmail.com>
 <cb547653-0ed0-4fc5-b022-6f0b9691a4c7@intel.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <cb547653-0ed0-4fc5-b022-6f0b9691a4c7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-06-30 15:05, Dave Hansen wrote:
> On 6/30/26 15:02, Xiang Mei wrote:
>> Please feel free to ask any questions; I am glad to help.
> 
> How do the CET features: kernel IBT and the (theoretical for Linux)
> kernel shadow stacks impact the situation?

CET should prevent this from being the target of a JOP attack.

Kernel shadow stacks should prevent most stack-pivot attacks in general.

	-hpa

