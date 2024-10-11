Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE810199381;
	Fri, 11 Oct 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665468; cv=none; b=eY37/P8Cv7xMAgPt2qfOyNOcCDXqF9Fcqc5UQi+k2KMYB0sntu76YCxYv/dkDILW2K/BZq7e54PgFw3Dqa9Brr7fKSD1GwNv9nQxbwdnazsIpZ0I5i8FgJ0T4Ar5Ou3M8eaCCepVNOpa3YZ3wCJRmVfeujWbTBLFnWu1y81y37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665468; c=relaxed/simple;
	bh=VXG/GpcD4ZaPugyfbuMxoUDkz9d8ii6cVFf3ZaBPB70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FI8KondbhWgmqGUVMrShZ7+HQyF8nmrVFR6trNlYFb+rxsT4gWXPay6ZfNmVHgExnKo9DsmbMF+pB+/mRYQnBmJjN5Cwypk4wUJMmE7aTnNIGdt5zLoUwKXxQfcugM9hneyb+Y1UjBTwSYDhn948AD9fBtQl1PIucT3spIe8bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1yr6sdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1yr6sdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5370AC4CEC3;
	Fri, 11 Oct 2024 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728665468;
	bh=VXG/GpcD4ZaPugyfbuMxoUDkz9d8ii6cVFf3ZaBPB70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l1yr6sdOtwtxKq6/CvpLss3HR9GL+5gW9//IS4hIuKQ3hKEw07J33H3cf+TUkFSn8
	 XNLmchhs9V/FstEhmNAvNRQIcdXcsYMqTYqjjSkPljltKkXX8t30IO/yiOVV4rHpdf
	 OuKl1+WS4NQaWVX7ShMFfLKTpD9iOZi+krbxzNmwiQAVN8yy3oBhl3LaluFdDnNVgt
	 B5Flk0lUTGX1VnVzzl4KrVT97Tyz8A2ll5ZAF/j83ppBoNI4dqMhtiW7oYSb53dI/P
	 EOO3VZEmaQRaH0Gyf0qJ0LCKyZ8XCfQa6IOzh4JELlOBTpd7gvDJ2yrJdxXJeSR4Ko
	 TX5fAQ4ZOEsHg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398996acbeso2683379e87.1;
        Fri, 11 Oct 2024 09:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWg8tCuaNlHHC+6in6b1b41bA8YUtWjXTiwssjIq+T6u1pqUDoRLmlBc6lTBi2S0pEMvDhLyN2AYifYF6J4@vger.kernel.org, AJvYcCXFY+VaPNXgxSBPp2ENXOOx38tTVHoiYXQoz27QEgUUsyWqiVDGE2x6khR9bqhImHAp0C4fLo+UH4GlrSZDSBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcWc9IGU42vJY5iKeqNdLjAN+0MFHQKzfdvE13vDS9Pr8j3aW
	sBpTiKLLGgWW9pSQFN++1CC6EbOxdUqdAmRmHXHNCoxok1RKvfRnzCEMgdCx8BoqV+yzHbjLblI
	Q2OXnvLoc+Yu/OJud+/NC8uPZOpI=
X-Google-Smtp-Source: AGHT+IFr4QA6SziiBfUmMc6IM6gCN+OvpGX21cJkCaQ5pNTmvRVSVpgDE8qM6X49xroZhvkO4gCrrlCdYmYQgYTgTdk=
X-Received: by 2002:a05:6512:ad4:b0:52e:9b92:4990 with SMTP id
 2adb3069b0e04-539da4eb2d2mr1588962e87.32.1728665466750; Fri, 11 Oct 2024
 09:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com> <20241010122801.1321976-9-ardb+git@google.com>
 <20241010195211.n22geblzb4ogxqcz@treble>
In-Reply-To: <20241010195211.n22geblzb4ogxqcz@treble>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 11 Oct 2024 18:50:55 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFaqij=OiJcPY7RcDd79V5qDKkXcxLbqNcnk7nBxiu=Bg@mail.gmail.com>
Message-ID: <CAMj1kXFaqij=OiJcPY7RcDd79V5qDKkXcxLbqNcnk7nBxiu=Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] objtool: Allow arch code to discover jump table size
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	keescook@chromium.org, linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 21:52, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Thu, Oct 10, 2024 at 02:28:04PM +0200, Ard Biesheuvel wrote:
> > @@ -2222,7 +2234,6 @@ static void mark_func_jump_tables(struct objtool_file *file,
> >                                   struct symbol *func)
> >  {
> >       struct instruction *insn, *last = NULL;
> > -     struct reloc *reloc;
> >
> >       func_for_each_insn(file, func, insn) {
> >               if (!last)
> > @@ -2245,9 +2256,7 @@ static void mark_func_jump_tables(struct objtool_file *file,
> >               if (insn->type != INSN_JUMP_DYNAMIC)
> >                       continue;
> >
> > -             reloc = find_jump_table(file, func, insn);
> > -             if (reloc)
> > -                     insn->_jump_table = reloc;
> > +             find_jump_table(file, func, insn);
>
> Can we detect the annotation here, and if it exists, pivot to a separate
> generic implementation which skips all the arch-specific code and hacks?
>
> That way we could keep the "ugly" separate, and also have all arches
> supported by default.
>

I had a stab at this, and while the code changes are a bit intrusive,
the end result is much better for it (IMHO).

In the end, the logic in arch_find_switch_table() is mostly generic
anyway, but it is the code traversal in check.c that is the "ugly". So
I moved lots of things around. I'll send that out before signing off
today.
