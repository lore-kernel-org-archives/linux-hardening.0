Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC867306D35
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206910; cv=none; b=Yftpj2cI6gMY/Kgu5hJglCEdngCz1wYDhady67dNYvVZIo1JbOyM3HAw8qz93sBjrm3OW2SkByC1dnyfIPh/9id/+4cNZM583ZOKkH3JNlezPTS+6xCCc8bBaObUpE7VZfTmG+8E09D0Zqktl7MmbcdvYTd01H+r7v2nUutvjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206910; c=relaxed/simple;
	bh=yNKW1svPWQYfwzN+Mwhz8LUQicThZsVtWpSBP88B/Xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pULR4OIoq2Rt+zt8biRgmqWUAEwmloQUBAMJ+HOLrEgs+nCU8LEcplTEidjdloPHrRodzEyHHZnIZodsXHbzuF80XmGUnQAwqs9XohfsTUyJUpQwcuSS8G2GsJ9e7yX78I1RLbKXZxtf6oTrfpPdIkU/BY+Q+GDkfMPMSDGtqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FeC82GPv; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FeC82GPv"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70ddab8117cso311676d6.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 04:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756206907; x=1756811707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNKW1svPWQYfwzN+Mwhz8LUQicThZsVtWpSBP88B/Xg=;
        b=FeC82GPvdHhvQv5ETJsVhved93ehgPLylUaqYCvrprkjXRZSgeYHVnl87pHPSPsmZS
         N8Cr5CDLTElkdd+7vGQPaWzRBWHvU7aPJ+Mic6VmlKuioOoPPSxEFc7DvNIoqoQRFgIJ
         TW++iakbMp/2lNr27MuaPpst8mSfGXRolT+OsuUrG7AIe0QNU5+Gfs03CVEHkIdl35Um
         zbur9kr2gUqGl6O39qAthNWat530xzk8GfsVIGRCs4mZDihX8r5eSIX3l1l1o9G2MToK
         m5L8rjZYvguAub7s00aa0KiJCepV0sABXFqmQtt3XB8Bwm0bSleIJfcSdk7yI0TcUp5e
         Y0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206907; x=1756811707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNKW1svPWQYfwzN+Mwhz8LUQicThZsVtWpSBP88B/Xg=;
        b=sx4G6jP/XPTXg4vPMtihYq8/oitwL++fzb65SozWzGwFP+dTz7Udv+xJeOisX5mMvF
         ABwm+Jv7iLNkt0637XUQsRcUsuk1G0mZuGLShyCFHGe/HKPOe+o+W92/K7aqM/4iHZmF
         yimD7ts4f8NE3EXLlOEaAN2cE8pHmJVYF3I5fOLIkr++n/obiJG4V6M1Q3Gr2CkvvL+I
         yDM+S2o9vmecXq+pToP9+hIohYE8N/Di7euQv6tmEwu7cgb9b/hkoVbAh4h3FMIsbpZM
         HVsx8v7l1TlWVQMc4C8Vee4v0pEYJzHnJbVitt1mruRJjFPAf2hgHyyRrJtBGO50dDbu
         jucA==
X-Forwarded-Encrypted: i=1; AJvYcCUEF9/ZjDA7o+4kshOZ2OJUUnBWb88CD3UxO2xO+nDiKm9tgNNDGI2aXXr0BHHne6u9WGpZ6dSB9YTwBgNC7F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTuJva4veo5tJmfF9XJ4PZeBEbaSuFUBcRZVWK79jq2qTvXJh
	eME8CAAn8Q+TaKffvR3+ki3eoMC89tqJOLiwCZmlTwhve7LslrlMM33cPAPEb5K8+pW76NIa1/L
	sskh/GlNwjKzeZzMjJ6UhLE6dPZZlvIh6vE7fnjPc
X-Gm-Gg: ASbGnctnhtpxsvnCgUx1+pAqD2FhbGww9QHDibSRI7YFXKkTkFEG/0ANjmo6tALR7+U
	LnWFVS2oEaaLrRGxvMaDqHidjTgOlWHpOhVry7Kdqv1ZYp0QcSg2dyshkGT6xIwlPDygmtzr45R
	1LAh/ggxxiPuhwqdQoAmSqPe6i7Pp9sJubPVnfW3t7tiaNreTCsADj0usVPAyfyu38dSqdciBX7
	wjbee3Gybxgi9s9GtknQ/Xt7hW3x3e8A624NnFdzzxkeL8Fp3iqr/g=
X-Google-Smtp-Source: AGHT+IGipSwQ9H+9lir4i7sthp7jXgbze4rk/DAEYQJrO9h7c1f6+7P3RPCSiB/lbUAJre41WiVi6jclfFNB3YTBRpg=
X-Received: by 2002:a05:6214:20e6:b0:70d:8665:3c5b with SMTP id
 6a1803df08f44-70d970b2b0dmr209892786d6.12.1756206899995; Tue, 26 Aug 2025
 04:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825154505.1558444-1-elver@google.com> <aKyT2UKmlznvN2jv@hyeyoo>
In-Reply-To: <aKyT2UKmlznvN2jv@hyeyoo>
From: Matteo Rizzo <matteorizzo@google.com>
Date: Tue, 26 Aug 2025 13:14:48 +0200
X-Gm-Features: Ac12FXyU3fT-SuKRuDR_nD8uSQNd7DGjj8J1BVXdXRtps1xhjblio7NMt2GtdbY
Message-ID: <CAHKB1wKZmp2Rpw0zry70i16-c3FVkwtb3-XpLs5P1s4eABDD=A@mail.gmail.com>
Subject: Re: [PATCH RFC] slab: support for compiler-assisted type-based slab
 cache partitioning
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Alexander Potapenko <glider@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Florent Revest <revest@google.com>, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-hardening@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Aug 2025 at 18:49, Harry Yoo <harry.yoo@oracle.com> wrote:
>
> Not relevant to this patch, but just wondering if there are
> any plans for SLAB_VIRTUAL?

I'm still working on it, I hope to submit a new version upstream soon.
There are a few issues with the current version (mainly virtual memory
exhaustion) that I would like to solve first.

Matteo
