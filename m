Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158D22422A
	for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878941; cv=none; b=AE8m7QbgmKmEBgt/3uA+Lx8XNUNYvvx1qV2NrDpR+3Q/avGppATdyT6q+bGXRSKkna0o7z4ELJUpIysDf0UUZqx+XYVGKsym0dGQgIvrYtPyNyoZkv4Ip8TLBiHffWTwr7aP+lLp9+LE8S1CLsUFEzaFlFKU5bbjq31uTqlSHgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878941; c=relaxed/simple;
	bh=j5a0DZ468QzMrvyF4TXu1R8DhWG08C4AbgOqB1No9Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlJtPMceYip0oWHpArlimEIuZ3h9TkFinCiWgKCo2Met67oQoaen09xFoNHrOrinSgHuWezPNejQMyvJ7vR5TF7YJ4HTBbkCsRKgSCGCd7cRuL+l3bbADagkeP6+ilt6xjX1p1uvsA54Ri9Vm/hueTNcbOX53HOfTcvj/HSl5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IQqOd8jb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQqOd8jb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23aeac7d77aso22350775ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752878938; x=1753483738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCekbMSEmyxIAVzfncRaEHsXG0dam6IEJBqPkNUa8Bk=;
        b=IQqOd8jbGkWpS5jXLTybWKrxG+S/FfLWQdKskC4kilDEoAPanQFX1ysI9doii4Nnki
         p5rk/hYUQEGegotwFpoAeXU9RlYW22EfGQZRAzMN1Vx8PPW4rNZ0oaFaQgTU9J+AYgWB
         XKl76gunpWV9ABpsmeOOHZZecWpGsd9RrnlJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878938; x=1753483738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCekbMSEmyxIAVzfncRaEHsXG0dam6IEJBqPkNUa8Bk=;
        b=rPGwxiYWatb+eXRxaSNX83+RZUw92+Ufppy2nTq1e1X8KfdzcNeyM7erKVk4CYWZS9
         cS5gOi/XqXk0EAGoJVMnfbCmiQdyzmY857VK3jdQU0qua7ONhIJeUo14tj0j3U2hoa/k
         YRxZHBq6YH6AjDRSQkFCZLwEivQjE+VFhMz3lZ1JAu8WAhfGeIHmXcN0taa9N1FV1/gV
         uGpo4zsorhtYcAlUWeqRCrU8z5A/NREydRygSVpExHCSP1HfVPipG5wKW4o6dySk1Zlj
         50XlEWyb4WnBUJn+sD9GUqXTSX1e1anbJl8e0uD658p1ZBuiPq8SsG827ErPBOz//W6w
         rV/A==
X-Forwarded-Encrypted: i=1; AJvYcCUoxNPmVFJeAr0E/zQ5MmcKHh7L77l3E3XSzOFXk1MWLHKEh1BQ2sVMUZ3ihkxmAd5fH/XcEsGmJTd5BXauMz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1xYFFUZXb6y+SgvByoM2XMXY/h4Zc2eDCb3LlN4min7f2JRh
	iMXb7TPe/Kg3fKaGWJLyiP15+I7vwEyj7ECnZoS9KkWYe9yq6zLhXn8Ctp+uswxxCZt4wR/if98
	fvtU=
X-Gm-Gg: ASbGncuPhQudgxNj+H9K4fo2LATdkatgrp6xYrAZxqv0ro7tvaMuXLjllOxFWE+lDCD
	NWZ70PybGquoST0ZPQji9GHCNk3/n+xKZX3UIaEN+5T+uQsxJjB3g2aA+lEht2hjTLIDOmwHhGu
	EGquLjXh04Z3OY8ZKsMEs7Wf3t4xMYSJG3kLi4iHmwKRvdVDZu5/FlT1l7b33sbpqXRLEeRlxjj
	e4VwuTJA8npegAWWxW4FtRFJN9WAMH2X61YOGALHJAUhkp7/lLNrqtdlU64E2LfIlCjbs9iJ++O
	88RrhzZnJRuHwHikyxYIP9Pm72cQlJUOgcLiCsST0iww8HVrFsUlX1PYrbJ5nYZJ4ucOCC4DIna
	nnrERJcGkePD2AzyWre3+/ac3yvTf4vztCqwlpYbhgxKKsJrojdRuYw/Msz8IVw==
X-Google-Smtp-Source: AGHT+IH50bdneQAhOHNW82KEl0fvb2GCqntGEeHaOQSYtUMbatw9WL481UCSKB3TKlaUHbXLFoYiwQ==
X-Received: by 2002:a17:903:182:b0:237:e696:3d56 with SMTP id d9443c01a7336-23e24fbef08mr190398005ad.32.1752878937780;
        Fri, 18 Jul 2025 15:48:57 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3bdfe68csm18162095ad.183.2025.07.18.15.48.56
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:48:56 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso2297123a91.0
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 15:48:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+F3XmpFMxo863W/eppZYwByXS+XUkn03vhG77HS2gV1Bia3/CWdF0XSY3TES1FGxMjeap24IyC64jAK2snJM=@vger.kernel.org
X-Received: by 2002:a17:90b:5307:b0:311:baa0:89ca with SMTP id
 98e67ed59e1d1-31c9e79bc53mr17025524a91.34.1752878935739; Fri, 18 Jul 2025
 15:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213725.348363-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718213725.348363-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 15:48:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com>
X-Gm-Features: Ac12FXxufG3DdfXgWkFesZeMyd_2GFfXRNaPb_AZ2xn1G3aBVcusp6YGrWqqY7c
Message-ID: <CAD=FV=W1tgwvajXD6mcggHKy=Q7EN8wLx4nSJgy0NJBzHLBnSg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhang Heng <zhangheng@kylinos.cn>, 
	linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 18, 2025 at 2:40=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_support.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

nit: Since this only covers things in the file `kdb_support.c` and not
everything in kernel/debug/kdb, perhaps that should be in the subject
line? Maybe "kdb: Replace deprecated strcpy() with strscpy() in
kdb_strdup()"?

Other than that, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
