Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794145267;
	b=Hq7D1lfRxpIGEVNisF64zsNJ52oCHfUE1CQ0ooRdj76zsoy3sliFD98hV6M5lJNCj932
	 qJPXOEIZZ03HH2ux0YfI3R3a3XQ7F8Ei/N5DORMLHe//5eVs4LlTtBg0IPhK7UENLOCfT
	 fub/RBNHGUJLo+eC4a094WJf6PJHWE7jVMo1MgRQTwXOeyxr3x+OasnZQp9E3bZiQ08uh
	 SbR7ISasl8mX/ADRGllCePXBi2/a5F5oeNI0P4p9hZheucuMhtMB4qRqf5kil6vma8CXi
	 Z5wvg/ncFZLnsilTePHSzRPxT0Gcg4iIKu4dr1w/D8Aa3SKrfzmts8JGH5izxqaIgMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LCOeMKTokO+IsyFo/KH4xhEDHzKKObBmSarGf98ko18=;
	b=yc8mq1YkwzircTcxCrnB+gUZaCXbNNPew5uYgUuVsjHoWyjiNf3bkr2vDDYkQKJ5M66H
	 1CMFpkd7OCwCt+ub7+BJjyLJqHYI2CO3pFD0+q5J8XiKdM/CZ5VpFvfNdclyn7K0Y1CQS
	 JyzYenhqW82wCWMjHumEkFhYsWcM1YK3fAm5oxLAb8qeLEqB7w6/ou2wBHIC9BnEvMGLN
	 /tDzFNrHSccpHj7flSQUp2/ZR/wa5pz9aBsUpYYRaoJ6EDz0c5ozfIqbNHVdQCWoa0hKl
	 LvcQKWZaGW5rnTUn2ggfoJL8Nbb8l/TmJtbBRuXgHZGSLtZTCKJOGYnfSXB7xeTBJQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gS4IyV05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523E606A321
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 13:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8523E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gS4IyV05
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so53911e0c.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 05:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794145266; cv=none;
        d=google.com; s=arc-20260327;
        b=XePsRDdLFCTfF1JxsFYIUXXBuaFWT6fnxU1tk0GKneyy2qoJ5EqLSz/cGi4eDv665+
         qRZ3N69pVzJBIwXwc551rKRfVbNI4tLFkaTXJvXqYiIsbXAWRMx1MySZ762/IwsjZgP1
         Vq2wSvh5S6Jdq+rNPfC5/QXwLHH2/K0Jtr5B2UL81ifBvsEptDDpEBIOri59K56zbir6
         9R8HL/Eu9M5rc2MlZ55AeHUFPf1bc5EbYtieDNie+0yvVXTfe6A1cUtw9BantgLhfUbh
         jhsW+NiZHyHmkCmhdAZpIe+GOSAK96hjqxqWiH6ujKWCcuUcpTXjA1lzoQXAKUwKpXLg
         vlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LCOeMKTokO+IsyFo/KH4xhEDHzKKObBmSarGf98ko18=;
        fh=mD1W4w93GSeFl4M3lOBe/PjED5WXJ74eubz3rh21+gM=;
        b=OFVGwaKghgJ3H0Ari1+9GZNEZWX+7rdeGKr4O2HProQ9TacFCS7ETcURrBOJJ2lnEb
         tE0w9ToRAGs8BZn+L+SwkvG12ppt4MHoYfXzuK0ozJDmmIYXHXRgAvnd5IArHlpFJOx3
         SmZvhGTEsKvSo1bt/g6vD43xhy68gzgu11OIzFwW6cX4IKA9A/p7Y5MoAhyebwaWwQMj
         isk+/ljG4vAgif8vVAikHqLXnZIQRrCzXhY1Yw0zUZDkxdI//W2CgdtuA/IEpUD+cfIM
         x/j4vLki2a51+iajYDJ3gZRfHd45ndQDnVvtBgeAQpNgdNQk3uwdp5g0xDKIUyJo1WFm
         D2kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794145266; x=1794750066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LCOeMKTokO+IsyFo/KH4xhEDHzKKObBmSarGf98ko18=;
        b=gS4IyV05VkDQCzcaj0cH60rzqPOTwC6Ek9YTcFN0sKygzYdNCgqvPCQ+PjGLj+iaOf
         Q49i8VsT53KXbBrEVbHw8jqpLi6ICZGlAi40SrXglC2l0oHF9f7r7Sh40F5tmhr5L0Kp
         TvoLYWozlenwobuTVNR00Mwp41dmm0+/wMs4HJnAIiNhX09lW/0VOL5l7Zzc+pUeBuCB
         gc4bkxR2Xli2wgfF7vqkseoE3XpxzWbNuNOEUCFyVz6YYj+nfoD5DHiRq1I8sIcLfHz9
         XGYsSx4bxvnSz49ljaRWXMOW7wkrHsGJmqpO8QWi/QqUGroAV0QTVRQUlt1v7yzVBofZ
         3RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794145266; x=1794750066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCOeMKTokO+IsyFo/KH4xhEDHzKKObBmSarGf98ko18=;
        b=HkEEDmaWn5XtRh20ZJVmHrpeihmy+Wi58QvHUda8efIjRfKUpILZ7raqlQKMql5INZ
         Oxwg0rQjlvf6Qgxrz3COnXdHdSzuYlSv+b1zY2+dZxX5nkzQlZFpsR+uZ6oO5H9Je6hs
         kyI6w3Oi6DeHFmWiVULa3j/UjFe/xseqZUY4DGHcme+fjgoJDbllxV3MbWU8+2FMeAAK
         IvGWGSApzZ4z3Ml8T5lNThBQ2/g+ePcpSeQEDdUTqCZEcqspBMNom64uPXg4qcZNa0KG
         KWAbbHTk0VArCSJLkzK0IgFo6HtNlefPxpboiu5/xpBXSwfIOO5dWGYWAwYSkHmjeBzO
         FJOA==
X-Forwarded-Encrypted: i=1; AL+hErH55azgCsz4llthREwwCstYr6r8VX/YfvyodUNDRLGM/uRL+QODOVppUqL0bx5jEOqIRkBoTC1rRGrVfW2EeQ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HTd92/5wZtmKiGOsXMwo2ZriWBPkybQV7luMFbtQYesvNhuhZ
	k8HyQfkKlJuY3iwPUNs33TRSZAMI1+JSPvexCYnMgwoPRK6gPSVQV8IHRuMhpbWua9rk8rYXGsn
	Ht/spU6TVJ4LR1nlwJNEzxK1wbFmhahWiDqgiLgU=
X-Gm-Gg: AYBFou0twJnGScQ3vfXdcQ8WuXe3ZZfn/7QVbAWTUcM71/f0aPKvQdT6uqNI2R8Lhq4
	9QhwkqVlndwUiNjyh17IO7KzuungbKNeFEA9aRtn4bu5wUav/GoRWpNHxRPb/iAbleW4lnbMC0t
	PU0K/EP/Ngfnpv5PjFMnIbFHyXDu8yuKAjA+kN3QCJ1W2xDAKH9xFF4y5WlH/2rRlVRarSUSN1x
	ubwIu2bGN0O6BbevAZl7KdT5mD4EyoCDUeh9fOMQKEKM7cQfe+82sU3XZ8eE6CUwHNnaeF1MxFb
	su4MUw9nspQwIy55NvQWz0s0YxSwm/s9uPTRPglanr/53SWqED/i1VirvN1FV5R4fJb64ug0E5W
	LOWrTaR0IgjPtiD8ESVa+Gm+l395M4yMGXdXl9cTkidpf809pLSjZSkSD2+X3kr3nEHANDeVK35
	nPeg==
X-Received: by 2002:a05:6122:e22f:b0:5ea:9843:fc3e with SMTP id
 71dfb90a1353d-5ece73577e2mr520167e0c.19.1794145265452; Sun, 08 Nov 2026
 05:41:05 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <asNuMzqz3G-gmIiD@google.com> <CAGG=3QV1eLy-eAfi3Q49qwMw_Yw-BJ1tmd3J=SLJB_qWrx4bNg@mail.gmail.com>
 <CAD++jLmR3hmEYN+-YCAcNq_0Zk0=PijS9jhGaMppkNhvbs90JQ@mail.gmail.com> <CAGG=3QXRPh=3rYyEHT0kTzDZ4omeHOjmN3OZGy=5hupday7jyg@mail.gmail.com>
In-Reply-To: <CAGG=3QXRPh=3rYyEHT0kTzDZ4omeHOjmN3OZGy=5hupday7jyg@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Sun, 8 Nov 2026 05:40:48 -0800
X-Gm-Features: AclHuK99orI-zbieegQi11J3FkK91V4jpIniTiB-SkdXEhfbglSkI_1dZl_-EBU
Message-ID: <CAGG=3QVi4ZrxRPT=9T6jHms3q6n+nTECPn4ybiy3CU7Js_U-Fw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Linus Walleij <linusw@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 1:18=E2=80=AFPM Bill Wendling <morbo@google.com> wro=
te:
>
> On Wed, Oct 7, 2026 at 4:19=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
> >
> > On Mon, Oct 5, 2026 at 12:26=E2=80=AFPM Bill Wendling <morbo@google.com=
> wrote:
> >
> > > I sent a patch to add `__NO_COUNTED_BY` AND `__NO_COUNTED_BY_PTR`
> > > macros to prevent this. They're similar to `__NO_FORTIFY`.
> > >
> > > https://lore.kernel.org/all/20261005102518.2400984-1-morbo@google.com=
/
> >
> > I see you are hashing this out with the right people, thanks for
> > going the extra mile and fixing this properly!
> >
> Always! :-)
>
> I'll ping this thread once we get the problem solved.
>
Hi Linus,

Kees' patch made it in and the original patch now builds. PTAL.

-bw
