Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA13C468
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324969; cv=none; b=FVBGNQzXeMlVF1Ge9Ao/TqWkpSvDDCamNEL2MGcIXdj6DUOFo234uUA1qRBoMnl1gizA2bAcI5mMSeyQLJL3x6DNI/TZY2sNu1KCTI+wNTwoCR3sgTH7t1RiZIFn55qX+QH5hl6pJF2Wh4sjpIC4aUidOhPmYnD7xvJz5iUneKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324969; c=relaxed/simple;
	bh=lY1M7XvAe4z3xW/aHER3sstij01V5RYloi+hF3mLnqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkXYJXxa07MM4RIs4QyOSBftNE+USOZeP970mGp24Y2DVIea/5C/x1xdzUPE3rlsNfw0lh4Xp65CG6Hu9pT1S3TIMvIzL5dJ4jkzP/UihKT56cPAZrFg8pAFRIBp4iEAh6suYn684OX+LH+Eii5EACAKW9DysQ7L4g2pGZ8A0ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NFYP+4Nn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFYP+4Nn"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5c0be115aso727435b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709324968; x=1709929768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uX4LCOmXabkT2zWb6MvvpjJWPlAoaia9rOgotZGNs1M=;
        b=NFYP+4NnEYJQK+DP/+lVnanpr4cx+7mAW26Bv4vf5SJyZdEUW/aN00XLEKnkUBcmXS
         MUbD8Xsr+5pHhMw0dEpFsNNvn1d0jF9wT1/i7Oj6utornQnGfsoIFSRD/EwyfuHsfNd2
         YrLm+3uQNJmnnBa9kfwjcXTYSgARExJRuGAuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324968; x=1709929768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX4LCOmXabkT2zWb6MvvpjJWPlAoaia9rOgotZGNs1M=;
        b=oZhDVW4acgZclB+lQ2+CPveBFsjq/KooRxyztjdt4a22FE8RF+zP1aiKLuY+lTNqdt
         MSV+TmaVB4UAWvo8VmvWeULMWdZ8mpeWM6qJ9wgDpltiTCxbtvSe8AXSOCyh+gtJRUur
         zqXQxZHWsjFUbvBH/7RkomEJNgNE1Crh+hXrDth0LzH9icr6Vw0dYbBT+8SqaH79+ycN
         ZBPs0Ji4tNYPvnAILPK3UZ11Q9tAt508jyEtxREuhGMgzVVKnQhBHjkRJenxWZf66zKb
         bIcnWgK2nEQghCdjQmAI93CvYW9KN5i+P7DY/zvvitjeiv5JlAHY/Ozwrz/UzVe22xXl
         A69w==
X-Forwarded-Encrypted: i=1; AJvYcCU4LDbXneKtMOA/1wjfke22LhrplDbDm3w/TbSCIluUwMma6grrqIrEYfomr+HYncuxsCN2v0cl7gS0mcaAKTbZGjhpK8/2pgYAyq/okgGZ
X-Gm-Message-State: AOJu0YxM1/WGR4mu5Bz+gX8J03Rp/bQb4y3HgJREyj9YLqwKVtoOE4ZP
	WoRc09bKodQoKqk4M671MM3xkxLV2Ni3b+CQhWSVfsnj55450OE9dIFoHp4nuQ==
X-Google-Smtp-Source: AGHT+IGC7DoYc1DKeYyd+Zj6CpoEtnPTOkULM9u+8uslMr+Qkuc2usm+ZIcd5hSRFzYUXEXYgYBZ9g==
X-Received: by 2002:a05:6a00:23c8:b0:6e4:eee0:57ad with SMTP id g8-20020a056a0023c800b006e4eee057admr3218997pfc.20.1709324967820;
        Fri, 01 Mar 2024 12:29:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b76-20020a63344f000000b005dc4829d0e1sm3433867pga.85.2024.03.01.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:29:27 -0800 (PST)
Date: Fri, 1 Mar 2024 12:29:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] string: Convert helpers selftest to KUnit
Message-ID: <202403011227.6C63925@keescook>
References: <20240301002416.it.092-kees@kernel.org>
 <20240301002650.1544829-2-keescook@chromium.org>
 <CAHp75Vf+zzVyVZ=fcXgdCMsp1MZdHmJ1aBTKFE4jHai2pWi27g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf+zzVyVZ=fcXgdCMsp1MZdHmJ1aBTKFE4jHai2pWi27g@mail.gmail.com>

On Fri, Mar 01, 2024 at 01:20:41PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 1, 2024 at 2:26 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Convert test-string_helpers.c to KUnit so it can be easily run with
> > everything else.
> 
> ...
> 
> > -#include <linux/array_size.h>
> >  #include <linux/init.h>
> > +#include <kunit/test.h>
> 
> I know the order is broken here, but don't make it worse, please. And
> stick with one schema where to put kunit/test.h always before
> everything else and somewhere else (like always after linux/*).

Fixed.

> 
> > +#include <linux/array_size.h>
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> 
> ...
> 
> > +static void test_string_check_buf(struct kunit *test,
> > +                                 const char *name, unsigned int flags,
> > +                                 char *in, size_t p,
> > +                                 char *out_real, size_t q_real,
> > +                                 char *out_test, size_t q_test)
> >  {
> > -       if (q_real == q_test && !memcmp(out_test, out_real, q_test))
> > -               return true;
> > +       int result;
> > +
> > +       KUNIT_EXPECT_EQ(test, q_real, q_test);
> 
> This needs a message.
> 
> > +       result = memcmp(out_test, out_real, q_test);
> 
> > +       KUNIT_EXPECT_EQ(test, 0, result);
> 
> Why do we need this assertion? We have a dump below to show what's wrong.

I've improved this all around with ...STREQ and ...MEMEQ calls, and
added _MSG versions where needed to retain the prior reported test
context.

> ...
> 
> > +#define test_string_get_size_one(size, blk_size, exp_result10, exp_result2)      \
> > +       do {                                                                     \
> > +               BUILD_BUG_ON(sizeof(exp_result10) >= string_get_size_maxbuf);    \
> > +               BUILD_BUG_ON(sizeof(exp_result2) >= string_get_size_maxbuf);     \
> 
> No analogous assertions in KUnit?

It's designed for runtime testing. This is fine as-is for compile-time
asserts.

Thanks for the reviews!

-Kees

-- 
Kees Cook
