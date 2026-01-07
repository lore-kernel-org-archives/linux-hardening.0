Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D472602;
	Wed,  7 Jan 2026 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767827870; cv=none; b=JKot+J9pOA2RVtovibAx8IQV2YjQvNCzlWyEyx/pTuccWAxuOFHY6ZGRU1Aa8KVa8Ggr32+VAvxB7Y78mBgyD9BPX3rlLTN0LJa32As9AWGG40U7FNpJzCRxEVHqYowDtHXyFNvn4OeR5szRgCxP7yrljPoxAzB6y+fmwFexd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767827870; c=relaxed/simple;
	bh=mkmuQuz2ZFVKgV3+h+OhAvSFwWRtBK7BIH9M+9qIwCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVtwy86C3SUjZayzG8HIWtP4cQzbW6RwtiSF2/8uf23cqRyhG65gKvhnkgs9fMSEHquynp8eZJ/vUCu9zKHVk1ZZXT4vSJRKRmB2HYTumbQH36nWFFPqBOZAU5vOYyKRw5zeaKUmsDdIqa8z4Cn+uVBFDkDrBEEo39Gaw9FqZD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d0UFsdwR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0UFsdwR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=u9oqDzdWLMAHZKw1pYtMhK8kbCuIv9Fr17Zy6yD2XJs=; b=d0UFsdwRbX2pajK1yrceb6LD6B
	1Ta240KTHyvMrSZfbHNnpReUPk0GFR8acnuj9eedEFtTuUO/c1tWKqUR4Ce6QpXPl4SAyX9TrzODG
	xzJHwsyabj1u/6KIBSTx+29NBGRG8emQi6l72gY24Cy+HtfAF5W3KhaafskaaNT9CD5VS8AscIpPG
	9nOYqXc2KhWWvZL5sef0z84gogBAAw+bmp2ZdYzUqCu09Xk0vxwR3toY2Cn9kDKjJBcEQb2HErSaN
	EtbJlEgquYeiaZt+n2aYjKlNdU5d+UaLbQT/UEimxnBV3mYMgyEbDZmuVKg44cdUWiwb/n3rCk/8X
	Ee3lnMyw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdcmc-0000000Fjuo-1HKt;
	Wed, 07 Jan 2026 23:17:42 +0000
Message-ID: <0c69b711-4c88-4e64-afe7-f7de147a490b@infradead.org>
Date: Wed, 7 Jan 2026 15:17:40 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
To: Raag Jadav <raag.jadav@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tomas Winkler <tomasw@gmail.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aUZFLezigzZQVt55@kspp> <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/19/25 11:07 PM, Raag Jadav wrote:
> On Sat, Dec 20, 2025 at 03:41:49PM +0900, Gustavo A. R. Silva wrote:
>> Fix the UBSAN: array-index-out-of-bounds issue below by updating
>> counter nvm->nregions before the first access to flexible-array
>> member nvm->regions[].
>>
>> from kernel bugzilla:
>> https://bugzilla.kernel.org/show_bug.cgi?id=220823
>>
>> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
>>
>> Notice that this flexible array is annotated with the counted_by()
>> attribute, hence the counter must always be updated before the
>> first access to the array.
> 
> Already fixed[1], but not sure if it's landed yet.
> 
> [1] https://lore.kernel.org/linux-mtd/20251111-mtd-nregions-v1-1-61db61e78c63@intel.com/

What's the status of this patch, please?

-- 
~Randy

