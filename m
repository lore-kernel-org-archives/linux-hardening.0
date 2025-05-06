Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318628368F;
	Tue,  6 May 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546876; cv=none; b=PD3AIph4cf0YtiPAah135TM1KAENgv00nXwXnjKzhboGeYD3j9ZtJkww4vuMp9XGFj4e7hko2ISG+gquBb3OA8VYoBKzf5e2RriILzPHzuUyxpAJgDwQYgvbYJxxCVtDBzxMP0/fE3MSTOAtf+D0PpXbQ8xcBaV3UzjZhrNLvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546876; c=relaxed/simple;
	bh=oRFV4V24cNjhr8AbioozP1pFhr7NS7efnPWyyGZeWNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oXkxE+PfS+e/K7RxtujmGzq4VqPAaOy5LozVOP2QzhGz2dXqu9OZxlJOW5ko1B5UZljgRFN/fcGJNRdt4OLEm4YU9NP0aEq3TTaC/FDIT78FbqaRLts1Jwa+UfdBAq5F00hWOnnBl+dDziThcBKUYoNvdTHDINdpR8OIzhQPs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N6kDT5Bh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N6kDT5Bh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=5kkxAIEuRdRGzTzcSjdlPRJhQQFv+AIF+5UYrxRSzZg=; b=N6kDT5Bh3VNnpddBQhTU2eZVEW
	qQAp39HTogt+PZhSrGQVZnUcWtjPjS0jzN08l5hKcXRgohI+bP8jYl8pi+dO3qMbPH9YJtrYWL83h
	e99PMcTlrpweHtJEUsE5wRfDlogx7JrEn9ruZqnKoL4FYNmZ/CR8iB5PftxmG5fvhFjjIN74vZzR0
	jvPqsM+wGo5GXGNAYhFq22s4kEdRXOJ7KlJ8o+kpE2LeQpe+8wDZ2FZTFuconrZsa9bRUOvVYiZ1O
	F86jqkQhf9yOutzjsygdBScOt3rU7ocqAHMKLXcs6HXDdGbt6w0KwB2h6H6+DVoVuTN4ySUahXAvE
	2s1Ynwiw==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCKcp-0000000Ff7x-4Ahm;
	Tue, 06 May 2025 15:54:32 +0000
Message-ID: <98d34958-e57e-40df-9196-920d40fd57f9@infradead.org>
Date: Tue, 6 May 2025 08:54:29 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EISA: Move devlist.h out of obj to always
From: Randy Dunlap <rdunlap@infradead.org>
To: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250423023743.work.350-kees@kernel.org>
 <1f7c8220-09e8-42ae-a611-9a21779badaf@infradead.org>
Content-Language: en-US
In-Reply-To: <1f7c8220-09e8-42ae-a611-9a21779badaf@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees,

On 4/22/25 8:50 PM, Randy Dunlap wrote:
> 
> 
> On 4/22/25 7:37 PM, Kees Cook wrote:
>> I put devlist.h into the wrong Makefile macro ("obj") to get it included
>> in "targets". Put it into "always" so nothing tries to link against it.
>> Solves CONFIG_EISA=y i386 build failure:
>>
>> ld: vmlinux.a: member drivers/eisa/devlist.h in archive is not an object
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Closes: https://lore.kernel.org/all/4a8ba1d0-d2d9-41f8-abf1-d45ec8996d10@infradead.org
>> Fixes: dd09eb0e2cc4 ("EISA: Increase length of device names")
>> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 

Please merge this patch. The build failure is killing lots of i386 builds.
Thanks.

>> ---
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Alejandro Colomar <alx@kernel.org>
>> ---
>>  drivers/eisa/Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
>> index f0d6cf7d1f32..552bd9478340 100644
>> --- a/drivers/eisa/Makefile
>> +++ b/drivers/eisa/Makefile
>> @@ -1,7 +1,8 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  # Makefile for the Linux device tree
>>  
>> -obj-$(CONFIG_EISA)	        += devlist.h eisa-bus.o
>> +always-$(CONFIG_EISA)		+= devlist.h
>> +obj-$(CONFIG_EISA)	        += eisa-bus.o
>>  obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
>>  
>>  # virtual_root.o should be the last EISA root device to initialize,
> 

-- 
~Randy

