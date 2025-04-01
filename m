Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC252E3360
	for <linux-hardening@vger.kernel.org>; Tue,  1 Apr 2025 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743468570; cv=none; b=R7eaiGKgvGH+89/gxqHAgbV2n7iP2rB88iJ6RP4DBzFDOhvto6rs3ss6rQaMkcA+lM2di0yGicw8xmj+opbwX2MaKML7SdGT+zMV2XpkPWxoWeQ9s1j4njkOlZyva2DokFTdFMf4GIkL+wuIyXz4FS8lDAmG6mldZpK7YCQy0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743468570; c=relaxed/simple;
	bh=OUTcZq07JBkgTrYml5GuZJ2vQhCaARTC9w+Z21EM7tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYGNnIq/yi0AOuxqtHtrX8PDlhl/+s6QLuZlD5tU2lLzUefYR87pos0Ca8btJN7vZf6trNZk9TL29KkOMfYFTYOakgAbAHQorVrWhx3BnPpv0X62tWZQDSRaJph5sZiHD3EHqbSOYsD7SS/BG78T+uaGARHoblD/PTTLhs2sU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QRcaOUvl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QRcaOUvl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so897312766b.3
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743468566; x=1744073366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vqJ2N3VREVt47VEa4RxuNWaTBMsssQWWo8kvJYNbQLk=;
        b=QRcaOUvlPOKx8CF/pXQKGrqy3fS9mIj8ystH1ObZE+7CIHxDzwmcjsTxxAfatgEA+T
         0UJvUCOwPkFq8Rw2ohVGu2Gg6ukn2iEuZmfPNSrDtiocEO/CBl7L1lo4RZH1t3jn9Ljq
         4jiAhH3Lcqo75qbRDewmVvWymwBp7d50XAJl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743468566; x=1744073366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqJ2N3VREVt47VEa4RxuNWaTBMsssQWWo8kvJYNbQLk=;
        b=sCXdRicU5R+JsUU+FRzmOwxnBbkEhIRC920DcqWi79C0vxgq4LMhRcUVZqibF8p6ic
         JDJERJ2/aaH6U3aGgQgT7kWx20+CnWwXGYPJLy1CB6LXvYVAAwW2O3U/USs0azP/oKg3
         fx9/+IkZs7HT8Y/H0ptVhV496zGzqN7tv6vt2DkPBS4LyDHIUsiKFRkjpwb3iLb/F18g
         YdXV56xZCrfJsTNIsX5BrwQAfSHOzkYORyqwk89XP0vJyeM3TBbjAv4DHQk6ChVlzb73
         JvD7RTRv6OR/jIh2F0eZJFCUgmep634+aKbNsF4OSX8zFeGAEFl2qQSAmJrvLwy5T3UC
         XI8w==
X-Forwarded-Encrypted: i=1; AJvYcCXoxJQlQYdhZIPl3S7yxVqDq9pkx6+SeVkXzzY9aWfN1LPCk8s1QoiKJTbJ9DMhW1EETDoy0/eUSum7Vyn2i3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+u56MQJpKBjo5RBSncSmFODFM/Y1PQ+7Y8ov+yCZIrkS6E4v
	8BCqvwSjY2j1OmYBmYXVSXobIQ4MebWtlEhqe+VlgCu4GwM5tHAvb9T6DstCOpYM8j+vQXrR0+4
	tkZ4=
X-Gm-Gg: ASbGncvQiiCnvNQR1/MCyrSEw/UTf2x9+ByYvFdi2ZjpJNUwXPAZJwBvQTExhW8Siup
	AHQs/vPxE4L3Mr4IlHF0JI5jwg9qH3uytSiaHbajVqk6TfnppXNUz5TR+WrEXQdUKfgPi8Y6zj/
	xfHjgdvsMnskAeETDHbnOLfU3Rbm2XnT2LWnXuJVzT4lepGegzMjiAGo6/0ZPjl58kQQjbPg8jT
	dmc3Dt6DZ6cxjgOiGU21xmFpBUEgW6DNmqnF+n4PGidhqGApKLcjV0hwRkiX/fNWAWwJLSWn6xh
	eoH0+fTquprcLlU101yKdxtgSP12n2+wT8p3mBJT503ZGzRrZRi5B8GF52wvo+SmP71BzPEVQpK
	URvtwwEUIvhHah77pp60Nt7ROaDnwpQ==
X-Google-Smtp-Source: AGHT+IFykWI1QD7P6unalNU2F+kVK+HLd7AWtfREdStrjUhLtOayYfnZ7NfOfa1hFNFmTy+GdcbEDA==
X-Received: by 2002:a17:907:3f12:b0:ac6:b639:5a1a with SMTP id a640c23a62f3a-ac738b0ba28mr1015943966b.28.1743468566309;
        Mon, 31 Mar 2025 17:49:26 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719621718sm702839066b.102.2025.03.31.17.49.24
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:49:24 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so897309866b.3
        for <linux-hardening@vger.kernel.org>; Mon, 31 Mar 2025 17:49:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUupK5EHhZB4b/Ix5vBhnzFpPV+ub4jj7hTPI6CCuffLckaOVIhYgl2boozM9naudZZdkSDxtZcpm5be/AJIfw=@vger.kernel.org
X-Received: by 2002:a17:907:97c9:b0:ac3:3fe7:b254 with SMTP id
 a640c23a62f3a-ac738a152d0mr1032969566b.4.1743468563964; Mon, 31 Mar 2025
 17:49:23 -0700 (PDT)
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
In-Reply-To: <CAHk-=wg0wQb+CbUk2GY0CeVuTQvq67-oYR0nL8wGgySia3ce7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:49:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com>
X-Gm-Features: AQ5f1JoBkC_QKfs81TmJ3LMb4XougE5RrROka215j19iecgzoAx9QaQPEIrhB0Y
Message-ID: <CAHk-=wh4b8hNT5XRDj9M4damUmij2bJGaRamqQ_icEkVUv8svg@mail.gmail.com>
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

 On Mon, 31 Mar 2025 at 17:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So *this* is the kind of "bad in a different way" I could imagine:
> things that probably should be cleaned up and be available to generic
> code, but very few people have cared, and so they are used in ad-hoc
> places and haven't been sufficiently generalized and cleaned up.

Of course, the good news is that (a) few people care - which is why we
are in this situation - and (b) the people who *do* care about these
issues tend to be both responsible and responsive.

So not some unfixable morass, more of a "one or two architectures may
care, and we might have to extend interfaces that haven't been used
this way before".

For example, just adding flush_dcache_range() into
include/asm-generic/cacheflush.h should be more-or-less trivial, with
the same kinds of "architectures can make clear they have their own
optimized version".

              Linus
