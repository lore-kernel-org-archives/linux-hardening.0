Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08575248882;
	Tue, 27 May 2025 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357003; cv=none; b=FDiHnQzTo+hzR8fDLn0fKQL9K34jcCQq6OAM65Kz2p1EE2tsy/fMmJ96kBpkF+/exbipaNVqu+HBMJ2cbKuS+I4ct8uZgE3891V9Wmf2vnelH0F4X54VLXo2QPs0zvzf4YpuYwnJHSARXTXtO9Cofza/r/lo4PhpHD2GwkMbARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357003; c=relaxed/simple;
	bh=7QkD4cTz0xp6eE1cr7OZXNKsBqi43uWnr+xz486DP7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZuu1d0UAqH3nBtGPdMjgAcr4cQDjlA+o0xZDu/OIbfnKial06SUfAg+bj3MysdWYi67F+KqpmRWvNp/lkhfASC8QvIVy1nu/KXkmwiFlv6vYvJxtSpwbvgx1AuxK0iyx7u4qx/M6mkoD/t3KqQQa9RcCCOvke0oGWYjCK3O7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWCq/0W8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWCq/0W8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3109f106867so3449431a91.1;
        Tue, 27 May 2025 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748357001; x=1748961801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kifSZSORdoUA9RpRHCMG0u68nMpgj3e5H8/9u2dhE7k=;
        b=cWCq/0W8SpgZ8yq75vYuYcMyvXc5Uy6Nf7tW4PYVcohWbCUrHUDYpHkIB3wnAUe9A6
         jNlTfAMbYo7wCXPQKksbBnXa12lnRP4Lx/NHyH3o81PQIvhD4vuKzcQZNFjEjZ9nZIQq
         oJlKZV+wBKah3ghswhWX/w9uwCjyGzCr+MjPYzXT6RIZxQXGX/Je8QONec0qFqwc7WCA
         z2lhfBAdQjpzssSA2G3TZdN5pSHr6HfC8O2BXVHcG325+SAsy7LGV2Ku9Lg55KZ33kqv
         RvzHtCZPv0n0gbKfN/v0FnSiVIVfgV1AOQyIPjNOkTIRPOMd4nVpN5V7GR5PNZk9twFp
         d6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748357001; x=1748961801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kifSZSORdoUA9RpRHCMG0u68nMpgj3e5H8/9u2dhE7k=;
        b=Sx2BW1LeibDShyUgoOKt6Bvq8UPyP9TnOMyK9kRfMwHVPt9A58r238r5CE03TDRYrc
         hmGYWzAqw+/TqgG7SEH8w80wWqw8DmFwZ/ZPOqsSiup8x73q3y/ze9CGLloCYymvvlAe
         ZxQTixMvDkt6MhjwDol8G2O9tBWSlKZ49IPrszV2gL7J4RLSYzc5q9cL4r5pILrzpjnS
         y0Glx+9NF2uM/fE7hD4ruLOSWZ3fk7rqVTeLZDrbD8pYhmpsQaNPIkXCU89XFJ+06Xno
         eqIft5U39VJE46JoitisVlgyHeOEzt9A2MHLMxa7JaL/4sW7RmzQ4fTdm0sFh60qclZj
         H54A==
X-Forwarded-Encrypted: i=1; AJvYcCU52lvisev2nTSfBoaHz9uubHQRj3PQWZ2k6pFFU9Qsm5K0PUl3FTBRwYUOlH5iywUMT50BxHivO5jwHFy2K6A=@vger.kernel.org, AJvYcCUb1Ss/OnyQyAsbHovk0f8xRsa4iBXTIKX2T4jacbYimpXfpY6dZ0OSZEZQjU3eqzzahCVMW7YULQ65FPEu@vger.kernel.org, AJvYcCXu5J0b08TVd64ojyG+M5bogVK2o/y0q485/g4yV52IWzcwCZiMz8k6HDVv4otRv/cQPhL/7xzVfUqkULI5+Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTPBU3Ti/Le5wPD/Km4qMz0uyz/D7rTJCCUxHFdHrdV1QE4+3
	1zZ1JJ8LBYnV7Mr0yTvka4SjV2RNd7bi07Ajdz9lyZqSyXHiXurWh49n
X-Gm-Gg: ASbGncvKMOcC4gcg8qVanpVODhysqd8/YfjXJgQVvHSDI313O9ATQjHJmOhhnjRhDqX
	Gtgra7lTOqqIVkokBXYD4QRidGWm4olQQE8djqG5I99a0+nyZz1J5rX4TkFwUJX7owfVwemfqtK
	kQXNrC57nGlKs0QZc6kYlDhO+5SG2GL3MYW5Nq6Lz9myLcB3UNrMAgdCeyRsHxVAiC+hyaTaPQG
	heskhMfKYRbS/1BpzBr3MoDY2Ch9KPP9qpM7u2k8oMkAdRV5rcoQwKc0ffFNvVd303JBEz1Klpx
	9GPr/5nnXMFxLiZL89W+rd223p+GtiXDWHFHqUwwPY5GSmD/y10LTMAdCPFHJA==
X-Google-Smtp-Source: AGHT+IG+9vAbZFkdtwGmPfMFcVuT8al4fJtK09P77+uOBKpweyni0RslyS+MnQeyFdQT2I4mFjFkXQ==
X-Received: by 2002:a17:90b:55c3:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-3110f0ec419mr24249340a91.14.1748357001118;
        Tue, 27 May 2025 07:43:21 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311ab7eeacasm1729917a91.20.2025.05.27.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:43:20 -0700 (PDT)
Date: Tue, 27 May 2025 10:43:18 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Burak Emir <bqe@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 0/5] rust: adds Bitmap API, ID pool and bindings
Message-ID: <aDXPhs79tQGTNU9b@yury>
References: <20250526150141.3407433-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526150141.3407433-1-bqe@google.com>

On Mon, May 26, 2025 at 03:01:29PM +0000, Burak Emir wrote:
> This series adds a Rust bitmap API for porting the approach from
> commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.
> 
> The Rust bitmap API provides a safe abstraction to underlying bitmap
> and bitops operations. For now, only includes method necessary for
> dbitmap.h, more can be added later. We perform bounds checks for
> hardening, violations are programmer errors that result in panics.
> 
> We include set_bit_atomic and clear_bit_atomic operations. One has
> to avoid races with non-atomic operations, which is ensure by the
> Rust type system: either callers have shared references &bitmap in
> which case the mutations are atomic operations. Or there is a
> exclusive reference &mut bitmap, in which case there is no concurrent
> access.

Here I'm lost. In the other email you say:

> You also commented on the API. The weirdness of the API is all due to
> the separating "request to shrink/grow" from allocation.
> Since allocation can happen while other threads may mess with the id
> pool, one has to double check that the request to shrink/grow still
> makes sense.

And here you say:

> there is a
> exclusive reference &mut bitmap, in which case there is no concurrent
> access

So to me it sounds like if I want to resize, I just allocate a new bitmap,
take this exclusive reference, copy IDs, swap the pointers in
corresponding class, and that's it. What did I miss?
