Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BD3B6348
	for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399305; cv=none; b=UzKAhVU63nhXBKkiHuXIw2M9kmk/i/oB9FRYTu8sb4bXZQ8lPUlBB1gaxBcO/DyFcb21F3NxYQI3S6a63JGKvJQ60OiGdsGluB7FxwnkH9dhyHgk9eWO47Jeej8wFzPG6YLevoQ17QTJEQfp+FCtylr0fYcKFyC/QWq8hxsCxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399305; c=relaxed/simple;
	bh=zIgGXFhPhcmCwRhLNlAk+r8l30LriLi3g1dxUs263rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0A68mqRsITfABvC0xmuzik5jRUcspnYfUcMMHr7BA9nn/1YVwGUf4CDsBOnK/7TQCUI03tcXtmGsA7pOKWZOC0FDQhbJYBsJ0mGQXfYv0iIM+zoYA0IA6WLNm1D4fASSn87vXeLWdCF1XZdIj1UUgGAFWM/UPZRtGANp2PzzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8f/YB4Q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8f/YB4Q"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1240315f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 30 Jul 2026 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399301; x=1786004101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gU8t2nLiO6KyR9mHd5oQe5CKsSlNQJu7tk5IuJVGRSw=;
        b=q8f/YB4Q2BvmLLnS3Mo3pHYQEvh9tBDhwsK0NjUV7UF+2N/jm19XI8Z8ux+RHZcLAI
         8Z9AtOgv0EevMC7q+gL37iW236gJkxN0FKcKV1177/e6GsYjI0cnigY7OhoWb3cjMWZO
         b8rioRaWei4mf8lFVNN4PuzNC/aNFyx6wSlCtX6CiJj6FZnw8OxZZYLs9TzFMcMzBa6x
         0YTjyKo7GQMtEjAqUpXVubnpsJpPIHq7L+L8CZdfWFNSmlOwLHP4VeDeXE1JSB6yYIBY
         qlZNf2G2rvEyzr4r5vWqMRhTazEvUllBRLMUbKsBmQN//o+c09vmx6waEwmWXeKgYrf7
         yMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399301; x=1786004101;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gU8t2nLiO6KyR9mHd5oQe5CKsSlNQJu7tk5IuJVGRSw=;
        b=PVsPdwFCKf743GTFk3odkyIMZW8LMLCeJxfANPXGmqSEaapTiZOuRtOPqgmh0cnykT
         +GI0/nBoCCYeM5tNHsDCZH/dlrzuzFWqD0G2fBULJnNcaAGLHIV8ykyOwn7vOKBvh6dM
         xDeVsGUSJ9MgnXd608QfZz//fMZxOBxdoqryOlOvnDaUe5iOZ+cvJSoZyFlUH3wYtoNT
         FWgzS/dlYVkCx//yF5/86RZ36VECZTJ52fx0VjcH69zsosjKIybZ6N4s+gE40CEiSZ8x
         pNMZTk7Tx179rlCATN9k3uDFAFKQuCJ0TakehJ6QUVupjZogF81Krv+rDucwWPoIOI7M
         8vog==
X-Forwarded-Encrypted: i=1; AHgh+Rp9UtPPz8Lxxl7XxgYiR8VvBkW8KGaJXRfhMrBDbo6ulopEvcC3/ZY6ZjYq9EdosRsxWpVkzEPM9/GnWarCI1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmV8CNEJYlxlrBnmkV9dPueZSye3Vp4PMKDI46XIVzlsO8rf+N
	77und0k+Ypxmrkal+0XnOSolhRKA2a7w15zGQXtiy1InkCA8sv2FqO/A9xgY7R4drR0=
X-Gm-Gg: AR+sD12V1TMKWYu9/WEL5OSUNzPU4OzA4d6AvBokHvTOxVdHKaG/LqH5Tc56gS3JZUe
	eo6xx1a1F8tx/gtOmQsY9sDrHiFYOZzikZjbH+l6bHBOAyMNhzEaF0KVbTdPOW4/EljtSOT7LRF
	d2eGpBhwK779h0NgLjzQH1JcyiFvSDlSFHppObPrqiwFwKzcALBVw5GbhiMqLQ3i6EJrUrY2J6t
	JsyS2OP/0pjIsrON7Fjgig01CE+DL47ixcFAdZqTFf7YJZzW0OlYMSP7EifBI+BcN/9ZE2Ul3J/
	XSUoqvpu5HLh5sq4gz+JUCyqt10fZpaK4xVBYsWiYYgOaM93eKhiLEZOliRBLjLKttKDZss6g9l
	VaNiw1JkKxGhSgpbv6VTrM/49VJtRMn9emvLsSY//lSWel8qnaXrkz+2l4Eiq7rMcUAz3jKu5/p
	iBt0CvvDxsnbx/l6DoeQhBJxv3gkZ1mJbIvobW0/8L9rcOPDsNO5zMMIWsslHPrEAssOpaSRD74
	at0zeF2NZAVHx/As9GjUT6qYg==
X-Received: by 2002:a05:600c:154b:b0:495:78ea:2687 with SMTP id 5b1f17b1804b1-49800eae778mr19575005e9.29.1785399300682;
        Thu, 30 Jul 2026 01:15:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f0ebfasm37683065e9.2.2026.07.30.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:14:59 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:14:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 apopple@nvidia.com, arnd@arndb.de, balbirs@nvidia.com,
 dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
 mingo@redhat.com, muchun.song@linux.dev, rppt@kernel.org, tglx@kernel.org,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v8 7/9] x86/string: extend memcpy_flushcache()
 fixed-size fastpaths
Message-ID: <20260730091455.1242d01a@pumpkin>
In-Reply-To: <20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
	<20260727123429.5673-8-lizhe.67@bytedance.com>
	<20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 16:48:42 -0700
Borislav Petkov <bp@alien8.de> wrote:

...
> at least the code is making a lot more sense now.
> 
> The fact that you had to axe off so much cruft off of it tells me that you
> haven't really measured it right.

Especially since if you do actually measure the clock counts (non-trivial)
you'll find that loops are often completely free.
The out-of-order execution unit will (effectively) execute the loop control
instructions to generate a list of instructions that get executed at a
later time.
So provided the loop control doesn't use more clocks than the loop body
(and there are spare ALU units - usually true) loops really make little
difference.

This also means that unrolling loops often doesn't make things faster.
You do need to minimise the loop control instructions (and gcc doesn't
like the best loop that uses negative offsets from the end), and
intel cpu can't execute single clock loops (amd ones can).

Inlining also increases the code size, the I-cache reads are actually
likely to be significant.
You need to time a single 'cold-cache' call not just loops for long
enough that the result is also skewed by timer ticks (etc).

	David 

> 
> So why do I really want your patch?
> 
> Thx.
> 

