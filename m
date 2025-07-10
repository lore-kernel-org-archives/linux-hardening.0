Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7D23B617
	for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185331; cv=none; b=Gk6rlvpjBadaXeDvkiEThcUGP9zQJa2ms2vq9QKAmlF8+4zV7182SFqt0DMIdh4nNs63TO5j0JB7Yjlid0057BLYguKS5LasDTizzHh0QLHvWeCQUxXqPsiqf8ppuvmPDMOw3WhOA/n6/jlj1EXKojqDYJ4s+rwLdYMQbGwZaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185331; c=relaxed/simple;
	bh=2U6l5kbEP9IBFxT9l3j6WvMdQZkeDWhWgT4LU0TCP98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nG5aHQpNzB9WO1LjxysqOlUdxMS3Gv+eWuzqZVdckNN2x40uDiBTPPwO0Ger/TC0bry+NzAFuej1a4a7GahTZ5bp70YNRNrJrCbdNpTdhK4QkIJdKlPCoG/6+lWJGskc1uI+X0I4ngkQqC24HjWlQ+3Nqdy3QY7QBP6V8F7sPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gJhmgwgL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gJhmgwgL"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so242482666b.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752185327; x=1752790127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ykdGKGKuBHYeQ543548mngZ+AURoPxGnuzWJOvHPANU=;
        b=gJhmgwgL/C7gthMleszZjDplyr4OXjtyBgSDzsQVHQc/LxxwUQJE6tWzeZLRRvVHqX
         XM38pflRzf02X7aoXKP7zc6gqLDvmfnGTClLJs7HXBJgSXYIaBa9ok54FUFaiWyGWw8N
         JGS4i+2I6lYQHA324wj09apsikModhGaCR0Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752185327; x=1752790127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykdGKGKuBHYeQ543548mngZ+AURoPxGnuzWJOvHPANU=;
        b=eVeoMUfRKT1Y04CQD568ozeIk+QiM8+u0sO6Wj2h99FXKtKnHA90lQIhgMN0RLyiKx
         /2mQPyQm2qC5dMSLKFP10r3xsYfOkSF/FAR1dmFhZ9wE+ZE9k9fW+jrjV0mB+vjwupPQ
         oc0SFRpX6D0zrd6eCtaY6ZEh16b3eQGig5iNVXKsTvCkMJVS5t3YippGg/nqwB31TFlW
         EtYIZQZdEA1msOopBQ9Tj0zvELfl7q9lpznG9mBqcLdpAMrDZ0u2IxHUGCkv6avPd3AV
         O68YhX5tmilh6JxxebW2OfAXXcbCOhMitH5XvpkgNbN2lKm0w0YCgmyMV744byJzDPem
         bx6w==
X-Forwarded-Encrypted: i=1; AJvYcCUyeCRUTXjZUIFs2GH4ZLEprz8uLK2qgMaNKcJ6oJ9yutWfAn91935J8xI5TCyC8i/3jLHLzig8l18FkzWeryA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5p4H/8QvbQ7z7aJ9mpB+TIFCvEKQwfLpcL2+NGmB9FGK3JNNW
	g4QewSCyi/YqY/XiefKA5p4lMOZJ6tikXBByCZMGIl5WAyzOCJMkiYeOWorxtHNoeG/P1WVZ2oS
	RsetT3pcHvw==
X-Gm-Gg: ASbGncuCgGkNcV4iCZ6NcZfdDOnodH0bdOcQXtOfdgUC2YopgZCqDukDaa3vRy1SunP
	EHbS5XFdd0eZdDf/ZQcd7C3NzEEP91H6NHywA1zdpl9hJZAmTr1kNDsFUe1QhhxXBVT8krAaPZa
	MhMhWYZ69Ye3rQA0b6E9HDbtnGVWgYgoGoxbrYXZ+rfPpUg7/xZan0TYOIqVqywi4BVC9ulNsUv
	QklfinvNZFjm8Oh3uKbSWD93eS+c0aKz1v00AvrojTrJgSL1sy7kXaX3jeff0LUqCG+dKUCAzW1
	oWGl6e8cvbGJbPzhCIK/YCL/mu9Sw8NLzaW2FHIuRmsFXi841mdZaKevu0bYhSTOg4H3vBWpr4F
	n4EBZphXPjXxftMWnMQfQ8N8LedaTp4OCeYMT
X-Google-Smtp-Source: AGHT+IGGOzNGIC5X1zRxeUgg2CxovWiHMk3XyzSOLOttLDC635yL4gdW3OjgrXZB3fO8tAUEHNhgGA==
X-Received: by 2002:a17:907:da7:b0:ae3:6657:9e73 with SMTP id a640c23a62f3a-ae6fbd9bca7mr81755666b.20.1752185327346;
        Thu, 10 Jul 2025 15:08:47 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e826466esm191297366b.74.2025.07.10.15.08.46
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 15:08:46 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so2382772a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 15:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQFuCMp1e+keACbBZu6O4ipYP2VEIyu4xDu0awTrNso+vF5OTavJ81YfMqvvu8iv7S4zH/Lztmt0WVQlB2oOw=@vger.kernel.org
X-Received: by 2002:a50:cd57:0:b0:607:77ed:19da with SMTP id
 4fb4d7f45d1cf-611e7611808mr397182a12.1.1752185326316; Thu, 10 Jul 2025
 15:08:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752113247.git.alx@kernel.org>
 <0314948eb22524d8938fab645052840eb0c20cfa.1752113247.git.alx@kernel.org>
 <CAHk-=wiYistgF+BBeHY_Q58-7-MZLHsvtKybrwtiF97w+aU-UQ@mail.gmail.com>
 <svune35mcrnaiuoz4xtzegnghojmphxulpb2jdgczy3tcqaijb@dskdebhbhtrq> <yxa4mb4tq4uamjc5atvhfefvxyu6fl6e6peuozd5j5cemaqd2t@pfwybj4oyscs>
In-Reply-To: <yxa4mb4tq4uamjc5atvhfefvxyu6fl6e6peuozd5j5cemaqd2t@pfwybj4oyscs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jul 2025 15:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOSRbTqEO8H=5bBem4Su3E=bZRLM3nE5rwLHSofhD0Lw@mail.gmail.com>
X-Gm-Features: Ac12FXzpHETNg-HuLSmnK9b1Tp10RJ2FzmkvjWu0i-rRbR44n9d-UbbJBC2bj-w
Message-ID: <CAHk-=wiOSRbTqEO8H=5bBem4Su3E=bZRLM3nE5rwLHSofhD0Lw@mail.gmail.com>
Subject: Re: [RFC v4 6/7] sprintf: Add [V]SPRINTF_END()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 14:21, Alejandro Colomar <alx@kernel.org> wrote:
>
> So, I prefer my implementation because it returns NULL on truncation.

As I pointed out, your implementation is WRONG.

If you want to return an error on truncation, do it right.  Not by
returning NULL, but by actually returning an error.

For example, in the kernel, we finally fixed 'strcpy()'. After about a
million different versions of 'copy a string' where every single
version was complete garbage, we ended up with 'strscpy()'. Yeah, the
name isn't lovely, but the *use* of it is:

 - it returns the length of the result for people who want it - which
is by far the most common thing people want

 - it returns an actual honest-to-goodness error code if something
overflowed, instead of the absoilutely horrible "source length" of the
string that strlcpy() does and which is fundamentally broken (because
it requires that you walk *past* the end of the source,
Christ-on-a-stick what a broken interface)

 - it can take an array as an argument (without the need for another
name - see my earlier argument about not making up new names by just
having generics)

Now, it has nasty naming (exactly the kind of 'add random character'
naming that I was arguing against), and that comes from so many
different broken versions until we hit on something that works.

strncpy is horrible garbage. strlcpy is even worse. strscpy actually
works and so far hasn't caused issues (there's a 'pad' version for the
very rare situation where you want 'strncpy-like' padding, but it
still guarantees NUL-termination, and still has a good return value).

Let's agree to *not* make horrible garbage when making up new versions
of sprintf.

             Linus
