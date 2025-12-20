Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046B16DEB1;
	Sat, 20 Dec 2025 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766214371; cv=none; b=BxMjL+YaSP1ScRby2pd+M+iGak4ySO8U31Rgixa0336y7Ycp2q1D7PwEDaJspevM/qAhuOt/DZOXO3FWMx9OQAKldPQRa2QmEjHP+OsMq4mdcYsxhboeOrtu57KT5Y8Gk3flVVuXtRNbGJkYdfgPdecjFp0TZZpL7fbB+a8sy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766214371; c=relaxed/simple;
	bh=5HPtk7P1MQhfYYpNQ+aRBt3SOFYRkcoz+oUgANhExbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gskULrw+zRrfz+MGh5wSdlzGmJl6lXHj3eVyfviaF/bzCW0hbQWWb1eTJGHoHYMAKDi0HUSrikX4M/x6dhZqf5BWqzgMp9H48R/ooTPlGUHShmnDnQJKyzo/so2M78x+XxzUdNUkq2XS0xPXs1JbDGI92IXVrnKZDuHYny61e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W0Pk8TN1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W0Pk8TN1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LGmUSJpqfSghi8dPluTD5nrQMLOMVKkVqZ7TQk/EQmI=; b=W0Pk8TN1P4moUdKu29bhiK2pNi
	++OinAB3HpCklcEta+BiPfmSIe0FqYc4pJEbYXlE1105YlMA9OHi0rx8UjhyEflzJ/Tj9SrKsS5hf
	APqzC0IxnOmQx2Y7Kg5MemJj4xlYLiqk/jByWlmIZ55exeRi2U4eqAeMc+nNA/VnsMeDbIbqepAw/
	ynfmLhulNHvEiiJiuiup6PJURbrl2cUDaZdo5PYQ+/jzX2ymWJMQXBmlA83+Zr62JPslnVPoUdLNF
	3nR5K3IN5H7iTQddg1trjcYZ7+mNzRVLh4sDk8E1GEi//te7L6iYmz//Fa9y/WGDYSCY4ryUZzaQF
	LZZbhgpQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWr2N-0000000BN9l-0ZY9;
	Sat, 20 Dec 2025 07:05:59 +0000
Message-ID: <4cf65ead-b236-4973-b81b-a45128959a65@infradead.org>
Date: Fri, 19 Dec 2025 23:05:58 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Raag Jadav <raag.jadav@intel.com>,
 Tomas Winkler <tomasw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aUZFLezigzZQVt55@kspp>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aUZFLezigzZQVt55@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/19/25 10:41 PM, Gustavo A. R. Silva wrote:
> Fix the UBSAN: array-index-out-of-bounds issue below by updating
> counter nvm->nregions before the first access to flexible-array
> member nvm->regions[].

Yeah, I suspected something like that but didn't find any in-tree
documentation about it.

> from kernel bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=220823
> 
> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/drivers/mtd/devices/mtd_intel_dg.c:750:15
> 
> Notice that this flexible array is annotated with the counted_by()
> attribute, hence the counter must always be updated before the
> first access to the array.
> 
> Cc: stable@vger.kernel.org
> Fixes: ceb5ab3cb646 ("mtd: add driver for intel graphics non-volatile memory device")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/linux-hardening/90e419ad-4036-4669-a4cc-8ce5d29e464b@infradead.org/

More appropriately:
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220823

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/mtd/devices/mtd_intel_dg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/devices/mtd_intel_dg.c b/drivers/mtd/devices/mtd_intel_dg.c
> index 2bab30dcd35f..d3e89fe324b8 100644
> --- a/drivers/mtd/devices/mtd_intel_dg.c
> +++ b/drivers/mtd/devices/mtd_intel_dg.c
> @@ -768,6 +768,9 @@ static int intel_dg_mtd_probe(struct auxiliary_device *aux_dev,
>  	if (!nvm)
>  		return -ENOMEM;
>  
> +	/* Update nvm->nregions before first access to nvm->regions[] below. */
> +	nvm->nregions = nregions;
> +
>  	kref_init(&nvm->refcnt);
>  	mutex_init(&nvm->lock);
>  

-- 
~Randy
