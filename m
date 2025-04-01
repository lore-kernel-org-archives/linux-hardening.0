Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0570830
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471902; cv=none; b=RR6u7X0LmMckwcsaCYsIDQnAC7BMclrSVOAE7T9RdsN1fXfjAhlNc2EwJ+fDfOC1ZIx9cGj6T0hFXESaMGRVziQyd+/T2xph/9edsWo9LGoJfKZzAKnrx46ETSS1WlU5HoAsrRCUS5cxIz2OsRjI5VTfb5FhJ21oTiwBNFER1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471902; c=relaxed/simple;
	bh=rn9IIVgH6dOcVB1hi9HKWEctsQtCMvhHl7Q7sdyUXRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/yGsugAc4pa7UZW9IpUeQAGZxTdIGO+O5jBJq1gBTCYJ+tPee1oYfl6wAkgaHoXkfldgf9ZndzrBhH1GRzLme6tk2PimBBYa5kO9ld3ba+Y+k3zsvLvnZyINCPnS1dRVkq0FWnige/xdHTkt3EhX/AxbW40TMMT9D996M99pXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GHbll4y9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GHbll4y9"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso9804199a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743471898; x=1744076698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIYG5OfWPexo+K985CDcAL4PXpvK2Cy/CrlETrEV2S8=;
        b=GHbll4y9QnouFoSHatRrJAs6MvAS+RpC34theo6Hozv2+CHGSfKZ5/zmO2X3VGJsyb
         twY4kdzR/E+MdNpmW9y8S9Fp8m40x6GKVHSoq+FihYUHFXvr+tjJ9O9RBwIKb60UkX31
         U59gw8cGfM1QNjsIosUHiok9mDn9Q5svn0cdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471898; x=1744076698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIYG5OfWPexo+K985CDcAL4PXpvK2Cy/CrlETrEV2S8=;
        b=S088tQIqOdB+/gnTd5Io4KG6oLLCqi2ZNLW3Fxxvrdka2b5rUyt3wSxwBlqP7naPXN
         kQPbg4vpABRvwY+8EPHhW5DNPRDY80FAOgL4JSMpI35YQvA2kXqZdFj2yTUELmeihDUV
         n0IRhVrjevA+bDtl7MG5hcpL69T+NYfQF5hq7XrAcwKA59zbj4Z2SYCkQ9RntA9A37uz
         eGD/3uE0UeEVBv+y/aYRqY8WA6+KHdZLWgkrei1m0DelUUZGGfXY71suvZXvn/SK3+TH
         0w5biQNH6gJKkL18LAjI7Ttl5szvobv2UekIXHBisB5MDpeoGfvz2rFOj0bLNwO5/Vb9
         QQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKxGtbUknQOK1qCoqPv2PeCd6besCIFfs7HZ0GQJS9k7CPhXxQVsj/GgIVBe3FJ9zh2hIJwxqbzRnGgAyRYsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEaoylfUDZMJvehIIGLf9ebPNbkqafeSWXdxo4hnFPCgzhW2lo
	uhfN+dJLMdLqYu0My22tJlfxLsP8lDd/eot0Hv8PZ8ZoFMNC3mRblCCVaKUybZD3KJl6v0jO/Yv
	YXHg=
X-Gm-Gg: ASbGnctKoEWd1VoV3PuFy+9+q6lAM2N/Ol4iuhitWub5DXACQ59XRu49R8+l2GLkIqo
	gK22Knnve9A+iTG3N3k5HWtFZ+lkclxuEs40X8DRBgkqdq/mJ51P5ORWKs69B4T56t0BCwmAN8b
	f1NdsOMcBv6nq5Zfd7NhPBxxQuHwPsTaV5rwuEysoQbn5IAlXfV85KKMWRQjUaQfKM5fR0DbNLH
	7vITTwNUwcpswHy61gmom5uRF9X+iH1Di8e/WvJPX+E8uAODh8mp6Nee8nvB0k60QbvSrC1fRn0
	tRUUYR7qWt+mFvSJA1qLrgbH1GkiycJYfBIsJPg9yedezjdl1l9WH7ZEB8SxnoQkE5/gQcOb7Ee
	SCvSuSVOXw43E1gnVkLA=
X-Google-Smtp-Source: AGHT+IF2XILGRG9C1cSEkVPTYhR4PKX2eLIFUzkJzbAtZ8f7ph6FnwAUMNpc4fnKGfCvzdTSLNRA3Q==
X-Received: by 2002:a05:6402:27d0:b0:5e0:4276:c39e with SMTP id 4fb4d7f45d1cf-5edfdbff01emr9987559a12.30.1743471898438;
        Mon, 31 Mar 2025 18:44:58 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b30cdsm6312522a12.64.2025.03.31.18.44.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:44:57 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb12so2132904a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 18:44:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1G3YvS2/pW3QbWgUXFzWor+7+/myJ4X4LPfxyv2Szhyg7jQhBDfSsjoHd1nC0F29pKaf42B9xF696yhO7wRk=@vger.kernel.org
X-Received: by 2002:a17:906:6a0b:b0:ac6:da00:83f4 with SMTP id
 a640c23a62f3a-ac738c6f29emr856911466b.53.1743471896732; Mon, 31 Mar 2025
 18:44:56 -0700 (PDT)
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
 <20250331203014.5108200c@gandalf.local.home> <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
 <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com> <20250331213616.18ccfa37@gandalf.local.home>
In-Reply-To: <20250331213616.18ccfa37@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 18:44:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKgKBeNBVFin4XYXLNSNDPnL1kdidigV6qfQ+6tY8cHA@mail.gmail.com>
X-Gm-Features: AQ5f1JrFwQtqaUhBPYTqFQvZ7sPYYUNGY-kB3mWrogAzqyhted5P9oPz7tJDnec
Message-ID: <CAHk-=wiKgKBeNBVFin4XYXLNSNDPnL1kdidigV6qfQ+6tY8cHA@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 18:35, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Just so I'm clear. Are you suggesting to add flush_dcache_range() to
> cacheflush.h and using that?

No, let's wait for it to be actually considered a problem.

And I think Jann is right that for kernel ranges you should use
flush_kernel_vmap_range() anyway.

Oh how I hate incoherent data caches.

           Linus
