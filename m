Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11B82488
	for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642909; cv=none; b=W+/DOO4XKqAdhlVVq+NTsPSl08SSjJdkTe5UJ4LMJUTzybykfy4zFZkwafkB8nkm/FcT5uqu9XQQ3RAU1XqWFyHN7YL0YeDIjhHc8C1cmmcEU1YrUtQsW9y2BLYZcsX7/ejg5DVFFDGd1lVnZ++QHehQ2sC/7ToV2TE+7D5YY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642909; c=relaxed/simple;
	bh=FK/pOlv8p257iH5M65SUDFW31ZwENP3sUAncbWrb2UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+qtaKgwRZTUqKQirRNjRGSA3i+z7OYLzKvyAPrrnOCAM3upSXfRAZYQokdhIhodeh+lfzU4o476sjhxJxFl7dnxMcHSBeZi7XhHV4w/YqwJkPq8mZIrUfErXafwdl1pZosODwb9i+QMYF70hQAGIVULvzhqa85rUQiKI3l7TqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iwklbf9+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iwklbf9+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-61f2dc31be4so4117863a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 16:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715642906; x=1716247706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Alp79KUasntAH1xAOt+qh9t4wrzIhrRSX97PEjrZLDc=;
        b=Iwklbf9+elmKMIJNZC5JlY5Dgm8Sqo6bOGVL2h+cjBGV0hwkHTOwKHWMQ7LrW92oh6
         tX2cKiKifvFY+PnDbBdRlieMj3r2qJvtX035ZGqUfppuwZBfw3dpexgQf0lpdxrOc2xi
         RXXuAOI6iSl+rSmIv//TvYamEErrIk2FtK+ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642906; x=1716247706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Alp79KUasntAH1xAOt+qh9t4wrzIhrRSX97PEjrZLDc=;
        b=ZW/w/7RPN0hDtRCwnpdzKcMtJlaApWirqwICb83Flm+JN9j7yDuQ5A9Il6p1SRF+Je
         CtSBcd/WvyRq/mNf36wGFz+gFI4nOtCLIltZCr/HAvQ8Xvi7EyfZrN8EXW5uKczoFt4E
         GCH2Jw7pYTOJGmO6e6rq7sWhMiK5zWQRX2PIBqBJAD5EpvrLUzrXsQJW++W9VYUKLY1U
         fzjzbJHPOng+I5Od8GNyQO7St2GYlS5uRSNk0aMuZ7OstRNr7/gQhnBsJfxyq4xUaC9W
         ZMu8FXeO1WH4q0UksRQZxPIwPIYiIzoDv7LEseDg79ovpTAKaYSESTrPFdFocz6JZg0j
         xszg==
X-Forwarded-Encrypted: i=1; AJvYcCWHhKKzgXGR4QHEyu0atrrOrK8CVf2xTya/EsWUrLMUYNXj8EFPzN/Ut1v4TD01p5Udhz8Kqf49Wj9zFDeEjeFHFgxRfdADzPd/WBzHsZ68
X-Gm-Message-State: AOJu0YyID2Z/9VaEaYIV/ZekzvV9y6A9U3wjcLBJwcW8wyOVy3qHoTJ2
	2Xn+iFF5Qc2lb/kdYGIO7YxItwDisS9fqMs152+qzLwJ9JntM0vz635FYjBHGA==
X-Google-Smtp-Source: AGHT+IEFgmE7chs18iM9GrKNc3YSJsTec4uS+kF7AHYYIMLhQ7Or1D9QN4CNuHbEiHbakVLBZ9zUHA==
X-Received: by 2002:a17:90a:bf08:b0:2b2:7c65:f050 with SMTP id 98e67ed59e1d1-2b65effb9d4mr20481677a91.0.1715642906269;
        Mon, 13 May 2024 16:28:26 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863cd9dsm10304270a91.12.2024.05.13.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:28:25 -0700 (PDT)
Date: Mon, 13 May 2024 16:28:25 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
Message-ID: <202405131626.D61F8228@keescook>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
 <202405131136.73E766AA8@keescook>
 <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>

On Tue, May 14, 2024 at 07:39:31AM +0900, Masahiro Yamada wrote:
> On Tue, May 14, 2024 at 3:48 AM Kees Cook <keescook@chromium.org> wrote:
> > I am worried about the use of "guess" and "most", though. :) Before, we
> > had some clear opt-out situations, and now it's more of a side-effect. I
> > think this is okay, but I'd really like to know more about your testing.
> 
> - defconfig for arc, hexagon, loongarch, microblaze, sh, xtensa
> - allmodconfig for the other architectures
> 
> (IIRC, allmodconfig failed for the first case, for reasons unrelated
> to this patch set, so I used defconfig instead.
> I do not remember what errors I observed)
> 
> I checked the diff of .*.cmd files.

Ah-ha, perfect! Thanks. :)

> > Did you find any cases where you found that instrumentation was _removed_
> > where not expected?
> 
> See the commit log of 1/3.

Okay, thanks. I wasn't sure if that was the complete set or just part of
the "most" bit. :)

Thanks! I think this should all be fine. I'm not aware of anything
melting down yet from these changes being in -next, so:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
