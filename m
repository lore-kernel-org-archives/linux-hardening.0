Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE741E8342
	for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489451; cv=none; b=u6x8QbfXSqLDGnLiw2fawEX0Wu66hhDbP5poO0HntE0WS14q2qM1vxecu5+JuZY6HdSVwE4ew2f5BVPDq3jsLOzWofi0B8CxuNKz8dMAFfcpMRJXfyR5whM0qZVR9HRZihg2P1TnEiJ56leFRilfIAmvFVmMcyMK4zF6pcwZSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489451; c=relaxed/simple;
	bh=pl8NaGuc07730Vhu9Yi5iYedyPwIa2ZX8U6xHGWonLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gurra6jK4EynEbOODJGmm4/ZEGvh5bnS5ATIfP1FF0WyHCJJMvKZ/Rk04TxMWusZAJ8HLY9bzGUcIqPMl7epK6lOJIXaZeZpD1m8ap5hkensj5Gk8osTRodlaPsT6HMfOhbZgtEbZuScZlMoaTdqWvGNur+Z3jEOuFd1i7oeO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKGxken2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKGxken2"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43945763558so362369f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 19 Feb 2026 00:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771489448; x=1772094248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0GbbSdysg+YFEUJI01k89ruDtqq8bN+fDTrKedLeRl8=;
        b=gKGxken2WFoZuX42NCCSDHpNUhkhkcbFoI2oSFAAtNqCVSYwcJ1ZZ5YHdMKN0/L/A9
         C7GEQFB2FaMYnNMx8qpfCuOgn6gG4jgqzjKRIEGtMI8MZ5kowIdn7Q5h3wlguiR7161G
         Ee2zBv+SjjSOawkLFJpZuKnR76K9nncojZFMMJ3EtWirhtbZKCkl0yMmQ8oogbpOOCUQ
         wsu3fkeNNU669hBRsiAqFCPuNeFPpTVi+HqGz+CoVExuvK5vvhwQBvjKYE9Uf+18VQh3
         IapODavNdIwRKIguMrscVylxkcg1tqcoHdJm7jIKgOu9U7UN8PyGQZZMNlI3SbbbFJZX
         cXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771489448; x=1772094248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GbbSdysg+YFEUJI01k89ruDtqq8bN+fDTrKedLeRl8=;
        b=X3G8g/QrY913m/mJVAFZJ1XjaUv8k/bKf4MXGod3BZxUF1M+dWOI1gNONV0182K4Vd
         1klgvvO/Q4gG2rGJRXYolQrFsw/Lu0ibCyjxswwqkOUkDyxFJqyyM9twHMRGPw2sOEer
         0R4DP9XHYAR/6QBvwJqFeEp0BpipdFlGfJM4+66BubLplPUnXe6kni1yIWPPoa0kyzDV
         QGDxmHtJfMIHs9VPt5UYRg1DyVz7zTWv/a754t6KBE2bBFKr/hkKJP6qWT5EyLRINffo
         oD/9ckbcYY2tI15HDBSrNHP9t+OhsZ0HJaQ4Dmiww6AUjzpmii1+M83Ph0aI8gmT3LUd
         k60Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlej82HaPojs/EzbBx+/YYpIGq21PGrI06RF8vbEAv5DciYba09BZJ6foPlyYYz9z64A6ptVz7HTdqkl0GKQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSFpeEnagyELPv42YzyviBjMr70PLMsXZova0JVlxjX5JMiow
	EJvaAX/egs55jBdA2Ez2B/X6C8qHl1pby2fqxJlpJzviXHg2MWI/wDqwlcDkWwqpDiI=
X-Gm-Gg: AZuq6aJ/ZaPHIw9aJT3ShF++PGVQ/Vj8kMpmrOlbqEuFhszPIVMOSDoJZlRznCK7xta
	njRHkNIjVwG7jXe7rPHlnqy8DgI7evasONZpfc3VVzy2K6Sbn1LTElvkzEXrvYHuAE804q/c8GG
	Upok9VI9NbW/PYeXwc3/KzzD+KtY1Jon6wi6/NrZygLGazqaeSxv3E0uHsFyw0POeCc+1c1yk85
	3U/2a09Wei+pMFDyQOpOC7vyocyyDdl4cyUaenVQjp8w54THczzBQV0Z0zWE9Qz2sd64pqsVxTr
	KkYc3DMC0AQcwNsOFQOFxfXSS5gOYLyHz66FzeWLJnsRPuwTxGEK5hGtiy2utBpYaRKJOiCPB2/
	57wdODWXdAhqvtCzRgH2LPBzA7xM4KBQBm0/QtlUaV8BJFynNd1TLJt9YvBPOWobhzgMAlms4bW
	shw5qiT3AwVJEZTOPXMf6CNwv6se4w
X-Received: by 2002:a05:600c:6912:b0:483:456a:5146 with SMTP id 5b1f17b1804b1-4837108fed4mr354407295e9.25.1771489448240;
        Thu, 19 Feb 2026 00:24:08 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836ff00332sm412241365e9.2.2026.02.19.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 00:24:07 -0800 (PST)
Date: Thu, 19 Feb 2026 11:24:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 1/5] slab: Introduce kmalloc_obj() and family
Message-ID: <aZbIpCSuKU45b66t@stanley.mountain>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-1-kees@kernel.org>
 <aZbDQLeMsHCv32X8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbDQLeMsHCv32X8@stanley.mountain>

On Thu, Feb 19, 2026 at 11:01:04AM +0300, Dan Carpenter wrote:
> On Wed, Dec 03, 2025 at 03:30:31PM -0800, Kees Cook wrote:
> > Introduce type-aware kmalloc-family helpers to replace the common
> > idioms for single object and arrays of objects allocation:
> > 
> > 	ptr = kmalloc(sizeof(*ptr), gfp);
> > 	ptr = kmalloc(sizeof(struct some_obj_name), gfp);
> > 	ptr = kzalloc(sizeof(*ptr), gfp);
> > 	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
> > 	ptr = kcalloc(count, sizeof(*ptr), gfp);
> > 
> > These become, respectively:
> > 
> > 	ptr = kmalloc_obj(*ptr, gfp);
> 
> We are already getting patches that covert these to:
> 
> 	ptr = kmalloc_obj(ptr, gfp);
> 
> (without the *).  This feels like the obvious bug people will introduce
> with this API.  I sort of think that "ptr = kmalloc_obj(ptr, gfp);" is
> more natural, so maybe we could make it work that way instead?

Never mind.  It causes a compile error when people leave out the
asterisk.  Thanks for that.

regards,
dan carpenter

