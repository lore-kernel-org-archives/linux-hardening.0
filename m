Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003B2C234A
	for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014484; cv=none; b=hS2omXxR+q6X8zVzY1FVmeO0Da6H7flHJUq80kzSTGfkNHToFgr7nkwQN4hjG9k1Q0Bk2INf86K5wNS+GlSPzhl8unSEfiZB0OARtRQZwojGnOJY9BjwOv/i/CTpXzaL6jasEW126IGmgVBAr8LGroSGLCFsq/PBtpZD+Hom+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014484; c=relaxed/simple;
	bh=cQwxFaYZHEmZNZ7/Ewdlophv+c6KxD1WHIcbrV1ZXCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkaRXMNZqPCDZhGZ4/UFJcD4R3bHIMfFcGGeiZ1x7FWo8rkqsTgLORa+bF24KZVvV8CKsuAPs4n4pLi9i4mPQYTJz6Hm5/z2NXGvsqc9/+iffInTogvHoCj4NBdZ8aSzXFwmTJsClbdHkKnhKvSRj3MzJEw7U+bo7jZrrgkXldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETkEasnn; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETkEasnn"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735487129fso688220666b.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014481; x=1764619281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5PZVjnzgC4twlZvu1HHXehXW625dMTnQMUaBeuTteM=;
        b=ETkEasnnaL9Kq6HnpyefvLJkHHs545yoyYWH+6WjdStREdnotG33McMSkctN8d4ZPv
         WStBdMZgeUe80uaQOjHp1m/tKIpHxkil3OHaxzeFyxjKzxaprUFf/bSmrjwT42gOkee5
         PZfc1L+ReNYBMJtyaIBCeDcGSVCx8rzYrUOwiLbxEV8DwRYImAynPcWV6nMdYw+pZF0x
         YNK6Lz5P1h/wJVQO+QT6sMj/ckzE/uabd/L8twyay5zKZFfPTRvrZvP8+xzXfr10+BWY
         XpDshu1XgCTVIDVshabUZql1xDWeh3IIfE6Jjjf1s3mXvpUqfWhAGqNiliu57yi8J0Ru
         9AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014481; x=1764619281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5PZVjnzgC4twlZvu1HHXehXW625dMTnQMUaBeuTteM=;
        b=jJIksId/my1oXyPz0xwUyuhRRSU9TNquV23Klq/fKcW2z/zH4nu9Z3KMQ6/3KaUcXD
         LQwh8wqcT3tggRrBu1SWM2r8pLAlHeCSWQTRPQ/NyvkkpmQ0SmiTfgTzkTK+BTi3lNoQ
         RLXyNYzJonjlBmXCeYUYi2JQ9V+tZ8zB1B46BA3u6Jj7TxFYRa6qj5plF6xaE1SPDXYL
         p95usU7XBP2hBI3iIP5BmsndvRr8X9xnCcdjABG9axJDW1kcGKhE5VovMbnZ3/BSr7OY
         o2gjcAc8blpED9U0KTha6CKEqaYc0KYcAyrrBGmkfnjDufFnweaUwqwSDOsyGS2GQIXL
         3yqw==
X-Forwarded-Encrypted: i=1; AJvYcCV9gW086yDAqle62luo3ut9LT/3WtTJHPY8DLjq/RBcrLoTr+XNKhCHGuNO4Aa5UyA+hGdeCEV2x7jdrzzFFy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMeCevwWO//daWFNNOLz1rDeRv/zmTAr32OTDocSAZK/jXiT8
	+DYsaUZ8KOlOC7vnp9eJhWQrcsWXmFWqNM8fSaYDsw5M5OPRWxmxxlMAfZS0XUkflLJW/ze/xQf
	fBB5GzVbNwX+xCfH8jKSmNz537SGUcdJRMn0DTF8=
X-Gm-Gg: ASbGncsBn+J2F59el5NBfTNP8PwSUsh+IE8w73uBrcQYnmVbAM6Y0dDRSGo+BeQtuc0
	rUGtj2PDpAI3XpqSlXNxUl0fa0Nj38Fcjzn1y5VllcGsDv4HZsAPHFeeycxBBrlAxqW7bhCTIR8
	a1gWJ+RnkS/VCDBWdLfU2SLtDwp8WDBsI3GUeHtl5q9GDm2/wJi+o7q912/NEHkCzn4VXJdVGvO
	gvh9cXIgto+6cx4qSX9fEodKBL4KN8EK1zaccmMdqE0JkMf8rY24F0xMPvSisK6POhhDxK9T7GT
	eyk=
X-Google-Smtp-Source: AGHT+IFr6iwtRS2jopoasnbFL17M2Bmqp2C8vwyIBKBMHZ+E2zi4WXWBgfEdcgwMQl/RRCDP0mXPA5rFrsfTeqdXLVA=
X-Received: by 2002:a17:907:3f2a:b0:b76:45bf:ce38 with SMTP id
 a640c23a62f3a-b76715abc23mr1304466666b.19.1764014480979; Mon, 24 Nov 2025
 12:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121193957.1655580-2-morbo@google.com> <20251121195504.1661783-1-morbo@google.com>
 <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com>
In-Reply-To: <CANiq72=kqJApbOJ0hmC_mAYe6DO8YqXSFaLJOsbPhkXfxmvJHQ@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 24 Nov 2025 12:01:02 -0800
X-Gm-Features: AWmQ_bnpCEFoHl49A5Mfn4Wh7V1-tjK9T0OOqowfU-0PuTPEPORtOdqbck8Ltl8
Message-ID: <CAGG=3QUNTxpFiQd6EkRaN2ynLPi4WTY9CW-pBZG9Y5hr8VT5qg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Compiler Attributes: Add __counted_by_ptr macro
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Qing Zhao <qing.zhao@oracle.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:48=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Fri, Nov 21, 2025 at 8:55=E2=80=AFPM Bill Wendling <morbo@google.com> =
wrote:
> >
> > +/*
> > + * Optional: only supported since clang >=3D 21
> > + *
> > + * clang: https://github.com/llvm/llvm-project/pull/137250
> > + */
> > +#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
> > +#define __counted_by_ptr(member)       __attribute__((__counted_by__(m=
ember)))
> > +#else
> > +#define __counted_by_ptr(member)
> > +#endif
>
> I guess there is a reason for this name, but it sounds to me a bit
> like the thing between parenthesis is a pointer, i.e. that perhaps it
> is the pointee that one that counts.
>
> Hmm... what about `__ptr_counted_by`?
>
> In addition, could we please provide a bit of context in the
> documentation? i.e. links to the attribute docs in both Clang and GCC.
>
> And perhaps explaining why this cannot use `__has_attribute`, i.e.
> what the commit log mentions.
>
The attribute used to be hidden behind "__has_attribute" (git show
c8248faf3ca2), but was converted to a 'CONFIG_' variable due to (I
assume) bug fixes that occurred at different compiler versions (git
show f06e108a3dc53). Also "__has_attribute" won't work in this
situation, because the attribute name, "__counted_by__", is used for
both a pointer field (unsupported) and the flexible array member
(supported).

The naming of the macro is flexible of course. I have a preference for
adding a suffix, because there are other expansions of this and other
bounds safety attributes where, during discussions about the
attributes' syntaxes, we've been using suffixes. I.e., Clang supports
a limited form of context-free expressions as the argument to the
attribute. We want to add support for that in the future, but there
are issues with adding that support to GCC that haven't been ironed
out yet. We've been calling that macro "__counted_by_expr", because
again the attribute name is the same. This is not to say that it's the
*best* name for the macro, but it does seem natural.

I'll add these explanations to the commit message in a new version
after I collect all feedback. :-)

Thanks!
-bw
