Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADF1FCFF8
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268356; cv=none; b=H0aWEKeS7bL3FbaGz+krP+ul4/3NZj5abBvkBM1hOPMTYFUqX2/DMC3j8YVNI2QcdqWqwkxRuX4jCxXc+RgXfDCRpUtTz+cAnCDgOhxeiSalRwkkeoWY2J1HhYF84iarq0H6L1tN3Lbl1FPYS5q2MKwqLnlwKWgByViSHCKGLJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268356; c=relaxed/simple;
	bh=O0MP8KZwZzoCuMItUb5xHUP4lzs/O8K3Xj0FuWpVb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgOum94fJJFNuDc2wbtD1w/wxqZ3Niq5HHafedReC+f7bV9m2Iw/iZqv0ejuujNLgMQayob2PG2q5D+Xzl6qeeoSroToiBnp+nzYWC0hrjIQ2WYXV7/KlySEj12CH/uyb1uuufk2xJbb6fNOyAIK6CaiSpdFcqgZFThTSMxKI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jgjuMlIo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jgjuMlIo"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b097037so10871495e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755268352; x=1755873152; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8FXQf+9ghxPzhtvwrtvyY02+a0FGz0lPsLgvTccoTfc=;
        b=jgjuMlIopCNE4eHRfW5bWZ7IzKi5/8hjWx5REXm/5ha20PNbMxLwutj9GkW2phl9bT
         Wg+0pKnEcWq2qoouyGbQ75RJEZZiv1M5oDdZrDd7Jl/oPFin+P/rQquvt1131w1z8nDK
         Vkp5Cn+gcGFsoiNZHRMkSo3nGSAj+ZS3RZBELtTOVOeGNmzUk5CcKIeoUUF7emvJiSsI
         2sk6suB+wX5IQpXFKJADYbvl5Cut03v3soLiNO7/qCI8SeZHYhMP+WAuz3cVdXdKcXhp
         Cp8E4yoIDXGJDQz0uiaRqFwSnJ2yPENUInFEzOp7Qw5Xm+9rNy8ctOXu0KxASRpMXIo/
         kOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268352; x=1755873152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FXQf+9ghxPzhtvwrtvyY02+a0FGz0lPsLgvTccoTfc=;
        b=c6U1Q43WhVsVpN/WVms0lVB81HXF83hSPdv+e+tjZiWLTMsesRHYd1/xHS0so092GJ
         1ucjQr19UNzCRJjOveodD0vwgbvczHNhPir3C1i4aXXniUFs4Y4HqnMQI1HN96xyDqQ5
         JEYVGY+gCWGzzHL/CwFHHog30XKIhmxjD8iuQG09YLb7HhgNaMZCpcl2qhJ3Pc0uz5pI
         7Fv8s3GeRlVTVnJjHpqruvDEzFRV/qxrxe6mqbTcKzSAosMyqcD8tedW0V0z2Cr0Mxi+
         f8G7EKALSZDZXY3cQrXZzHiyQS1AiI1142uQVGOrlA17wYNIMONewLz/3JxqQcwG4JNc
         iQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEX0PnTF6DlXK62oTlFz4zS3bYUPbMaxinbn3AQKW1h0Cnk7gSvv6Tbn/WiTJJgx2Hy2uIx5jgVb0G6wHRTgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYClwz6usSbDdJeUQwmSL+dOv5tFtKFe3HBr7PVt4/xGUdUF1
	E7udXj8kmHMVnN2HaO629kvUigcsYBuXerj5TevF66CBuV4zMf0p6NCxk8mKeVaytpA=
X-Gm-Gg: ASbGncss0IsojzA1gOvoYa3gk+BN0rtFSQk5yQSduxFy2a7r1ZjWMrBS5+CqNo3JnK1
	k8Mfr02TVhceM0zkdxuK3SPoTT+gkOuBWaCz2aWeFqkQGSDClE1u+S++KnpBWwfKGAwq7i4oSDa
	YUvrWo4A8HNsavPr/FQ52Bm7Y5R/V5qAk0nzAxcFFQFTPLar/TjQ6vnQHupwc6d8FrHGbPotAUE
	VWE/+3HTggEyfxpUAxZB5gtZGNuJPk1VdJT37q4DQLGiVTMLcGZLesl5gyObxEyFZQdntT40W/+
	nMgQGLwppKgWiMagfzQ8MFm57ER4vOCo9PXi/DN3lW3kYWbAionjINQ8JaFgL0H7seu2+KFRG1A
	mdglJH5AIAgTLULsBNqmnyqRx2DQriCqwSb4N56ASlUZ5Wxoibnu6xwWivm0idME/eYT22aJ98O
	G7i5XvjA==
X-Google-Smtp-Source: AGHT+IHnSLhDMqXcwx68Y9138TqJ+c1Cuo3gefZ8a2Oj1eAADjXvGhxdolw2Wdfb2t12ox2676R9IQ==
X-Received: by 2002:a05:600c:45c9:b0:459:dde3:1a27 with SMTP id 5b1f17b1804b1-45a2182f2d2mr19947185e9.26.1755268352274;
        Fri, 15 Aug 2025 07:32:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74ad27sm64461825e9.18.2025.08.15.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:32:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:32:29 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Replace deprecated strcpy() with memmove() in
 vkdb_printf()
Message-ID: <aJ9E_W4Z0n7EzjUw@aspen.lan>
References: <20250812132621.119641-3-thorsten.blum@linux.dev>
 <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>

On Tue, Aug 12, 2025 at 09:24:55AM -0700, Doug Anderson wrote:
> Hi,
>
> On Tue, Aug 12, 2025 at 6:27 AM Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > strcpy() is deprecated and its behavior is undefined when the source and
> > destination buffers overlap. Use memmove() instead to avoid any
> > undefined behavior.
> >
> > Adjust comments for clarity.
> >
> > Link: https://github.com/KSPP/linux/issues/88
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Changes in v2:
> > - Use memmove() because of strcpy()'s undefined behavior with
> >   overlapping buffers as suggested by Doug Anderson
> > - Compile-tested only
> > - Link to v1: https://lore.kernel.org/lkml/20250811170351.68985-1-thorsten.blum@linux.dev/
> > ---
> >  kernel/debug/kdb/kdb_io.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Much nicer, thank you!
>
> Given that the old code was officially relying on undefined behavior
> of strcpy() before, I'd personally even add:
>
> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
>
> In any case:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

LGTM... and I agree that this is bug rather than a clean up so am
waiting to hear back on the Fixes: .


Daniel


PS Feel free to roll all three kdb patches discussed recently into a
   series so I can pull in one go ;-) .
