Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBB1AB6F1
	for <linux-hardening@vger.kernel.org>; Wed,  1 Oct 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332537; cv=none; b=BHTKq7EAq+C5+JVRo1C19fjkYmWDUqkRg4CGey5RZiqWv17qCSQmig2Bo0Ce+uEQqk8jpDGRgqrGPxFforuQ3QtzEGLs2I2FkpcaRVrUYWW7S9z0FjshE7AlxG+Z7lcCGHyjiIq0mRAgVmcWufQPpHqGAWJv3/K40az0hih0b9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332537; c=relaxed/simple;
	bh=pM2tJQto+FBXrWHQP6YpikRxnpK4wtkLL4Epta9htLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdmvFt3MzNJEPZEo7uz0uvU7j9N5TYoxhXDPD11FKCE6dStj8JEy3r9DRTf4MoMNg79Yp/qEFs9zshtjpxTUS3pqKrlGZXbSoKqABeZOB4XL9kHU1h3Y6AKtLzpnOOHsF0JGc1nYt/84mVFbReAmOr0mBGjw4oE7sdy4z+ylZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv8UE29f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv8UE29f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759332534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e+slWpPA54aYcVOS9FeUlchlk4c0XDL9e2Lcv8RaMd4=;
	b=Tv8UE29fgeSBqvtOzIIB1JE5k7CpLl71M+2/LhmMS1oFaW0boxjCJHmNqt/s+yI1x+9wnd
	J8uCwZiLtkTA+xF0RMRQjwSFO+AEqTPr/UIAVxMxj4OwfXp/ziKdi12c7Ttv+rQHPNBkdh
	5ucqGpJMM9XVlDAEco9kxM46k45gfmo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-yvjJD_AqNGa7kg_8w9WymA-1; Wed, 01 Oct 2025 11:28:53 -0400
X-MC-Unique: yvjJD_AqNGa7kg_8w9WymA-1
X-Mimecast-MFC-AGG-ID: yvjJD_AqNGa7kg_8w9WymA_1759332532
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee1317b132so5765039f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 01 Oct 2025 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759332532; x=1759937332;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+slWpPA54aYcVOS9FeUlchlk4c0XDL9e2Lcv8RaMd4=;
        b=m3lnDGLQ96W8TLEoelwlff+iKHPXdAoxPks8YWxa27bGEkzXdXr7M5yoKdlmfR0L01
         +Ip7lZUCFmgAiEXqIwoI7EyM45aHEDyd8ymbO+QGM8wip3/UPJcq67b3Psrw1JvmXcH3
         VkUJngVvU2l/tBYsSdwxhTiKdZs6It0la/Z2va4eJouYafjEEMRdu0kgvmSTuktSmVjZ
         Yy3Q+nTYssjiQXOLVTmXTNQQqgYnn5fijKn+BEOz2AkUakqqa4938vVEyfzX3mQPL8ar
         5snI31SgYEl3K9jcFVA1cObfx27U/snJdY0+0oOgSo2rmLRcjNGSd1/9qERtbngqblsV
         GB1g==
X-Forwarded-Encrypted: i=1; AJvYcCX1JHY7IcdOUm3fl34V6g6scV8twryZbeHtGOp5ZaHqF2SFL/jSY0rZL28lPtAmGBMpFXwSh7PXjOMC16uA5PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyOGIXl8nu145oyhJ2A6WDvJNr8/KOQ1TxFcVqG5aZNm6Pfjc
	jn3XxHUCDLtBGknY5h9LvZqp/Pem7Zz8u1/y61BVCAF7Dijhen3NWs+W9L7fvvvJwiaE+sW1CQQ
	1R7xzlocUOZjelDbbpPwvfHjOQkqexdFq7yMn5HyaWVxalO1fwKQEvTH6nZ3ai/gX0LtSPQ==
X-Gm-Gg: ASbGncv8AHShcDTqQnw0DgK7su7XYeqceMdg1IXE9rXaWXslHha2sauHEwiOShJxXQV
	T8Bbj7p0QGp5sRE0g1j/r/SfsHjOoLy3DFEKBhQcjHuvisiUNcH1Ha/UiU8tfrNuRCrLS1BSmv9
	s35nkfLqkPrwrgsa7fBV+3ufWPRr02X9/OXgecLZ22aAlexiqdZlntCbolBBLKGGGOTdKLlx6Lz
	GMQ7S6AzZt+xQ1Ah1UhYJv3g1AqYjNFpjRUHzPWRc5U3eghUfmNaq9pvleO5f+anvASjCssoxzO
	/IO+0QZlU0W4S/8S0rslJ8uJGkBO7z3JRKFGAzOJpINo9ZOOcTroEj3cLr5OEoVh9lFzfq2FWsl
	yZoBuWn4U
X-Received: by 2002:a05:6000:2388:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-425577ed5d2mr3451656f8f.11.1759332532359;
        Wed, 01 Oct 2025 08:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdwITK7uCSqv/A/igDjSEGaWLXOD/8b6fdy6NcMUtXataIInxRPW2Ouk591De4Glwn2mQ9Sg==
X-Received: by 2002:a05:6000:2388:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-425577ed5d2mr3451604f8f.11.1759332531757;
        Wed, 01 Oct 2025 08:28:51 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603381sm29816097f8f.31.2025.10.01.08.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 08:28:51 -0700 (PDT)
Message-ID: <48ed62b1-cceb-4bce-923c-25c11dbccc37@redhat.com>
Date: Wed, 1 Oct 2025 17:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 13/18] mm: Map page tables with privileged pkey
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20250815085512.2182322-1-kevin.brodsky@arm.com>
 <20250815085512.2182322-14-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815085512.2182322-14-kevin.brodsky@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jJpCg05coHvJGlNRD6t4kYke16Ffd07F6Dg_84wHUSA_1759332532
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 10:55, Kevin Brodsky wrote:

Just wondering, should the patch subject be:

"mm: protect page tables with privileged pkey" ?

At least patch #2 tells me that set_memory_pkey() will set the 
protection key, and the function is called "kpkeys_protect_pgtable_memory"?

Just trying to connect the dots here :)

> If CONFIG_KPKEYS_HARDENED_PGTABLES is enabled, map allocated page
> table pages using a privileged pkey (KPKEYS_PKEY_PGTABLES), so that
> page tables can only be written under guard(kpkeys_hardened_pgtables).
> 
> This patch is a no-op if CONFIG_KPKEYS_HARDENED_PGTABLES is disabled
> (default).
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   include/linux/mm.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d9371d992033..4880cb7a4cb9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -34,6 +34,7 @@
>   #include <linux/slab.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/rcuwait.h>
> +#include <linux/kpkeys.h>
>   
>   struct mempolicy;
>   struct anon_vma;
> @@ -2979,6 +2980,8 @@ static inline bool __pagetable_ctor(struct ptdesc *ptdesc)
>   
>   	__folio_set_pgtable(folio);
>   	lruvec_stat_add_folio(folio, NR_PAGETABLE);
> +	if (kpkeys_protect_pgtable_memory(folio))
> +		return false;
>   	return true;
>   }
>   
> @@ -2989,6 +2992,7 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
>   	ptlock_free(ptdesc);
>   	__folio_clear_pgtable(folio);
>   	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +	kpkeys_unprotect_pgtable_memory(folio);

This is all rather nasty. Not your fault.

In the near future page tables will not be folios, and the whole 
ptdesc_folio() conversion will not make any sense.

Likely you should make kpkeys_protect_pgtable_memory() etc. consume an 
address range, or a page range right from the start.

-- 
Cheers

David / dhildenb

