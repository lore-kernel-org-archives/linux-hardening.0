Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D81327E8
	for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716337; cv=none; b=ewH0/oJ1YZfks4W+IDQvrROcZ0sjxxsKlVwSJ6POOdK3pkNi4ztYdne7egVp23CS21NfZuIdiA1SNaGLZ8udJNAAMjhzFuqiSGmkR0m0/stDAEHoBpGtzbcO9tYiktyjI2jCIyeOxaPy94j0kQT6660DGLfQC0kqBFRzr4070Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716337; c=relaxed/simple;
	bh=sZP6tHo+9CZUoeCNklvRvOlqbMBw89gzuROoS4J3Mzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bfb83ZVGJMubvgbq2HNtsXzRuXF4tWw18sThcH+a5JvhyIacB5oOiFcBlr7HY9VjtiF1YJEbLvF8Ub2btQ4Dt69cJSRn4JDuDxMZu5/m7Mkd+JBauBKsNu2lM+vpwJjmNVe/047BPicC5//+q8jzppbfJFROzCn7ht7kmws1Hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZfnpfGN8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZfnpfGN8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ed96772f92so48483535ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715716334; x=1716321134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh5lqeIFxmDIv6drPBD1UeOlHcOcbwmzayc2S6c55cU=;
        b=ZfnpfGN87jzG0rt/lfhe7vQg/eTCzaodROzOlcQIx6Vet6mWXxV+LrOwJQblYLeni/
         dJGrz1RnoNb1mWjELi77HQlSyyf24fbpmVjwXGl052q2NvRXmG4e1GlPytFtJhtpAEx1
         B0izW07S5S2J58Qg+Fj2123oqlSEPnqklv1WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716334; x=1716321134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh5lqeIFxmDIv6drPBD1UeOlHcOcbwmzayc2S6c55cU=;
        b=knFqnsj8uq1qsgQsQa7w8He022dS99KaG40LuEKmUNMVlpHrZDONUmyK5EqnI50hmD
         mJwwGyQqjRYov6gRiWI6vv4MfQ1GFg4QrHC6X8pwEf+WVKBeLxACaMCmrpDDkouVB0ue
         GeAygye84nDM3rctJ8qgoR5KNPTPiRxESdKpTblEuPJRCTx/2CzxK7c/bRFfKevw9uLU
         EyGuY6Ov0yXouwkkTXZCDGF/Xgo/vDo0JRWj1JlqzXBbln5cPQxKIKbe/BnBITmUV7Zg
         hzeQpjiwZ68DU07ItpUXSa+nRZ+0il6ikxpqMICChH79k7NN07Lr3qmg+StwWuWZ7Inx
         JWjA==
X-Forwarded-Encrypted: i=1; AJvYcCX3DdGHWam9efAL2f5GzEOuOksa6xAZYLQ55AT03KdC9uQQiNvaauu+6ru2y/Qi+kpR9zEzk71SD3SDRl5e9r3e4XSEa+FieH2SW0QjNEh/
X-Gm-Message-State: AOJu0Yx2Hva+wyIIw5Un2DU9c7svMT4YAg8ujLFsWUfBxblak9qUVl1j
	h2VHjq8ixO9ehepuJGunwhyuN7sIp08+VZJsYdDLsqdpiees5Cc3fNyHXDvc7A==
X-Google-Smtp-Source: AGHT+IE4USN+kE7T6RZD7G5inzqpecMh0wnrqgy4EQ6oLTRU7SRnjNyHXsSdHHrK+4e8wMQQLJM0Rg==
X-Received: by 2002:a17:903:2290:b0:1e0:b2d5:5f46 with SMTP id d9443c01a7336-1ef440495b7mr159207695ad.46.1715716334549;
        Tue, 14 May 2024 12:52:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c038c4csm104274535ad.226.2024.05.14.12.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:52:14 -0700 (PDT)
Date: Tue, 14 May 2024 12:52:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jeffxu@chromium.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	corbet@lwn.net, Liam.Howlett@oracle.com, surenb@google.com,
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com,
	jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <202405141251.8E9580E@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>

On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> 
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> 
> I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> of the total lack of Reviewed-by:s and Acked-by:s.

Oh, I thought I had already reviewed it. FWIW, please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

> The code appears to be stable enough for a merge.

Agreed.

> It's awkward that we're in conference this week, but I ask people to
> give consideration to the desirability of moving mseal() into mainline
> sometime over the next week, please.

Yes please. :)

-- 
Kees Cook
