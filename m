Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0ED4746AD
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196017; cv=pass; b=p3a7t7AhlsS6HPQmRxqDnZO7of2GrcDkVudIB/XESv3K0mKDbtoySVRrTK/TEs1S3N8aMorTxXZh1OKuBV8qzmpzmKVO0yROLVas3bhKJwj7qVEppsqF3rLNGSfG3O4PIyrmYiAuEmzSMuASf2BKYTbXdyuyjoM9Se0S2KVN7is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196017; c=relaxed/simple;
	bh=FoH71T1sttzcTK7jTd/MV4MMsSrOgn3/fa5zywp33Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C87yhq/MnOBZGlszaKxX0/aFkjH2/j9icOixbF185tq961OdMZ9QdjMqimJvMDdv6hSCBKkCjDbC8X9jxky+an/Xq1RRpBwFOOCH/a1pOs2xTr0O8fBBTjViehvaNudFW0VHY/Z08pFu/ln8RZhgc4LKXJv+wmI8kjmBWU5BWGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKIcyWF+; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKIcyWF+"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7beb81b2834so370517137.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 03:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791196015; cv=none;
        d=google.com; s=arc-20260327;
        b=L5sy0j5HFwYjK65TALPF+BPRUU7Dakjusa2/o6e0LThZC3uLpw7dmSx9UgTzLgHY2j
         7CVIIZkneB7ed4HRhZ1fAoXJ0ssT6ruq4nkExO95ZMWgO6XUsoE9gt0DRITmjZMgi6w7
         7lAZ8zL6ivKbn7HdWpXmO5N76h6c7uQciP5d0HQWOPnoeJkgOprju1g932653jCwqkCR
         OMmycizhiU5u4gieMqlawJbCSDhvmRBYG+A8XqR4j1qxBQAr8LS7MxRy1CgFJFW8EswN
         5W/8K05rYiMicWwrhMRIxGFP+XiOFJkfB8Nd6I9DIdD1jh2C7gvWqb8bXqo8hqSckQ5U
         myzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S967s+iSBQZ44jx/2IytRD1jtlv2+1P1I8JkvdWsI7c=;
        fh=UIvMSpvjHeL9P8mavkt+a75tbtKOpzaIbDCC3WqOUAk=;
        b=IAhUKD6Rgg52IvWYfNS+mbqZtsY0eQtGDdb++hJ4749h8KWF8rEXp//UoOo8kmksQm
         f4QydcTBBCijI1jHanYla+hZDbA5oFd6HqL67HnN8NN3HtS7zkmeUx5WsWes06PJoMZe
         BidoTKQwApkZJxDYXPN6wbFpmFcOfLSNExQZuwcSlP5ZL/5KfKggXWcVgVRho5DWZPGk
         1jfQb9MvsSdpuGWCd2sk/WB+LaAmnfV8kCFFBHoOhOCQvOkXa0rRaJ3Di/gL2FwVAbsW
         CNeS1hFdXASnffT6c9GxSEXhKC6pkUjV9JCvgIM4qwoi4OBKiAf8/SutB++Pcgcn92Iz
         jyug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791196015; x=1791800815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S967s+iSBQZ44jx/2IytRD1jtlv2+1P1I8JkvdWsI7c=;
        b=rKIcyWF+0tKspgAGKUAW0rACoFDD7SAn9urDOW5mRABwj5etQgrIOcGQSY0tPgDvFb
         cutlpZoUfDpouR+rRMDTLwJXc0T+1jx2T18BSrfIoztqTQhlYB88ghIkxAalLblekSYH
         b8NqKdCt77d+/ineoHHQdVJT6IywQwHuacoo1XlxZgSPoKeDFzGBppJef5JdI1nljsKU
         2vDXGyOo7UIoecDZmgOqj0byb9usUx8PIbJCzA4i7a5+A3nxkdun2gSWDM11/UXGolAo
         eGDO9FcMIS0rh6ZfMU1VztBEC0D91aCbAQ6FnR/zKhVlehp4vDQBY6LSxLy/Fk2QQYq4
         w69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791196015; x=1791800815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S967s+iSBQZ44jx/2IytRD1jtlv2+1P1I8JkvdWsI7c=;
        b=znsRCBEg9ChQbAG1/obYU5Zpi0eLfkFPi3ALUJ0vMRqCO+i5kzhZQ1RLceD1fVTEl2
         0x1jAZBo8t2TaVA9x6ntshyuGQs04McOTET8f2v3OBw61vUdrhAWuNs5ipbqXiz+bT78
         797npfFxI+O2tVUU/Z7UofjbD/0z6e9arW51rwD9M51PpAwEvYLaSVQvE7CN85nmrWCR
         dPmaubrRxGdaQP+086eW2oVHPLxuTAcUB1Pz9t6h1zFui5VvXpMEQRkDiJMu471UUs4j
         MB4p29iudL1QPTcZHim63uclp85182nj/HJygA8Id7x9IPQZGS0AJJPGlv4Fkafcscmh
         /Mfw==
X-Forwarded-Encrypted: i=1; AKwUvBytDwI3krfxJVHv/jcSxrzWNMqxUqVSzJ8RdqwKaujgbWya6v+b/fQfWo2ZQXHOQYNfFANvw0LNe4wZnFe2RXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLd6CXlb45WuDMWOHA9wshGgXjGKUyzXXrrCvLVR9WehOX0VY+I
	k9hGMf9CMI24WrTrZHOmEvN9AByDL+yvSdBG9MpWoglB/vcBq3f5wzBeZaCOp1NyG0hGPQMbagr
	F18o6F54A9Vastkeltm1FKRoAyMYE1Tpw8oF/C0o=
X-Gm-Gg: AYBFou3k1vDEfNxrdQSylGovSgQvXdS02hpA7JEwaHgcLHqmDVb8OmGNDNtwh0uAn4R
	1MgX5uuEQcOhodbfi2E/74Grvbr7hF3XMBjC2mPajn+fPaAUvZelM/MqmhkicapK8vYcwbWf2oJ
	PUPdwna+Ngm7IpXI6jBwbig8oigP5n2q+rgcVrBxJTZC/LWS4KN/CNYKbtmQ6wxwpzAEhzb7oxu
	7I+g53aAzhFsnnv98PwIYM+Evm1KqWeSExEXjAP5LD3KZ7iOCE7nwWDRSL7ARa91vZaoFILkNIV
	wnS6p3uju/9T16DZuHEjT5dnTyzSL7jmeRDakPQdQBpGuCiGgn8GWdmebE3+SxurqEq8f4AWoh7
	nt8yTwZ5ln+4+yswC1LwX7gtfOYpjbOY=
X-Received: by 2002:a05:6102:291e:b0:7c0:c723:2053 with SMTP id
 ada2fe7eead31-7c0f4c96e41mr1732042137.17.1791196014389; Mon, 05 Oct 2026
 03:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com> <asNuMzqz3G-gmIiD@google.com>
In-Reply-To: <asNuMzqz3G-gmIiD@google.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 5 Oct 2026 03:26:37 -0700
X-Gm-Features: AclHuK9GJaR-vXymBVjABDCTEzvCLBikCIuMwz9R2xSRvkQQKV3rpJQ1IPlyOco
Message-ID: <CAGG=3QV1eLy-eAfi3Q49qwMw_Yw-BJ1tmd3J=SLJB_qWrx4bNg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Justin Stitt <justinstitt@google.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 2:31=E2=80=AFAM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Hi,
>
> On Thu, Oct 01, 2026 at 01:04:47PM -0700, Bill Wendling wrote:
> > On Thu, Oct 1, 2026 at 12:56=E2=80=AFPM Linus Walleij <linusw@kernel.or=
g> wrote:
>
> <snip>
>
> > It's being #included transitively:
> >
> > In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:12=
:
> > In file included from ./include/linux/efi.h:20:
> > In file included from ./include/linux/rtc.h:18:
> > In file included from ./include/linux/nvmem-provider.h:16:
> > ./include/linux/gpio/consumer.h:670:55: error: use of undeclared
> > identifier 'size'; did you
> >       mean 'ksize'?
> >   670 |         const struct acpi_gpio_params *data __counted_by_ptr(si=
ze);
> >       |                                                              ^~=
~~
> >       |                                                              ks=
ize
> > ././include/linux/compiler_types.h:392:64: note: expanded from macro
> > '__counted_by_ptr'
> >   392 | #define __counted_by_ptr(member)
> > __attribute__((__counted_by__(member)))
> >       |
> >        ^~~~~~
> > ./include/linux/slab.h:602:8: note: 'ksize' declared here
> >   602 | size_t ksize(const void *objp);
> >       |        ^
> >
>
> I wonder if we could have a better warning here guiding you towards
> -fexperimental-late-parse-attributes?
>
I sent a patch to add `__NO_COUNTED_BY` AND `__NO_COUNTED_BY_PTR`
macros to prevent this. They're similar to `__NO_FORTIFY`.

https://lore.kernel.org/all/20261005102518.2400984-1-morbo@google.com/

-bw
