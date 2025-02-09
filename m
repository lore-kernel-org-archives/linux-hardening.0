Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50709243384;
	Sun,  9 Feb 2025 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739072736; cv=none; b=m5OxkstfvyuBtJfKBp1e2caT0Dn3ZN0MRl7cZgOl51f7W1ZdAMMT2OvevcL7s/NIqLAiV4YcKeAIfoNRrOiINqEfkrbss8Co4AMJklnVA6Xcf1ZiyKnMyK2CtR9QOZLn5R01XKPp1X76U3epCb7NZNcwKjTcKVvm39F6G4OXA3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739072736; c=relaxed/simple;
	bh=338iPXjZDlUhP6o4Fg7qbAjayGvr0eEBDQocUyHmnww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjauZTiwWKk2Np6bSnYtZ4u+GgI5nFdWaSc0D1iKXIZxT8rlWdAheKspODwe+vXjlShs0/s2o8mvgqUSWZv1g4+WhsUAhgc15nbnSYtyD/jdDXyw3kVfebShngGvHWSNtA739hACV7OaCezfx8OErRG7zKNIZVPr/ekwUvTZTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=xy12kheP; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="xy12kheP"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YrDBB4k0gz9swN;
	Sun,  9 Feb 2025 04:45:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1739072722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=agZpKSsd5fdzyN9OBz2BDTXHlW6w6QtZAvyhXYpYcrU=;
	b=xy12khePBAai55WERQUGDfslclILql6MXbEtnoXVKCyvjPqujf2x3RhV5bUkk/77kKQY0w
	EHEKeCYvdbIHcAMDSQkhsn5ZfWO5JPeDvHp69UJq1zEVvvcqcib7UyJfMK73p2ddzTaUh/
	MldDJBNlpMl3Z6sqAg51L9JGGh4FPdRsytWn3l9Yx28pN9YTIQikfIeflsLRe2CPDN9Zat
	EONVFUcLfvVTbZ288ysFzDlkRkLkqGDvgkGlyxwfVyRjRq02DvI4sWRamvr/TFEnG/s6Nr
	nJtadRDXeNHYcvOsuL9AL6zLuPirPBXVq+areDnTQCfzYX/P8C44vKhEb6iBhg==
Date: Sat, 8 Feb 2025 22:45:20 -0500
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: mingo@redhat.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, "bsegall@google.com" <bsegall@google.com>, 
	"peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH v2] sched/topology: change kzalloc to kcalloc
Message-ID: <pqhk3i5byxj3ygnh7jp3irmluykrocwdmfudfb3lm6xm3enygg@cezu6wjo3a2l>
References: <wayfdq456uccu2kzujdokp5kklbl7evp432rmnxcdh2222wwlp@67idbpxoy32u>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wayfdq456uccu2kzujdokp5kklbl7evp432rmnxcdh2222wwlp@67idbpxoy32u>
X-Rspamd-Queue-Id: 4YrDBB4k0gz9swN

I wanted to check in on this. Anything I need to change?

Thanks,
Ethan

On 25/01/19 01:23PM, Ethan Carter Edwards wrote:
> We are replacing any instances of kzalloc(size * count, ...) with
> kcalloc(count, size, ...) due to risk of overflow [1].
> 
> [1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> Link: https://github.com/KSPP/linux/issues/162
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  V2: fix email client formatting.
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9748a4c8d668..17eb12819563 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1920,7 +1920,7 @@ void sched_init_numa(int offline_node)
>  	 */
>  	sched_domains_numa_levels = 0;
>  
> -	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
> +	masks = kcalloc(nr_levels, sizeof(void *), GFP_KERNEL);
>  	if (!masks)
>  		return;
>  
> @@ -1929,7 +1929,7 @@ void sched_init_numa(int offline_node)
>  	 * CPUs of nodes that are that many hops away from us.
>  	 */
>  	for (i = 0; i < nr_levels; i++) {
> -		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
> +		masks[i] = kcalloc(nr_node_ids, sizeof(void *), GFP_KERNEL);
>  		if (!masks[i])
>  			return;
>  
> -- 
> 2.47.1
> 
