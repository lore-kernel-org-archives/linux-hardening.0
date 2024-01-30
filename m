Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09914F61
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651743; cv=none; b=MnVTAtAvG9dAo+xX6ndwA4oM+oHwnmsjEaiTFwkNLD+P1wHbmsLVfhukUCAicWtmol9nIY8fdFyICiEOx8XFnn+sKIXdUiwp3iIb5k6r66+/HNvR1tjf/vJUSSESrIWGdZPOsiW0/J1ADPjmY4GM4vAH3IY7x7Ws0FdJCupeCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651743; c=relaxed/simple;
	bh=Q65Legcaqxpk83zwUxTW+gQWMAoQAmgQ7r7moKmFE/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D53pyphmwXJe8pTBbrBdE4AH5zyL7nYP2LAs+Z2ZVF4yEvJRzgmSplFlHpqHmg8vd3iTwmEFicz6TtBxC94UzGldJxHGBmFm7GbFIl7vpNVbunu2UVMGDRABelXwERnGmQ6Sx5DmcF9k8KIDV/mtWvb45KPQGcl/HkJydFQ0jAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h4stz5ff; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h4stz5ff"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de2e24ea87so1677244b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706651741; x=1707256541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgCw758SnRU10FmXGJ6fL0E+0y68xRsCAN6bqEGIiyI=;
        b=h4stz5ffhVjUZ6HXZFpmFWmSsXE4MmAj6prdup2kNs+ODL7hU1+L9oaEbq5wrhVUHZ
         EglrL2QccnN+hUblX7n5PGyaMe0ncE9OHkA8qs2k9egMraNr4F8puUpvSLbxv7FiW5QQ
         VT3zDednCv8/hYlj1qxOH5ranKNlSWsBy0RJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651741; x=1707256541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgCw758SnRU10FmXGJ6fL0E+0y68xRsCAN6bqEGIiyI=;
        b=Cs1Bq2IRsJLzEYY+68tcEgKrqzRSL2V2XS/B54OvfoI/VDj0d9XM/D08j7pZS0Ojmh
         LqJVDkMmLTP0bwu4Bhl61BVL8YSbE/rAs8LpbfjW1XZm0k9QN9zn036ppRvQCNzcic7k
         3oP8W3ytFt2o8xdWuRhUN5RIwTa3mC6GvRIF/sdF9rwDaYL/qK08BZIkiA8LqFcxWvAh
         pRO9vhdaSNucbtdynXZdUpB2Gi21qcBgr7NGOCCHCQCYQf4Ivlk9/UzvP6l66zDPZBlo
         Ptd2wV2kmeRCeADkVOj1zhG3TcHFDD22bLAkhZN6VPUbMUekCmrF0p43a+Gpbz7z5deJ
         XG/Q==
X-Gm-Message-State: AOJu0YwzEQhojeNWYGdPeWUsCoJblQkUf/qeTSzis9fpiv1YDh0IiFca
	f0XiSKX8zrG2EUmiPL/PUvY+t0n+77Y/9jOItc3l4r8OerC3heQcGcY1WZZ26w==
X-Google-Smtp-Source: AGHT+IFNNuJ2tpadInRyYT/MIBretl+h+m8yAcR8cRLKOZm1Oa7taQG2Zh8eDqCVcHX76clnYsUfpQ==
X-Received: by 2002:a17:902:bcc5:b0:1d7:8816:a81f with SMTP id o5-20020a170902bcc500b001d78816a81fmr6408751pls.134.1706651741309;
        Tue, 30 Jan 2024 13:55:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bv123-20020a632e81000000b005c1ce3c960bsm9078626pgb.50.2024.01.30.13.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:55:40 -0800 (PST)
Date: Tue, 30 Jan 2024 13:55:39 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Lee Jones <lee@kernel.org>, David Laight <David.Laight@aculab.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <202401301351.83A809993@keescook>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
 <20240130150721.GA692144@google.com>
 <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>

On Tue, Jan 30, 2024 at 04:18:42PM +0100, Rasmus Villemoes wrote:
> So here scnprint() would have returned 1, leaving size at 1. scnprintf()
> has the invariant that, for non-zero size, the return value is strictly
> less than that size, so when passed a size of 1, all subsequent calls
> return 0 (corresponding to the fact that all it could do was to write
> the '\0' terminator).
> 
> This pattern already exists, and is really the reason scnprint exists.
> Yes, scnprintf() cannot distinguish overflow from
> it-just-exactly-fitted. Maybe it would have been better to make it work
> like this, but I don't think there's a real use - and we do have
> seq_buf() if one really wants an interface that can build a string
> piece-meal while keeping track of whether it ever caused overflow.

Yeah, I think we can take the handful of places that really need to know
about the overflow and can't reliably use scnprintf() and migrate them
to the seq_buf API. It should be much easier to use now[1] too.

That way we won't add a new string API, and we can continue to remove
snprintf.

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/seq_buf.h?id=dcc4e5728eeaeda84878ca0018758cff1abfca21
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/seq_buf.h?id=7a8e9cdf9405819105ae7405cd91e482bf574b01

-- 
Kees Cook
