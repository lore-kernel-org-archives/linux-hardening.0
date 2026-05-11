Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE0B36494B;
	Mon, 11 May 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778468166; cv=none; b=i+qGXgTelixoDbtst2ivXOn65zxZJIc0u1+e5whQR4RfnWJvLx6gQIqyUKoBGQJ6hSgvzdZaqwU12jYn1gp/3utxUTzRv0QoTlpO0FzTXKLTYPQUCi+bESI9uV96PrJm18VqPOaxoWgEYYaxCu7n0K12RFowF5eZVO2kiaxvWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778468166; c=relaxed/simple;
	bh=y+M3UoaxPO64rUtSQGFXguLqRLn4phJrx2W4zZYFbcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB4lygGu+xq9AOm2RrFwM9U+8pMjuRvn0hqMt3gNSC6iOGovLcfwTnB7LE4b6RE/JbdViut9I9mzTgLV0xe5hezc94E6nejpNVRacZcTWpD2JC59CWgWJmIgPsGJZojlouGmHihOBAexObLhJeg/nL7mQY41BiN54aiH64gJrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uYHZXYuu; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uYHZXYuu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778468155; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0upIL/r5PlHA2QmAdZKfeZ5Wg4iPfn0PljTHC25lCFM=;
	b=uYHZXYuupdm71JRKi5At4wOfByW6BFKCxsGLSV2iMcgraoD0O88djuhrZ+NRqvfct/ia/eyCzgOX+lTgQO0n9o68gVojs3N6C1BpDgSSWwFASPRXgy8C9qLeXMIfObVV2AvLv3rgE5d4efrfqQOtkAUdBV1WIORxCKUq8VmN71k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X2dsRpW_1778468153;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X2dsRpW_1778468153 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 10:55:54 +0800
Date: Mon, 11 May 2026 10:55:53 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Message-ID: <agFFOZvRHMWCtPHm@U-2FWC9VHC-2323.local>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427153416.2103979-19-ardb+git@google.com>

On Mon, Apr 27, 2026 at 05:34:19PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The empty zero page is used to back any kernel or user space mapping
> that is supposed to remain cleared, and so the page itself is never
> supposed to be modified.
> 
> So make it __ro_after_init rather than __page_aligned_bss: on most
> architectures, this ensures that both the kernel's mapping of it and any
> aliases that are accessible via the kernel direct (linear) map are
> mapped read-only, and cannot be used (inadvertently or maliciously) to
> corrupt the contents of the zero page.

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>

We did hit the issue that zero page got corrupted due to non-kernel
reason earlier this year, and it took us weeks to track it down to
zero page corruption and the final root cause, as it randomly happened
to different user space tasks. Thanks for the patch!

> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index f9f8e1af921c..6ca01ed2a5a4 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -57,7 +57,7 @@ unsigned long zero_page_pfn __ro_after_init;
>  EXPORT_SYMBOL(zero_page_pfn);
>  
>  #ifndef __HAVE_COLOR_ZERO_PAGE
> -uint8_t empty_zero_page[PAGE_SIZE] __page_aligned_bss;
> +uint8_t empty_zero_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  struct page *__zero_page __ro_after_init;
> -- 
> 2.54.0.rc2.544.gc7ae2d5bb8-goog
> 
