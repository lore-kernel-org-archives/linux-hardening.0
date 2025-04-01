Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A76249EB
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467908; cv=none; b=CQ7+HcDNLMRskgo2K3eRgqtvc5NFwPtpHv5ncIRkJJSX4mOEzow3lXreYQXNRCFkZj+P+TW1M9HkTrZHJUiKJ1Zc0Bp0Y771lqYMq1i06vTeWW6oL6f+p5r2xYd2NXX2ERWc/7E7Ld8xAsUJRyFz//l23Mp6nFwd72/ArTkbGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467908; c=relaxed/simple;
	bh=EI1mPvdCbyYHIwBWxdtH54j+BVCkqp7WsbZyJafCRLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYuDhhgelEFSbTz49FwB6ReLkYujjfT5auJRrDpIyeEZ5sjBRjOiNUTHgbk8kyUwiUgPHY63HbjP1Amxhjby45G0zgv7gLQirFYGCfVtMFLymGOBAAp9vsxGg2cA6Mmh5+sInZOASv06Gdo8W/NtbFmUPgrKScAP6skrx8ZzhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=feYzh6nc; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="feYzh6nc"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25520a289so838401766b.3
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743467904; x=1744072704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmYjDTtlr4FUxPBxvb78kyKW+ePiRCaB/F3Y0k4Lqp4=;
        b=feYzh6ncXAnSo0shkcojcEi2a5yZQF9Vxece1fJ9YM4WGCvWkWZY8qkIZh1DjFVCor
         MqLayQP8Hto5waMeh9sH2fxztgwJuPwnlzg5YwlbNATIqFAJ69RLCRDx+KlbCIABnvLg
         Gxn6ONG4bnVRYDZxo5BEva7ptRt+T1jb5yPQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743467904; x=1744072704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmYjDTtlr4FUxPBxvb78kyKW+ePiRCaB/F3Y0k4Lqp4=;
        b=vVWnKWZq1szu/21wvZdDnJuO2dczPJRWtHotM9jezycOvjwdmyCeqqS2r2s71uD2dU
         Qib57QQG//jsGD3nGN/TcBuW0hTD8g5p7WqcoS4Y36c1bkGg3KZi/aGHLCLM+xgO6tjs
         C9X5CHuH0EMbDWEukuDKs8ClWNZETtg4PYyv+IxV21sbwQls6LIZPeN0CCEGd/2dg2Ra
         1snUpdACF1LuAFca8LUjqfK3xM95tsJ1x5IMOvK4Sj8LwNj9gkzrmK8TfFbjwQYnmbaA
         nCHuuYVKC86D9LXQ1VFTf9Hd0J8ukIgG9TZIIDvFNEpF7OsozdReJEeNgVUZvrZt4nvk
         i/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoRhf+MBbOriIFk7at5uWNI/qL+TvH+yW1JvlBzrhxfb6EaE6n518UKtEDsMclfF2Q8uzpYYxsIlpdenqUWvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcbA9FKFFMAJJ8M9CJhGkjoTu0lvJT6y/+S/b+SrA0LOztimt
	z5La1VCe9QR8sW4x+ahO8LsEbvfzIy2jc8dk9BEP9WsX4RC4ITzhotw3JZ+GTwLHKyV/B8Mm4n5
	JE5A=
X-Gm-Gg: ASbGncu7IppQiWY/u7ypdvXL0HiISDWuoxbrPOBk4N+F5E+4Vn0+pRs1wjY3Sia773b
	hrrVrfR3ZWc8yVQ5xiS22t8nLHBmWBVsntCEN4bZvwmrxyKUtaEnPFT/EZJ4z4tmo8NQQXL5xpN
	zPb7hhPnF7iWbjaaCghiPYuGCIJLdiT15AH8PQVOa39nkPbBvjR8APfJ3CYqgoY4MhNVXomE2pJ
	IrqM7HlDkxTk0Xc2oRvrXzAh6K0iG8xONNrqu7A/jc4/h2GHmGvqb16rqnHOIiUVI6tLASU0uSn
	pu1qal8L0jruqqIDWYca7WOoSxhmGkxVya86Ituyw7pXx0Q9ve14nLLJ+xsJf2ujfsMyom9vuTC
	CLUlJs/qrilB0MEre3q4hL4JraqBUWA==
X-Google-Smtp-Source: AGHT+IF0y7eS+Pr7fIbaUM81psJ+kn174Rl/fReZuRJpyk1vl/ygsZhGgO/GKt0PQhfVvOpybF5lVg==
X-Received: by 2002:a17:907:a089:b0:abc:4b7:e3d3 with SMTP id a640c23a62f3a-ac738a3e93bmr1116375866b.27.1743467904436;
        Mon, 31 Mar 2025 17:38:24 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b150sm696640366b.46.2025.03.31.17.38.23
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:38:24 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac25d2b2354so804913866b.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdIRRA5b0vwO9R3w7Gf6YhW4qe1zywA+ycDsZjKikFb+pt8es48jL8LzVE3S64Tya1YVDRUX7SuDW/C6OV9j4=@vger.kernel.org
X-Received: by 2002:a17:907:9491:b0:ac3:84d5:a911 with SMTP id
 a640c23a62f3a-ac738a3fb45mr1010426866b.28.1743467902999; Mon, 31 Mar 2025
 17:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home> <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
 <20250331203014.5108200c@gandalf.local.home>
In-Reply-To: <20250331203014.5108200c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:38:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
X-Gm-Features: AQ5f1JqkcRUTrAOWfRx6dOFz_CgrRYBalx1pwXYdM-tsf3km_onhfKZdgX2Gx8Y
Message-ID: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 17:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Of course, I would expect the same to be true of the page/folio cases,
> > so I don't think using flush_cache_range() should be any worse, but I
> > *could* imagine that it's bad in a different way ;)
>
> At least we can say we covered those other archs, and if a bug is reported,
> then all that would need to be fixed is the flush_cache_range()
> implementation ;-)

Well, there's also the whole "is it I$ or D$" question.

I think flush_cache_range() is basically expected to do both, and you
don't care about the I$ side (and I$ coherency issues are a *lot* more
common than D$ coherency issues are - while D$ coherency is happily
the common situation, the I$ not being coherent is actually the
default, and x86 - and s390? - is unusual in this area).

So maybe powerpc people will be unhappy about flush_cache_range()
because it does the "look out for I$" thing too.

There's a flush_dcache_range() thing too, but I don't see a single use
of that function in generic code, so I suspect that one is currently
purely for architecture-specific drivers and doesn't work in egneral.

So *this* is the kind of "bad in a different way" I could imagine:
things that probably should be cleaned up and be available to generic
code, but very few people have cared, and so they are used in ad-hoc
places and haven't been sufficiently generalized and cleaned up.

           Linus
