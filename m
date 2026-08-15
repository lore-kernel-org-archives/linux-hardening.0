Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09219CC14
	for <linux-hardening@vger.kernel.org>; Sat, 15 Aug 2026 00:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786753710; cv=none; b=SGkRUJW0apC0uciyUtr00xwVfnO2nYx4bhCKkYWMV9ZvBW0vzZ0Z7ON1m1FnfAK4JN8wzkEhF7p19CZ4UMeRRQ2ikT6pVQOo23H8eUOh/ad6r26DPmpgG4SyGBABCeSijKHKczDh7sXKckdw04u2rdBCdgoL3yOzgajZcGHG87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786753710; c=relaxed/simple;
	bh=VdoxyZPOqc4gajM4tWVv7aPhUu3It/yyhy4oJD9Hkqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjtUoy8q8rhbIZQzEOmM/uXUNZJv/9Lv/ZNKjFBkZWdzdG+YgZG66WGoPICQxFLRX6pnJbKn0nW8wtXbYNksd8vnDr30hqD2V/4aRRln8DT2M9SfuhffrE9Tjh1lw0+3CGBQS5W9KdsgWeDk2Tz9sq6s4RkRWZ23TdMn/nngdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKoiYbot; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKoiYbot"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so14070695e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Aug 2026 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786753707; x=1787358507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5K+G6TwOX21s1Ie3PMbo+iOlYucj/5s5+PZY2NK0NE=;
        b=XKoiYbot4HBUDrVvAc49cY7lBArs3k8u5JNVgRwmtX82dcfla1O2y+WI9bFAM7w8jR
         TpbfyCgaTiWx9U4m6V2VUrqYkzzr1/TIKqvNiela4frBOSMJb1k87sXYIB3BU/om0bki
         PHkabL0tPbn6kCNHjuMu1cTEPyKv8VSu5rSCM2owvwYDbVFxOALoji7el2kSG706SZFa
         saC40SFjB/LQ9l/tCiYmwIS1tD6dP44LYwKzDteY65THVAA378A3KC0m5nK+W95nO/Ne
         0be/xe72sxTemv4pgzakkoUd4jvvW1KW0UJ/8iRrXxEQima1Rk/Wq8lKlCQW5Q7Jjdj0
         InMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786753707; x=1787358507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5K+G6TwOX21s1Ie3PMbo+iOlYucj/5s5+PZY2NK0NE=;
        b=JZUZCxiKyxSAu6gLeFV0Kc9BFAw2FgDNCbR1NSWa/8Vnmzc6TX449SDIVJ5NUtJSJM
         bBtEMYOPU8pi1NmGqIKJfYTo896yP25VCowumTjJl+3EYj0YJWkC5u2SCIOE2mB5Cek9
         rWgA4rNRHW1vAtOrWvl9IiFBPkmwiCUoVTEjUS7afs/3iNrvytscLsF/hBfBnXmA/31X
         WDPUbcWVv7tGU+86yJePkEPRczaQp/yI/3pIG2F0soQ/knz6zVxwIBZQCZRIXvZ+2oQZ
         YjAFpqlgk7YeMlpGoHXFtbwohkmPPDNyPcDPh512esoB8NrwD+VniZlYb2wa93Pt5WYO
         yNUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgteOlCc2ls5Ngs2NNXZVfpdM2I16nUgGp5HkJYPwRkelyLa7h0UqwbvqP8+U4gczuQEDDvJ9FJZPTJYxdhSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLdeitAzC6Bz7Qpq2zekOJ655ApSpy32MLaA0cLTnHvIWqwd1
	PSY96kvWZgLhDpZSq9PSBK49piZSRm/AHs0RudKwBTGJGtTXbKmpR091
X-Gm-Gg: AR+sD12dkdqJaftSbTzuqGaLmgfxhGFgAEazpnUW7ESwzKkEaWJrwkUcIuSDMXTBRvQ
	yQOWeAKHTmm+ZppNl/E05Iat0DwGN5IHiC0wHFZZbWDmc670VN4eCsA3cdJDXCCR13BJ1+D6SkR
	d1Fhh9rrI7NLVvNB19eCP+sNT20Fx87ERNcU2FM8WrgrbYtIAofuuaBZN3x3lyFAuSy+eb88VL4
	E/zQsLod0qceZca6b1G1rJ/6/Dkuz3qHMWc4Aa8oYle4mfd3SBPGUE9CdYPpGVFE/jm4N/Clm2J
	l9S/ZEPSd1YmP1ox+KuJCRW3vSfy3t05wvZOFTRv0gcmuC/WWH5sK+NsFYuOT+gwpvzicErjaEN
	lqOhtIsDB1SXA0QsJrXUDx8KJ41tjC5WB040086Qn6Z9YmJ8tCiFGK/1oulHOQbxyQAL4tcIPv+
	VQ2HpMimb9KzBCXHuuXg73oIOvMWsUX3fIBREj0nCEh+bII+MfeNhZnKJpouiKIuaZ81JBQ/CaZ
	vPA6Z0hRBfVV+QkujarNpvJMjF/0jIDH0w1RDkOgl0lVHYbcz6WdayBrIyUUHBQ7PJ8OrOn+mpu
	1IK6NxGN6eVaJeiapMKy5Z6III025iFR3vI2Nmzr2YuFzJKMA62TNsDubxF3rDrytQ==
X-Received: by 2002:a05:600c:4e0d:b0:499:900c:9c68 with SMTP id 5b1f17b1804b1-499900c9d75mr3231915e9.6.1786753706369;
        Fri, 14 Aug 2026 17:28:26 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9d7d-f301-9495-44ec-73e6-1be7.310.pool.telefonica.de. [2a02:3100:9d7d:f301:9495:44ec:73e6:1be7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998ba01c62sm58696145e9.14.2026.08.14.17.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 17:28:25 -0700 (PDT)
Date: Sat, 15 Aug 2026 02:28:22 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/3] slab: check for ZERO_SIZE_PTR by exact match
Message-ID: <an-yHQe938PS-Opz@gmail.com>
References: <20260811141240.62519-1-kmehltretter@gmail.com>
 <20260811141240.62519-3-kmehltretter@gmail.com>
 <202608111716.0FA9DB17@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202608111716.0FA9DB17@keescook>

On Tue, Aug 11, 2026 at 05:17:48PM +0100, Kees Cook wrote:
> > Compare explicitly against NULL and ZERO_SIZE_PTR. Store the argument
> > in an unsigned long temporary to support both pointer and integer
> > address arguments while evaluating it only once.
> 
> Can we move ZERO_SIZE_PTR to cover the ERR_PTR range too? See this issue:
> https://github.com/KSPP/linux/issues/93
> 
> > This also changes check_bogus_address() in hardened usercopy: nonzero
> > addresses below ZERO_SIZE_PTR no longer cause its null-address abort.
> 
> And then check_bogus_address would also catch ERR_PTR.
> 

Thanks, I did not know about the earlier discussion and the KSPP issue.

Using -4096 for ZERO_SIZE_PTR is tempting.

However I found a few conflicts, for example:
  - PowerPC KVM guest kernels map their magic page at exactly -4096. A
    kernel making this change would probably have to move it to -8192.
  - m68k DragonBall has a hardware register at exactly 0xfffff000.
  - OpenRISC could reach this address with an exact 1 GiB direct map.

Linus's original reason for choosing 16 was that it should fault
like NULL:
https://lore.kernel.org/r/alpine.LFD.0.98.0706011554300.3957@woody.linux-foundation.org

I would not include ERR_PTR range for ZERO_OR_NULL_PTR()
globally. krealloc() also uses it, where it would make an ERR_PTR()
behave like NULL and allocate new memory.

Maybe keep the exact check and add IS_ERR() separately
to kfree() and hardened usercopy.

Karl
