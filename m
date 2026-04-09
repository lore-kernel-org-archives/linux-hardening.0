Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB63BFE3C;
	Thu,  9 Apr 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751239; cv=none; b=sj4LodVsteeSdMEejen998Tdax4T+kZGv9KbX3Ge/jjgzMOimhHBZouKWYRDhCXnbso+hxnPIIrH2SbRMhDWoAhKARicdFf7goJxNDRs8TQh4tCBwxVI5QKEPlmw/V7NjyqQlF5zNw19zMZxXM80SjI9o5T7FP/2dN5PM4z0dPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751239; c=relaxed/simple;
	bh=fPZbJyTRNUQdoxjECuHRN4wBArcP+sqxGk2yn+YQ1CQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:References:
	 In-Reply-To:Content-Type; b=s7APk+wreTW3NvQKb8QEYIkgsGI2u/gp4oH977Jjx/aShSK+Lk2Ueoi2AU3F7NWtcU8dbuop5vbPtVwraG2kFV4B6k1FGK1evHG33KGUK71jvNSH3WPOVZu1+bVpyQ5V83a++mr2n8NPomdy0VD24fyexJsjRxFm9aHl4tLLd04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kwyHTX37; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kwyHTX37"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9pSD6e3SAXfscapnv9+Nc/KqJ397PTPXlJJVK4aPo1k=; b=kwyHTX377XnEHm0xYfpDcqCqCp
	E6BToIJmM8ejdRIMKLSmQiv6kr0Hrk9dKhTvOLcvCudKwJOahkcDydMrQTYMcf522U89CuTZXRcvH
	CkBYbauR0YOZ15+7tCGI3GJNUm17tghYiTaC6yzvW6vslN/tL3FChmwZrXlNvvtQYVGW+Qxl5jVij
	fCh5JQ/nROm7qUGH3Hmq1oi1KXiRF2cWkMzCedbEVH9dfmBs4Rizy2GYK42fMd1UHu3zqlio6dnws
	6SOZIs3N39YFSqmAuZW2ZxGfAMEZMwuIGaLYc6SXKgFcboBAk4GJ5sK3dwvTCDZ0b/BBgpWzPUaMf
	X7DgJ/bA==;
Received: from [177.189.74.94] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wAs0u-00E0sx-Jx; Thu, 09 Apr 2026 18:13:52 +0200
Message-ID: <df4c3da5-37f6-e695-dcf7-cb15f19d8fbc@igalia.com>
Date: Thu, 9 Apr 2026 13:13:49 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pstore/ftrace: Factor KASLR offset in the core kernel
 instruction addresses
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net, Steven Rostedt <rostedt@goodmis.org>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
 <202603311445.F9975321B1@keescook>
 <f1f2408c-8fd0-2fa8-052a-176485e81961@igalia.com>
In-Reply-To: <f1f2408c-8fd0-2fa8-052a-176485e81961@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2026 19:28, Guilherme G. Piccoli wrote:
> On 31/03/2026 18:48, Kees Cook wrote:
>> [...]
>>>  /* This doesn't need to be atomic: speed is chosen over correctness here. */
>>>  static u64 pstore_ftrace_stamp;
>>> +unsigned long kaslr_off;
>>
>> This should at least be "static", but why have it sitting in the data
>> segment at all, only to be scraped out by attackers with a arbitrary read
>> primitives? Can we just call kaslr_offset() directly as needed instead
>> (it's already an inline)?
>>
>> -Kees
>>
> 
> Hi Kees, thanks for the review!
> 
> Totally feasible - I thought in some form of optimization, since it's
> tracing, but if you think doesn't worth, I can easily just put the call
> to kaslr_offset() there, as I did in my internal V0 heh
> 
> I can try some perf measurements, let's see how it goes ...
> Cheers,
> 
> 
> Guilherme

Just for closing the loop here: V2 was just sent.

Link:
https://lore.kernel.org/r/20260409153830.2560633-1-gpiccoli@igalia.com/

Cheers!
