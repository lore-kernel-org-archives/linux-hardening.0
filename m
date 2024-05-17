Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1A1DFF2
	for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978475; cv=none; b=rer1FAHYWknL+I90oNaC0wQBvSwLFAoymcGsg90FeDs0X3R52Po2TswWDye46ZNMJKycMCwV2tY3NCFMwCUJlUHO1nwtN5J1OTg2psO4oD39Un9RyJ6H0OxOG/phN/2HhXItpT2XOThVyw67VMe4GJkYAcOUxg0TGKeYExfM4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978475; c=relaxed/simple;
	bh=1zR4oNwvnA8BkAHQhbNCPpvycGJsy3kDip8fLJUMvs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNGcKT5qiiZ3U8S8Xynt9Zb/UpOGO/1m/EGOSKEndqhpOwMYu1oRsvdts4o3ThexxF8zAA0LhHBpjgrT+LalhXNGiNAlPCEgNkYqnqalZGPsqMwhgt2Vv1Jt5xJ5x4T5+qHP9m8ZhWXR6ekZHn6KUbP/Hk5bLOQp5P2XJnL34PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mH+oa/U+; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mH+oa/U+"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7f82c932858so421749241.0
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715978472; x=1716583272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R30tVZwDgV0/d0XFfhvgj7VuYYCEcxfHEIQCyiSom9Q=;
        b=mH+oa/U+pZw9M6PdpQ0Ikf9E0v+oC4j3gECWwxWWr9cRfLqWdCjLZ3Tq/F9vO3H8AZ
         RJX2aEPhAz6oT7DMFisz6xSAKeosAs1p/h5fj9zJMg3WmlrbLt0bEkQiS6Cwk+pp7yeq
         mFkspH4SPjy0Xt/0azA07J7te/vpitJsbEUFmnliPiiRzb1cmVR6eVrcuC0HhD5tL48u
         fPOOzWJrBCkTZlYbsl+TdPT937jCX3bVLOj/c0Agmd4k1GWtp3+lwuvPRm9vfLtMq/mC
         DLReSp6iscWNBwxP8tz6NRgSreGqkrovduvwEGc9qfvIJ3b6q/PWf367QqFqPfWHGWdY
         D2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715978472; x=1716583272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R30tVZwDgV0/d0XFfhvgj7VuYYCEcxfHEIQCyiSom9Q=;
        b=R3Y4zHcY+Cz/mdv1FwJ78At0gxStW2Zbw1HcGlLfjYJsyOMkgXUZM97bu2d6oFbQ/T
         vDRKoOWgQFZqsUHX9y1IdxlnBfv3CdQX/3p0p4CHzQZWFD/D4+ia0XYlTDh4ZOdNf8sT
         yL5FULpROWBWHeQmff+6gRoUtiCPeqmqT0zNx3YSOr0uQv5cBATfobqLdCck6XPyvrKV
         6uxdzWMi8UGImVXWI636HpAZ3HNMrNwu8QAJVNOqw2yCmkV+tUijiXnuaJN9M5zG2N8q
         U/XPlHY8XtNlAup+C8f0CA3WKO9ITWS7lrAfwazOveQDcV0chCntpKLuQA6KvvV8nBFi
         lxSg==
X-Forwarded-Encrypted: i=1; AJvYcCWr9CCPz3nsubSAfaLdXNK79Cg4v1SSTVwfATivu9tULDBYLVE/K0OakhIqmt4uUP4XzT9lmnGywkE6hsz0dWZNXso+NKgM0fK2iRgqyxEt
X-Gm-Message-State: AOJu0Yw9edV8K8GT1itntd2ftu1T7R461NiYVpyHcioP6pzp+REnZlRP
	8AK2VNPXDLXNAtmELi8lMyPJ8hzRaofXR1EdLRadTN3ffdFKCFxwNupDe5GLpqvsBXmHJ3niyRu
	TpUHMxDpgDgCSduruBzOq4RKsPC4j6t0G+3wb
X-Google-Smtp-Source: AGHT+IHmfBLbTvuWZDrq9Mhu7TtpE/aaISjoWzyeUMYFC/bgu3kwTmD10Cx24kOB+yYtazT4c5jmMdY6e5JklVkmxy8=
X-Received: by 2002:a05:6102:390b:b0:486:2c0:1d86 with SMTP id
 ada2fe7eead31-48602c02a3cmr6067630137.7.1715978472478; Fri, 17 May 2024
 13:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com> <ZkavMgtP2IQFGCoQ@casper.infradead.org>
In-Reply-To: <ZkavMgtP2IQFGCoQ@casper.infradead.org>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 17 May 2024 13:40:59 -0700
Message-ID: <CAFhGd8pQKE_uak2gqUXjbQy4LCGoJqVD2XCZrOC606u-tzS0mg@mail.gmail.com>
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset calculation
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Bill Wendling <morbo@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 6:13=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > When running syzkaller with the newly reintroduced signed integer
> > overflow sanitizer we encounter this report:
>
> why do you keep saying it's unintentional?  it's clearly intended.

Right, "unintentional" is a poor choice of phrasing. I actually mean:
"overflow-checking arithmetic was done in a way that intrinsically
causes an overflow (wraparound)".

I can clearly see the intent of the code; there's even comments saying
exactly what it does: "/* Ensure offsets don't wrap. */"... So the
thinking is: let's use the overflow-checking helpers so we can get a
good signal through the sanitizers on _real_ bugs, especially in spots
with no bounds handling.


Thanks
Justin
