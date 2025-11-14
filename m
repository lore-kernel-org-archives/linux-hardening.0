Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54C326934
	for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763130672; cv=none; b=qlc9mPja0rwT04DM0L8lxSL55M6fBuJ07Bdyv/V6GY2odCmSGW1PdNADhKFCyZxbLg/BR+qBJZ0PZuPGj9gceWMjWbWca9vpeJOWgTsQrlSQ7UWssUYQv1fW8qs5QMOjJs5+1IBrC4pKEn1NimTQsWGIGX+HyQqE47JLVGsh+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763130672; c=relaxed/simple;
	bh=0Nd/5UcvGGQ3wMP5hcatUCUy3cHNlcIa0pLV8mrh2PI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVVwRZzDmXLJ1EB66E6sDgo9lcluYrUgU5NOGwycxviAjp9Q7KGazZY3Lh1W1vOswWa1bCwwNGsERf4jEP/DGTj0miREaL4BQ2BUPWzck1IkcWI7Z9wlKh5BKUV0782WP3O4hMqKVI2J2b2YsCsVUVCfCEMlVJ4Jwimx61zFT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvLIYH1o; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvLIYH1o"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47789cd2083so15579035e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763130669; x=1763735469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6MM5TkUOF6yH5fMK7JZqRWlPSfFjm0LYdpGBKMINJc=;
        b=bvLIYH1o1IpNbLxVqQ6aKlD4aKiTsEHoZcqbtHJlN62d/tsdq3D/pHySBHF5h9P/XI
         bmdrO2y30oLWn02fNg8A5qRtfd/oMOy+f7qXKetyTRHwDFNJm0OBzc81uE5vUE6BVP8/
         WngbtDT3ygRygnxn8DG0aL22SXE+umYDi+B64iPwpXdczMpGoLXZsN3kLULNkvhUJJ1k
         JQ7lmv7zMJQsHjHwn1jq7Vc9HOnNTCOdfpHrSZ9GzqHtt52sY0LkVdWtMoXfZXP94A9X
         ELbJZ3lw5A0Q8chudyvVZaBCVsiMimU1f6bLSKIvMqdoM8YbeeO84NYFL9iXzLhUgqZu
         Vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763130669; x=1763735469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6MM5TkUOF6yH5fMK7JZqRWlPSfFjm0LYdpGBKMINJc=;
        b=HRbLUxeypAZzHpLu8saE3s/qXMZQEWrd1aNxZo207Qd6ZaaImDiZ3G2wAUD7GHy8Tw
         YZwfgeGdbzf9jYYHMwxh4Ndovp3IhIE15wJTAfgi3pVe+1LzRcfkdfpECgbB1UJbQzUj
         s7yd0BIcI1FsDfD1DTF1ZrlqvPxQfvhZdt8s/S8a2Sm9xeadA3dtUTDHUoDo7PLKLOLF
         FDis7Men93+uRBX4rTAgPzODyeN2RhJ4apGr71vYatV+cfx0aNwWPgDVsOgzE/M3/rj2
         Li3UI17vpBkBWFHXzMIqjjknpT+R6/dIJBfOZX9m4IKUeN6rHScdWp5Bo7niUfE3igNs
         kc8w==
X-Forwarded-Encrypted: i=1; AJvYcCUY2/mm8qcWKoO20VBjGn79jsghDHnNm0VaZ0DYE/8SwJ3CybwWQoXh3GXg0hGnRNgRPCivKVo6GLw7Wb5oJi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoZfjRD2gED+pPsWQT4dYx11RrxJBH+8FTKozl7En9xnd7gfdN
	SrLqbHQjz+g26M1aHk5MwvED687/XiAwvRvUlyyvzF2P7xuZhqPsBDfeEkQuRQ==
X-Gm-Gg: ASbGncuVnbCq5zXV9yM/T5DNkwwuzwhMLeVeH2ieIjxN8a87fLF154C48NKPPYkJD6z
	ZTAmOujbUNl89dZ05mG/t2ZYpjYa2PWYORQzUw3F4QtNH7WcCsckJpAQJXOdObPfYeeGS07aKVs
	U3S6KKsovjyBEWz43TNfrgSy4naDCQNqpp6oIrGnbUX0zcYVFDCGl4BpV0R5xJp6IhxvWUJVGr7
	VvaxzmhYl3c2HCTReHrbW5rc2sZyr4rmoNqNCqKTldNbrssnEKq6nFCS52O5QL6GOEemPGQWXmM
	w9BOu2MFSwSerohv4VuCVp6aG9YFIEfKjpNtAAt46PVchS4xa8O1gxP3wSvQkkYcGRdAcm6EZm1
	wkMHOtdizMpDdgLOfwxd4PBpxB1fqwHYcb15LzyAVbuUeRk5aaAoVxGifBlHf8x0S25vnOFjVOU
	75XnXSx6XXllSZ5DfVTB4ojncCPtj2eQrhoCf9rJ2EzIkHJ1iHKarb
X-Google-Smtp-Source: AGHT+IEHrDuoHFECjPf0CKJ/87IcJrAsvvtIb2nB8T6rg1oWoh16xlEJf+x0ICRT7Ao9WTxW06pbKQ==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr32213275e9.10.1763130668582;
        Fri, 14 Nov 2025 06:31:08 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47795268e0asm9388645e9.6.2025.11.14.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:31:08 -0800 (PST)
Date: Fri, 14 Nov 2025 14:31:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114143104.0d1aead3@pumpkin>
In-Reply-To: <20251114084346.6469edc0@gandalf.local.home>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 08:43:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Nov 2025 13:27:47 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > Add the __counted_by() compiler attribute to the flexible array member
> > 'entries' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  include/linux/unwind_deferred_types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > index 33b62ac25c86..d4b67f0116f3 100644
> > --- a/include/linux/unwind_deferred_types.h
> > +++ b/include/linux/unwind_deferred_types.h
> > @@ -5,7 +5,7 @@
> >  struct unwind_cache {
> >  	unsigned long		unwind_completed;
> >  	unsigned int		nr_entries;
> > -	unsigned long		entries[];
> > +	unsigned long		entries[] __counted_by(nr_entries);
> >  };
> >  
> >  /*  
> 
> Wrong!
> 
> I need to add a comment here that entries is not bound by nr_entries.
> 
>    https://lore.kernel.org/all/20250730093249.4833be14@gandalf.local.home/
> 
> Maybe this?:
> 
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index 33b62ac25c86..d05409bb14fa 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -5,7 +5,7 @@
>  struct unwind_cache {
>  	unsigned long		unwind_completed;

Does that need to be 'long' - 'int' would fit in the padding on 64bit.

>  	unsigned int		nr_entries;
> -	unsigned long		entries[];
> +	unsigned long		entries[]; /* Fixed size, not bound by nr_entries */
>  };

Perhaps it should be:
	unsigned long entries[ /* MAX_UNWIND_ENTRIES */ ];

    David

>  
>  /*
> 
> 
> 
> -- Steve
> 

