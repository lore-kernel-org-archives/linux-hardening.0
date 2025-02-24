Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B8200BB3
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438436; cv=none; b=n5wfjqjXIDynFHpxgGnGdNWstg/cLpauOlMklrSK0DtsrUfIXqEXafhoi6W7Ih0PuYeg7jSnYZ8VJ7EXuA5l/3pZpqXUvEZg/4dzHLWx6mbpZG7DBsKNUCQsly0DoXxOtZ5AYR4WKuK1NSdG2S5+ntAwRxRyORLD81H7mnPCJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438436; c=relaxed/simple;
	bh=FYfFMWiTzduSPtbvpZ0Pkv9pDjTpRTObNnikiDKwKYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pc61jMjgSOmykWBtJpNRMB7YDzyGHySy5LpKriiaX6JITRwX1UqFVE8s0L+2ai/YaDU3qjJoRHCbxVKP0qcVv9V02bzGmrlU5kExNUfTzS+Z6K401kZPE2z1Xr1e3KeccmZW65FFom+PEpzOhgTI2JwPMcj8JU+NEBV8POf1X0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IwU1ezg9; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwU1ezg9"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7273be6e79eso691375a34.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740438433; x=1741043233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt7M2cm9mI5eYr0nERX+qOY3z3eWRP2n3iQJDxTpkO4=;
        b=IwU1ezg9yFX8REbX70AWUvgJLlfygynQGT9OQl3mQmsKmY1Z8wfb42p6S2T5nG/1CZ
         Mx0MImm5cfkZedJfbk2PKz7F4FL6QRgZQX6H4vJZcb1do0WegnUkjAiDDaYU3q89mIG2
         568cdQ59KLnakjdjCWTPqJJk2vG+/NxOK9NkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740438433; x=1741043233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt7M2cm9mI5eYr0nERX+qOY3z3eWRP2n3iQJDxTpkO4=;
        b=XQHnaMW0AjThV9GtGILWohX7H3WmAB0sDeRAYNxgiKoqiPq7CxPIWuNiy/jp7EGXzn
         7jfJVhb5b1eAWbxjeaqkNJRK0ERvtsMpaXKzDrVG4LBTqvenPK3+abpZBMFHwXRc0iFM
         UtyLRwCC2fGnNJD8TuRCDMyLehHGf67t1i+F+H53Vgfb7KRD6G8tNF6hBWooR6OGKLkx
         Mj1Yp3pWVHlM3FPGFnP2JH/VrfzZwxjgg8eXwy4INNcX3+5C81Ik6A5Ak0G1/5J+qHlT
         agRgRw/hFb/za1qQqALPWGsb9OFljMRJx/m9n+lucluY87QKIPFKbZNkHgJbEt0eYKWO
         DBxA==
X-Forwarded-Encrypted: i=1; AJvYcCVRPdYrMnNuzIQ+/wsiYhCSv2m5NP3TPnERK2UfwPkO7lL3Q+WMZ72vg3yvXKC9FwXeOvtCg87byoQ4xTWe/x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBqZDJOTMDU3KTc2bSuMHKCLmxUN2z36WpZT7zZYhD2ud71Gf
	lcPUNRB0XuL6187V9hoEfY+IWMhUY1CBxDs1HkHMUzUReek6ybl7PXR7wmzWZ+T3/yfKLkvcxS1
	jntILXGQySpoMqouEg2D+bZQSc3Kada31lCEg
X-Gm-Gg: ASbGncvazc7mpSFaOZe1Rosqzp5mUEq7sYmdYNjdgEbEQp2hr395ZzhUdHpsX0tkphI
	hUwSWUuOj+qA2Ujc4v1pVpzxwlpDSxf1IXJcwmbr8d0hRiU/owOmq6o3a/81PvtH3aOcFvKw19n
	3VAir+tpWAf7KIFQkEGERsPre0uCrZC1I62Buh
X-Google-Smtp-Source: AGHT+IEP4PV9DNBhdrXRh+chy4n1/lVYXwdesM2YhvWLjUuJsbctZ76XazgP1D4104ECH40KdG2B3ht8gtQ3Gkm0fcM=
X-Received: by 2002:a05:6808:191e:b0:3f4:23ea:f9b9 with SMTP id
 5614622812f47-3f4246b3c3fmr4357094b6e.1.1740438433475; Mon, 24 Feb 2025
 15:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <CAKbZUD03mBKVfOTQ4me79bZTLgWP8QLyD1PSxTcpw2YPmtsyUQ@mail.gmail.com>
In-Reply-To: <CAKbZUD03mBKVfOTQ4me79bZTLgWP8QLyD1PSxTcpw2YPmtsyUQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 15:07:03 -0800
X-Gm-Features: AWEUYZlNlJhjCemXFyWfsLbYFok5NAL1CEToK9WkF-XdBylNHUu_GFihHhpgA0Q
Message-ID: <CABi2SkUaUMTS06mKm5_k7m=NpfyDR=L45xqp1i+FkvPJHT4-TQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 3:03=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Mon, Feb 24, 2025 at 10:52=E2=80=AFPM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This is V7 version, addressing comments from V6, without code logic
> > change.
> >
> > --------------------------------------------------
> >
> > History:
> > V7:
> >  - Remove cover letter from the first patch (Liam R. Howlett)
> >  - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
> >  - logging and fclose() in selftest (Liam R. Howlett)
>
> Jeff, please don't send out new versions of the patchset that quickly.
> We were having a discussion on v5, you sent v6 today (acceptable) and
> now v7 (while changing barely anything of note). It's hard to track
> things this way, and you're just flooding a bunch of mailboxes.
>
Ah, I apologize. Sure.

-Jeff


> Thanks,
> Pedro
