Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254129A30A
	for <linux-hardening@vger.kernel.org>; Mon,  7 Jul 2025 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900372; cv=none; b=K5hZ6t+J25CGMHYZeRWyODumC9gSbqwOLp7OKNF2DKJAF2tCsuYlOy9Xw7gUxMtYSfv9AwBjll6iAArFLxh+ZDxOEvX4GSZO3LbUqFcEyRCUGGB3Oun6tzZC++A9/hu2tF5UvK3QIdWtUd3WEGYE/DLm8hS/kd11qRrgE1USbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900372; c=relaxed/simple;
	bh=5J6/q/GM8RZ99jS9z81cyaKyHg6P0FVUWfxHrUa5/58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG2X5HtbvIwKcp/KpIXW2z9U7JK486YVeN7a9CcpwnH4xdZJ3fqHIlUgru78rkv4VM2C8IdnMj5YGbEEpUuzgtydKhHxidQW45KqrllvvrVJ8P4wYUNGbCqzGhzjQDtmTU9JL/Ch5VHG/TW7ZfCLKUBhHlNOorVCU531ZyFZqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ho/SLovv; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ho/SLovv"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313910f392dso2621344a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751900371; x=1752505171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6TQLxoKJTtnPQL66AOVz1qBZAurWsbbtmQ08gZuI+u0=;
        b=ho/SLovv7ZTD7nf26TVEZqkkJaOXDwFjpqiXUIT/mABz1JG8jIXNfwKzgyuOKoqpPa
         GjNHc+OF0/cykuCxakHldGkpfmpZwXnLo4N0t9tbfYp05nGkdH+WmWBl94BO5BulKe3O
         J2DsBKYVcU0wDeTVaSStyZ4YqAUZcbmt11q4v+IaAjZzrE21xoMzRKyQQ/sJ9Qo6u0RA
         Y3OOJmWqwmb9S9SC35B2bVbeOpShkTqrzwlHrr/Fm3R2oDGtK34o0yH/jb099G4Yn+mW
         Iq+is9JHTAzQx4LkvrI92DKSKk9AOuWa//YdW1a3boFCa5ihHOzTcvzNcSqaI9LjQvOZ
         cIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751900371; x=1752505171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TQLxoKJTtnPQL66AOVz1qBZAurWsbbtmQ08gZuI+u0=;
        b=VdKUZm5jbUuP5zkRr2e6j+nhLzwzdop3C7N9x+bRiatpKKMzo3AcfzuOzlOmnKzbAN
         U7F2JTIWxHReNdWvz8PjTGH9cl+CtaS6kS9TvdNy0CiX3tFfD/qtA5SjdYRpsand+g37
         JGHZhBl35ZaIPUskLy8fu+zMICW7bk2a3xVWaKcQJUHWvHfF4688jiPRlslttY4ezyB5
         tCYmO3zNDkdi5qpF+Ca2GOdDsZX78XhJOI3AzHtXLweXod+auwLzp+8L5IUO412J4heQ
         c7LeyoFgNxoTDs9aUgHOoH/B2jf1AEp/JUmlT/uF+MbPdi2SLOIpW17rvZ2AMmtfQcdb
         m6rg==
X-Forwarded-Encrypted: i=1; AJvYcCVmb6nYnIZxvytilXizaHeVpBEc/QWAqGRalZ1/bZeV7T7F/d99v3ADNAEmNXfgLK5QNUgKXVGtZZlrA/7Y64Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLe+Ii/bwppvQnFnW2V4xa0eAbcmEwFmBnIeJSQyX49FTxMhRD
	GySQJMWzSmbj7IyhD5dRr9QZuSV14liGpxJ1HpsNxumsfKO0lnRzt1+sJvGSxvu0tvnJ3nKkjf9
	mkMzvvNBOiNNR+JXBwnqAdhu4WE6xDoHrk6QRXzn/
X-Gm-Gg: ASbGncuh8PA25CgKgHq1bB4Y5UZkqS9NfUM5Uz4s45JcZLE69VLn6lYCor2aT/To/dq
	lctoXt6S+ubli9DNBR9Zw4oOqhIQg0rYQvtFiU9aFHr1AozudT1zT/Br1JjlGZ6zZCVo03wwPxz
	xGij6dOVNkloVic0jRmGVhqjN+fy98XyU3KX8+d8iO
X-Google-Smtp-Source: AGHT+IE9YWkTfOUxIPM2EzEa1lJ2gNYhmQvgWwWfNnfCuD/M3jrRM4u+/9ssAC3XE0kDqrvmOJaz3qcx79G+IEBBFhg=
X-Received: by 2002:a17:90b:3f48:b0:312:b4a:6342 with SMTP id
 98e67ed59e1d1-31aaddfc24amr20985661a91.33.1751900370388; Mon, 07 Jul 2025
 07:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CANpmjNMPWWdushTvUqYJzqQJz4SJLgPggH9cs4KPob_9=1T-nw@mail.gmail.com> <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
In-Reply-To: <kicfhrecpahv5kkawnnazsuterxjoqscwf3rb4u6in5gig2bq6@jbt6dwnzs67r>
From: Marco Elver <elver@google.com>
Date: Mon, 7 Jul 2025 16:58:53 +0200
X-Gm-Features: Ac12FXxNc7MVDdqbSkiHg-OPuizBzk24Lc8ThBNq8a8QxrLwekty4YemWnP4YPo
Message-ID: <CANpmjNNXyyfmYFPYm2LCF_+vdPtWED3xj5gOJPQazpGhBizk5w@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 16:39, Alejandro Colomar <alx@kernel.org> wrote:
>
> Hi Marco,
>
> On Mon, Jul 07, 2025 at 09:44:09AM +0200, Marco Elver wrote:
> > On Mon, 7 Jul 2025 at 07:06, Alejandro Colomar <alx@kernel.org> wrote:
> > >
> > > While doing this, I detected some anomalies in the existing code:
> > >
> > > mm/kfence/kfence_test.c:
> > >
> > >         -  The last call to scnprintf() did increment 'cur', but it's
> > >            unused after that, so it was dead code.  I've removed the dead
> > >            code in this patch.
> >
> > That was done to be consistent with the other code for readability,
> > and to be clear where the next bytes should be appended (if someone
> > decides to append more). There is no runtime dead code, the compiler
> > optimizes away the assignment. But I'm indifferent, so removing the
> > assignment is fine if you prefer that.
>
> Yeah, I guessed that might be the reason.  I'm fine restoring it if you
> prefer it.  I tend to use -Wunused-but-set-variable, but if it is not
> used here and doesn't trigger, I guess it's fine to keep it.

Feel free to make it warning-free, I guess that's useful.

> > Did you run the tests? Do they pass?
>
> I don't know how to run them.  I've only built the kernel.  If you point
> me to instructions on how to run them, I'll do so.  Thanks!

Should just be CONFIG_KFENCE_KUNIT_TEST=y -- then boot kernel and
check that the test reports "ok".

Thanks,
-- marco
