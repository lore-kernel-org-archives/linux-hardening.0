Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F312224247;
	Wed, 16 Apr 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829053; cv=none; b=cbBr/ZiREarrXJU/bh4Bd+j6MolNleWU3RdccUu+vubEWRh8YpdjgBxNuYooRVe+XZbAnOpCg7mlfBB5DLLZqV+vkCI3IKJUAKWWCbzCJ6kj2E4a9EG7QXssdoT93Ch6X+rMEn4kDhefl0IMLRppKGXUGGQM5mah3ZJONvdWCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829053; c=relaxed/simple;
	bh=xvCR5iVQAHk4Tvf6E441jur/WH6gyOI6MT643z7GMqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4dg7auKh4EoKZNgl/CzJrxzBR5JsULH8+nKTbMOVi6Op0BPqRiO39wW51t/c52Cj5e+gvYAgwTCKz3QGvvPMHABqTCO85TxiB97lOFWAZ+Hw0cT2lpheAoRKkAmdtsBP/x7/hGTpVl5Hd46f68C/EztTsZJQCFI4ApheQFpDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuBItzEF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuBItzEF"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30363975406so1202904a91.0;
        Wed, 16 Apr 2025 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744829052; x=1745433852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvCR5iVQAHk4Tvf6E441jur/WH6gyOI6MT643z7GMqk=;
        b=DuBItzEFnDaNxw8JNIymWVsq9btlOCv34kjSRm5HolhbgQfPgYb2qbF4fHLOeEDYDy
         i6YNURG1agTYMmgWJ+9UYHiTnaOmt6L7XM9ITYmJ6AOOj/44Rux7cENUNcgJR1P9Pmx/
         eAXCSuftmWUrnyfrX3+IF+J7qhu+VeADIaj/2ujJF4vdEAV4jwZz9BAYmPLqBMjICxtk
         4nDfAZApCLdp5sgbAyHc7HOBx4NAcTY+y7mUbQXhXAzI8q4o3K2rcFblVPI5f9a35tjH
         djpSDe7JBJkFDCMdTnApDjajtinprnkujWIYi3CGTPzMuMbfZqVatju+0olo3zX7NoAR
         S82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744829052; x=1745433852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvCR5iVQAHk4Tvf6E441jur/WH6gyOI6MT643z7GMqk=;
        b=sabzUTTlDrVtAUhivm2J6n2BXP91B8NsoegHuXbleeu3rypU73tU6fADSdpcemSC4U
         eEADy9CeZ7aCnuEpwuNEUYA9ZKHHfmm0CqIlt5/P6BJBN0P/I+Y0jqBDUoZVDmXSZmW9
         cBSGxAHniwjVchNcsXbDTJGhA8wKl9VI3Yk+ZoieI1LTmkgcYT//zkoCtMB8zOAXH0ZL
         TV6jml9HYoc/B9sRDT+yPBH4DBtBNN1BBnMJH0/U/6Ux0bzNIx2rGs0z34mUiGZDWaTH
         98W6hG0sRoDPGaQcZnQKgB0YNqaNk/1hxtr4MQoYTGHiovETYlAMqv1EJ3Zxs5bSyigW
         /6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKJ6iAWVlbUJlDBWSHw2rtj/qc++oY6FXs9LDsbOsQyW/fcvAHXMOuquipWnU28QEZ0PdGTB+DqQjWiMpo@vger.kernel.org, AJvYcCWWsx+OcFP+Ee7fiA/67kg6A+lYo8eI6Nju6m/g/6EEDp9rg7AmPYytAN6XvxYmtaQwD7na0WsRO+TS8ivsjQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/pCsHSq5PehBST09KKWEiTYYbd8aQtvjOaAfRvR4lVdEYCdx
	LFMO40dK5mtxWBIUXbj45JA367ehE8Z6fB/V34HGck3gkSFkkid2ja1yJcuLAs42CMgqUsynhiB
	+pDt1fUkpSL6i55lGuQKnlHKoXck=
X-Gm-Gg: ASbGncvkr/H4IL7KpVlELTzPX47ktws1OeATkHn1WMHUQWS9VYKGpBvo6KRpae2exQC
	q7BLcWdgmhgQ3tvUeufUV0joLUDn5g0AOyKOA32sX4cQzUPcEJrK6TRh0GlAl0kZAkh3KZsY3Rv
	78wpnQ8qhvuqdVKL7XycTY/Q==
X-Google-Smtp-Source: AGHT+IGz/z+KUxXc0G33wVCMhaj0SKBILS+bup38MKz4IGI65K2wAnc340DmtbFbjrtGqJWq1M1fbmkQ1lCjHd+vde4=
X-Received: by 2002:a17:90b:4a4f:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-3086eff3792mr78829a91.8.1744829051661; Wed, 16 Apr 2025
 11:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416172016.work.154-kees@kernel.org>
In-Reply-To: <20250416172016.work.154-kees@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 16 Apr 2025 20:43:58 +0200
X-Gm-Features: ATxdqUGibHpjNZ3ZNK7NgImsJdoOgHlkWudDRmL9Gskw_Ayg7Z7YSleG2ywgKQM
Message-ID: <CANiq72=2Y1NYVkEYR=Q5_HDbLu=P6KRsOzDKGw-8Zw6U-_KtYA@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Identify compiler versions for __builtin_dynamic_object_size
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Marco Elver <elver@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, llvm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Hendrik Farr <kernel@jfarr.cc>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:20=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Clarify when __builtin_dynamic_object_size() is available. All our
> supported Clang versions support it. GCC 12 and later support it. Link
> to documentation for both.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Looks good to me, thanks!

If you/someone is taking it through their tree:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
