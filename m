Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF71BA89E
	for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654643; cv=none; b=Ic7nO5UIYQrjPABguLiT98adhB4DfYLsbjjzanjKWO+X6YQzGKvr2kEMZSTAiMDMZ0Z+lOoP3SnM5A57g4456xjp8DKGcnO+IOZnm5UyFBTl7hu0F++qCIbyxU1T24+ORUlaCQy4/iAeB73eAlMFWKT3HYlJZ5Y5l0nZhaZj3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654643; c=relaxed/simple;
	bh=ZKpdMlwy1Vuuc8abJVg8YoHUbcl+6GvtZq48vUrGLY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lnC1fBeHpMjQVRj2Cb3AvE+pRvAFlaqAXaOCul12nSRSY0TpvouuelsALETIzkuan4pQrpXMLDFZmbxgTih+oFcU4ErdI3+YncQT4PE6T1orRYVwU2r4waIO06XZwKKHZET0abcF8mbVByH9HKIp5kQG2GaX9OUNWu0wlqixoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fnrvC043; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fnrvC043"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5f9d68805so63633eaf.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723654641; x=1724259441; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3V7sI5wa59RYo+sZ7xurVHGqINhPxAhasnZ5W2BayU=;
        b=fnrvC0432wJJexqO+555N8ww1qFWm9nFbI1szZyw4ev+x4vkFE0q2l37yrM/ohaa7m
         AAbV5SOEXiYz4UHtb3zj3S9vWGbRhe3/mCdBBjnI1iz4hahFKTMNlc0t68DXFUpAcjmU
         XonN6AfAI0RP8MQQy6KPd3GKPmLYVhDU8S7kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723654641; x=1724259441;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3V7sI5wa59RYo+sZ7xurVHGqINhPxAhasnZ5W2BayU=;
        b=r9wFzMuCH6EejQ0dKVr9H8sfrn6yGeAzCN3pM58QIHRYUu1zn3ZfKBqMUTQ5j1ywNh
         80WU2PM5Ii4L2tg0sEG2TtRCShJnuxh6C4JrYJ6sGOOsReE4NIr++diVHJ4QXvl5Z9kD
         8EijLnTU0ftmlhpvXWLxcHg3EFzkh5hrH+zq3V3D91ZkUap++n+SCN+2OVyoz69dC/sy
         C5pQijQcmzWAyIkGWQ1edKYRH8p+j0dWTVOyeb3eBxO5DrT1aOmQfpmMf9IMS26V+z03
         sXPINGytOF2G/1lxvR+llA+ko8wqgsmq8U9UOZslevvr+CRFgAX+rZFf24+uGCjl3Kou
         jpfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEIWcWQFNukxozvaKGcmzmD3aViWmyusuPbTxJCTBQ02609NuQ9aLZYesLRFoPRDv4jObmJ68UtIzJSqQ6HH1gWZNfBGxv/18oeSMDS3Jm
X-Gm-Message-State: AOJu0YxtHnRO4fh+LSzmPTSFED1PaLLSi0OFnun9euej2NwCxJQDafKF
	mNApuo/qOGodMEDNgVROQBxHQSjW0u3eeAfs598fz6ikBZl1BztY9oJOQuEKd8Htd//DdtTp9Gz
	kAPIPA+AGlgFQ5c3YhgQUGD3TAMt5sUSP6Seb
X-Google-Smtp-Source: AGHT+IFrRfkhR2XduT5ByCnGofWNAIRptASixgPkXKhJgovUeEbG9xWDO8oNJsdQPuXoITtCyftAROEZJLTwNudxnuI=
X-Received: by 2002:a05:6870:5b88:b0:260:ed20:dcb3 with SMTP id
 586e51a60fabf-26fe5aea2camr4053360fac.30.1723654640802; Wed, 14 Aug 2024
 09:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
In-Reply-To: <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 14 Aug 2024 09:57:09 -0700
Message-ID: <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	willy@infradead.org, torvalds@linux-foundation.org, pedro.falcato@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 7:40=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [240814 03:14]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> > refactor the code to check src address range before doing anything on
> > the destination, i.e. destination won't be unmapped, if src address
> > failed the boundaries check.
> >
> > This also allows us to remove can_modify_mm from mremap.c, since
> > the src address must be single VMA, can_modify_vma is used.
>
> I don't think sending out a separate patch to address the same thing as
> the patch you said you were testing [1] is the correct approach.  You
> had already sent suggestions on mremap changes - why send this patch set
> instead of making another suggestion?
>
As indicated in the cover letter, this patch aims to improve mremap
performance while preserving existing mseal's semantics. And this
patch can go in-dependantly regardless of in-loop out-loop discussion.

[1] link in your email is broken, but I assume you meant Pedro's V1/V2
of in-loop change. In-loop change has a semantic/regression risk to
mseal, and will take longer time to review/test/prove and bake.

We can leave in-loop discussion in Pedro's thread, I hope the V3 of
Pedro's patch adds more testing coverage and addresses existing
comments in V2.

Thanks
-Jeff

-Jeff
