Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97595344D95
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196892; cv=none; b=NaQEMLowlhbF/pqI5yf0AxcOqmxbVn3jhmdo50twOhCx0WgjXgkzWnpQ8naoiSkVoTLfrQ4YqaywZCngZpzN+KXpl7F+3RBcQBTF99Kvcomfe7CZU89xSsXKKb8VmfiKePnC41/gtmf3s6fvV9gTMgeW4UPzf9wmIXoFt79zLNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196892; c=relaxed/simple;
	bh=U0seoVi4n3qqjK+J09RdgSIJmaaFquCQiKFxG++i0kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t38BvmJYvaGh4PY810IH666pia6QSWrwXMBsJyHT1X/bL6Q/D48Za4eN57YKLugwChwjlONRP+UT6q9HrEkDhr7IPxjGlGKbMfpvNuSLcQCO9TzDgCoxVa2mGCI8+AHtbH2bWP9e4WVODFaZlUnxHuiMMkokTwGkUCBYekPBo0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T73XOx0N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T73XOx0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778196889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSM6UscZWrZrRnJYPP1LWeuyeD/23NQG6vtPlp735gM=;
	b=T73XOx0NTCxgZ8TtTwLgr/gzoFiNC2ENkB0Y6mxUBgJbUWOCxUstG450dxSNEO0I1BMjM0
	YFNx5EUueS4BP/NCiPujtNagpqik5uSrbjOlIe3SaG5unpwebXLJXOW99wpaJpplGJ/tyN
	4bdVzs9CuNryPrNEO910ziJ0ltZrGBw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-CMY-xJ8RMcCU4p7mhSa9jA-1; Thu, 07 May 2026 19:34:47 -0400
X-MC-Unique: CMY-xJ8RMcCU4p7mhSa9jA-1
X-Mimecast-MFC-AGG-ID: CMY-xJ8RMcCU4p7mhSa9jA_1778196887
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50edf01172bso35819941cf.2
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 16:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778196887; x=1778801687;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSM6UscZWrZrRnJYPP1LWeuyeD/23NQG6vtPlp735gM=;
        b=ksbLqFK8U9DTKNjvcKMHM/dbUga/8LWhw8NpFAZuTeFmS4NE2SYGz7kcQ7I1JMpadw
         uPDuJzj8f9yUx4GJOKRCwqKqvpvd/B2WhB1rihso53gFKRRCvbD6YoHKtgp5qbYG8RLj
         CKVxAuSIhzIc/Kxg6/ds4B/FDQNnyF7FzLR1n1wzOiU/+asnayMhTy79DgPBjW53u66W
         Aaddj5OSs4TzkcGnRNm+M+0n2G4IjyLGV/u/tlMwuWeHoxdlTDJX29EtPj1kwP5SPZyV
         AiqlQTT7wNisyEU5Ee6DnQinx9vXQLScN4b1ThKO52b3Z6+/HYmJ3jM25W5DuGu29kdw
         PMtA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ew7jJtYLAhRLJOsiDSpWmgq3JtGtvyzrM5OLiNXx8rp2jn6tXNurn4fGYZteWUvg9D1GqnNaPjJHgLmwcVTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHPpbqCY+9Ajdf2WFLPHXXq1g/AFL+QH88vjBAHDoYe38oyyM
	qQHNi72/E0FlgI8xIPP0Vv4CKox5JhgNkkm0/MoFOUi0nCCB/J6xFlaUwSpPt4JFAJLN+ksaKYJ
	ApWOhDU9wVaUShHzn0yzt2HiP51LlFYFK2YjFXmBLKk/6vF8fYZM5fvpIhxd+hn6Z3y9V9g==
X-Gm-Gg: AeBDietq2yZwJhfQZw68mCyQMVPwkyG/icIcNjqWocTOOEnsTxwGEJc+IJmCkk5XriM
	DbHAAuVRO9QS9xoK5EhrmTIdLp9nKt5o4+lo26p6TxhLz0VoENAwAltX/guV5HbzB+VsIj43z3F
	RCHelf3iS8fFhnKFbIEkFw8qj6qET+La1XVkBWmGJfegTmpXBsujjNd5vjt4CztWBir5y04+r7h
	GwOSgG3JCa+XbGpuKNZm8dtjXzJpaeAis6qoSr9Mz/E/3MEaB6lUgrZCfNSr4uIHoHO86crgho0
	2pTPFtYSkdqnTQYa2Pcf01pZS5I4Kiiazt0+pKwKhgdcUbFynfbijCTikx2mBM8LvGKVAEl4qQ3
	dAJfBRyiT7R6LPVCjC6kZJcriS3i3EfQToewxEJtnfdZHp/mW6XufIPao
X-Received: by 2002:a05:622a:a14:b0:50d:aae1:7070 with SMTP id d75a77b69052e-51461fb1ad5mr157914881cf.48.1778196887224;
        Thu, 07 May 2026 16:34:47 -0700 (PDT)
X-Received: by 2002:a05:622a:a14:b0:50d:aae1:7070 with SMTP id d75a77b69052e-51461fb1ad5mr157914391cf.48.1778196886751;
        Thu, 07 May 2026 16:34:46 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83dd35sm1697181cf.29.2026.05.07.16.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 16:34:45 -0700 (PDT)
Date: Thu, 7 May 2026 19:34:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:SAMSUNG SOC CLOCK DRIVERS" <linux-samsung-soc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2 1/3] clk: samsung: use kzalloc_flex
Message-ID: <af0hkVm0TQPTAiPd@redhat.com>
References: <20260506233833.178357-1-rosenp@gmail.com>
 <20260506233833.178357-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260506233833.178357-2-rosenp@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h4L_vjNmu1OCQjMihIeGY1xDCGnBbJyZ1d-wysCBqMw_1778196887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rosen,

On Wed, May 06, 2026 at 04:38:31PM -0700, Rosen Penev wrote:
> Simplify allocation by using kzalloc_flex with a flexible array member
> to combine allocations. samsung_clk_alloc_reg_dump is no longer needed
> for this struct but is needed elsewhere.
> 
> Add __counted_by for extra runtime analysis. Move counting variable
> assignment after kzalloc_flex which does the same with GCC 15 and above.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/clk/samsung/clk.c | 11 ++++++-----
>  drivers/clk/samsung/clk.h |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index 91e5cdbc79d7..2895c77534ae 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -430,21 +430,22 @@ void samsung_clk_extended_sleep_init(void __iomem *reg_base,
>  			unsigned long nr_rsuspend)
>  {
>  	struct samsung_clock_reg_cache *reg_cache;
> +	int i;
>  
> -	reg_cache = kzalloc_obj(struct samsung_clock_reg_cache);
> +	reg_cache = kzalloc_flex(*reg_cache, rdump, nr_rdump);
>  	if (!reg_cache)
>  		panic("could not allocate register reg_cache.\n");
> -	reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);

samsung_clk_alloc_reg_dump() is used in three other places. Is it
possible to convert those 3 places in a similar fashion so that this
function can be dropped?

>  
> -	if (!reg_cache->rdump)
> -		panic("could not allocate register dump storage.\n");
> +	reg_cache->rd_num = nr_rdump;
> +
> +	for (i = 0; i < nr_rdump; ++i)
> +		reg_cache->rdump[i].offset = rdump[i];
>  
>  	if (list_empty(&clock_reg_cache_list))
>  		register_syscore(&samsung_clk_syscore);
>  
>  	reg_cache->reg_base = reg_base;
>  	reg_cache->sysreg = sysreg;
> -	reg_cache->rd_num = nr_rdump;
>  	reg_cache->rsuspend = rsuspend;
>  	reg_cache->rsuspend_num = nr_rsuspend;
>  	list_add_tail(&reg_cache->node, &clock_reg_cache_list);
> diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> index b1192ca03db5..098f27a6290d 100644
> --- a/drivers/clk/samsung/clk.h
> +++ b/drivers/clk/samsung/clk.h
> @@ -324,10 +324,10 @@ struct samsung_clock_reg_cache {
>  	struct list_head node;
>  	void __iomem *reg_base;
>  	struct regmap *sysreg;
> -	struct samsung_clk_reg_dump *rdump;
>  	unsigned int rd_num;
>  	const struct samsung_clk_reg_dump *rsuspend;
>  	unsigned int rsuspend_num;
> +	struct samsung_clk_reg_dump rdump[] __counted_by(rd_num);

Personally I think the rd_num should be above rdump so that they are
together.

Brian

