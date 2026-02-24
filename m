Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469F363C71
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976559; cv=none; b=NSOXtUXQQaL5LqzmXn38nfviGQAe0eGxtGdzyaZVMbSPwhFVF17+M/yVCMIQcxGWLb7Q7CBidKKAQc/Fy4VOu+9QUQ0uWO7PnOuVbJqOh9bYQDf4ctxfmRYprvkKsnJeVSdDrsvpeezW/t+QF/ZAMA/B46B1bjhMNJEMoj6rehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976559; c=relaxed/simple;
	bh=nThqBoHvxv0i4K4E+o35nZrHluhiCc9HsFbEP22hhaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzhl1UxA9IvrZpWA3fIr0iXRDMP+6UblAoNfKWfOkEovGyvAo5rYyh9blYU4w1riNZKMdJU4ts66JeOvzi5I2zC0WMm2XhtSEFShi0z8TXgryIUrz+GfNblNiDe5b29qLsJxaLIwjXtqaBqiE9sL9jFMJRuAVm4HZEkvJkldMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=C7D4wzF5; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="C7D4wzF5"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id v1m8vDbCICxrGv22xvYnUZ; Tue, 24 Feb 2026 23:42:31 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id v22ivNTa2qfpWv22jvOiks; Tue, 24 Feb 2026 23:42:17 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=699e3767
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=k5Y5iPg+dmTXVWgYE/XtfQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=xg7tYuzjMYL13E36G44A:9 a=QEXdDO2ut3YA:10 a=6F3-OobHFTVsTf-5yJ88:22
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UZm3zBCsQs5cBSJ/lyF1YKWH8bECa3csQwx98aVNlYc=; b=C7D4wzF5TwjmqXNEb7fkXubuAV
	skijkveDtduHCI7cdfDgnYk7JqzbPuIOJBkeOb6oR1LEpXRc3gv3A9s0ho/2NHe6idG2aVK4vkT5D
	VQwo7onA6mWDkBsOfGgoTOTgiGIj7Wgnjh38BMS0YWPXGtwyruy3OWt1tfWqHlrYqN5g5z01nNZbJ
	RKRBhVrO82ogqQEZtyC/I1lzDsFGj3PA0gjBWubcqNoYf5MFo9w2jhitU5UTPl5oqxrAtsFbe5SAc
	35z95NwPKn4jzdCTuUsqr2rAmWB1dBZELCY6Y22FmNe22dc87Qn2esVSlDCxp9xdhLFiDEgcym/pF
	sq34Y6Tg==;
Received: from [177.238.16.13] (port=45614 helo=[192.168.0.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vv22h-0000000472I-3H2c;
	Tue, 24 Feb 2026 17:42:16 -0600
Message-ID: <e185faba-1b65-4831-b077-68fa10d0554a@embeddedor.com>
Date: Tue, 24 Feb 2026 17:41:39 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overflow: Make sure size helpers are always inlined
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260224232451.work.614-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260224232451.work.614-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.13
X-Source-L: No
X-Exim-ID: 1vv22h-0000000472I-3H2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.104]) [177.238.16.13]:45614
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCFLMnGhG/ZWsG8K/mVJYiES63nZgA301YbkcesJ5QIkESD/KVIfUY0HqMurgR5lgv2KjddK6qQFNGelKK+MnX73RxBu/x0Qjq1xZZVQl7b0PuO19x6z
 8p15Eo97o97Jy5wb7jVCA+MnEjYKn4ZFAfh8eDQfEM9K4jopVKvlUyHDE5L0oyKpsbI5zYiATDju90NN2J78WkGHicuwUwtZrM/E/qkrGnkZviBYHFZrPs0L



On 2/25/26 08:24, Kees Cook wrote:
> With kmalloc_obj() performing implicit size calculations, the embedded
> size_mul() calls, while marked inline, were not always being inlined.
> I noticed a couple places where allocations were making a call out for
> things that would otherwise be compile-time calculated. Force the
> compilers to always inline these calculations.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-Gustavo

> ---
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>   include/linux/overflow.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index eddd987a8513..a8cb6319b4fb 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -42,7 +42,7 @@
>    * both the type-agnostic benefits of the macros while also being able to
>    * enforce that the return value is, in fact, checked.
>    */
> -static inline bool __must_check __must_check_overflow(bool overflow)
> +static __always_inline bool __must_check __must_check_overflow(bool overflow)
>   {
>   	return unlikely(overflow);
>   }
> @@ -327,7 +327,7 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>    * with any overflow causing the return value to be SIZE_MAX. The
>    * lvalue must be size_t to avoid implicit type conversion.
>    */
> -static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
> +static __always_inline size_t __must_check size_mul(size_t factor1, size_t factor2)
>   {
>   	size_t bytes;
>   
> @@ -346,7 +346,7 @@ static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
>    * with any overflow causing the return value to be SIZE_MAX. The
>    * lvalue must be size_t to avoid implicit type conversion.
>    */
> -static inline size_t __must_check size_add(size_t addend1, size_t addend2)
> +static __always_inline size_t __must_check size_add(size_t addend1, size_t addend2)
>   {
>   	size_t bytes;
>   
> @@ -367,7 +367,7 @@ static inline size_t __must_check size_add(size_t addend1, size_t addend2)
>    * argument may be SIZE_MAX (or the result with be forced to SIZE_MAX).
>    * The lvalue must be size_t to avoid implicit type conversion.
>    */
> -static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
> +static __always_inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   {
>   	size_t bytes;
>   

