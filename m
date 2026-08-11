Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27403932F9
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462966; cv=pass; b=fzZJ2YQ6vwOpuxykB5aDeRbp9C0jLyWvrM/NEWFcY7AOg+Oe3Hvuaf8aSd+x8HQZkYFSjL17hM6SRYJrPvLjh+dUdNg6yM6B1sRB+gFVq9oT2Eb5WOlR1NCJirsYlJ3/LGz3qpM9kFNsO9E/uRVaH8LZft19T7z+LCqsRoYu3ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462966; c=relaxed/simple;
	bh=WK32yOxbLjB3jonpeVMeBQOLae3OsMqNjNC0RLtddE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWzUrNTmh71ok4TBwYVs/j7C+NMJLXNSBRt6zjQUvhW7BjoN5qe/BwiIe3e/tCSONAyUnj9KgeHAd2ZIB0Y84iICrhvrO++6kDQ6snOJASRMMrCOE/+rBA9nGhQAY80PcVoZXAr4ryNEYzxaTNgstwuZLkgi/DaeixV25oTS51o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNSZN/5N; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNSZN/5N"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cede6375caso119615ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 08:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786462964; cv=none;
        d=google.com; s=arc-20260327;
        b=e5trRKBt8rDQ187nzfhZcjd1z1g9DrqPT6z3V6zVcZQX3Pz3UQ9pVwVxGEwjPW7rja
         G0a3d/UnmmULlnYYEKfcjlF1sUAu8NJkEZl7cI5N8HlYmKtUOfZJ3Q4GsCteKSVKkPUF
         iDHhmXAtEtPPxg8gkC0llfwSvFD0MKddfhoz9UMhe4tXoc3AbvRGYcDOtiOQgnA17UzQ
         ppoIO5O9+xuFxRGQHx2GeNsWNvD49h9Yyvq9G6Azz8FzwvUGr+rVqDAyL6GhGetN1xnP
         RTxWfSDasZeK3nfGEfSiLJn/ywhhtEPRGGskCGGIpo/vtqMMA8xWzJAu2PI9fBrGR6G+
         WZlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67yVZg7Sclh/kMsuis6FMTvEKCWItPaYWqtUQHP9qvk=;
        fh=S0YZ9vI1R7ubFLzh+N6mwIC+TdusYvyIN4Ow3a8h5BQ=;
        b=r/fM47S+iJjRpjjWTRkImzkA0AlKN/6rMktKMm8PLbFATQsG5TD0r5K1Zaiwyf7EUg
         yP2s6nTZQzgc72+O5IjL9gIbWLpWUawXM+h5z3BCD07GS+SBhJvJsEum3xfD7ET4FeH0
         jDT50kiXOTRfiEFiAeQeLWu9pmd0FXV8kMAa80fO4k5ksbhfCcqmED4RhFFzmgWOdqlo
         pFxzDOdQyf0Tl3jXB2CHjiJR9cCp2XC2c163Q6Km+Pia21jSXaVlnsriT40XNyrJw0mD
         07xUcIwzcvWxa6Xb2kxBbP2jzbte1//r85KMQ4XT00ZXKurExhwuBH/NzlcqEdY/jtsr
         KDKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786462964; x=1787067764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67yVZg7Sclh/kMsuis6FMTvEKCWItPaYWqtUQHP9qvk=;
        b=YNSZN/5NgJw/z7Zg9J+BLKVbyKRLOi/wmAfe4JhctaHZ1Yrtzl5zRZN3SKmhCZMw8D
         smM7gz6x7gm75Bh37Jm54ZW3dBvkOOcXdZrjhjUkOoekA4WUt2fKd5vmhsd+N6iZ+jCU
         rKJU+5ix9tDW93HGrdh/qrcb977Y2xeGKhi3MsEq+6qYMnJUcBTLNcc7M7SiZW50gjUR
         mvrXz84TwDnpAoZeKZCKntAVyf3ToUGerdNw+xDf6GI9Kz78iKX72LXPoAHnKfLoBkLy
         K2aFn7IGRWhhKOFOc1I4G8IOy4sfiGT4sqKiQq87jh5+ibu3DuW/JRk9dob39T3whGYh
         6g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462964; x=1787067764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67yVZg7Sclh/kMsuis6FMTvEKCWItPaYWqtUQHP9qvk=;
        b=Wvomo6//i9PCYEDuwSJtVUN11S1D3rii7oLnr1PFeULkHrDnFE494s9mBPvbp0JENK
         k6NImht1bvvo3xamq+48VSMMPJNLim9k15U8MF48P5XTdeQgVlJ4AZCrH8bnf57eoiwe
         bX8OYopLEuSLxuLBQBSXh2zg+lhva5Tnz6sNZAIfde+8IhQNFSs61wviifyt7Vb0YN3E
         kcNqnDJSBvIgEu9myPwKJayEGo/zX+evwHKi6pzbhU5cF/cFKwXuIVJt61Pd2NM8JWVl
         6KPPwAMo0NYVUn+P5LziRDYGRFGcajplFqrjFCdSs4cdcJFtTBSeKj/ctL9T7Xdti7fd
         Aygw==
X-Forwarded-Encrypted: i=1; AHgh+RrpIal+PMn54jlN1k+mRIkLhHxbVcGYtcnmAnefjIO6svAH6EYwCp9Fou2jlQqpBX/LQ8GYsfv38YVD7UVrl04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7sazlR0z8XlcR0B3M6DVOIPASBoFBC4uluiyRCD6q9XrI86mU
	WjAYo2WZVOWjvpzY5qNxJrkjSVeQ4pAuGEFf3hwEpSbzS5FQd2thUzL237mOrWJcVvr6o+LTQYm
	E5esNu2OFELyX/kkz9+hXK0sSszrWEAvGqBmc7SDI
X-Gm-Gg: AR+sD135Z+wheeN2DuvxMICkW9TTzw1boH/EijcQI9rgQRle5PCaNWUws/w0SwcH7hb
	G1Umy+FG8KMccGptJ9xQZPn7BIOp1NhKN+PyIMnQU1UlLXQctXKbKNBb207UCkN1NNmrNRNFVor
	vgwtC5cbCETYaNIqxSabsZ4JNIodvxIRCNkUWlOW3LbhbNseJ2H22xDs24SPRuUEfnyLglAoz8p
	UbUtKo1AMKGPI68e1iI/JlJi8siKaOyUXbmYD4eNz8vYtb3FsxbkjQM5PfFnXM6yOkwG/YUDbrm
	n2sW68J6UcHSOSnL7exe/V8VU3sV8SkhSHp/w3UnHnkSoF8NuCBedxF0nHYquEcPhvLfWAZDgrw
	bLcQI8Ml6VN9i0nYyjSeG96+X3qfeTsw=
X-Received: by 2002:a17:903:4b2b:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d3171a56dfmr5502005ad.2.1786462962320; Tue, 11 Aug 2026
 08:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com> <20260810204118.1981755-3-morbo@google.com>
 <202608101713.34DEA00E9D@keescook>
In-Reply-To: <202608101713.34DEA00E9D@keescook>
From: Jann Horn <jannh@google.com>
Date: Tue, 11 Aug 2026 17:42:05 +0200
X-Gm-Features: AUfX_mxNDlgHpFyI6ONdIW4H6ADGwKcPUAc6snIFj_-8RLhUKE1_F9ggNW9ZDT0
Message-ID: <CAG48ez1VBBkukXH17RRSnAU7rMu0St5x59rkTDVkcMebxuS4-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: Add KUnit tests for fdtable
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 2:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Mon, Aug 10, 2026 at 08:41:13PM +0000, Bill Wendling wrote:
> > +static void fdtable_test_alloc(struct kunit *test)
> > +{
> > +     struct fdtable *fdt;
> > +     unsigned int slots =3D 64;
> > +
> > +     fdt =3D alloc_fdtable(slots);
> > +     KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> > +
> > +     /* Check that max_fds is set correctly and is >=3D slots */
> > +     KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> > +
> > +     /* Check that fd is allocated */
> > +     KUNIT_EXPECT_NOT_ERR_OR_NULL(test, fdt->fd);
>
> Nice to add these tests! Can you add one for each of the conditionals
> in alloc_fdtable (e.g. ENOMEM, EMFILE, and the power-of-two rounding-up
> logic, etc)?

Wouldn't tests for stuff like the rounding-up logic get into
implementation details too much, and break if implementation choices
change?
