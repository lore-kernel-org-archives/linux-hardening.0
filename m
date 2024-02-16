Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99B145328
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119956; cv=none; b=K4TEzndiqdrKsRycGi9fiSNl2sYwmIY00o4E12z6uUcdPd2iWeETGWm/jLA8X5ABc9+3Cbc0hMSwwzoGq8XkmzmH+iQ8b6vZHFj05XLs9BTOY8XfkiEeyIciGQUvvLQ7f34mJ5bIkA+GHF61yJJJ55GjB788QTyBJy2iaPNRbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119956; c=relaxed/simple;
	bh=sWcb4QWZQerF6dGRRf3Saf0ygsiHNPwWHpaQ0U2ubAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrHZOdWz2ZELYoEeRYBijtf8r5v4YJ7ybKo8iZLpkc5lasdfwfsehtP3DGmc9w1+e7j3fz+qEx2Bq8tSfI8hhDkk0Eh4zOssA49ZvyIcPlvD+eVY1guh2eZi/oePWj8jx8GyC1d9fHjP3vKQ4RvQhMYf10xxyYO6WOKC1SZoT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TdZbvg5k; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TdZbvg5k"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-599f5e71d85so1533668eaf.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708119954; x=1708724754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jksvwB5iTFy80QFc8o5j3z92gnehVl2fAGc//WCCKZg=;
        b=TdZbvg5k1WzoSRChsZ8ZH0hIBJkpubl4faHGJBahsAR4Rn1FbSpuNIqXbeQxN+Lqv3
         cl5u9EIsM6UTMHn1zhkGC3A8fvhn+6ZBQ0aSS07tZXNk8Ix1XkWGigxhdKpvhSubBrYd
         irmgEFLSC+x384R3lGCtxIpLBrVn8qbSNCONA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119954; x=1708724754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jksvwB5iTFy80QFc8o5j3z92gnehVl2fAGc//WCCKZg=;
        b=Ou7+UBijBMhAbYoedxGWNx5IxhrJX/5XefbkbdzfP1tI9kNZmgaxFaYNJU1BPesEE4
         MPVKJ1Mye1jO6fn8RevQ7wqkTe6vl04P9vSR99LSqio08PrN+uh+UMgpQFNJUvOSd1wg
         gNWGw4i3KUWv8hjLjR47mrU0tT/O2CtKZUnqnFoKnMkf3XNm3vtGboLLbAEsaQKzTDAx
         OF7lIhyiqK28+1dFgsOJExT0liwP1kZXzE/KE7hj2UjM47271ecAiKAXdnwf53+oZImO
         lDNjN+ceyJY2/7s9MbHRP6gjoQR35TNjVtjlwU1xNWnBt0T+4XitbRruoOXbMEA/Occ3
         0TdA==
X-Forwarded-Encrypted: i=1; AJvYcCV45vXHhtDscCsPfFajJVY36GVdLP7URPDn5jMteL3aH6G3edUmz6/9c97uXMn+aEOWdmI3g1EDs99qSDvAVJBWgIRXu82cwDZcWYQNa+RM
X-Gm-Message-State: AOJu0YzpseIVaisEKBostvTUIzC3vs3Wwki+kjeyeEHikoI0M1XPXAE5
	8cJZ6IdeBEW3xMiGNK7AECQYbyM5j+j3rj/S/H5WcwzleRQxP8PyHStkPHYQfQ==
X-Google-Smtp-Source: AGHT+IF9+vJFbk3kmtKKuYnkYafkp2Qrd9UzE5RWwOf99PqpIE62RSHCclH6Xu0D7RM+/Fd/EwCtzg==
X-Received: by 2002:a05:6358:648b:b0:179:2136:9971 with SMTP id g11-20020a056358648b00b0017921369971mr6537867rwh.11.1708119953974;
        Fri, 16 Feb 2024 13:45:53 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b11-20020a6567cb000000b005dcbb855530sm296297pgs.76.2024.02.16.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:45:53 -0800 (PST)
Date: Fri, 16 Feb 2024 13:45:52 -0800
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fortify: Include more details when reporting overflows
Message-ID: <202402161343.DC688FDB@keescook>
References: <20240216203935.work.829-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216203935.work.829-kees@kernel.org>

On Fri, Feb 16, 2024 at 12:39:41PM -0800, Kees Cook wrote:
> When a memcpy() would exceed the length of an entire structure, no
> detailed WARN would be emitted, making debugging a bit more challenging.
> Similarly, other buffer overflow reports would have no size information
> reported.
>
> Always warn for memcpy() overflows, but distinguish between the two
> cases in the message before continuing (warn-only) or blocking the copy
> (hard-fail). Additionally add size information to existing overflow
> reports.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

This will need a v2 ... something in my manipulations is triggering a
bizarre warning in Clang:


../fs/dlm/rcom.c:490:13: error: member reference type 'int' is not a pointer
  490 |         memcpy(rc->rc_buf, rc_in->rc_buf, sizeof(struct rcom_lock));
      |                ~~  ^
../include/linux/fortify-string.h:636:47: note: expanded from macro 'memcpy'
  636 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                                               ^
../include/linux/fortify-string.h:591:20: note: expanded from macro '__fortify_memcpy_chk'
  591 |         __underlying_##op(p, q, __fortify_size);                        \
      |                           ^


I'll track it down...

--
Kees Cook
