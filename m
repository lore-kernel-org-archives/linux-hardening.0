Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7E26AE0
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235396; cv=none; b=KwexKqXFy990xzenmaR67cwFdT4cY9NwyICDUSXjjYUKy6W0krey95RkJd9bkdT/7rfDiNtN9dkG2oCAWD16lr+bLiLzORRRsH8w2hP8luFxdOYpGAOf+hYWV2fK0IvCkO+KTJGfI2cM64Eg2rq+eDDQHMRvFUNCET5QqlYs3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235396; c=relaxed/simple;
	bh=PtJHMj10OXb0kdkgkrb8tgubNV8cNGlXUgK81dDn4uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWzgyCXrNs3cB1DFY7a2tnBmUwkavQZ30qvbzYdnCTuvwvoaNbkKJegAI5mT76ISgcnK/sBK5FX6LRpV/VIUmEYRaA6i63q0JZwEx5CSHhlbcWSB7e8+w/YOdDVbtUOg6Rdh2CmACkDQDw7B243YbmeA90aq+x0n81XUexJaaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mFw1Qnul; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFw1Qnul"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b37731c118so451886a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715235393; x=1715840193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8s5ogdUt9IfEZlAdYuj7aMmz3fDPUoN3crsNCifKctI=;
        b=mFw1QnulXKtHwMeqJ36x/CQP7UOYa+CMrVvUctDELyB1e8/B1Nlq9LWQ7JSGUF0+Oz
         YkiLhgARY53CVU3AaGl3EOhkQWX3VDonqooPYPhiDZnb44M4rJQ92bmUzoLEh+hfQiHF
         0xdQbi6Q2e8dr4FUGKJEJIk2qbVxLBlO+af9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235393; x=1715840193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s5ogdUt9IfEZlAdYuj7aMmz3fDPUoN3crsNCifKctI=;
        b=LYNTEJmkdBGIOiwLIJ4lnCWHrRB5LzdaSgBoiWHZK3NHHqDAsJXXIauRcYLojOjZ3B
         Yt0WXtWzT7hF7q1ETiPI4P+ymLr7FMJ2S7d3eWqpj678d879vnm4hJPdqWQIN1GHCCPW
         T7hqCuXfVGBd2IR4v7Zgs4K7R8nzAKWsdIc17Il7/bPKZhuU2KN+VrtZ+EhOpkSpqJ3t
         RXUb2YguePvfHNwWD05gSv8UDpe7XqDq2oLWvutj7n7+IhHvoXOiivBbHJ9glvjG9iUc
         AjOXgNZi+kkVPG36NgKKjU7EEfcxaztDGvNEIFYqArOwueO8ESHo6m9gw4wOaSq48/yI
         CTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9/4HtJbEyV5KZtnRZ11bwq7p8WwuRZJmkPRCEKYGRZDmkxdjv+wQdjUoWO6iQZRsmu45jSiTObsnxHJB/0gON4JhsD360qoc9pfYKu5/W
X-Gm-Message-State: AOJu0YxAJh+Gnr0ecjvJYpabqz7tKKYwvmoaOivxXn/bpUwrbDAxk358
	DKEJe8N5L2m5Q/N+oY71EDL0HMGh/u1UzpGGAvcsCsSIvZKGNc2R+TeTdj+YCg==
X-Google-Smtp-Source: AGHT+IFqzikMESBMZG+WVvk+WptHcSgh5kqTqoDaOrL0B6tQBKEyulj/ZA+fDWbKAGEbWorXR4unvw==
X-Received: by 2002:a17:90a:ac03:b0:2b5:6d47:9e12 with SMTP id 98e67ed59e1d1-2b61639c8a6mr4341255a91.2.1715235393466;
        Wed, 08 May 2024 23:16:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea6a83sm2490804a91.56.2024.05.08.23.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 23:16:32 -0700 (PDT)
Date: Wed, 8 May 2024 23:16:32 -0700
From: Kees Cook <keescook@chromium.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: "H . J . Lu" <hjl.tools@gmail.com>,
	Chris Kennelly <ckennelly@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Fangrui Song <maskray@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Victor Stinner <vstinner@redhat.com>,
	Jan Palus <jpalus@fastmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/exec: Build both static and non-static
 load_address tests
Message-ID: <202405082312.D922795@keescook>
References: <20240508172848.work.131-kees@kernel.org>
 <20240508173149.677910-1-keescook@chromium.org>
 <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6a2905-395d-4f81-9ee0-57c541fb2486@nvidia.com>

On Wed, May 08, 2024 at 07:54:13PM -0700, John Hubbard wrote:
> Didn't we learn recently, though, that -static-pie is gcc 8.1+, while the
> kernel's minimum gcc version is 5?

Yes, that's true. If we encounter anyone trying to build the selftests
with <8.1 I think we'll have to add a compiler version test in the
Makefile to exclude the static pie tests.

There's also the potential issue with arm64 builds that caused the
original attempt at -static. We'll likely need an exclusion there too.

-- 
Kees Cook
