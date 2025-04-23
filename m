Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F43D81;
	Wed, 23 Apr 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745380210; cv=none; b=QKlQUcy/i+Ve8gC+JLRvZp5PG2M1OxMzgg+naGIkCFZ8V6oW7bz/tCxNcfHGWL7de1+wq18Sm+NGJvlMXkUgn8rzb67PNCO3IGG+CBBZ6MrcBf/U8hNoG9GvzME/HIJ7qOQbEuDM8r2X5kr27x65vSYw+0oM3lx4FNANktpls24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745380210; c=relaxed/simple;
	bh=ZsyM7pKfLQ1GSJex7G8wkgg7irJ0es/s+56m+9aXwvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PufjiPZeKrYH4dc+9Gu/NtxZBv08cXVEqXsf6pJOrdtfF66rmws9jITRygvJgqgXHLz8Tql18JkNl+qFiug15VcsGebvm7bfeS0ixUrGxaGGYfYaua0yfEwWjrJNfDrftD4pFNJswzQKb95alEgxxvUKV9YrZYeHpSRHxm/Xh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LTY/4WeN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LTY/4WeN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=NSCt4vR2msWj/6nqRwvajHdSPnfmkoRmQAKsfracq1A=; b=LTY/4WeNhc5egfFUcE4RI9nMwE
	E7OVb+5QUQUpFYumkhQ2uKGqGi5GkWR3hQbKINZ9RhETIcqz5XDlM3ZfpnrOqjDi8CbTlxG0lim92
	dTM5nEhCGIQ00dPleNaWNzy+1XLFw9gvPG6qawpPjrXlZM95B5hbE/TOPbDKy2nAWpge7gcybwQh8
	9yTV8p5fDkmb3ZrWMJ/0YZQLQ4KFJQ8YVUCM5QB6ydKBMDelI1/d/M5iPaX2oHonvaqMbG2EIruDg
	sax0ggxBdnnkwogXsZtNq1XKcLabr8alwpMFmYa/vv2x+oZOtOj5PUDQKnNVFFMcfvylAcOMoGxhd
	MOOAmPBw==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7R7e-000000076Ci-11AV;
	Wed, 23 Apr 2025 03:50:06 +0000
Message-ID: <1f7c8220-09e8-42ae-a611-9a21779badaf@infradead.org>
Date: Tue, 22 Apr 2025 20:50:03 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EISA: Move devlist.h out of obj to always
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250423023743.work.350-kees@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250423023743.work.350-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 7:37 PM, Kees Cook wrote:
> I put devlist.h into the wrong Makefile macro ("obj") to get it included
> in "targets". Put it into "always" so nothing tries to link against it.
> Solves CONFIG_EISA=y i386 build failure:
> 
> ld: vmlinux.a: member drivers/eisa/devlist.h in archive is not an object
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/4a8ba1d0-d2d9-41f8-abf1-d45ec8996d10@infradead.org
> Fixes: dd09eb0e2cc4 ("EISA: Increase length of device names")
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alejandro Colomar <alx@kernel.org>
> ---
>  drivers/eisa/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
> index f0d6cf7d1f32..552bd9478340 100644
> --- a/drivers/eisa/Makefile
> +++ b/drivers/eisa/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for the Linux device tree
>  
> -obj-$(CONFIG_EISA)	        += devlist.h eisa-bus.o
> +always-$(CONFIG_EISA)		+= devlist.h
> +obj-$(CONFIG_EISA)	        += eisa-bus.o
>  obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
>  
>  # virtual_root.o should be the last EISA root device to initialize,

-- 
~Randy
