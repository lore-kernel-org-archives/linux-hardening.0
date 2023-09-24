Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAED52F
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 17:25:03 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694DBFC
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 10:25:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c93638322so1172329466b.1
        for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695576299; x=1696181099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRXyiwDnkcF0zN2JsUwtWTqR+TaAuDaKDz+KJ6kvRrU=;
        b=HLGqwnkyzFQVdgYOXY0i49HeFCR6URzFxfpL1sidrOrd7PMp434Uk0KBW11wXZSpu4
         3HErpiTjei99XzJzZVVKa4rHW7n49LeqZEQPOL9vz5uoFrMV1UXMbokYlOKBrlHAxAXv
         9BQdA++xabk014UiEZT/kMxhZFGNlXbvrYpFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695576299; x=1696181099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRXyiwDnkcF0zN2JsUwtWTqR+TaAuDaKDz+KJ6kvRrU=;
        b=sMT2Dd52t5kDTtkNF+uzr+Gv7fF+vZ5ZPUOV0SJVmAjIpXXhrYMKLVrlrCPUHRndIC
         qihTovD0MbPNr1j4/kR0v6W/yo5P0TzsvillzpZ20EHCMGTntjyhFTlzL/omLHI3CfNC
         +Th0QjWyOXWfwiuJryhllv93eZ2tw1+oUWYHZ+LgoI7yIg0apKRLVmwW7/B12KmP8mFP
         HgAl2v/jhNLjAAbyH21iMyNbrEwJrQs0sEWxpn8bvkSH9a0eEyRXIfC2TThJ81/GjjUr
         Jb+XAwU5gLi0TIwzrFOkYtnrJJggE6LBtNuOWFF7/OD9ONFz8VAdp3aKvfBJ/mYWOyZB
         KCeQ==
X-Gm-Message-State: AOJu0YwWLBEK93HHU7Xhs+zKgSWyCpJ0nO6Pip4iDtzFHzXEofJVXDP+
	VJl2bJ6VpjOCQc2Bfv5EaAYPEk+lX4l2G7e9OsUIj385
X-Google-Smtp-Source: AGHT+IHJkpBaD4OjAPdkJwt5NSSfrXN4dMpU9qpGyjxo5ws2R5L40VpuEXc2sVzJKQweLZw/xe2f1w==
X-Received: by 2002:a17:906:4fce:b0:9aa:206d:b052 with SMTP id i14-20020a1709064fce00b009aa206db052mr12356363ejw.27.1695576299716;
        Sun, 24 Sep 2023 10:24:59 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm5267660ejp.145.2023.09.24.10.24.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 10:24:58 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so11674466a12.1
        for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 10:24:58 -0700 (PDT)
X-Received: by 2002:a05:6402:270d:b0:530:bfb6:66cd with SMTP id
 y13-20020a056402270d00b00530bfb666cdmr11388000edd.7.1695576298038; Sun, 24
 Sep 2023 10:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202309220957.927ADC0586@keescook> <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
 <202309222034.F2B777F55@keescook> <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
 <88707e12-dba9-4a9f-95d7-8d6f3c8f0f58@p183>
In-Reply-To: <88707e12-dba9-4a9f-95d7-8d6f3c8f0f58@p183>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Sep 2023 10:24:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh++R5W1ifuS6YoSb-9ExKGr7cVavo8SHiWtzyR4-hVgg@mail.gmail.com>
Message-ID: <CAHk-=wh++R5W1ifuS6YoSb-9ExKGr7cVavo8SHiWtzyR4-hVgg@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 24 Sept 2023 at 09:58, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Most of those in uapi/ are likely unnecessary: extern "C" means
> "don't mangle", but kernel doesn't export functions to userspace
> except vDSO so there is nothing to mangle in the first place.

I suspect a lot of it is "this got copied-and-pasted from a source
that used it".

And even if you don't export, you have to *match* the linkage in case
you have the same name.

So I suspect that if you have any kind of prototype sharing between
user space (that might use C++) and kernel space, and end up with the
same helper functions in both cases, and having some header sharing,
you end up with that pattern. And you do it just once, and then it
spreads by copy-and-paste.

And then about a third of the hits seem to be in tools, which is
literally user space and probably actually has C and C++ mixing.

Another third is the drm uapi files. I didn't even try to look at what
the cause there is. But presumably there are common names used in user
space vs kernel.

And then the last third is random.

We do have a few other uses of __cplusplus. Sometimes just "we have a
structure member name that the C++ people decided was a magic
keyword".

So it's not like this new pattern is *completely* new - we've had
random "people want to use this header with C++ compilers and that
causes random issues" before. The details are different, the cause is
similar.

                Linus
