Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46033F39E8
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789810794; cv=none; b=mr0LS3PhTkhvX17n2BJNT0bSilMnj8mfihS6ue9grBr7j1cIyAH7Jomu0PJPcm7A8+cDf3V3OKohN+lVSnlw0gVYZ/btqjG1ou6Bp99jRdQwsBPZt9CPq4wYWfLyl/PHljLKGBDnUUpDuYp/2mIlDiuty46FZkFk7r8Tb6QTQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789810794; c=relaxed/simple;
	bh=tHdHCeV3i/53pBzx+BvRaG4iEMebCHpkPsy50Fuskxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvB1wVhBEJJleEjtiU/2odtZsF2aHUtluxKD2AGFv7Hv71ZFXpYWBU8gVIkZed31pMzMz2xgqDNkIlUg+p2MSQeW82MiQPDzFAv9Oya6H04+CYa22VqwUoMZ0hJoLMTl+oTpDMIx08WEHMJgspM03eXlD4OtGDjtM1/q6uxQtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcDGXE9v; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcDGXE9v"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so12886035e9.3
        for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789810791; x=1790415591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G7D6znmpASqvbzZksdBAJ2aUTbJ7HvmNoE6FBY58urg=;
        b=QcDGXE9vmm/H8m4H5M7wjApIcK1rfcHQ4bH6+pzWqT/pcTdIEgATWEUucjdZPixKK0
         ELFSRmPrh1/I82b3TSRUZE7sMNGGxJAcAPCYS5Tu6oTiwZwYVo75pnao4p7E9DRO1xxs
         FE2dhZ9g+MCW0DkDaqh4F7yNxvViK2ClO9JUcgsV0e03pXZyhqM1lCoL29UF5E3m+NBY
         1slOKaaOnH+bzU+qLC/lXcVFIZ3qc3myHL08DAs3aJLYNydQf9o2H2Twx8MIYl0pVzFi
         lfM72nR1e96Am1bEriXQUISdbDBXfeTcf0JOglWdsAb0funNzAsxxm+z+zbCUiUOoLAo
         Tpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789810791; x=1790415591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7D6znmpASqvbzZksdBAJ2aUTbJ7HvmNoE6FBY58urg=;
        b=qm0mOIHMAixbge518iGilfqvos0G6rr5ey8MDN9bDtB/fhiH3C7Br27DusnJVWoudc
         zequWFvY3mNzQog2CIWD+33+LxXf3NWepgebkwioRr4aibU8gHiu0Y+FeGzWFhrWHyUG
         2SkivPKtw4vET4QcUvll6I8MqroZAvzQA8TuaF+/sz4F8BfHXb54ilXdAg1TkRMztesL
         HDkJEkzl+Lt0a+Bmm0omX0xvc54xvxZA/uLleHJy5uKjq6xB99wPiMdPnap8vJOwc8J2
         vsl7/o7FFrXr53UfsNaYij1LSxpoq0+PPxYhM/A1m6jXQv0YFxw4Gm023mlbp1b+FJK2
         91lw==
X-Forwarded-Encrypted: i=1; AKwUvBzlmc5v5HknLm2OhCslGtaV2BJa9Bxkeb/VQ0sGzVnD6OTPUXHzu7lyRmk/6CCcubyGC/GgoEjdI2IL4t9Ic5w=@vger.kernel.org
X-Gm-Message-State: AFuF++nPDyc2gexzccKkRxFjf0zzpuleUvE81tWYS7mv4I68DYwBqNiv
	z0aSm8Um6Uqh0ywnTlTKRQXQ4NQLNnFPEu1jqPM4Isylb6dsvVrJVvct
X-Gm-Gg: AYBFou0pluhm7OSjTI3YoORuLIFC/eJwQlb2y7O9gH0FPk0C1IYVXbPa/oFJaoJzyl7
	yJJGeK8WLT3kuDj4NG8nrNqyD3WewoHEHTnzfNnqJ48xdUblfrOCItft2KNE44kgXqBoOVLUMi7
	8OriQf38uB4t3L8CHwDcRqW+O4Gc5BsE3wVxNZAilh4nU0Hk5dZx8ANZk7uc3hkt8VFXz+Hc27Y
	eEJ1EJKTAH4FHwm6eBu3ydn+n8ISs95G7vNf1ZbVwRyeA319DVLrycMxNchsJfi6QhYf3V+388Z
	NbT+y3lCQgOc6HtcYroULADVf5H8ZgK8aUKhf9GmwJCqc1XQZ6IhYAgSLDjNAPmUc3XrWisGjNi
	uXopD2BHJuH6NGzXeUfePYRK9zQvTGVKDzJVoj+PahtnzH01YiUsYArOp+1EUlxtRUxbFoU9m5G
	OyAyrrk/hmzShCaxr0otrHwAaSh8+BnVcsXYsww0WONgCOjpJyOO5uQ8BxMrMoozKwV5rIk76SA
	f4jsT73LpN8Hk2g9LplA74xAYAyRv8S24CnfPBBXPb8PnoL1lsXKkmWL7nJn5301j+Pand6xTbS
	sIDEhTXIVe7QjudmTUr/44CnTQTxcfovw1yanm+jZTrkuqswje9k3gFLdudoN+i2qj1BDnsERH2
	FXhopJbMY
X-Received: by 2002:a05:600d:848f:10b0:49d:827:e5b6 with SMTP id 5b1f17b1804b1-49fc5735351mr48923145e9.20.1789810790822;
        Sat, 19 Sep 2026 02:39:50 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a017-2b01-05fe-203b-7cd2-a640.310.pool.telefonica.de. [2a02:3100:a017:2b01:5fe:203b:7cd2:a640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc6ca43edsm124495965e9.0.2026.09.19.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 02:39:50 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:39:47 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 3/5] slab: handle ERR_PTR values in kfree and hardened
 usercopy
Message-ID: <aq5YL3P6tuFy4eTU@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
 <20260903203720.63689-4-kmehltretter@gmail.com>
 <497a85d3-e062-4930-bcb8-c86a8205e7b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497a85d3-e062-4930-bcb8-c86a8205e7b2@kernel.org>

> > +	if (WARN_ON(IS_ERR(object)))
> 
> Wonder if WARN_ON_ONCE() would be better.
> Also wonder about the benefits for hardening (as opposed to debugging).
> Without this check it would fault. Now it warns, but hardened setups often
> use panic_on_warn anyway, so the result is the same?
> 

Yes, I'll switch to WARN_ON_ONCE().

You're right about panic_on_warn. The benefit is a clearer diagnostic
and, when warnings aren't fatal, returning before virt_to_page().

I'll split out the ERR_PTR patches as Harry suggested and recheck the
KUnit warning-count test with WARN_ON_ONCE().

Thanks,
Karl
