Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7102512C9
	for <linux-hardening@vger.kernel.org>; Thu,  3 Apr 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699133; cv=none; b=J79LiuHSICP53dg8lEo9mTxH6IWoAe7zGOMux6jucCAqr0YobnioPyDxjZ76NJZNk/+gGTXHGjMQ6uUrZBHP62JPhtuTvcfRkN2IlBFZpLrJ5SPOmCt27V4zwGhscK3KI0o04dvnPTKy+bQZldWl6Mh+cjOq8ded0mIM0vHBRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699133; c=relaxed/simple;
	bh=c4k/wLTjjWRN0G3MQ4/ueWmzFfj6tAoe+LhodSB0qc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMd2Os5VA2Zzy+kBYvnhAvroomESKaVl1ngpvNeRXErsBZFxLcx1wz4XQg04ORo21/2eg00QtZ8jJan3k3R+Xrmu2Y5xD+sDslHSvIEOLJyWQg82c5Z6XHhjveTu0VIUENhBkB0dQJNcujIL1LoImA1C0uFiVJEsNfq8H/ojPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qv7aYP79; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qv7aYP79"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2271336a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Apr 2025 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743699130; x=1744303930; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxz3ZOpXSZ7yPtvl/GON9cIiqoopL7kPorpXa/Hocqg=;
        b=Qv7aYP79p0E9XYjOP35plaGcc3ao8rtOdXjwg7+BaxhFka4M1dqj6XAvsAZfgv+ZYt
         WjNriiZBFwzCdBMymnYVDZWJUEIVq58wP9GkFPOEwMI7va97nQqYxnWfEZIg+cLYYQwn
         LgNBmxuD54tE5UuinSw7sXgj9Y6KyiwAR5cIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699130; x=1744303930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxz3ZOpXSZ7yPtvl/GON9cIiqoopL7kPorpXa/Hocqg=;
        b=wcmXrjNbsjQV5wbWsiWUrOKhSZo/WcTlk/5cNreadXilN0ln7nOIXLdGTbPpnQqL9K
         B5M4+d/wFUWmPCll9jz3BKygw1xpnZU0+HoRC/N+s8lh4ojaJZKIZC+/Hr7JiFccDmx9
         FZgTgE9IL93lT9xUKkiKaKHHQtEsEWmdFC8MG0FZBjqnQ15zbASpoENoVjBhesI/Po4c
         VQHPnH+UbuWk4E5gqm+TwakEgSswJtyany8lgF04rCEMXMeSHm1s74NUFfeKmQAliSXM
         rBhD1hf2Ky0MQ9bkgW7ryoN+UBqBR0h64jUdHi4hIQdUBkijqzS7BS8jriwdx9OZ4ybm
         HXow==
X-Forwarded-Encrypted: i=1; AJvYcCWj40FjAdmILVFrWS/UGGjGZ59a5M1HwTNhY+IVzguZcj+y20G6+0/tZT0AAImA1pR5RHAmOAKBsDJLoj+U08M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYARa877TlwHHeFkqa4fZO3BeHtE8lEv0vANmaW7IIt5MFxfG
	nfz6RAjoBA5cElHBjkQto0WT2kwFRNHZ3oaxRp6HXfAPMKqsEC4PYoZV9SlIqNUJwfEcjDRBdh1
	f0J0=
X-Gm-Gg: ASbGnctWuzkU153eKxnNvUdrUZsKbJMEMy8H94dra/dnblvhg3eSvCr6bgLQrSPVIIZ
	ZFluiG4O60f9XRMeLpmn+WYjLX1mhYkF+Wy3olD18tllLOprYNVrDsVPngJi3t7JD7pAJ+1M4Lk
	W51uX0bzcCHFbEvJpK7p4mxYn6pkNTFK6e3jaX8RjEp5mgBC+sXi56S6X/DDaY7qCRFNI04vP4S
	ojzNbZhFlFNSPdJ0MnEQzUdQI80uQZS37/h8GkhqyTfl1iSbsJpmMZ6Ti2MzrmIotP2N3PKsQIm
	L/Z6q1pr2pGahGLyH7df0HS7+7GW1tH1zBDFnJmEvBO51isajwRUszKv4aokWBQJ0fKLCve6o7r
	of5lZmIIeJserC4ewh+M=
X-Google-Smtp-Source: AGHT+IE92lV+KfVw2oS7CswrOODzRZueU0EKSAGexopxqQVKrVdr52mnApiXM2AKI3BVkUkV3BeUVA==
X-Received: by 2002:a05:6402:2349:b0:5e6:14ab:ab6a with SMTP id 4fb4d7f45d1cf-5f0b2881e63mr37046a12.7.1743699129766;
        Thu, 03 Apr 2025 09:52:09 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084e85sm1124696a12.60.2025.04.03.09.52.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 09:52:08 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac297cbe017so418259466b.0
        for <linux-hardening@vger.kernel.org>; Thu, 03 Apr 2025 09:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8nSPCO/6lBtDC9Ne/cVtBWVEUvypxItNEGoj+RYBybMq+PO7qv3ogh1KzB5Rv9br3r0VmVO5KZrFnTin1Ivs=@vger.kernel.org
X-Received: by 2002:a17:907:970c:b0:ac7:3028:6d67 with SMTP id
 a640c23a62f3a-ac7d2e9734cmr3856966b.16.1743699127992; Thu, 03 Apr 2025
 09:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <202504030941.E0AA2E023@keescook>
In-Reply-To: <202504030941.E0AA2E023@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 09:51:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwSx8Bm6c=UEe0Xh6MvkZ9aAYhYBTwUxYk3Fu6GehHVg@mail.gmail.com>
X-Gm-Features: ATxdqUGzamms3HBwS2oeFKY1M4I1ihINB3lWR76jBDO6-iwI1TuKjoGv0rxX3qw
Message-ID: <CAHk-=wgwSx8Bm6c=UEe0Xh6MvkZ9aAYhYBTwUxYk3Fu6GehHVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 09:45, Kees Cook <kees@kernel.org> wrote:
>
> pstore tries to work with either real RAM or with iomem things. What
> is there now Currently Works Fine, but should this be using
> vmap_page_range()?

Yes, I don't see the point of using vmap() on something that is
contiguous but is made to look like a collection of random pfns.

IOW, that whole 'pages[]' array (and the kmalloc/kfree) seems pointless.

I *suspect* the history is simply that 'vmap()' predates 'vmap_page_range()'.

But maybe I'm missing something, and there is some limitation to
vmap_page_range() that I'm not seeing.

             Linus
