Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0828CF7F
	for <linux-hardening@vger.kernel.org>; Wed, 28 May 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452560; cv=none; b=dWHbh9xBAYC93H2UOnnTVwJCCIV9ebVRptT/hiEEqDij0U+JJ7ky8t8c6J9O1u/XD5zMRt95Y8l4tHMYrKewyq5SE0lo/D2RDF3fFsZZ6KiGswhLVtw37Bs5YE92aIsbeXbZ/n76I93Fp3FMzA6TxRlTQYCfGO9JKzrppyvbxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452560; c=relaxed/simple;
	bh=GFuirEaKGhl5vMyZboOmESj/mIt1D5zTTMZxltcKv0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA0lJ4uuXcn8YezpbEJX8/743Mv6QFMLTtaSScDHk/Nw+aTjBDkKd00yNTMdWhOHpSla6OzT/7cEWrxN6YecU1gg0HtvCuJ60HUPR4ZiPge7Z6wAqAs/5BmK4asIH7sSq8UNAvKaPwhRnghHYIUVNSjOqsewFnNoUmXEgxv16mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qARwkqBv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qARwkqBv"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so412a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 May 2025 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748452556; x=1749057356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUdwWMmdYpRWctOElE23L2fIeNE3afrw4G+RZhKXn0o=;
        b=qARwkqBvmySlm5KgkxKy9dYHiyFRAlaSZiND0UbLEvUeRLenuKGMG591lLl91Zxd//
         zMnKVGZCZaf8W8YwowvpQ/kQ+lwxqAhDfnDRrbl6RZ01JNt3xGlJfl3du/R+IuOMG19W
         dGsQs/QP7UA+V89sEHRyAuwx8Gu/dJyxU+8w1wCUQKrMNsNz+I0rfulSgSMdCzjkO+ax
         cZ4zbFvzJNF7Xq6N3Ic1UQdgYPMqgwnQNPFFM+aVSrOUrCeba7jIizXOXDIFsQzVs02M
         hhI0UbR2efSwkV5nLlY0AABQXAKp8VeFeehKEeDP1zt/F62bQYXQSoIOzXzzQiF4u+dv
         Ac0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748452556; x=1749057356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUdwWMmdYpRWctOElE23L2fIeNE3afrw4G+RZhKXn0o=;
        b=SPl80Fz068ANi4/jx9hnvRAP/yFNY9vhfeTl9fNBfgJdXOFph0KuMqzn3tCzQzyDEX
         zvbR1xIzY9MOUjaIhdFvpOtZbriYQRG2oik6kCAcFcGAv2m4PkvCMdFQekYROIffpfbO
         HlgD+IB3iCNzZ/YUaPA6VvTlp+cMU6xOioKVIA0RbrWrcMtQDO1XS/HP0aeyutw1KazG
         8lo4vtOySqO9VffgRRiQnl3xfKRC0YKcWqMXcolSJqmhr4YqZaifh/g2Fz/heWyC7vYR
         o8X7WB+KMKHfzIJs6+f3Xy7hxISwWDY8nPHp/c5g7OVnhbqmhHaUVK58zYidcD3VfvCr
         CWlA==
X-Forwarded-Encrypted: i=1; AJvYcCVGTsKeLM7cItunYBTgHq0HhP4qu4oIy3JCf25p3Na80soM0pjOzOkY9N20JP6p9XBq0R0J4NBNX8W+ev0qv7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhmpq83PTmUJT4R4peP3+TRhMu0bnLP5ywdQhfUbZ5I8LVboHH
	xGnIsdOkP6hr0CMUGKlRlcfqkVXe/txcVwJr7K3djbry6Ylu2w2zZ1lKJh+FolJmCBncCZ1DaUS
	1kLNDHR7yGMcywqVnT3WhWHzxU9A/n/TaiR7MvXtUyniMnPNr7PnHGsyXh9Y=
X-Gm-Gg: ASbGncsTkHc+Dt2yx/M1/ult411kaSrI+t96FNT9hoPf88p4+TWEjTep9Sa5faCXC6P
	OsX+FNQcVShfeCvflLRxrw69diwVbE8XSXpeRBInU1UHCZzoVsxjTktdYuAc0gRYEocMGwZFh7c
	Bn3N2sjbgf9WgjZECgtLqvzcm/A3Auz8n6U6WAtC0EmimR10b0dnVOQsLrq3Lj/QV6lT2JERs=
X-Google-Smtp-Source: AGHT+IEt7PzAIkfFsXWZlxFmSgQSVYAlHTzvWz749ZmQ/S1uJVlMVoEN7SLnaEY1BBFoG5gmWjLgKZ2VITWWPkBMzQE=
X-Received: by 2002:a05:6402:14e:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60518dd2ce6mr131981a12.7.1748452556188; Wed, 28 May 2025
 10:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202505281024.f42beaa7-lkp@intel.com> <20250528061427.GA42911@sol> <202505280937.6802F0F210@keescook>
In-Reply-To: <202505280937.6802F0F210@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 28 May 2025 19:15:18 +0200
X-Gm-Features: AX0GCFtG0eJUnIASULD2nwd-Zdd6sAxsHjSny6-oy6ySySzZaKEp0fZyIUqXpLw
Message-ID: <CAG48ez3i37DYjM+SjBjC-VKQOiJs7-YVdLEQ7aqXQwxWs-rS9Q@mail.gmail.com>
Subject: Re: [linus:master] [crypto] 40b9969796: UBSAN:unsigned-integer-overflow_in_lib/crypto/chacha20poly1305-selftest.c
To: Kees Cook <kees@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 6:46=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Tue, May 27, 2025 at 11:14:27PM -0700, Eric Biggers wrote:
> > If this new sanitizer is going to move forward, is there any sort of pl=
an or
> > guide for how to update code to be compatible with it?  Specifically co=
nsidering
> > common situations where unsigned wraparound (which is defined behavior =
in C) can
> > be intentionally relied on, like calculating the distance from the next=
 N-byte
> > boundary.  What are the best practices now?
>
> Hi, yes, this is still under development. I tried to make it hard to
> enable accidentally (not via COMPILE_TEST, not UBSAN-default, etc), but
> we (still) don't have a way to disable configs for randconfigs. :(
>
> We're hoping to see Clang 21 with the more versatile Overflow Behavior Ty=
pes:
> https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes=
-for-wrapping-and-non-wrapping-arithmetic/86507
>
> and our current testing is showing many fewer false positives. (Having
> run syzkaller for weeks now.)
>
> > Documentation/dev-tools/ubsan.rst says nothing about this and only ment=
ions
> > "undefined behavior", which this is not.
>
> Right -- this will get extensive documentation before we move it out of
> its development phase.
>
> I'm not sure how to enforce "don't enable this unless you're developing
> the Overflow Behavior Types" with current Kconfig, given the randconfig
> gap... I have some memory of Arnd doing something special with his
> randconfigs to avoid these kinds of things, but I can't find it now.

You could depend on CONFIG_BROKEN, the canonical "if you enable this
and stuff breaks, it's your fault" flag?

Or if you want something even more explicit, maybe something like this
would do the job, so that you have to set an environment variable for
the kernel build to unlock the feature? (To be clear, I'm not fluent
in kconfig, and this is almost certainly a terribly convoluted way of
writing this - if you like the idea you should figure out the proper
syntax.)

config VERY_BROKEN
  def_bool $(success,sh -c 'echo $ENABLE_VERY_BROKEN_STUFF | grep "^y$"')

config FOO
  depends on VERY_BROKEN
