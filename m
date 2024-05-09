Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F238C
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715213188; cv=none; b=S8hKeEOSUrTcBnKpwOJy0pKCagH6InCxheUbzuk9ZY0VHZOR/SMmMytbEwLiSST2Entle8Nhxg8gx1IIK67NRe2mo34cx0lOJfdRA4NQkr16++uKhdBY5K24wCds/JwAaf0+lmI+nYQtahXxMKk1oCnzq3wltS2lgDzqOcCEbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715213188; c=relaxed/simple;
	bh=IDtem1V12nNx0FHh41q9CjFqh2Oa/zkNU2jMr995274=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIH/2XHPiuzlXXGe4YxevQ9tTj7mU5M28ykYx3Vwjg/ITyfaLfpnm2u8o/opwXAH8Kmi9YelRS6SKR8oL6nI/Pud4JGl6s4VodrSwLC1uLjYe+N5IIE2CdbtPhtQdPPFzJhIQzaNqkM7Qw2H1VaRPf4s1q91Vy8Xtdi2jDp6nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BpolYLB2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BpolYLB2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f3761c96aso341695e87.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715213185; x=1715817985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EqMDZ7IrqUxdNK1BGX9Bv8+FLqyvy2F/S5DRaEwsjkM=;
        b=BpolYLB2TQMuWl5ZJQvBBF6vUbd/E/WhtGCFYRz80rqWDLw8OH3g49shyQkXdxfKc9
         2wWpsN+JsR+8YQ9G/qbHpkPfEEiav7c78JHDhHXn6dtMP+YWvcy283aPl+HheT0+4K54
         riQ8bC7TUrcFmW7uzspGJaqc41IfqeGsGjN5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715213185; x=1715817985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqMDZ7IrqUxdNK1BGX9Bv8+FLqyvy2F/S5DRaEwsjkM=;
        b=WaklrnieRt3M6a9NPVbVWRz1CkD66dZqKAQpvYRdSFhRZ8ExkMWNUdv7lkOVhWPanG
         rsZyMDj+hCucXyiI0lB+mLdfTtjy18/ASDjiQCTvWGco3L7AUiOOAuGdsjSGNvJXyE14
         IeF3NVX4zVon9lmWFih8WcObj+SfhkzUNbe4s9++PZDMxkdOaC+PElkjvL6L5D0VksSp
         ujkwC2nZL9y91HjJPxtMyiIiuVjI6Q64F05nrkloxGw3s72tI0sD5aWQP8oWwUTH0gZm
         g+22+Czwwp48oXSeFrvqyky1awxHEL1u23kxTHzQdbMzXe6kjSp84KbsBacEl8tnJMS7
         82rg==
X-Forwarded-Encrypted: i=1; AJvYcCUGbUFW3DBizyCCuB522xphx/Ti+N2RPbfvJv8pwJ4Er42oBRJVjZNa6YqLdBsDxaA+kLlHp7E0N8b1YynMcZ+ElPKhi5V2s44YIj+xezrI
X-Gm-Message-State: AOJu0Yziev8b3JP3HyhiSPGpmLyvIHt4sklkIFf5+qHc1mxHBDEhJLoa
	AgxpOKg2jggO+VZkyOE25Er1PmEhUEpQfInGtStfs9rL5K7N8vr3Un9wn/vTmOmeF6myee0rY4J
	VIyX18Q==
X-Google-Smtp-Source: AGHT+IEC/tnZW8V+kYD2M/d0EGHNPNIO7LRdgsiHl7zKmaJK6ORqduNJ83rW1NlxtvmsYRjG0Itm1w==
X-Received: by 2002:a05:6512:29b:b0:51d:a541:733 with SMTP id 2adb3069b0e04-5217cf3bad4mr3091613e87.66.1715213184931;
        Wed, 08 May 2024 17:06:24 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2cb52asm107173a12.74.2024.05.08.17.06.24
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:06:24 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59b81d087aso67803166b.3
        for <linux-hardening@vger.kernel.org>; Wed, 08 May 2024 17:06:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0wpaDW6E8w1J/89ZWvvnSmVHw8n+BLUN3o/g6PDPwDJMpMUxLmBrfaiTDLsN7VUnkq8cFJrorqriPZYfMngjniE4S1doGXdsbQGNySn9z
X-Received: by 2002:a17:906:57c1:b0:a59:ea34:fe0d with SMTP id
 a640c23a62f3a-a59fb9c675emr342484566b.47.1715213183807; Wed, 08 May 2024
 17:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 17:06:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLaDBSP9MXCHc8heA7-rVNGh9yZDG_y4=87KOx_N0cRg@mail.gmail.com>
Message-ID: <CAHk-=wgLaDBSP9MXCHc8heA7-rVNGh9yZDG_y4=87KOx_N0cRg@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 May 2024 at 16:47, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But again, maybe it would be worth looking into, at least for some
> limited cases. To go back to your particular example, it might be
> worth trying to limit it for unusual type sizes like implicit casts to
> 'u16' or bitfields: not because those type sizes are magical, but
> because it might be a way to limit the pain.

I think it would be interesting in general to have some kind of
warning for "implicit cast drops bits".

I fear that we'd have an enormous about of them, and maybe they'd be
unsolvable without making the code *much* uglier (and sometimes the
fix might be to add an explicit cast to document intentionally dropped
bits, but explicit casts have their own issues).

So that's why I feel like it might be interesting to see if limiting
such checks to only "unusual" types might give us a manageable list of
worrisome places.

I think it *would* have flagged the perf u16 overflow case. Again: I
don't think that was actually ever overflow or wrap-around in the
arithmetic sense, and it was purely a "assignment to smaller field
truncated bits" issue.

Which again is most definitely not undefined behavior, but I would not
be at all surprised if it was a much more common issue than actual
arithmetic overflow is.

               Linus
