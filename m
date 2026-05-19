Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE93DC4DA
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224429; cv=pass; b=DuFjRJL/nBg5gNWywwL8fVm64+cMCyeg8pcVszvZvLzngCvA8ZRRvethr1Zo6h5qYqaaIIpOPZdtw1VHpHcN2mYbTy0LKTC5iIcTnEUxcTy4h0FnAvSixOwLuc33TuQQolNTmOOW17CYusaYh8Vf1HFvjSfj1Crkv6VnKrgxBj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224429; c=relaxed/simple;
	bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntQLQ/j0OdNKDH0ZRm2rbP/8sPZDa65B3sNakvQ2LARNrV+A1IKJWnPgAu6SjalqGrq7j8LkEG1Ge3ABOtq7unRNSMQFnXVLddx5c3YVClgf3WGPMEjGONr5k9YWoZY49EcOW7E62gCUdEIFHASOv/yuQKsgfm5Mq7omCB5aJVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/T62TYB; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/T62TYB"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-393a44854d2so39805321fa.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 14:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779224426; cv=none;
        d=google.com; s=arc-20240605;
        b=EXWyY73A1RkJicbqSrWEZW9tg4b+3TxMulotARCG8tXMMOcCmk+miCzevgpeibc030
         Ifk3p1du5DuA+fM4Hi/9cpZbLMKPH6UVF4cLq1W5Rm+UDZt8fZCCBVqO7OTVGJrJwiPd
         LcrkraJVkPjcRj+ZMGcPAlLkDlLgHpOf9e0JW9XOvgLBCSn0UqZQrWRpfHTEowT6NlCt
         pVdMHG1x3s683WuVGfGQ+Blye8ywhj7/H1cU3PTWOuKfUkca4LwbX+JMJ75+H+P7pIx4
         EeiOVRCukELJb7iAnRSpY3GDnYtxS/NBr4/tSzs72Y/t8ErFGSWop2jt3xD+IIyo9R8T
         2nVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
        fh=RKxJrKYRXKe+6tucSQ38dIpayFLkCBt/wHoxsivm+aE=;
        b=eijmW6V2du3RetfFuqtcBdqJ/hssK3Ox8SaiaaoC9njocf0+ikfyQjR6zB1IkKy1hD
         JJTB1HL22O/grJXFZ849M819OhSf2UeUp3wZFXCgiRm4eer7wXLHbYaE/EAw8rTWHVtA
         Df/RowBIVnQbvFaFc9+qx3Od/6m0NyfTyPgncp0E9KJ9q9dZ/0cM/xmDV4dwrPzMoIlS
         p3ugNIfHR6lpb7vUyHnuIH4AjbMZBBIVPAANHLz86+qBU4S5txb3XA5Exy8995yc5Saz
         4ioYdSh5JXcNZFnZqFr1OLpL3iK53vAb4xao42upb+70VK85R8BfTepBt2E/oh00SYRg
         Lc5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779224426; x=1779829226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
        b=t/T62TYBGVvNW3TnJzguQXz3Fg4JukMXhPWvma4WeEL7hWY7aFRV+0sdeovJbirSqg
         aPlQirQJqHbPaFoAZUFko8NXgiiGJDerd00786MHwp6y45/CvTffxkU3lWgY6De8DDob
         DkPB3EfZZAs7OzNaGScZbrdZE9jsTop3AMcUlpPDBlFMY+i3PgBc/CgvQU2mNWrH0Ifq
         TY86Ml0liixakw20QpFo68doRB2eINQqXIKFF6MyWQjfbCY/J4T/WdroM+Lbph2kUbrZ
         U4jZmA8ohgxA0E4bXx4HxIRm7s3J4XzfSeoTrPkN6eMU9E5uo5ZhR8tiBc0HWt69zopi
         yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779224426; x=1779829226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5xX9AzWZwqtZqrp61qy13Pz2Ds+N0iybZrAmj9tWm0=;
        b=EqHd/lwnaSnUnMUQ5XvzVEQNfjF+LB70AcznBDY18De9MIevGGb6NAPbXFiTxgs9ZV
         E+F6qIOy05ULuN4wqQysqLINt0iaPhe0uMOEa+g7jG+r3TN/+88XqApKNdG0+I580awK
         kOxdMDOXytyowqfV5D0/yA4cQxN1/ikRubkpM3EnO3DfXqRZh/k3VJbbxKi+wNVnz/pv
         XwqjBtUcWKgByXG5OPKynk37zRFyJ4AzLqSBXeCbaD9FONdig8izP0k07IuiqYuWFJUt
         fzwBId6X5HCHpeD6bgA+SLXtWWdpO5SaYI+GfRlGn5i0icO0uDKxIwamjWPIpwEGClic
         Ozog==
X-Forwarded-Encrypted: i=1; AFNElJ/GrRsjKDSCdPc34XMKzwQoRh6/JzvNCEBHllhA9yRP074TkTjUepPmyelmyYY9yBlwSCG91L8enqNGNKQzp0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IwYr3NWCriZi4CFO1plVWoUVzGp7NV+iYXV+EG9VEFdfqiFf
	IUSHuKu8GfAIxSyNo4fxroj3nc4k3HJ46PBtJb9Veg42A75uUEH/pCNFWArr4bFm9c7LyUVb33j
	WYfjmn51lF9yX4V93l04o0KqDEv1ignFX+YNKgvXQ
X-Gm-Gg: Acq92OEoN95ZaxJyKKTx6rMxHwl0+2eubfuYthL0fJi9Pg0tTLzt+gBOrBMyQ16DJqR
	jjTNUXVTrLyfrxFqmqb5AtF8lIpZpzM3FkezWy8sw5i0yGfeGDvMvwuf2W/bMthDlgXuD4vgdlB
	8eY6qkh03KxodXhu1YM6/NS60kmU7CqHFfoT+DHRZscU5d/Qb5RVw44njoiiLicm/Tq5woBXqOY
	wp5tUwG7jnWMyw7Gz8bwV/kkodVG8o24D34ARshxUa4d5B8FNEVajULFd1t/PIOJTUljYEmvG2v
	m7sizxKR2QHeZx1ChJCHBTRCgWW+7E40osSPAKtI5Hq5GjpROGaz/UxA/+0FpKOR2R0x/A0E1hJ
	h9FbG
X-Received: by 2002:a05:651c:1608:b0:38e:7a75:8763 with SMTP id
 38308e7fff4ca-39561d60079mr66044851fa.18.1779224425970; Tue, 19 May 2026
 14:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
In-Reply-To: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 19 May 2026 23:00:13 +0200
X-Gm-Features: AVHnY4JQiCOJUMjfX0rK9mwMWaqqgmFj_5h1OSJG4OrZMSmTfEHnd45kmHmSl9E
Message-ID: <CACT4Y+bzkW0fjrUcbG+6XfTsw9_0sGfYN+9myHtC72dZT7gvNw@mail.gmail.com>
Subject: Re: [RFC] hardening/fuzzing project idea: KASAN redzone before skb_shared_info
To: Jann Horn <jannh@google.com>
Cc: Network Development <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 21:19, Jann Horn <jannh@google.com> wrote:
>
> The following is not something I'm planning to work on in the near
> future, but I think this would be helpful to allow fuzzers to more
> easily detect OOB access bugs in the networking subsystem - maybe
> someone else is interested in working on this?
>
> As described in https://docs.kernel.org/networking/skbuff.html , in
> the networking subsystem, SKB head buffers are stored with a "struct
> skb_shared_info" at the end. This means that out-of-bounds accesses to
> SKB data in the head buffer can't be detected by KASAN unless they go
> far enough out of bounds to go beyond the skb_shared_info.
>
> For debugging/fuzzing, it might be useful to have a KASAN redzone
> somewhere between legitimate data in an SKB and skb_shared_info
> metadata, accesses into which would cause KASAN splats. Maybe we could
> split sk_buff::end into two separate members for "end of tailroom" and
> "start of skb_shared_info" so that a redzone can be placed in between?
> Or let debug builds store the skb_shared_info in a separate memory
> allocation?
>
> (We could also try to go further and KASAN-poison the headroom and
> tailroom until they're actually used, but that might require an
> annoying amount of refactoring of existing code, so probably not great
> as an initial goal.)

Hi Jann!

There was a related issue:
https://bugzilla.kernel.org/show_bug.cgi?id=199055

Not sure if it's better to include this into the existing issue, or
create a new one here:
https://bugzilla.kernel.org/buglist.cgi?bug_status=__open__&component=Sanitizers&product=Memory%20Management

It's also list of things that nobody is actively working on atm, but
it's still to have such a list b/c people periodically ask for things
to work on.
