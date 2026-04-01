Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E13C0610;
	Wed,  1 Apr 2026 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775082521; cv=none; b=FHNx63rdgzMe7pdA8eHAXAw5hme76WE+h67x+gmrCNylzeRicRRhXIBfapjB3KXccuTDwt7YLlrhiQLGuCRWCMg4tDDpxwX3vorkuReDxdFnTHSGRh4/9/AH/4kAt7CTG189nZW9Sg8DKn5VDV+4MwQ9RrpUpHWRNrUMUcLSyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775082521; c=relaxed/simple;
	bh=voGtP81NgptA1C6fuavsFKZ7bL92S1nKZ6nd5PZE4WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbNjHebEyxMkbDBJPRuqEkcU8b+ap0T7L1qrN3qo85hDXRyIRQ/q5m0uJauKa5dobclbtmXK2+6i1M71QTQMitSEXcU5kO5FautuR/o/xlJiEmu2HiYPHrv35hUILmo7KKwWzQRq+exCOJLFKzJiKuZThesOC3ONjrsqASa32PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IZAH7FPs; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IZAH7FPs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X2KfDeqsOheg39Ne2C6bVVsZPi5WeroemMXB3xhhYtQ=; b=IZAH7FPsMzI7WzC2WENAYBKE1N
	Fi2Fruz3gVoNFAfttuiHcbEY3MudgD4unOy2NDnRCjW0otMQP4gTpGsp141REuOPzZbXIoYYKJ+YJ
	IPBIWP0jdEYuGJkssxx/Dsa8nmMA4FKYbAGv8igsL/+OhuueENoHGIp66X3z9xzjPIjaasBFMJcgA
	OFBOQ9l6inrnB3ioUfDVNFBrgG9B3pkPH/s6q5I9Z46LmZzLHMYxPiTcG+iHOdFX7xm929pJeQAls
	Y+eiVkCq3+arzprp4lQW3Zd7JIlx0cPIktvpsLjCSCjzdJ7hzBheafR+Au/JPh68e1PBdIN9YNzr0
	Auq8tFuA==;
Received: from [179.93.13.238] (helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w842z-00AB2k-OC; Thu, 02 Apr 2026 00:28:25 +0200
Message-ID: <f1f2408c-8fd0-2fa8-052a-176485e81961@igalia.com>
Date: Wed, 1 Apr 2026 19:28:17 -0300
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
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 tony.luck@intel.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Steven Rostedt <rostedt@goodmis.org>
References: <20260313201010.1622406-3-gpiccoli@igalia.com>
 <202603311445.F9975321B1@keescook>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202603311445.F9975321B1@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2026 18:48, Kees Cook wrote:
> [...]
>>  /* This doesn't need to be atomic: speed is chosen over correctness here. */
>>  static u64 pstore_ftrace_stamp;
>> +unsigned long kaslr_off;
> 
> This should at least be "static", but why have it sitting in the data
> segment at all, only to be scraped out by attackers with a arbitrary read
> primitives? Can we just call kaslr_offset() directly as needed instead
> (it's already an inline)?
> 
> -Kees
> 

Hi Kees, thanks for the review!

Totally feasible - I thought in some form of optimization, since it's
tracing, but if you think doesn't worth, I can easily just put the call
to kaslr_offset() there, as I did in my internal V0 heh

I can try some perf measurements, let's see how it goes ...
Cheers,


Guilherme
