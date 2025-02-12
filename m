Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347D1DE8B3;
	Wed, 12 Feb 2025 03:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331108; cv=none; b=RuQUTK4F98idEpFqzw2FkNNFllfhgrYN2hYfk5lzgjtvz/IFKR5rzA6+ZTriQ1wGJMJ58h7nfAeouJwJIPv4BBk3FGjBFtmNyHVy+UQANXaqmle457csfo4OrRSzR9s8hQqSXK2rYRIk5qUwg/4kanG1jfLf4mvgKM4ciNwCwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331108; c=relaxed/simple;
	bh=6s9L6fJanGi8ZtgVTowzMcVUocmDAdBBWB4S5Si2pyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIGlHwEm9KsGbqRoWcst0FIwBLZkx0ipSDmRWfwNmcAb1xo9rfMkZksvBhcs04JEWuMm+mHgB3C4arp+Lm9yv0fRtDh/3679Pn9NTqZIUNtH+FCAWOtVMBQAMb7x7ja6S1j3w4yR2L9eH75dpgV9kaE3GBrIIf1PqnM+kIzbjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kcRI3TxX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcRI3TxX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=cQrSfRwNABviGfwM/d64pwDP/18rbhxrzT6j7L7xx9A=; b=kcRI3TxXWqA9lHV1TjIa6Veu+/
	n4QvqUtpPd49yxixdh15WvTQJgAdtbDxs4Uj/2Ys2xDuXw1pwPUvS27Nry1XWRGF17egLp3U/ndcd
	BI1gLRapFQAYwx3EAaQa1Y9n2L/OXHkcImW0ThSKBOoRV+7CYh7Xh8olXl+ETQVrnMOUZg4P+BLdR
	ujtlqeIqkGar2DI+fwIZ87Cae04v9tW2/WOSaU3c3PqNXsZMCbudPMJNeJfFNE2MtaOe9XALYqI+g
	ffp0SGUkh8+UQaQ2f3sdl9b3aaCsGQwBeAmn9p6n0V05WS8gPogYfczHDMrqoEHw9js62n6VyUeZW
	vKPI+oXA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ti3TI-00000003BSQ-0ad9;
	Wed, 12 Feb 2025 03:31:32 +0000
Message-ID: <8899161a-573d-4826-a6f8-88c2dd145692@infradead.org>
Date: Tue, 11 Feb 2025 19:31:19 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
 lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com,
 adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
 benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
 ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
 johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com,
 willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com,
 linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
 davem@davemloft.net, peterx@redhat.com, f.fainelli@gmail.com,
 gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
 ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
 ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org,
 mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
 mike.rapoport@gmail.com
References: <20250212032155.1276806-1-jeffxu@google.com>
 <20250212032155.1276806-2-jeffxu@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250212032155.1276806-2-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 7:21 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 

> ---
>  include/linux/userprocess.h | 18 ++++++++++++++++++
>  init/Kconfig                | 18 ++++++++++++++++++
>  security/Kconfig            | 18 ++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 include/linux/userprocess.h
> 

> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..892d2bcdf397 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>  
> +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  speical mappings calls to include the sealing flag and confirm

	  special

> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. After the architecture enables this, a
> +	  distribution can set CONFIG_MSEAL_SYSTEM_MAPPING to manage access
> +	  to the feature.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help


-- 
~Randy

