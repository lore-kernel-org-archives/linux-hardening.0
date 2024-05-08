Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6C12FF9D
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211811; cv=none; b=aDOgv/eT/izVdgFHKPxMtTrVXXg13pEjBapKTNReig3qrzFY8ldgkhVzo5fprIkUizGu+XbMpVQ9UnHDvN/+uaz1nx0IN1fib2QMXZ72RtLjimRPxQpLgYxStfbM+VtWvJenw624pd4IRkekTAnEl8lWW6B56yJNw0hsjyYNAlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211811; c=relaxed/simple;
	bh=y1HGQWnW087ryWPapOIDF4ENmKxgHtUhDXYwnbKJErw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5neZeKbGMkZizsGzMAUZ3l1VCL/AcD7C7jqZdTZ3htGh8ebxothZ/In3f0fpRqDa1i0upoDLopkoqT/xTA3Jp1CW/iOJZmd9FeESvh5WMWjI6y0KNZoJhHxdoHELapgmFScUh0HNN1e/kSUCGKzueM6gFtuctspXdIPvaEINtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nuLXf9VV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nuLXf9VV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so2140555ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 16:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715211809; x=1715816609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4aOUo+Ox29GhQhR4ZuEuFwhEG4wIeHKCaf3AQBwPEAY=;
        b=nuLXf9VVy3cdEJc2X0CWWl0m3aKyXQLggY3J6tZjbSZkNN3zqtvULVXqQlaAV1mGuV
         kHul54MHVfiTswM2HR/n0KVStc/Q+9AYO1/xJa6NhHBZ+WWS8qJS2NyX6mVu4wRjsSX4
         MS7HlviY2mkWBiJP1nhq97eUqhys+SzQM2hb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211809; x=1715816609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aOUo+Ox29GhQhR4ZuEuFwhEG4wIeHKCaf3AQBwPEAY=;
        b=WUzD5YzAxaIMfQleaX3noVATy3cux2xQ0/PaeAt81cNPtAaKmoZE3WhRy8aB1NvBrv
         tCfGBHHLtkwRJU3Actlet08eKtqdUMTKeszuIkh1y5msu985MTmXykXutIPk7tzE/Clg
         0V6/zpcZ5oAck8s+6n0160+ujBg3MaUpV0A7EMdPBMkUJvIkXPAKBrRnMfsRmnfCK0vv
         CIXt1blO3JZxQiGjMozZf5unM1qjOGNhcFsJyt2ZfbFPvxaBublk/7KYaxo3qyBp9HN6
         xvsfIx0o/SV8e1m+5BzVrEbnLMoV9v4utQTjxNSg63NP5hYE9IldNuyTVkDTBVzmLEgC
         HZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzt6VcHwezmud76LzkPbLI9yToePbvcBX1iuEeWq5m902QclcJ2nD1J1Q1hNQkNmFHUjJclhTA95iwXV8Ld7veWYAIflHvT2h6+l/rSsQi
X-Gm-Message-State: AOJu0YwMbTJrihVQA+igGEdN6GQwL/SWN47dPFaizhExw+A7aSz+yD6C
	3lUaNDf+BH6ZlH/zT2iu4c+4OgBqxLvQQjRcXeOJx0rE/zvVPeudW+4cysUjGg==
X-Google-Smtp-Source: AGHT+IF8F9eYSrfhWch2mudjIXjyH4c0O/q8Qefji8NxXLaBVZvd08ca3pmytlTZPjibFtmrd/seMA==
X-Received: by 2002:a17:903:32cf:b0:1e0:ab65:85e5 with SMTP id d9443c01a7336-1eef9f4181fmr16879805ad.1.1715211809118;
        Wed, 08 May 2024 16:43:29 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30b22sm1013945ad.180.2024.05.08.16.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 16:43:28 -0700 (PDT)
Date: Wed, 8 May 2024 16:43:27 -0700
From: Kees Cook <keescook@chromium.org>
To: David Laight <David.Laight@aculab.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405081035.6B1A791B@keescook>
References: <202404291502.612E0A10@keescook>
 <e777a057e8d246efbc90381c2988b9b2@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e777a057e8d246efbc90381c2988b9b2@AcuMS.aculab.com>

On Wed, May 08, 2024 at 12:22:38PM +0000, David Laight wrote:
> Have you estimated the performance cost of checking the result of
> all integer arithmetic.

I hadn't included that in my already very long email as performance is
somewhat secondary to the correctness goals. Perhaps that was a mistake,
as it is going to be everyone's first question anyway. :) But yes,
I did have an initial analysis:


Performance Considerations
==========================
Adding arithmetic overflow checks, regardless of implementation,
will add more cycles. The good news is that the overflow outcome can
be pessimized, and checking the overflow bit on most architectures is
extraordinarily fast. Regardless, for many Linux deployments, the cost
of this correctness is seen as acceptable, though all users will benefit
from the fixing of bugs that the mitigation will find.

Looking specifically at proposal #1 below, we can do some estimations. For
a defconfig+kvm+FORTIFY config on v6.9-rc2 x86_64, the signed integer
overflow (SIO) checking is added in 21,552 places. The unsigned integer
overflow (UIO) checking is around 55,000 (though I would expect a good
portion of these to be eliminated as they are shown to be "wrap-around
expected"). Running with SIO enabled is mostly flawless, though a long
tail of false positives is expected. Running with UIO is not ready for
general consumption, and performing benchmarking there is not going to
give useful numbers. However, we can at least attempt to extrapolate from
an SIO build how a full SIO+UIO build would behave. For example, based
on instance counts, we could maybe assume SIO+UIO to be ~3x compared to
SIO. This could easily be an over or under estimation, though. Regardless,
some rough draft comparisons:

Image size
       Stock	60197540
    SIO,warn	60299436 +0.169%
    SIO,trap    60195567 -0.003% (trap mode probably found code to drop)

Kernel build 10x benchmark	Avg(s)		Std Dev
                     Stock	439.58		1.68
                  SIO,warn	444.20 (+1.00%)	1.35
                  SIO,trap      442.10 (+0.57%) 1.52

> If you have a cpu with 'signed/unsigned add(etc) with trap on overflow'
> instructions then maybe you could use them to panic the kernel.
> But otherwise you'll need a conditional branch after pretty much
> every arithmetic instruction.

Yes. This would be true for any implementation. Thankfully in some
places where bounds checking has already happened manually, the added
instrumentation checks will have been optimized away. But yes, turning
such a mitigation on isn't without impact. :) But a significant install
base is interested in correctness within a reasonable performance
budget. And some will take correctness over all other considerations.

> As well as the code bloat there is likely to be a 50% chance they
> are mis-predicted slowing things down a lot more.
> IIRC at least some x86 cpu do not default to static prediction (eg
> backwards taken forwards not) but always use data from the branch
> prediction logic - so the first time a branch is seen it is predicted
> randomly.

Sure, though I think the nuances of CPU design are somewhat tangential
to the overall topic: how do we provide a way for Linux to gain this
correctness coverage? It's accepted that there will be a non-trivial
impact, and I agree we can start to consider how to optimize
implementations. But for now I'd like to solve for how to even represent
arithmetic overflow intent at the source level.

-Kees

-- 
Kees Cook
