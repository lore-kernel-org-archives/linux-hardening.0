Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C7A32;
	Tue,  6 May 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559055; cv=none; b=jf6rdBmS1VIVooUD9vj3Q1kH94geN+OgfpotI7POVbR2NWTNjblWEyl/uURUc5hXYfTudPQWJ/JfKm73jNeLaFStnq/9x90D9tb5GbcfQM8vCKRBIes2sfyQbnKTmg/bbbSs/Jp7Vwr3Aw4UH+47cWyVUveRvpKHkSHAGIixwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559055; c=relaxed/simple;
	bh=8BlyK5eXUTdeNKvLgCmdPxuJcObOmDDC6s9tJUGFIF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URPaywCQsg3z4E/vpFBdYUKhyuTWAyX3oiMLN02/T9nAcS9KZNqxWQ0DDV+bXi6BpKSz7oup/OA9A8X86kHVSUIGtLxWTyVf75ndY4A05URGul7FI2Ol5PuiY9CEXF9eyXhQ8MTLE/UeyNB2Ph0cMS6BRbi5zQW6k7ugUQorQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H0OOSffG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H0OOSffG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=e100PB9nq3NLfBr33oPYoZ10gO09AjlSnyIs6ceFKRI=; b=H0OOSffGfqgfszCZyN5QW1HE1R
	PwwQME4mJWNgl80eg/AwHVBeA5LyudWqRsPmpXPet2e3PF0GtnaD8iOdSiQkKKwx1fpV6mUA2xdab
	Eho/WpTIoe19aYcaIfc694yUG5t0vNqNsFkQcqiok0vczH8xlKYD4KUHUNVJSdANGfY29t1+tydcz
	f1AzzhkmdxdXfoPnwlJKf0Qwl8FV76oOXW1dAfm3Xyjvfu6TTRXGVm5yn35rphwVZs8d9EjAQPWWh
	C3t2KVhDi7F37NPlfqZp8O2/U9QctBktGIB8O+x7kE6OPy2n4L3kMm2REr5EGkZPE/WSss3/Ny9Wr
	O8q9ym7g==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uCNnG-0000000FgNU-2Bab;
	Tue, 06 May 2025 19:17:31 +0000
Message-ID: <9b50a71c-4106-438b-b475-592a60307a68@infradead.org>
Date: Tue, 6 May 2025 12:17:27 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EISA: Move devlist.h out of obj to always
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250423023743.work.350-kees@kernel.org>
 <1f7c8220-09e8-42ae-a611-9a21779badaf@infradead.org>
 <98d34958-e57e-40df-9196-920d40fd57f9@infradead.org>
 <202505061150.4B9A78AC13@keescook>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202505061150.4B9A78AC13@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/25 11:51 AM, Kees Cook wrote:
> On Tue, May 06, 2025 at 08:54:29AM -0700, Randy Dunlap wrote:
>> Hi Kees,
>>
>> On 4/22/25 8:50 PM, Randy Dunlap wrote:
>>>
>>>
>>> On 4/22/25 7:37 PM, Kees Cook wrote:
>>>> I put devlist.h into the wrong Makefile macro ("obj") to get it included
>>>> in "targets". Put it into "always" so nothing tries to link against it.
>>>> Solves CONFIG_EISA=y i386 build failure:
>>>>
>>>> ld: vmlinux.a: member drivers/eisa/devlist.h in archive is not an object
>>>>
>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Closes: https://lore.kernel.org/all/4a8ba1d0-d2d9-41f8-abf1-d45ec8996d10@infradead.org
>>>> Fixes: dd09eb0e2cc4 ("EISA: Increase length of device names")
>>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>>
>>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Thanks.
>>>
>>
>> Please merge this patch. The build failure is killing lots of i386 builds.
>> Thanks.
> 
> AFAIK, this needs to go via Greg's tree, but I can see if I can send it
> to Linus directly.
> 
> -Kees

Greg told me that it belongs to one of your trees, but Greg did
merge the previous eisa/Makefile patch.
> 
>>
>>>> ---
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Alejandro Colomar <alx@kernel.org>
>>>> ---
>>>>  drivers/eisa/Makefile | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
>>>> index f0d6cf7d1f32..552bd9478340 100644
>>>> --- a/drivers/eisa/Makefile
>>>> +++ b/drivers/eisa/Makefile
>>>> @@ -1,7 +1,8 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  # Makefile for the Linux device tree
>>>>  
>>>> -obj-$(CONFIG_EISA)	        += devlist.h eisa-bus.o
>>>> +always-$(CONFIG_EISA)		+= devlist.h
>>>> +obj-$(CONFIG_EISA)	        += eisa-bus.o
>>>>  obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
>>>>  
>>>>  # virtual_root.o should be the last EISA root device to initialize,
>>>
>>
>> -- 
>> ~Randy
>>
> 

-- 
~Randy

