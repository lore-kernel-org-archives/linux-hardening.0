Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A62FD7BC
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977292; cv=pass; b=Go1/a309QP1t8x2qLJV7p52LjUZ2uYfLHg+m+IdEi9aZKnrdiIXa8xYnd4jIoaskZBzxUmm5HALLfvLOEjjpwtNPOMpf+j86V5dxgfkGbhmghtvdBZMeYsdbPHTj0cWcL302/yOahzOpdKrLoYRjB/73Vna/pQYf8saaMdD0xQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977292; c=relaxed/simple;
	bh=2O4CeHp6Qi+il6t0Xb3UEnGL0DA/23aBF3dyaOzbgrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TisDO3qQU7s50/uWcVBHwgmqOJbWY1ASqL2beIhcvCfxmOuHNhMAMEpBDBX36Vk7uf3fNmGmp1yAQ+flaVWE9PIc2GHBstFYbmXW+AbuSbDf0WSDnl4mQ2+1pdlIXA9Kp8JISi9iOkucDsmK5xThvAOeIvdT+5ivXLC8YphYPRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j69l9BA/; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j69l9BA/"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd5658b901so226969eec.3
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977290; cv=none;
        d=google.com; s=arc-20240605;
        b=JzgQm3Qcnh3tXIKkWMhE55aRQiJ928lVmKtIs1+sVQQNeGgaTqvzvR9WPsH4FVt/1X
         oM2zEbWwtTDwr27Y5TioPQMmqH5+7qHCM9fPKvH7FdR0RfIuHvzMAFU9xEB4Qf0g+8Ze
         p3xKhcJ4Au4i+TbZhk8dVGCVmzDZWYZ0cgMMW0b5FtzJ61EsdBpcTLZdm24PDuTmOZZT
         mgD8+nryf6HKQ+AgRG75WqBM9NctYckdZPY2NfUDET4CD2RK4hE7ziUPkRTeElJnYmyn
         12PnsrmSalXUnpxglBOq4U2YlXQqQGuOb0wy+ZoXRh+mj6aA303Bqi1tu3ixi+71HUVy
         6hFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2O4CeHp6Qi+il6t0Xb3UEnGL0DA/23aBF3dyaOzbgrA=;
        fh=TKpi5wK82Q6mJbdePO+ANF4dM5l2C2vik4ZGvN64c48=;
        b=VlYb8F7Knei5q0jqEnwL90Zxrs417bYMWLClaKkgA5TRh0C6zCh5AdrWA6j8qx/R/N
         wC8pHXqAuRuJQ7RjAS8UyLmUy3IzfH0uswgo29Q/45V2wOB6lqCc8u4KxdLtr63Fm1pD
         hznZGLI0iduDoXyeuLhcsdncBUdpRyOGNx4wSJ2IQf9t/idM2WoPGIzzbJk9tgp82Qjz
         80zvt/VA3F890aHr2ad64AEzqkvCfDqox1uC8paZ9kSpIJEx7GxNTarOPfsnQVPrwXlf
         hoWS39ttlTnlwtO1uDLfVmvRp7P7IOXgAJoz3K0Ar04frmyyCyC1+uMF9UH87gqCAXO1
         j3Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774977290; x=1775582090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O4CeHp6Qi+il6t0Xb3UEnGL0DA/23aBF3dyaOzbgrA=;
        b=j69l9BA/W/vb+ZMCguLW/f+lFajXySckHWUW+FCngYfO2RF4QZGegBrfUHB5DqZYdB
         kR9wgLgl0MLjWDtSgc0YK7Z95lt9F5Ba2OYkB92SgxLj8dGMGBhfChfa9Ey6YMlnNrg+
         aIfwCSHEwYw6POj9gtRv+lWb3gFXA8CgXZeqpM1LL6uPVHhTl5s5IHAdBBcyJ2lsjHBU
         +6+T14j0FM5GPctPR4rpBwCxATQnYenhfli3CLe8LuUTdpu/X6yJgVdBTSxcN3qnVbqi
         d9bzBjjd+cDOWGiTwMjfEBdo0KqnZfycqlzG70S3VASA0Y4W4Mh5NgtZiVmvKcAmHdLw
         XWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977290; x=1775582090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2O4CeHp6Qi+il6t0Xb3UEnGL0DA/23aBF3dyaOzbgrA=;
        b=LqrjRC4FU5SVIldKgQG6zHlGDZzYgx8dezcZWpTydhT/jsjt7Xv2NGn3Pp3fBjh0o5
         SyFUpvtsHDRRt4JjWvrZTHYhENe+OrFtYiB5QlKplzNX4C1DOSnTgwD03FOSke8iQlqx
         MBnWNZn0U6AKebjwrIbiwlTwgVkTHcN8fW/ygvZz0eMa23+iAouXov+QWi63Cer/GQ1n
         i8KCzY8t9QYmvno9ASftUfYMK/6iJXXtImk2OvGXS13/s+VgASbKScHjKzO8RNhwoW0B
         jtUzBg8vvx19hwFHrA4VTZsnIE6Gsgn3KTFNsRJA/DsXdRmkcHHqPb3hNVaOJ1JcRXwf
         RGqw==
X-Forwarded-Encrypted: i=1; AJvYcCWU5PeLvp3D2CIoScEcQS0G3QgYazXh0kL72do/hmzEl62zYgodkxLfpuo43FJmPUjgBNyjj6Ojm21aaPihHJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQhm1UBtXH3KCAjYoO6pIcwgSnbL42R9cAsQqHWIKRcTOcR6e
	UvUDYlxgr2ivXPIu7futvObImvkmW6eNUXSvJW9qqX/+YP52mY3D5T5Jfj52P3r1vsaEVITlvic
	ttfl/tAbox9UQLt8g58tAYH2K9DVjcZU=
X-Gm-Gg: ATEYQzzrwAnV5EGTSv8mPz/ZlDpVNdxojt8WmR+uj8wK9PURoAXRcECskokU9EpucXr
	Jw0mNJcpTI+yS3hHKUKpbfO8HpdIachiuZIf2KYB0uoPoceMVQKfWyVEDBLlFEp1njxOA9ZoLXe
	pBDaqOWQSMxTGplIVAeyUQJCetTwRvqXYeenUF3YKUjjuVk3GyueVrRWuNrhf13f5p53qjwlwP3
	5k4hAlx4IP3WVsAX1K+Qug5iZNXANrg2+befVebxDDYL3fCIry+r7wKAFpk/Sse9DNhnAHNeCjk
	UI8HfdjnHwfufD+coDrUbHs0ufXUzMvxSeKNEt2OFAdAiVXXjj4yp759OXEXCZHVGwVSe4UlBo3
	fzhX2UvAiqYeosfredInhfqU=
X-Received: by 2002:a05:7300:fd16:b0:2c4:6ec:141e with SMTP id
 5a478bee46e88-2c932bab66bmr7028eec.7.1774977290081; Tue, 31 Mar 2026 10:14:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
 <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com> <CAFhGd8paijFboDVr8rJDjScob047q+zgYAs038WuVozOG0aYaQ@mail.gmail.com>
In-Reply-To: <CAFhGd8paijFboDVr8rJDjScob047q+zgYAs038WuVozOG0aYaQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 19:14:37 +0200
X-Gm-Features: AQROBzDhgoRzvErl2Hff4GGNXVWp6S_FczTi75dcVGu_6O4eHFWwYHMrEyNGrVg
Message-ID: <CANiq72mQPU2Uyz27mBtfT6UF4Zgoq_osodALs21kJ4qOFLVhUQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 7:09=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> __ob_trap and __ob_wrap are defined by the compiler.
>
> There are some examples within the documentation additions of this patch.
>
> Kees, is it possible to make it more clear about what we expect of
> kernel developers in terms of style? Should they use keyword
> spellings? attribute spellings? only use custom types?

Yeah, I noticed that right after sending the email, sorry.

So I tried to use a macro even if happens to have the same name as the
keyword, since that form is a bit more flexible, but it is fine either
way.

What I would suggest is adding to the comment that these were decided
to be used as keywords, and thus we only need to define them as empty
in the disabled case.

Thanks!

Cheers,
Miguel
