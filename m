Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AA161933
	for <linux-hardening@vger.kernel.org>; Wed,  1 May 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593973; cv=none; b=tfpzUjH6+yGcO1aDrAIf9ip5pZb92tODwYXtFZ6pieJ08Hzxvelic1edUhAsh16QUiZ+bTvVrner/jB8la4vOrPFVQ5sJruAZzNsvm1wOwLJrD6a+Fw1d5C1cM4dHWJ5Bm5X6DzaeBYVPR3gt9h+muag6SFfQyVLsbsAbSKkMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593973; c=relaxed/simple;
	bh=MxqZIuh4IKZCsU3TBM1EeIPccCk29czriRckRt4Zj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnnqrhVBCtiiDH1bDoHOZg0stDVnbnJ3+g8QZ9Bw9GTQix0P9Hx7LuZ+WLBwk6MRnYRblTt6jeeaWP3OCIPDi4UTqRu+GOdayfnJOajpQbMb7G4zXV0rdYU3kBgQEKZp5WDUnIeP4oGnpqrKGUxkQSIrS5hPgY88bjqjJw8C3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G+k+SzpT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+k+SzpT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1eca195a7c8so7330815ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 01 May 2024 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714593971; x=1715198771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2o4tlUNctY7U6Cr6T8194ul7f2V0l6ukmfj5Y5+0nw=;
        b=G+k+SzpTdcnn3nLDye9OgNwYBcG/THqUUOQpXY+TgZY6pTLzwHLsDFq7bZMOgA12ns
         TsmKy6pa7AwJzWTOHYcTD6AeTkfWLm1cBvCWC4liXvGlFLSO9fyulf6ytDQiOzDe39Fj
         Ad0+BG+UWTerz8w+WmmDb0zpaHlmDXoqxgocI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593971; x=1715198771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2o4tlUNctY7U6Cr6T8194ul7f2V0l6ukmfj5Y5+0nw=;
        b=dIEErbhkLtQ2Nz4WQ7IpY54R1pBYyUTKJR6zmb4Lj2IbWisOQAi77kh838+bgoVY4m
         ZFJc/3a28/nRettQBo4gz1heZ/QjV8sGzVoWPDd/2bUCo+dgWORWckU2HAsA0WUlc76C
         CpbAQq2skJldvyleD2rAdg7LM9i7tRBDnHxiv8URidDkuFrUW0vfQ22/4UD5MO2Oye1b
         Gw7YWgYK2i0Sq560SnldDcYJZ3iwuB69zORStK4nIWvthnxvz8p9wARpC4w0NCHep7mm
         XCeTa53cxnZ1aWk24Xje0htBWTBHf32y56OWa7OpSzkdCJayWRzhOG59SC9a7sgaQnlP
         SwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVskPLGr75xYTBRERZaX6PGPwyGueo1ZcUmKZHHxoeqww6xQKdYpe97yGuBJ/zd8Pyg8cD/VhObDEEVtUHhJGiwesjUc/9HvVvDz4g91YV5
X-Gm-Message-State: AOJu0YwRGzjNY+AnT5kzWdXdLTvOaIOwC6HT2VJqY7hu08XwLzIjzjp8
	24KPHwDom3ZiuJpr6FkDgplcJNQP+KdEpQ2Rxu5fgsQzY2SxB5+w3cetJmCaRA==
X-Google-Smtp-Source: AGHT+IEw1MN7ZWjyOSnwvYGcsH7NwE54BG1k+72eDhYVUcDgtLB0JDZWdDTjdOhh9mn3t7M+X/IQiw==
X-Received: by 2002:a17:902:c213:b0:1e4:24bc:426e with SMTP id 19-20020a170902c21300b001e424bc426emr3467826pll.28.1714593971355;
        Wed, 01 May 2024 13:06:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b001e0e977f655sm24582522plq.159.2024.05.01.13.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:06:10 -0700 (PDT)
Date: Wed, 1 May 2024 13:06:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] sctp: annotate struct sctp_assoc_ids with __counted_by()
Message-ID: <202405011306.0B9D906F1@keescook>
References: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Wed, May 01, 2024 at 07:01:22PM +0200, Erick Archer wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
