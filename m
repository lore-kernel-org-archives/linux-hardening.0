Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935782D3EDF
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097116; cv=none; b=HfzjsenMGjmbodhgxhP9iYGyOm4inv9sFt9dC9jv0IKoy6/A+eIEWQiluZNMm4yd545r6wXppPSL8YQeYljt5tJk0TxJCN8K5YYkYhmMWpkdWW7A+3KyUXKyIOtQ3lDsotZZBr34RvAx+e4ey/HOOONDDcSnuBXPxOM8cjKfpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097116; c=relaxed/simple;
	bh=P6buRtJzpa25T5VxcH/q8Nt4p9GSLN8WnUDho5tkVtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erxKgXtu8XFTIh4/43Vj2DK8ZDwnuBbb7ZKQMpwQcXTetX02CBlcRGRVgPdihXNouRSUpywkXhNWK7rxoap+r4ebZaOTHvX2TH7zh5KFoi5Xiy4hSIx6sscadA0e1NQNkGhUFluJlLyVAmbIzH40fSzEMUm3pI9t8zkQYZuyXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZTifSKX; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZTifSKX"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787df0d729dso58687037b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764097113; x=1764701913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+zeOdZZaF4BJyqy5kMaeSWqNQvCyQPG+omQ/g0Gj7k=;
        b=jZTifSKXL5ZytmMfbS6mrxQUv8melgGuWIzYiJrJSdf+MHJbjTiTTTYOxxEstOOZUW
         3iUPA2fOx4Vb1D028IewvBS7KSEANUIrZbdUEZugwfYQh6U/SHeClWDpl5X6n56NRiL1
         aX+qEq2ecKBjCC5imUP+yPAUaFL1gprO62dIpCSw8PzI04lKHS9dUIVozhmG7px+hE3c
         zKFlHtLFXjKqfJPvrAWy9SWJgWwS5tDnhoe9csWZMf4bfsrbGdZH0hwgApYZh4TUtamH
         tHcFdeFvGCs4NP4yPSu1Csu6Da/lVsE+lJpldhyrzoP6JQGpqEoUn0KbUwIcxWnZYul2
         /urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097113; x=1764701913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+zeOdZZaF4BJyqy5kMaeSWqNQvCyQPG+omQ/g0Gj7k=;
        b=jQiCorIEdlbtOb5Vee1qSx02u4J+g3xK2lJyIPmuX3Le6Q1vJO7q+rL+BNgkf2booy
         paZ5E+8BPT5W8bFSl778aZHNHyUO9QiuMajVkhgNeaUFU8uVs5yG6FiW2apW9b6+ImDe
         gX11Stfsq/ECuPcX/isbJl1uvLNOkZUuIJ5a7lXCmtQyIZmYNd8gqP0M9f/4RC5NDEpI
         w+eEWPvisiHZl6OGfdZ50zgmSmeEIsfRkwtGZ/Uyd1JqFKacA3QTrzxl0CaULwRbPBYc
         XrK8O+NYk0MpBSUuJpFWE1toWpYHBb7N3BwbPFH9FXwLjgFtYhvnpk8WwbpgUNCj62Kx
         jOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlmQqVd7X9BRQmeriZEB9QizDTfUUoFJiX9oGNciAr8dz514JqTir773/RZME4WupzIqZ79ezNEVPqbid8FyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2s1Ur3xHRi6q5f5iUir/kB1sclxMfPOl2P3BndmvWhLQhKXQZ
	SFJRBF4HdCtDGkg/ryf5ImHZnvqfq6kIEbxXY/aZWbmKb3YDfPAuqV/7
X-Gm-Gg: ASbGnct27PdQXzWlhOr5bphpIIG4D+vzVR/7hCCDZCYl8GrxCmMglobQQrzFFcxlfgQ
	ti4vL/tCcxeOaCfPt91hM0SctqnORdDEsis+5vv//SMLwCHdGWTxxVn09OIR3rbhZc+a1OuBaQ/
	yC5nJy6+z39CNDMUQsw3iYRcutQW7hpvyUvK94lzSjGd/GXiJRapW2jbqq6LbfCFHKS/22Gz6kX
	LkMlVeEucV5PlbVq/xdk7Hp2ioSCyN49DBrZ6C7sutLVYc5y85k+ioECxXiniQK1rElFchAuPAB
	+xy6WCyQUCQUv/DphOQ+Nz2LTKpZWqB136frnmu7wohJwKduCggJ9iE6ygBJa2+v2GEtODmluPF
	4Ha3lNw/0Qr2Hgvx7AlhcaT362VM8rXt32IQ9JRsY44ydiKU0srFqp0iNIGhOKfhbPTC79kdvKJ
	EmYibzZZE=
X-Google-Smtp-Source: AGHT+IEd3fC2WDscBWmJaJ6t/VrtBvr4q279/8luMzo4kTWQtijZrJPqNt4WkAAB0deXmKVtpnwI3g==
X-Received: by 2002:a05:690c:45c4:b0:788:17d2:be64 with SMTP id 00721157ae682-78a8b491d25mr140972287b3.26.1764097113523;
        Tue, 25 Nov 2025 10:58:33 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a9a39101fsm35977827b3.43.2025.11.25.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:58:33 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] mm/mm_init: decouple page checking and init_on_{alloc, free}
Date: Tue, 25 Nov 2025 10:58:18 -0800
Message-ID: <20251125185818.1586946-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <5d0c582f-7e1a-4623-90d9-1dd6db443473@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Nov 2025 19:06:53 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/25/25 09:45, Michal Hocko wrote:
> > On Mon 24-11-25 14:54:07, Joshua Hahn wrote:
> >> init_on_alloc and init_on_free protect the kernel by initializing
> >> allocated and freed pages to 0 on allocation time / deletion.
> >> Commit 700d2e9a36b93601270c1e15550acde2521386c5 ("mm, page_alloc: reduce
> >> page alloc/free sanity checks") removed page checking from hot pcp
> >> drain and refill paths, and instead coupled it with CONFIG_DEBUG_VM,
> >> debug_pagealloc, page poisoning, and init_on_{alloc, free}.
> >> 
> >> As the commit suggests, the first three turn the kernel into a debug
> >> kernel, while the last hardens the kernel against leaking sensitive memory.
> >> While enabling page checking is relatively low-cost and tying it
> >> together with page initialization is not unreasonable, it does feel like
> >> a bit of a side-effect, rather than an obvious consequence.
> >> 
> >> With page checking now pulled out as a boot time parameter that can be
> >> set independently, let's decouple page checking and init_on_alloc and
> >> init_on_free.
> >> 
> >> As a direct side effect, systems that have init_on_alloc or init_on_free
> >> will no longer have page checking enabled by default; they will either
> >> have to pass the check_pages boot parameter, build the kernel with
> >> CONFIG_DEBUG_VM, or enable debug_pagealloc / page poisoning.
> > 
> > How come this will not break existing users? What is an actual upside to
> > get for the risk involved?

Hello Michal, Vlastimil

> +Cc hardening people for input if they are fine with the decoupling and if
> docs for hardening recommendations or something similar needs updating

Thank you!

> The upside is mainly reducing the side effects i.e. being more explicit than
> implicit. In practice I'd however assume people running init_on_alloc/free
> and paying the cost also want to do page flags checking anyway. The more
> important patch here is 1/2.

I agree with all of this. Maybe an alternate approach is not to decouple
the flags, but to make their relationship more explicit in Documentation.
Currently, userspace doesn't have much visibility into this relationship, so
an additional line in Documentation/admin-guide/kernel-parameters could
achieve the same desired outcome.

I'll also let the hardning folks comment on this before sending out v3 in case
they have additional requests or ideas for this.

Thank you all for your review!
Joshua
