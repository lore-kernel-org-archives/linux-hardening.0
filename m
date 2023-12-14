Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h2s59+EP"
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C040D5
	for <linux-hardening@vger.kernel.org>; Wed, 13 Dec 2023 17:31:59 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso52159525e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Dec 2023 17:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702517517; x=1703122317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bu41HfL0rPJ5dM5yXqa7CgHUFFdONYm5ZwaUE4WWVI=;
        b=h2s59+EPWVzWaqCXPmHRCZzhYbTL/HDh7sOASvPyS9uG6XcONyiAR5iH3MnvosVBFU
         j+GLXc5m97XZ+FrdOuy8Ekx6bXtkHaNQ3BHAioqzow12coeiw2vlilQkgIQGiM8LBxPd
         Kr4OW9ft+0NO8k31l6HWS6gWhmJH5qKTnAkFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517517; x=1703122317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Bu41HfL0rPJ5dM5yXqa7CgHUFFdONYm5ZwaUE4WWVI=;
        b=cOPmuo5QPX+HbNQ7K+++TaFCTR1wrdydtEx4H5UFyrYFeXBMWEt+QffwpZIOIM6Chl
         AYzlibHdHbDPKhhBrEsq9dFmqkd1cbnnWAKeiYCvl/yrJs6cwqWaM2isUJSmo8JEMaZw
         auTNZj3MLXHfxQHKC7dQeY6dZNvSFJngHwTTNZIIl5sMGKJp1llY5AnQ5PtG578gNNBJ
         9RODI6M6tuX6p8cXs86yYuPg76I/D9h/2zL/CfliDsGs54lk5I2LPbIUVw6C8hvIGGdW
         hZNKDc2dHprQvqoQPtBftZCK3T//GNQ3owfA676TpdoQKCsCBz074dvTjB286xDxMTDt
         tt3Q==
X-Gm-Message-State: AOJu0YzZJh1ExsMDJk6dDkeDIkRRdsodHpFRUmTZjDuo9mMitsTSwrBE
	TZth2okbjC5pDJ4UX11pJuk7zcrWPoKjFQZlJs7tO5jMJXU=
X-Google-Smtp-Source: AGHT+IEDFHQs/jfcScuiuudHPtvjWi03KzxUg6afNEbrq/t1oqQlSHTA58a3pIrXSCr0rtetz3RQgA==
X-Received: by 2002:a05:600c:4d0e:b0:40b:5e1a:db89 with SMTP id u14-20020a05600c4d0e00b0040b5e1adb89mr2878400wmp.42.1702517517550;
        Wed, 13 Dec 2023 17:31:57 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id j8-20020a1709064b4800b00a1e377ea782sm8557257ejv.196.2023.12.13.17.31.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:31:57 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55114c073b8so5636714a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 13 Dec 2023 17:31:57 -0800 (PST)
X-Received: by 2002:a50:d592:0:b0:54c:4837:7d1e with SMTP id
 v18-20020a50d592000000b0054c48377d1emr3150337edi.93.1702517516946; Wed, 13
 Dec 2023 17:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
In-Reply-To: <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Dec 2023 17:31:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
Message-ID: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Jeff Xu <jeffxu@google.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 16:36, Jeff Xu <jeffxu@google.com> wrote:
>
>
> > IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?
> >
> The MADV_DONTNEED is OK for file-backed mapping.

Right. It makes no semantic difference. So there's no point to it.

My point was that you added this magic flag for "not ok for RO anon mapping".

It's such a *completely* random flag, that I go "that's just crazy
random - make sealing _always_ disallow that case".

So what I object to in this series is basically random small details
that should just eb part of the basic act of sealing.

I think sealing should just mean "you can't do any operations that
have semantic meaning for the mapping, because it is SEALED".

So I think sealing should automatically mean "can't do MADV_DONTNEED
on anon memory", because that's basically equivalent to a munmap/remap
operation.

I also think that sealing should just automatically mean "can't do
mprotect any more".

And yes, the OpenBSD semantics of "immutable" apparently allowed
reducing permissions, but even the openbsd man-page seems to think
that was a bug, so we should just not allow it. And the openbsd case
seems to be because of how they made certain things immutable by
default, which is different from what this mseal() thing is.

End result: I'd really like to make the thing conceptually simpler,
rather than add all those random (*very* random in case of
MADV_DONTNEED) special cases.

Is there any actual practical example of why you'd want a half-sealed thing?

And no, I didn't read the pdf that was attached. If it can't just be
explained in plain language, it's not an explanation.

I'd love for "sealed" to be just a single bit in the vm_flags things
that we already have. Not a config option. Not some complicated thing
that is hard to explain. A simple "I have set up this mapping, you
can't change it any more".

And if it cannot be that kind of thing, I want to have clear and
obvious examples of why it can't be that simple thing.

Not a pdf file that describes some google-chrome design. Something
down-to-earth and practical (and not a "we might want this in the
future" thing either).

IOW, what is wrong with "THIS VMA SETUP CANNOT BE CHANGED ANY MORE"?

Nothing less, but also nothing more. No random odd bits that need explaining.

              Linus
