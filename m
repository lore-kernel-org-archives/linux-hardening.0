Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF73749F7
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173852; cv=none; b=Resh8s5gOQrdnmvyI1Q1F0QgQcX7QuH7FP8KYUd1W3KBVxBe8u0X8wF9yIlA04v9Q/RdutrB/0eR0ypH2Ee4NyHUh0/oc48XsMFKUaTtIzoL1LTBOTeWVPf5MoOGFiomErzi+OOOrHpiN41d9WfxIdsBkpH17dEtuCQmG32Gz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173852; c=relaxed/simple;
	bh=0TmWzD0OkYAOTF3WXM3OUBy2Tm1qGtelDPvfzKNoRkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JznVYsf1zQy67FHltCrF+lUNSXIHrqDV3RevDFU8986uKYW0XhDpDeLRgioFChQzgP6GgzyhmbJ/u61R+oY1+Fk3ACSUxRuY/4bsrhzbDANj6KBLcD5qt24haSjckJ7uEQx93TACuovxYSpN24iOii2AMe8Ad/kmCH5o6FaK45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KNcfY7a6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KNcfY7a6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=YZyfreQiNsXXBW0WzzGM2TytWhOs2zA5aLXTOBlFfAU=; b=KNcfY7a68JWszzhMoWoKGIP8Tx
	ROKtRP5eH1BbRAhgiLSDajM24hgxNdQippc52ZFMD+LuzmIpkjid9BLfiaaOLa+zviFh0BRMmJ0CL
	qsaK1080pqbgyXOboh7JSzn/ebuQwW0gQ8V6HT6tuXwvoGoaqfpaTiso8L62/0gMseYaaMgjr67G2
	VT598vtjtRPv/sQS90yYCh239fm88UCJr1DRjlCLV27ljro+DWI4ptBKdbSBtOmqTi97tYUuyLE+k
	wmf3rbTyowkxz08c35ZK1z5W64lDNtkJEVUzcSNI/5uTKlCgETgpBqR5a1R5UIWVq/YnTpuUp363o
	mw6Vnljg==;
Received: from [187.56.162.63] (helo=[192.168.1.56])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x9Nze-006BUZ-5X; Wed, 23 Sep 2026 16:30:42 +0200
Message-ID: <dd3810e4-7b98-ca4e-f20d-0a7e863d7983@igalia.com>
Date: Wed, 23 Sep 2026 11:30:37 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] Small improvements on pstore user experience
To: Kees Cook <kees@kernel.org>
Cc: tony.luck@intel.com, linux-hardening@vger.kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20260922212532.98571-1-gpiccoli@igalia.com>
 <202609230016.101B0479BF@keescook>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202609230016.101B0479BF@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees, thank you for the prompt response!

On 23/09/2026 04:20, Kees Cook wrote:
> [...]
> 
> Thanks for poking at it! Yeah, that PSTORE_COMPRESS=n seems like it
> needs to get fixed. :P

You mean, relying on DCE for not adding zlib symbols?
If so, I could work a patch if you think it is worth. Indeed, it is
quite subtle ...

Or are you saying really about the proposed patch itself, avoid having
users to set a compression even if PSTORE_COMPRESS=n ?


> [...]
> Sashiko has some notes:
> https://sashiko.dev/#/patchset/20260922212532.98571-1-gpiccoli%40igalia.com
> 
> I fear it is uncovered some other (small) preexisting issues, but I do
> agree the kmsg_bytes concurrency race is troublesome.
> 

Nice! I could fix it by guarding the init function with locking and
adding READ_ONCE() to the remaining kmsg_bytes not guarded with that -
does it make sense?

Now, I'll be out for a week, will get back to it when I'm back, if fine
for you.
Thanks again! Cheers,


Guilherme


P.S. Also using this thread to mention that I also plan to take a test
on the pstore-mmc thing floating for a while in the ML ... apologies for
not doing it earlier!





