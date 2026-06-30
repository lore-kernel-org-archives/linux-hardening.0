Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F02C3245
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782806957; cv=pass; b=ZMY3nD6sVVzlfnE7JjP3BnpREuVPqRJQ2aMreHsBumqdyT1dKK/VOyix0z5RAXLUwpQnOUbeb+fLo+RGlqYQyE8ecGp8tENu+aVtCPmicpZXAcrdm09wkLIJnAxvpFPLRW9FOYqxDiUah8rqHXGWymMNgiWblik7C/dscuN8ZQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782806957; c=relaxed/simple;
	bh=BZiqEOF622Wn1mEZzKvDK3USmkyKBgRUpLQz4VE2a3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j96mh+S74D/4ZAlF2kkeRkZz8UmAObhKLji3szHrZzol9/s4xJWylMO25d9KP7XZy/6Wa6CXv2YJc8AWHIp1woflR6vXI5uAvw7r6yBiFPP+Vp3/JGFuMI63iRfqHSOMi5kNnIMv7M36ciKbUnvF+2rJKzLIRj0Cg93N9uO/c8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=YsIXCevK; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="YsIXCevK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84780c95e2eso1234528b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 01:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782806955; cv=none;
        d=google.com; s=arc-20260327;
        b=cGRP4GIMBxTCLS2VIGUIjKfyuGTnn1OlQnBtFAvWEDWBkF7cAfzU3+4Kpu1CdKVfuw
         39CRBbeh2qGkfp9Qvyg6DiUHsj+FVJYINuKUjCcREf7ICAMfREHBGz9S+kszQPih0ro7
         SSTv96aur783Vu9PvWOGTtGznnPRpaVt6tW/slIvtaGQBLlOhVYY+2nNjLaVhEF5ny5+
         FHWCStVdfbWwE34m5aDTn2NfnZ85Xbb1MFm99LOp7/rH5sHyVummlPp6DHnNOb2XQKbY
         oQmvwkL9hmOqBKyAsv9K0k/5KnwKWX3DkgF1Pei6ZSlZy2I6TQr4R5Eq2TWgwrHb3GsY
         2AXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QMfxs/lV3gs7hZOuAvr99QHZT5L0EyUo7IHm9UkfFF4=;
        fh=rlmncKrX/96pyK9MgxsCirSamjS0/fiFDsr3wy8S4To=;
        b=AcCPc/1RMq0mmIeGhOP5gNtEwDoREFOv7JMaez1eP0ikFRQYOW6bI6xTKgysNZJDW4
         NVi9ErS4/KOgeXDgJOZ9QeJqe7lNR61+RXsDoEu5d1TzMvZm0KKf8PyGDVt0FVv+pF2Z
         WDzMgWXL8mb4X+wXlBY69XBwMjyQAguYEIeMlNnMT+yWOodDPYf6Zxz9ZIu4QwFCiuG8
         uFFkozhin6twChGTNjGOcE7qHKQgO+smOglI7XckmhVlSuIL6cxl+QPu0AdJv+KboIAq
         yirF+p2C1wSra3A9kl48YE1arsKh3ujfdK64S8i7ZvaI9PwQ1Pfom3btS3W7MUxxqUzx
         rCrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782806955; x=1783411755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMfxs/lV3gs7hZOuAvr99QHZT5L0EyUo7IHm9UkfFF4=;
        b=YsIXCevKuRk/r+O5gIVXuJFavn1kh6N8etEn9xvTfRxec39ke1RHMfAqjYGtRgOe73
         hrWHU0DZ4wmQj9qrwVdQ0DRjB204qTNOecS0yJgM3An11G4fQr+cwQv0uulNgHeuAi5P
         mUL9uOjOQR72i3EtKmSnXBaxvTn3ROASUrz3ElKf70xMkXqAx+bQbW3akE28eDhRCMee
         mfiUz0Rul2ttI6LQlG+xmMoZ1eiR6WEKMoovAfNB3vTUQemDTMlWwkZsh3vRtg0/I34q
         gQEjUC2iu5nFL1fThqz2XLV7LDvJRlvvoQSa+mMecRebsXwtJS52DdoZ1D6IvMz66wrw
         h6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782806955; x=1783411755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMfxs/lV3gs7hZOuAvr99QHZT5L0EyUo7IHm9UkfFF4=;
        b=pgm/1VFFYx9sUWgfbUWtmKLzdtNvgZhzOsx9YrgK1J0mKtiph0PNs4T42KEkOlzrQC
         QyX3cfHeHkRFCMwqFx2nMIFb1wvXw7gVfv3avw7CaZ3d0Vn0rP7FsH3gUh5ZxnzLd3Vi
         Wb8Z5Ypv9QMb8LokJFe8uoOrcTlflrUSQo9P8IIH5mZ32QgdJIf0LNhwAe+GpFF5kRoq
         hW49edi5ArLw0K9m8HFLYKEm8HHWiLVaDAex1W+7xAVMTxKefwBdCmerrqwnQSSDmETk
         HDeZBQoDPz1jrVNy35rzLPwsrzOh17KhiYaepFHFHxIR5lSuFZKA/lRB5BmD8TZgxdwp
         wTJA==
X-Forwarded-Encrypted: i=1; AHgh+RrYm7u2Z/bdDWdNQ2LNTwh7LGRcz1MMyhayDci8dZHW4WHB3oWs7siDJQ8DEheG1K2YQo/d4BdPKOauiV75OV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBI25Y6kydogrK4uLDC9raMzPCVv1oytDeMqRc9a/u+sHmckm
	jWvi6K5amDmmmqCTTISzxtjSWxxiOi550ajxahAg5LMmiSxregpQHL9UIYLFnb2PVkl9OumJk4O
	NAcwD+XhCpmEtV6dg+ZNJ48GhBWoBSQG0s/6prZD+
X-Gm-Gg: AfdE7clqUy6SZL4B35Yus8CMlHbit8EzB7lXwGRpKlsu0Im9+vZ0ay+vc58cdawaWqF
	nOlNTVDRF2QkeKUFHMZNLBws3yseI3nA9+Bg8P5o38Lv8NMJhScRWS25CsEUZOkmL+4ZoCFjEcB
	Mi1w2BNbmqNCUN2LCZCmtauskh5p2khSN8f5HMyVfsjyURsFkJuInMiOHGSpx6s2QeFMfJpx1XM
	D5Cn2aFOPQz21KjC7aMJvxQ2f61vW2UwXEvQf7LO+2NVwwd86vjdHNSOi9uc6H1NzF+EAqftR2o
	CSdnfoH6dLOtYvATW5ACffUS9dE0/g==
X-Received: by 2002:a05:6a00:bd0b:b0:845:e8b5:8c49 with SMTP id
 d2e1a72fcca58-8479ee9a9a9mr2040137b3a.10.1782806955524; Tue, 30 Jun 2026
 01:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626173444.2252041-1-xmei5@asu.edu> <yu6l7zo4dmqcnho7thkf7sk42lt6xkz6uxxwxmg73x23vihlnp@pe7vdut4o2jc>
 <CAPpSM+Qwmv_wsNFnEjtk3GbLdZB_JtH5vW0v-Cj-CyiE8M_UEw@mail.gmail.com> <20260630071257.GQ1181229@noisy.programming.kicks-ass.net>
In-Reply-To: <20260630071257.GQ1181229@noisy.programming.kicks-ass.net>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 01:09:04 -0700
X-Gm-Features: AVVi8CdBvYa65GaG_aiHMGG_wGQ7SXzFa_rmBeFZe4-w9ahKm8Oy_NU9CMHCKu0
Message-ID: <CAPpSM+Q3nZTULXxRM8_6QzfF0BBDLEWOcLF16cciuFzS1aodCQ@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:13=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Jun 26, 2026 at 10:48:46AM -0700, Xiang Mei wrote:
>
> > >   - The displacement is attacker-chosen (via the immediates) up to 0x=
100ff,
> > >     so the pivot can clear any guard narrower than that in one step.
> > >   - ENTER is reachable as a gadget, so a pivot of this size is availa=
ble
> > >     without depending on register state at the hijack site.
> > >   - The pivot happens after the control transfer, so it is not constr=
ained
> > >     by forward-edge CFI (kCFI / FineIBT).
>
> > Please ignore this line; it is not related since we assume we already
> > have a CFH primitive. Sorry for the confusion.
>
> So I am still confused by all this. CFI does remove a ton of CFH
> primitives. Until we have Shadow Stacks sorted, ROP will obviously be
> the main alternative, but I'm really struggling to justify adding 16
> guard pages rather than going after any actual control flow hijacking
> primitives.

Sorry for my wrong information. This is not related to CFI. I'll remove it.

We assume we have a CFHP (control flow hijacking primitive), and ENTER
gadgets escalate the CFHP to ROP execution.

>
> I mean, if you have a reliable CFH, we should be fixing that. But
> somehow I'm thinking that if you do have one, ENTER isn't going to be
> the worst of it.
>
> Or am I missing something here?

You are totally correct. ENTER only works when we have CFH. It works
as a stable one-gadget primitive escalation (from CFH to Arbitrary
Code Execution), and we propose this patch as a hardening feature.
Sorry for the misunderstanding because of my mistake.

Xiang
