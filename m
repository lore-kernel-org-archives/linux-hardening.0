Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C9A332614
	for <linux-hardening@vger.kernel.org>; Mon,  6 Apr 2026 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517892; cv=pass; b=HT9SmJu/bEBhFpqlO9HaDjcwr+0tWhQV33lkSwmwmLzgSQWaZm1ONTA6klDM0gRbBfB2rbi9UFx/KhjPP3ORDVDKptvHqCMHomkauxTG7iGhlw29dBTMyULCZhknrN+UoSF9Zp3/yiDfyToodISCZdGfmDRUPZSc4NqsHVaG+ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517892; c=relaxed/simple;
	bh=gCJIqEfBHdWZLIfLLkUByoZiap4h9NMvkXjnioy5hKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcOrKRIBIKPlgwvL3gScKHT5fIUxB6GY5rOzENNgf+agyCy1TFKlJJBV6r9pq0wwHsZajNav9XfH9ZtSnrKbL+0RfXJWwiNPaiL+tVGfaucHXe84bcwFF5/UYxVYsqtEm+uSlj+Aq0k2XNO3H935tebesc/XPOqFlyCcoKNvYxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3cnK4yU; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3cnK4yU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso20440995e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 06 Apr 2026 16:24:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775517888; cv=none;
        d=google.com; s=arc-20240605;
        b=PBnGKvmrvb4CwKj3gAWSvBkOHaWqNHwNc4uyDQOpHyEGf0W/ieCazJ37HvGxh9lAl4
         1yJ4JEirSbvJvwjeFqNvJa04Su7XP3Sv3sWpTY9ObS4JJltFnl9wSUw1qs/dr6T8y2dJ
         OSyLQ2jg1t0qhsvg9EnT3t6One9Mg3NO9mOUrRU1gQBkKaoqv9fLbNfvJ/wxYa/glZTl
         mQFEonLtMknbJmJjFqZ5GfiKDwRoWrqpWn7mLnvzodHhI04+O6+NPcm8d9y+4raAKclH
         P2x/4RhRkwUPmcSLRP/q/g58AaW1o+nNYjDQ/X7aKrY8IhGo5vbWGhVxyZZf3FGZkHwR
         OkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=giiyAPaGWC/+H4R0yj89JGnzz5C2kC6xrCa4cJrqs9k=;
        fh=jRm4OQUA+OjCnduws41vNd2ScARxSTl058Kqa+m5PuI=;
        b=D5dri/nx7dAQs6leMCodgCvLkokm+vpo7XVysRv/w/+7rqPbSTuuT3qU/YhBIC8PY/
         P2oRssJ1kV5eY96kaiiUBF3OkVR7FwMD504ha+FM78ieRXzhMovQMFWkeExd4oHGy6Lw
         S/0N0yWmOl9QJ1L3SG7z1SXqHxSWSC04AAix8SobCqC1GN/oGO4oxkXPJEf+N4g3TsYE
         JXwv3Lqc0b1UJJgL+duf33uexIRF7TK01jbbs4EWxJI0MuflnfIiIipXFWq8w3rzbIz4
         uvIoWqi62+jbBWUKGnKB/ZKoCeBp/LLKegfibpZKYk57lIVaGMTc/IZ84VQPCSTuYfU1
         vX4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775517888; x=1776122688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giiyAPaGWC/+H4R0yj89JGnzz5C2kC6xrCa4cJrqs9k=;
        b=J3cnK4yUKb8M9LewhSmna0CD1zNwgZebvdnxVmzN9Rq7KuZHSrho7PwcBafPWH1dir
         Z8k4EeDfzhLucdY3lQtcMV9kREh7saN4p5eUOX/nSmnIA0Rq9Yz5PWjXJUX2JdLMhdOs
         /x/sWRzIbE7EAEN7OoBEyJ9JBvjC8bKUzWjlSGuY4fA4cBV6Pm5yrcby3UFKIWmRZBlo
         rkJtDBhwkd3s6yGl++5RxfGUKxl/aq0/AJ3wPboMKA8qrj6HSyJFxAaU1HcHVQdNFPIr
         0rYiHa+CMH6tjO2CDh3Fnirue34uqR1XQMAqjRgaBnH9h0ew0IEQMiAGkOf6l+NzPfVA
         qVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775517888; x=1776122688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giiyAPaGWC/+H4R0yj89JGnzz5C2kC6xrCa4cJrqs9k=;
        b=gRo4/A9nJsX6Rc3ZYIQ08C8Ysx4ow//gXbyM5XVqhq4FmcJYI/4IUiFgsZptsdSpro
         ZZoisZfQvLej7DQRllH5Wj0+NKvSUQWwNV2BsBnxW/6RGBAb2Dxrf/nNxQrBU0IAn0WI
         1f9Uo8GGnQiap5OcBCb4lnMvqmTL4a0faylSH6fJW2WxekjATM55aLW94cEcx3W3lEzg
         Z6EicERekQq1XMWLhnCWjymTGgw1aZnvZONVjv4Eqv+kdaYFIvWm45mzKztnQN62uAdU
         BFTxNxCHKCK4Uf5lheE9nhR+z7zXNmwVM4QKcCmmaa4Vp4vKTdO4jrYfKbG9wNF+cqyi
         d64g==
X-Forwarded-Encrypted: i=1; AJvYcCV2wy40PZFgi5piggUzVmWiAX2+R2V6zLasYkomnPbTo3eN7ry4I3ij5CVNy7dZ/rRQXfGUyjNOh7am47VxH0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR046NuOlGBb82DbKC+s1YLZm5oCjTrTXIuf+/FeTlZH3zvdQ/
	dMxpQKpUUN/v+6OEHpwpI0wfj5Xo/wmc9dxh7JY1OGShtFK7kmHxuBEF9nQwWmeXbGD0D0Er+ii
	nN0ZQb3r9w7ibMsfNNNNTzehYbRAcq3A=
X-Gm-Gg: AeBDieurpef2p95I0bRurXzr0sqYKfH0EDL0hWXgoFeiePh7MII4V22QbK/9ZQs2ekD
	fKuYK7PCRCSoCPUsXHKfyrF3ZnVO8dIIO72/ANE08vxB67BpUJDWTkDKLNqTw7DpwGhc6MMUF3w
	AW9lXP4aXZs4O/s4SNUQlzLtKGMqyVi0gZDPHiZNOMgXLmigTxglEmMejJ/jMzukfIhbTu96Ve0
	VspBG1osS30RIVlf6ma1YXI7EfbvyfFbtqOaz+8peA4Qv3W7zTaEwsbNahZIxHer0KV9b/foGzM
	2hypqCXVEfAclaSKYtbJ08z0qS+9HOILSjjwVKCa/gkJAH0vIe622nAoDOKnSFuPwTCIB1Ciw/c
	NLwZzud4HBsl0Ba1RzhyQ4O9+Ww==
X-Received: by 2002:a05:600c:a47:b0:487:1108:48bc with SMTP id
 5b1f17b1804b1-48899775d9amr222192405e9.17.1775517888153; Mon, 06 Apr 2026
 16:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acr7Whmn0br3xeBP@kspp> <CAADnVQL1kaAZE0L2k6svR4FK8UZvw44WXp=g+Df+SseMkc7xGA@mail.gmail.com>
 <202604052007.4EF0560F@keescook>
In-Reply-To: <202604052007.4EF0560F@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 16:24:35 -0700
X-Gm-Features: AQROBzDda2R46zaFR44hh-lUnrF-5MQQDqCYqqirlLv6uqn548J31w5zS_2FGPQ
Message-ID: <CAADnVQ+NMQMpkG8gZPnwBD1MMPsH+uJ65C9bMeGf_YH5Cchxpg@mail.gmail.com>
Subject: Re: [PATCH v2][next] bpf: Avoid thousands of -Wflex-array-members-not-at-end
 warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 8:27=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Apr 05, 2026 at 07:44:51PM -0700, Alexei Starovoitov wrote:
> > On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > Apparently, struct bpf_empty_prog_array exists entirely to populate a
> > > single element of "items" in a global variable. "null_prog" is only
> > > used during the initializer.
> > >
> > > None of this is needed; globals will be correctly sized with an array
> > > initializer of a flexible-array member.
> > >
> > > So, remove struct bpf_empty_prog_array and adjust the rest of the cod=
e,
> > > accordingly.
> > >
> > > With these changes, fix the following warnings:
> > >
> > > 7659 ./include/linux/bpf.h:2369:31: warning: structure containing a f=
lexible array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
> > >
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > Changes in v2:
> > >  - Remove struct bpf_empty_prog_array. (Kees)
> >
> > Kees,
> >
> > It really bothers me that you ask people to clean up
> > warnings for the sake of removing warnings.
>
> It's not for the sake of warnings; this is to remove the ambiguously
> sized objects (i.e. structs that the compiler cannot reason about the
> size of).

I read through the AI debug logs. What steps it took to reason that
the fix is correct, and it convinced me that I'm wrong.
Applied.
