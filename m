Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F5C77103
	for <linux-hardening@vger.kernel.org>; Thu,  9 May 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278116; cv=none; b=jtXOOvsBY1WdxYcJDb534fdbcMYxXvl/zqwSv4jqn5aak5rufmNKbXV6YKJLtueU7THjSj0B9bmakHeqqJDOxV+SwQUjWrwQjM/pWf10WajYJUTSnBngCHb3b7FDF6ixrvPKgVjAcPH3uC4ZzHNnKXhgvte3LyzyLfLkH8K7Gms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278116; c=relaxed/simple;
	bh=B/fLZgJ1kMx5q/e/aqEvOH6JUgyuZ+Q/2hXPHkpLqEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooNDzC7zyVudVXWYDkoRg77QoK9WslCXR4lN5+Ukvp+MSMSp8RjeThJeZDku+xj+Pvr50cgXkc1D+rMv6lJwcNjEmMOhO8RrAQsqagMl/ciMUTwyjL1IOOpx1NoPhMtOAwyTWs6s/+GABPtV/wbpuw4p4uPmLcO2YrTEotddR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M/LpqZvF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/LpqZvF"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cf8140d0so289981466b.3
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715278111; x=1715882911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2M1QRjYBDT1Zd0NqfbgFR5skSig9YZV6L8U7l1RklbU=;
        b=M/LpqZvFQsL0LP06ze4AfWlXdVRaQOk3G/VGfIpjZIyXdlWH4VZznYvpVGPubY2V6/
         dNjCyD9ShvpdFQbxwPr/6saizdK+KvhfWPC+AuH9EY4UgAsaKjEc5ea1i2Pgjk+pKTkd
         NOjjaWcJ2/TqK1DHS9hVQbf3pjRZidu2Stwjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278111; x=1715882911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2M1QRjYBDT1Zd0NqfbgFR5skSig9YZV6L8U7l1RklbU=;
        b=Pnv+8n2KtevNE30h1lHKumr7xlzceDAYn9c2Ld+QEZDHV4kiHlS3nXk9aYs7zraPEN
         3gMRMKAb4PLW754PR0ZnlSJxELYLtmcKFXbjDmYkDN/xzJ1zwX9M6gVLOYF35ybbc3HK
         4xlN3NqyKNs+Xrd+pOxkdWQOONv6Kx8swrxFgC5ztt2kpX5p/MLlfMXY094AgfjLzbbw
         SSCclwM5WUAd4GRHNI+B55pmx93VKmtW5wmg9bjP60ltz1Z7A1+ZYQxnV3KUbWtIHPEL
         n3lKU32buuzKfNA7fiqVCi3BaZxrFwnw0gpxAxf5H0fdxr0xjc1loWdwmefaBbYNemb9
         CAdw==
X-Forwarded-Encrypted: i=1; AJvYcCVp9TSxQ+LISy97EqlTz+uNh59iJIkX6x2Rgg25Lw5v2s/Nm0kILHBsIz2004JeFFJWt5jkg7A/knxvg89SXIKWWVkoLhYKd1HRDjRDcE1A
X-Gm-Message-State: AOJu0Yxn1LSmcIAMynJZb19ldD1iU8xH9A650zCEQX5P4RUtzdev+aYE
	bMj5H9+S+j4nDpS5M9V1boURoXDkGn7rZnxJhMFppEksfPBVia8LkXjovHydJeANv+44OCe7zU+
	Es4s=
X-Google-Smtp-Source: AGHT+IEik5AkpmlMeRCH9LPJT0KgSuNFBvqCD6eEjJELQxTstAv1iLbvkRMRF/+fw+PzjTHn3YGVlA==
X-Received: by 2002:a17:906:17c5:b0:a5a:1b57:426f with SMTP id a640c23a62f3a-a5a2d54c10fmr25636766b.13.1715278110824;
        Thu, 09 May 2024 11:08:30 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d85sm98018166b.72.2024.05.09.11.08.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:08:30 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so285190566b.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 May 2024 11:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKr9XoaZghmcwUOBCjRKqiZuiP+8pm4nmOdvgrBePC2LygQOr/7fSOpFqWYuMtxpes52woLIDbb8KXWoje8lvxqRNBSlOquHcUHvKXlVYg
X-Received: by 2002:a17:907:1118:b0:a59:c5c2:a320 with SMTP id
 a640c23a62f3a-a5a2d581b19mr26210766b.23.1715278109328; Thu, 09 May 2024
 11:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <202405081949.0565810E46@keescook> <20240509140854.GF3620298@mit.edu>
 <CAHk-=wgKyP2ffZPa6aKYtytzzFibiNVN5MS=D2cn7_UGCECKdw@mail.gmail.com> <20240509175417.GR2118490@ZenIV>
In-Reply-To: <20240509175417.GR2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 May 2024 11:08:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
Message-ID: <CAHk-=wgXm15gZHvt8waSFhXS9yZTfvMV95xyvNtPc6FSEA_rvA@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 10:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 09, 2024 at 08:38:28AM -0700, Linus Torvalds wrote:
>
> > Going the other way is similar:
> >
> >         all_bits = low_bits + ((u64) high_bits << 16) << 16);
> >
> > and again, the compiler will recognize this idiom and do the right
> > thing (and if 'all_bits' is only 32-bit, the compiler will optimize
> > the high bit noise away).
>
> Umm...  That would make sense if it was
>         all_bits = low_bits + ((T) high_bits << 16) << 16);
> with possibly 32bit T.  But the way you wrote that (with u64) it's
> pointless - u64 _can_ be shifted by 32 just fine.

Casting to 'T' is probably a clearer option but doesn't work very well
in a helper functions that may not know what the final type is.

 Any half-way decent compiler will end up optimizing away the shifts
and adds for the high bits because they see the assignment to
'all_bits'. There's no point in generating high bits that just get
thrown away.

                Linus
