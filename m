Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DB4430;
	Mon, 24 Feb 2025 23:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740438235; cv=none; b=fg/sbgIA/QxSJGtXchEXnu/0sYiwG6AZNeOJQdhSdWDnla4e8OJA+CoqCbm4z796Rmw3UmxuFnOkgCnQKM5fXtc2meFw/dgM53j2aRlVNTL46A0eZ5zxd0I3nGMF/Dv23WBH0s9dNsprWr/WcD1ED0Vbze2mMQReEqUv7JJWSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740438235; c=relaxed/simple;
	bh=UCYFzGm+oqa/rIw4z8gdcEA1xM4+kNzpmdFLMuhTSws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuhJ0BNFRQmW9KX3PbtJVGHYylPr/CjBVFnFiWAUdHlx5avLk8Mj2+513a2645BKYi4l8aU/NZhj1nso+8h/yg/myRgj53FCeWBQKjRxx4c5tHv6Ao4OQT5+FXmok+0tPXODY3Q/3ktj41Q1Q3W3408pNPivsHLbJd24URK/ClU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPbAqyi2; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPbAqyi2"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-867129fdb0aso3077584241.1;
        Mon, 24 Feb 2025 15:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740438232; x=1741043032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZG5uCncxJc27nMcC6EtrucfyR8M9UbZtxPaabTQt7c=;
        b=aPbAqyi2n6sGB5EbKaZ6YNlFImDPYxdfc6Aon0GxllvPIGTKp+BEMT3FNeBwG5ttVN
         HMfIjEO6MEcuruxOj3v2A7JAZG4PHOGpADa65ssuilpgQFg7kEQmoSQwg5EKv9IW7xoa
         hqwiHOb2A4ETggYCbGLrWPJLrDsY88wXSZiBdB0QdQ2qwzgXd/+Sq/FXr1eThsY+TVNl
         bCynGZJDOkTE9si3CtSroSwvEmmZ1kGATAa866i8NQtL+dgnlHdao0zi876qFsPcXdpl
         OEa8bW7Mp4PVMvDH2N5eaNJXD2lQI25oSUAHkW79LMyRY/ynZNYaPpso7n3pcZhE4bu+
         8lVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740438232; x=1741043032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZG5uCncxJc27nMcC6EtrucfyR8M9UbZtxPaabTQt7c=;
        b=PrHOSXOr8YaH7bu5FRsyo1KdbaGK8tqHEBDYT0PewiAYFxKmVR8TVyD451xkn+Aa2u
         LqIqY8V1XMzB4iaYAi4m5UMpxVC6CxvdPzrxkqUvUKSwpKOjUBA+Fuosu4EW/I6LrnuR
         0+1C8K0RaTJ7zuCydmkRpIIydOX+izVR6Ul0b1v3/h7vIrqKZunlRUUXhIIHgs2WwcWu
         l5ne7s179wIoCBDAKBNquA2eU3NUJpHfdqWx/AkM+boCY8sKJBJP4u25tCpPgWC8R57n
         n+r/nbY1HGP3FyLdmsKCeSS9Ya6PZ68tDpn5hKlpWKF9lyFyo8GIgWpDcJnqYxhj7ncy
         u3qg==
X-Forwarded-Encrypted: i=1; AJvYcCXmjXPSzqeFUOgvzCRWWrXOOXULGPOn6Ona1fPaRsUMlVzhtWCwpKDr27nDPfOSHxycs/HhuOumF625Uthiauo=@vger.kernel.org, AJvYcCXwIfsBOJFdUobYmkO8UZ6m7FL63nusiblj/jBoOXtDgbwHov/teffSIW5p0eblpOHlfelsgZZVtIfT9CQD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6osQBFjBRao3I1S7WKXvpJ3gG+Yc3eAkdMhGTfx3xKpEXpjo
	aRWz/tKD/QEqqBcWQkd/FiEKmEBzGQEu0W1V6vzryUGjZcG1ez9t0j8JbPwJxrer1430KRGV19p
	L5+qK/WjIhswYWrj4UUt0xKYc0to=
X-Gm-Gg: ASbGncvspQxDSiMCmM2wfj3vUDfWhirZsV1YnloEGVgebdnXrWF/XtVuAbX7sOxXF1N
	y++3kMgYRlVUqT/fRqnByj7agpVuYzk1xBjGoPgFqLfMOmrCIC2rwxA/uHiVt2716G/nlznAQN9
	YGYdTDcfy5A4ozp1qPlvbp3Mlxvt80HokNJ22if7s=
X-Google-Smtp-Source: AGHT+IHwFLoPqTHbhsyr/5IxvvXCSWguuLxPn+rRnxIMd+GxUkwJYAvq04NjximczYdwl7AwSCcc8Wi0HulShHapW2M=
X-Received: by 2002:a05:6122:860c:b0:522:1d6f:2b4d with SMTP id
 71dfb90a1353d-5221d6f4d8amr2294272e0c.1.1740438231840; Mon, 24 Feb 2025
 15:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com>
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Mon, 24 Feb 2025 23:03:40 +0000
X-Gm-Features: AQ5f1JrmtS13tninAaio6tk2UjHNtEXTrRqx2P0eeUq0Gzh4fLbp0C95ziuJk8I
Message-ID: <CAKbZUD03mBKVfOTQ4me79bZTLgWP8QLyD1PSxTcpw2YPmtsyUQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: jeffxu@chromium.org
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

On Mon, Feb 24, 2025 at 10:52=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> This is V7 version, addressing comments from V6, without code logic
> change.
>
> --------------------------------------------------
>
> History:
> V7:
>  - Remove cover letter from the first patch (Liam R. Howlett)
>  - Change macro name to VM_SEALED_SYSMAP (Liam R. Howlett)
>  - logging and fclose() in selftest (Liam R. Howlett)

Jeff, please don't send out new versions of the patchset that quickly.
We were having a discussion on v5, you sent v6 today (acceptable) and
now v7 (while changing barely anything of note). It's hard to track
things this way, and you're just flooding a bunch of mailboxes.

Thanks,
Pedro
