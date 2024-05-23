Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE381272B5
	for <linux-hardening@vger.kernel.org>; Thu, 23 May 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716507150; cv=none; b=NRrfANvk/aloOLQv/G7GxjDmfM2F0UT5m4vo67uyDiJJYPO1wJ2eQKS5c8pkTtbw3+nQmTn+9gBIDad+c3vnWasqJAddC9FrTQyscpDbVibDrCjdKwJiwYvJFaHoMfaJUyhsWfgZePfxFQgQJHrY3nI8rXbmlhJyT9Kcuz5E/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716507150; c=relaxed/simple;
	bh=Rl78iHC2xR4eTLgM9pFhtSrNG+eYrSYtgxu8L4wWsfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZi4WkwfbkrWhHc5+q91VHp0lDeF9iWZSS5FcDr1PXfFfcty84NoN9CzORJSnckZ6Hjfb2weMQSgOBCBiuBftK6wCxFdmuuw9+sspRqHl/loKJZfUiLR+/g92Vq7ZWq1ln6ANtG9VvA54hig9pBtKgpX53STUOZROYjHKTzEsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DYAIR9C8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYAIR9C8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2bf62b121ccso60455a91.0
        for <linux-hardening@vger.kernel.org>; Thu, 23 May 2024 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716507148; x=1717111948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uM+PPkDPycb5a9YVze8N+KZpCRY7ovH1PjJ2ki6nF5U=;
        b=DYAIR9C8W8spsie8Pc8vutCp2t+Jd2cRx0RdrITfImvTQVPr6GxPEYOGVED3WFHFNi
         ZMOROiAYQuReyR0EoAisvfbR2PESQXw/F5sye1MV6wcwJ793FpbG389fU8wEL6oBE9xP
         DmUvIGd3QQtMbsPTbBRe0VhVt2GFPRAlkstrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716507148; x=1717111948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM+PPkDPycb5a9YVze8N+KZpCRY7ovH1PjJ2ki6nF5U=;
        b=MI/a1WKSAakY6S+rkeXgPdLWk3Wmu9a/B8bUqvbbT69sWF4PRahVyVeMcOoVi46YRI
         ZvD0EqNfx8azt8+cdqLhElaaA1bNU8a1TtSt3Qb+9kDQJmKTR9U/KyBEQDOej1jf72/f
         CN1TEeWKUvg0Y/ufXmABLhibPYuFFk3pJAvUZ1ombrTAhQvAwNKpc61BXM11EY85krE/
         AAYDQJPIHD0HcX2zC2alpSDXBgGbgsa8Ggi5Xd0PRgl49NRv6q+PKNVqD36bd3x+xlFW
         OlMeEg6CeHnA7uK+owQnHusgZyHisFQNLRWWjZYnzTl6+BJoAx+K7pYGG54E7CU86h89
         /zpw==
X-Forwarded-Encrypted: i=1; AJvYcCUQmqP+k0aSDjdRK9dkhTTmYVdaofWhHQdiWT9GlJlrD5ELERNrq2Jw6v1HYpgfeXkzFHN+1+1r/Bo4KTHV0Mp/6yZG04XB7E/u4ehJUvrA
X-Gm-Message-State: AOJu0YyogWta0Ntt/6jYJVjZJLDgCjL8gNlnen09erfW7joS3AtywErJ
	dIONmf/syVdKmsqorhFOy3TsZhslmIuELa1R3Cx8Xf1HDFSHPuvKYMr0tqpxrQ==
X-Google-Smtp-Source: AGHT+IFOfvlBfPaN91h6KUnDd+S4/iEFS4mMZGfINsKu6kdcMCF6+DYoaaEjtaJjxvPHQzQQjzLQfw==
X-Received: by 2002:a17:90b:ec1:b0:2bd:d898:8732 with SMTP id 98e67ed59e1d1-2bddce8fa91mr5008761a91.13.1716507147992;
        Thu, 23 May 2024 16:32:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f615b9fsm247043a91.34.2024.05.23.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:32:27 -0700 (PDT)
Date: Thu, 23 May 2024 16:32:26 -0700
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
Message-ID: <202405231628.BBBB9787F@keescook>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <202405141251.8E9580E@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405141251.8E9580E@keescook>

On Tue, May 14, 2024 at 12:52:13PM -0700, Kees Cook wrote:
> On Tue, May 14, 2024 at 10:46:46AM -0700, Andrew Morton wrote:
> > On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> > 
> > > This patchset proposes a new mseal() syscall for the Linux kernel.
> > 
> > I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> > of the total lack of Reviewed-by:s and Acked-by:s.
> 
> Oh, I thought I had already reviewed it. FWIW, please consider it:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> > The code appears to be stable enough for a merge.
> 
> Agreed.
> 
> > It's awkward that we're in conference this week, but I ask people to
> > give consideration to the desirability of moving mseal() into mainline
> > sometime over the next week, please.
> 
> Yes please. :)

Is the plan still to land this for 6.10? With the testing it's had in
-next and Liam's review, I think we're good to go?

Thanks!

-Kees

-- 
Kees Cook
