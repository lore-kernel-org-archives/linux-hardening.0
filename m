Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB821A0C;
	Fri, 17 May 2024 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931939; cv=none; b=L5x+5dQCIAB6QxCWxj/JsKNZtyjN3OlxpCPbjKIcPr/JWkV7fwkSbPDIAadovyveiwApVitC1WttmaiawiFh/GSaq5LpZIkKZX3IULU9DCvnQYJ/hBLyPQjOk16tDUdrKP/yNKM5ZGjHOVv6CBTKAGmDBspUKyV6LnUFK11HeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931939; c=relaxed/simple;
	bh=NIUqWEH+uSM7abt6BRHzGWYIu+/xBzUmrnsC0dtANhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO8qvlkGrKGT30QoXcfU6i/IbUTzsObM4lLmcUmnjyQwACAwiKv0mjeeyJgAorVwJcwWMoui5I6dfyQPqtn2hbnopcbMW9UPUk14Xj+eGa97e21tT+Lddlk5fmjzX+vohs6b04zxqLR3rxRmHfMak2iJG3XXRXORtRtCv72uqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VgdqH4dQPz9v7Hy;
	Fri, 17 May 2024 15:28:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5F1291401EA;
	Fri, 17 May 2024 15:45:32 +0800 (CST)
Received: from [10.45.153.237] (unknown [10.45.153.237])
	by APP1 (Coremail) with SMTP id LxC2BwBH8RkTC0dmBZpWCA--.58599S2;
	Fri, 17 May 2024 08:45:31 +0100 (CET)
Message-ID: <99da3934-2c44-4a1f-832f-3f182ddadefa@huaweicloud.com>
Date: Fri, 17 May 2024 09:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <202404291502.612E0A10@keescook>
 <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBH8RkTC0dmBZpWCA--.58599S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW3Cr4ruryrJrWUGw4xXrb_yoW8Gr1kpF
	Z8GF4jyrn5Ja97u348Aw4ktayruwn3Ga98Cr9Ygw4DAF4rKrs2kFn0krsI9ryrGrZ5Z3yU
	Xr4Utr9I9FyUuaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 5/8/2024 um 10:07 PM schrieb Linus Torvalds:
> And no, the answer is ABSOLUTELY NOT to add cognitive load on kernel
> developers by adding yet more random helper types and/or functions.


Just to show an option without "more types and helper functions", one 
could also instead add a coverage requirement:

Every arithmetic operation should either:
- have a test case where the wrap around happens, or
- have a static analyser say that overflow can not happen, or
- have a static analyser say that overflow is fine (e.g., your a+b < a case)

Then the answer to safe wrap situations isn't to make the kernel code 
less readable, but to have a component-level test that shows that the 
behavior on overflow (in at least one case :)) ) is what the developer 
expected.

For static analysis to prove that overflow can not happen, one sometimes 
would need to add BUG_ON() assertions to let the analyser know the 
assumptions on surrounding code, which has its own benefits.


static inline u32 __item_offset(u32 val)
{
         BUG_ON(val > INT_MAX / ITEM_SIZE_PER_UNIT);
         return val * ITEM_SIZE_PER_UNIT;
}


Obviously, the effort involved is still high. Maybe if someone as a pet 
project proves first that something in this direction is actually worth 
the effort (by uncovering a heap of bugs), one could offer this kind of 
check as an opt-in.


Best wishes,

   jonas

