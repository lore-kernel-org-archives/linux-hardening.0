Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF81D61AA;
	Tue, 20 May 2025 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747702629; cv=none; b=J8IafcaUxR5/87HOryFNgQDWq5SU4ERwO19O6rNRNjmA+aSyDhIqRqxz/04VreyxFWYlqwySvE/vPIjcjhsTVM4QAH8EJBzLHL1sf6KbYbGMis0UoQvtHX6EoNnb1kb7DLcjGAVeuxlKkFx+rYbRIoky3FLwKgfPuDZ72+hhtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747702629; c=relaxed/simple;
	bh=3ay46nlc3n+X2gjdnp64fYuIFnWIDPYbwP20Wl2PbOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzqhunNBiUVndFqSvvUzlnO/n4YVCFZ0oIBy/uIgp47A0o0kJ9a0l2X8jQzPlmMglIGjeziBV4QLMia6BOtInFS+7n+5UGqu8xE6i59x6IHSoD5sZyQIJhwPxsnZd0tJuHHNyKYT9p280h6FPySRexhXH/BpCOiU2y8kzuO5vqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEchxQIs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEchxQIs"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af908bb32fdso3956470a12.1;
        Mon, 19 May 2025 17:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747702627; x=1748307427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WOZoj5lGolAElPriJPP5mMHKvwh3tkRDIoUgFiEfOK0=;
        b=YEchxQIszVnKxxB9NSYEvbsdETfjzaMnHhn+5wbTLczKAvX+MxwiPT7Qe45tYWNYjC
         n/K8Joq9fQ41PRbwXKvhZ4vsmG/IOmWZrNdUfNZgOLek/Ga56+zTO6WLrjBbG3/Cyh+l
         BkxouRguAj0dUjf/O58BA9n5UM5/PtFrtCuPUK3AedgA3Um0s1Vf+apZ3G+pWJSNyUUt
         u7tiMmgeDlf87L+yXKjFU0pfajZ7eUE+HK7fkvlceeEiDfUmQ0xcJa/d0BSBCNEtFAfA
         TqnLOB94t8qLA9AJrfF0klgdOAy3v8Mpjq0MZOeNWHHAXpDw6g6AX7SfWP4JFPRHtI2D
         6c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747702627; x=1748307427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOZoj5lGolAElPriJPP5mMHKvwh3tkRDIoUgFiEfOK0=;
        b=ImF/XtzXQHDI1l7ns/U5CuKNE8WE9IstZSFvwOT68HtEeSCOQpBJ2it8In+8sMPnE+
         rdYFf8GjVPmD0xCfhj/32NCw12iaR+Ptb2GGxYYUbb03YKmDGpEdYuR3E8c/6gnTd37z
         3SeDREpEDg1WfqCPUBlNAmjCi/Tb8upTEe6ATwWpcOfv9oisUrEbEvQ/AqM5Nh5GJLab
         oE6i4mysUoZqTOxLbg3rsXpdunVUtc7LyJg/nmxhJ6QQ9LXqijBlDYfvbWDevUZPLhph
         ucd2ldGzcXNiCOf+fjh25i5aYIHMTm5fZwD/081Szz5TPOIut/mtDlXXUQDkS01g3w9z
         0z+w==
X-Forwarded-Encrypted: i=1; AJvYcCU/Mts1XQ8ONYTpLrSF2TzpyqVdMHElAxZiqW1L8CttSUEs/FX9Km062/X3s+6HpcsLMQcRLQmsDJU9cbUX@vger.kernel.org, AJvYcCW7wm3+oeMJ/zezkYVCZKWeG2m1QnhYGzaXfjmyZ7xDoFQK5SVZ3PxnhxayF4Lg4Bh+m9irAhyI/upVn/eXTd8=@vger.kernel.org, AJvYcCXzoRgy4sJGzdcLsYfyugHTFeFGjyNfCHE2OCdmd1skrpnvBdyTzaDKcfiLqa//t9Yl29SKqnuoPu0juviuxp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4NLHwO6W6Xk5nGvD0MjWHWtaRKmCqeRGGHAWTLs7PgADp8pC
	z/1RJ1CNUNZv8mvndWFGm+2Zid4kmdvubU+sG2x1fl2/Y3Ongg+0IsWs
X-Gm-Gg: ASbGnctOIS4UfV7XePJaHfKiWTIvhyePp+pv6pu8JCwhtlRBLP50HYpTw1PuSSSDCMd
	+nKcM2TE81dj6BWueUhzIbAC4SPUR505qzpD48fBntdkp2poR/9JCe7gr9Bkx/f0o/9THKQiH8Q
	3qY4ry/kS45e5wb+RXpymqQXOz+qO1SnNIx4vyIVvJni68RupMaD9PFejue/Efxya+8veim4jIz
	wkHJBzOFawtfgyn5uayDICmsVKlIX7wQTQG3KLAEfFq1x/fIMRhNQCkm3I7QyptlGCWB3n1JlVk
	2koBAdhNdwBu7Duwq9QJSAml0nacNMENdgSfAg6ZHQW+ck/7hqU=
X-Google-Smtp-Source: AGHT+IGvVskIxNh+tv8noWy4hcl0vR3Ickl8Ky+fPBkOU92qo0wzJ8dAq+wnVoplwYE5SFuk2Gf1PQ==
X-Received: by 2002:a17:903:3d10:b0:22e:23c1:d711 with SMTP id d9443c01a7336-231d4e5087cmr211842255ad.16.1747702626934;
        Mon, 19 May 2025 17:57:06 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231f304a55fsm55208655ad.93.2025.05.19.17.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 17:57:06 -0700 (PDT)
Date: Mon, 19 May 2025 20:57:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jann Horn <jannh@google.com>, Burak Emir <bqe@google.com>,
	Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
Message-ID: <aCvTYHMtuWZZizn9@yury>
References: <20250519161712.2609395-1-bqe@google.com>
 <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <682bc528.c80a0220.13f632.9ec0@mx.google.com>

+ Carlos Llamas

On Mon, May 19, 2025 at 04:56:21PM -0700, Boqun Feng wrote:
> On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > On Mon, May 19, 2025 at 6:20 PM Burak Emir <bqe@google.com> wrote:
> > > This is a port of the Binder data structure introduced in commit
> > > 15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
> > > Rust.
> > 
> > Stupid high-level side comment:
> > 
> > That commit looks like it changed a simple linear rbtree scan (which
> > is O(n) with slow steps) into a bitmap thing. A more elegant option
> > might have been to use an augmented rbtree, reducing the O(n) rbtree
> > scan to an O(log n) rbtree lookup, just like how finding a free area
> 
> I think RBTree::cursor_lower_bound() [1] does exactly what you said
> 
> [1]: https://rust.docs.kernel.org/kernel/rbtree/struct.RBTree.html#method.cursor_lower_bound

Alice mentioned before that in many cases the whole pool of IDs will
fit into a single machine word if represented as bitmap. If that holds,
bitmaps will win over any other data structure that I can imagine. 

For very large ID pools, the algorithmic complexity will take over,
for sure. On the other hand, the 15d9da3f818ca explicitly mentions
that it switches implementation to bitmaps for performance reasons. 

Anyways, Burak and Alice, before we move forward, can you tell if you
ran any experiments with data structures allowing logarithmic lookup,
like rb-tree? Can you maybe measure at which point rb-tree lookup will
win over find_bit as the size of pool growth?

Can you describe how the existing dbitmap is used now? What is the
typical size of ID pools? Which operation is the bottleneck? Looking
forward, are there any expectations about ID pools size in future?

Carlos, can you please elaborate your motivation to switch to bitmaps?
Have you considered rb-trees with O(logn) lookup?

Thanks,
Yury


