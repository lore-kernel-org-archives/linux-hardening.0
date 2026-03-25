Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3AC3F0AB7
	for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455897; cv=none; b=mfx3x0r2aJ0NHC69IvdNWr4fa2e3Tu61LhtxvrZM4/wNn9ghWE7XACUk6BH25iLAOIIFhTDw/bfUx03T6DdeQMS0Sm5frhsTtcHaMlemPak46Kc2NEtRCxVScSc2bGapEu9Au2+dGPeYBQ9mGglUX5VdPRWifd4oDl34gi+yGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455897; c=relaxed/simple;
	bh=rmeZVPSOtvHKsudTVqrd29mAkraoSiHAZ4PP1RwACbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ob+rD467WdgACJO+yNwkFLaMFHLf6pES38KdGcVMDhg7FuHzJdT263NNgz0qMakx69WDEW08Up9LsfQJE3DFUdq+ePKWNmrYDAxaioVd2h529T96M8z/VFU13yEY9f/UYbhhekYr1gqpboTQ+KOu9hVX5CLplQB3XgrgV3bCOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-60328744754so1137666137.3
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 09:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455894; x=1775060694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gAXhHrpF27wFNXFA6QhJ48A7x34w2nxZZrvrXeYgHw=;
        b=P+VJaW7b3J+EwSOQjPjwqSclsei60m8QVeYIRz9f19XPKmFx9EeDzUoGppTmCC/kny
         ns1SyE2huUX57bHxcPvyaYYao2Zd1cmu/UMYTcb/8eodFDkf8mbLwTt9WhzGvnwiQxX3
         t5GhBVqpwoYVYdrvXQEPXyYM5krqOcICtHJV0dsh+RmVQxspAFxJiRnyx5KZrmhXYH1B
         GRgBHLvj35hd97PXLDg+8eq3vN1RI3ZtbCUWgvcvDl175PqKLGQYI4+ZTxbsHhdvlbFs
         6YkRq3g1evmpez/+jTrGqXbQPMdmTHS3EYiizbJiYYsePu7la1ybhTc6k3OHoGCy3J25
         n+jw==
X-Forwarded-Encrypted: i=1; AJvYcCWWctV55hCBuYsl3HyhFCt1eWQokMwdgfff+OxW5HEfsjq92GbDY4Pj79c8XEGNfIj1mi6hW0dRQdHEdcztWxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrXsItsM+RtImxOUrwoLXs5lHhVDF6HDGCY9VwgIUf+WCR8kT
	4O7iB4+vayPZ5YADZTIll8cldlGgoMWX1Hwp4evk+pAxVNcuHEcGaa5MnsX0jbqFufo=
X-Gm-Gg: ATEYQzxoRJ7PzKyLgGSu/hqMnuESIxFtNY7/i13m+5KS5wtUanuLrB2vyBvaK4i0QW+
	InyFMZL+a+3tM8c/EGCqiveBLmPxbebp1vYD9n+xKgsRBCowfU/db9s7igrUhmmPYfFei/fmIXe
	0mRRw3wxefF+NB91sQmCQt9HqkKNGgVmSlzcCXPLrjnfQ3pWrOLbi61TRTSPtKz7zgcu14s9AL0
	NwyvWAjzkuCXdycf81ksUlLDE3xGfVSkWUGhyhsqFQX5kcP6xg0D4xWyjFCgGATDY1TXUa1/2LH
	m2vSTOOehbbYpFoN21hBQsFufqCyPRx/edUQmbT4mro5fNliuR8fPdV38DTgVhMyvrZbVp/V3Iy
	/yR8HVmNaLbaMNgFM+GwYzW1JbOoL8rmj+QT8kd60i826kCJqRI6aQ34490PkNZ4og8uBfz+Bh8
	MNtTAIOsi1WeOLU4YiyVUd4SnC4DUoA9liGvrUflJQ14b2h+5/vmeJsgcEqb2wxdr5
X-Received: by 2002:a05:6102:ccc:b0:602:b370:7814 with SMTP id ada2fe7eead31-6037903055emr2267531137.7.1774455894167;
        Wed, 25 Mar 2026 09:24:54 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951be5af7b0sm462145241.11.2026.03.25.09.24.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:24:52 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56cf45deb45so68906e0c.2
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 09:24:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUplqJKBKaqLVoOgBLMnJHyyv0P1pB7KcInFhCSB6TdWt8cXirpFAK08+LHGCaQ4b3NEUJoh0dNMBc/o5JkPp8=@vger.kernel.org
X-Received: by 2002:a05:6123:4c:b0:56b:a534:42c0 with SMTP id
 71dfb90a1353d-56d220ef9f1mr2094685e0c.15.1774455891759; Wed, 25 Mar 2026
 09:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324021103.13651-1-rosenp@gmail.com>
In-Reply-To: <20260324021103.13651-1-rosenp@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 17:24:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV6tBG7zQX_eGuLnvp1he1kQxTxj+8QmYj=jbo2OTGbMg@mail.gmail.com>
X-Gm-Features: AQROBzCGGCNDC4VvyRbtehsEECFBYE5hrIOwkI-_9A4YzO91h6FhBZCpQfgFjIE
Message-ID: <CAMuHMdV6tBG7zQX_eGuLnvp1he1kQxTxj+8QmYj=jbo2OTGbMg@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: cpg-mssr: use struct_size
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:RENESAS CLOCK DRIVERS" <linux-renesas-soc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 03:11, Rosen Penev <rosenp@gmail.com> wrote:
> struct_size is what is normally used when a flexible array member is
> present to avoid accidental mistakes. pm_size is still needed for the
> memcpy call below.
>
> Added __counted_by for extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

FTR, no changes in generated  code.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
