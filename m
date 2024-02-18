Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D08EBB
	for <linux-hardening@vger.kernel.org>; Sun, 18 Feb 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708219537; cv=none; b=cqsCbcmKFWMjuh4pkI+1X7vlOSCUGArLdSmToY7IKal9XpRzO33cLnwN08fhBkVupQo3Wm97hciww/ctHow0DEEJaIp8dlJGgTYucuY0xAQ00De8Lgxp/eZlO4GtR82bdxdxsNX31qJccKhvlTrV5u53M3rvI5pYZeg4kg2+rmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708219537; c=relaxed/simple;
	bh=a3hJQoAtYSUkKDh/waTTxwVQsYYIvXqoZW7AfetXO1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyLzoXdIC/mG9/DDqzFIjUc4szjV4TqCiT+F1JICCyaF/ZlN1zugwZMZhYWSr/ekFk3kP0+ePfmqup9QRAhRrnFSXWFGGlT+g6TwfcJxJMOLbVVg3kP/Fid5wwTGw2Sj802yI4UP4yR1N/sY3Q6q0ky5mFKhGxZbaXb8Q8DN6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xq5UyXTr; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xq5UyXTr"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2185739b64cso1982856fac.0
        for <linux-hardening@vger.kernel.org>; Sat, 17 Feb 2024 17:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708219534; x=1708824334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VuoBtT2e7jiJsHrgcaJkRcD5zeydER6RGTa0O/OCH9A=;
        b=Xq5UyXTrn3X6COKYrRkFMlDVB0KcI0cr+RjjxXQ61P76WT6ApgRMYI6+4wF4Gv2qhI
         ggfozzffPJun+wMy5DBToaePmcgv12KzuLyUHk6eA2H14zScdcgC5MIfFEalLnastZUf
         EUbbNOXTUILTpIP1xoT4D6ygu0h3oCCzvrP0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708219534; x=1708824334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuoBtT2e7jiJsHrgcaJkRcD5zeydER6RGTa0O/OCH9A=;
        b=KrR/LZj5xqQtXWGpJn86yWDy4rNKygl+987dhyC+gOIBDyGDa1jxQp+pEhXYG7YanA
         MKcAuGRlvk3fwV/4N2fjqbIJqfcoGAaZrMcQiR49DK7AczqXqy4ld5rCRt59hZBNv+9A
         rf5CkeBJyOCy+zUyoBfWR8gA7pWj+DJQ/yT+b+ktQOV+tNhGvNfAa2FhvlyBEgRCjCxQ
         J6FbA94k8FafCuHN/1HJMIyN281PlQ03+yG8zIDTU51rPgTpTYTvZNRbQdwMTCJ0rYPU
         FSivqxt3mBJ5QKS8rNCGKzTgPlZYN7YGhxbdTz+GigAIWNsCiOnvZkYrK7VODTpiims1
         C7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw389wNENesJglApSqVUL5giRlMKd4PDHq86yhgfnveN70fgJkT0cd2UnlUukm3nywSeKC6xK5zpfGgSepJP3AN1JfRN/4mKuhDoN74xjC
X-Gm-Message-State: AOJu0YxM0v/fhBlB/+d5TYjRh8TRxrIPouLFTa6mbphfYyaAeNWI+ljv
	24HJ+xs3bxPjMbGJidiNPl+Gl+qbWj6z8qaaAEuAqYQ1MaVxP9kuPp5P2SGzPg==
X-Google-Smtp-Source: AGHT+IHjBUDoientSzd3b5MGz9AJNkPP1IEibihvCcJEeLidYINReimoOazQTftO263H7irZPdbdug==
X-Received: by 2002:a05:6871:453:b0:21e:bbdf:8b94 with SMTP id e19-20020a056871045300b0021ebbdf8b94mr543705oag.37.1708219533979;
        Sat, 17 Feb 2024 17:25:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r135-20020a632b8d000000b005dc4f9cecdcsm2168893pgr.86.2024.02.17.17.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 17:25:33 -0800 (PST)
Date: Sat, 17 Feb 2024 17:25:32 -0800
From: Kees Cook <keescook@chromium.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	linux-kernel@vger.kernel.org, y0un9n132@gmail.com, x86@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2] Adjust brk randomness
Message-ID: <202402171723.914538A526@keescook>
References: <20240217062035.work.493-kees@kernel.org>
 <05E12A71-D8A4-4E6D-9C9D-024251C1BDC7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05E12A71-D8A4-4E6D-9C9D-024251C1BDC7@zytor.com>

On Sat, Feb 17, 2024 at 04:25:33PM -0800, H. Peter Anvin wrote:
> On February 16, 2024 10:25:42 PM PST, Kees Cook <keescook@chromium.org> wrote:
> >Hi,
> >
> >It was recently pointed out[1] that x86_64 brk entropy was not great,
> >and that on all architectures the brk can (when the random offset is 0)
> >be immediately adjacent to .bss, leaving no gap that could stop linear
> >overflows from the .bss. Address both issues.
> >
> >-Kees
> >
> >Link: https://lore.kernel.org/linux-hardening/CA+2EKTVLvc8hDZc+2Yhwmus=dzOUG5E4gV7ayCbu0MPJTZzWkw@mail.gmail.com [1]
> >
> >Kees Cook (2):
> >  x86: Increase brk randomness entropy on x86_64
> >  binfmt_elf: Leave a gap between .bss and brk
> >
> > arch/x86/kernel/process.c | 5 ++++-
> > fs/binfmt_elf.c           | 3 +++
> > 2 files changed, 7 insertions(+), 1 deletion(-)
> >
> 
> Why do we even have the brk, or perhaps more importantly, why do we use it? Is there any reason whatsoever why glibc uses brk instead of mmap to her heap memory?
> 
> I thought the base of the brk wasn't even known to userspace other than in the form of the image end...

AFAIK, it's part of ELF ABI, and the loader uses it only for very early
allocations. e.g. it's what shows up as "[heap]" in /proc/$pid/maps.
It's also available to any program that wants it still (see "man brk").
I don't think glibc has plans to redirect it.

-- 
Kees Cook
