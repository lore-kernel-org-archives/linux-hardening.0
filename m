Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037420B1B
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 18:05:19 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6712127
	for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 11:05:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50336768615so6700225e87.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695492317; x=1696097117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcipxSNQY08wl7UPw3CDMFJCTeN6Z65jpzmRv2y1p7Y=;
        b=Yb0m3ZNueVYWCDBBP0RdYirqLddPCZX0l+BK8D2hQljNkocxGFmwA5TZD5QEAtk9Sh
         IjAirY78b/pd7KK46EDlhMN+IkuHASg55baBzueEdCvgzIFPaO294zkE8vZs3yi1wxY7
         lfRwopxyMQG4s01cBPk1gTSnv59H8AnLB0k48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695492317; x=1696097117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcipxSNQY08wl7UPw3CDMFJCTeN6Z65jpzmRv2y1p7Y=;
        b=cq1rlmwh0qihyx7tPDHc0uaA7q5bHATbL84i74WjOit/eM2wu2BP06vc6HMMpqDeIH
         dtJ1YhfFP6As1e588/tiwL1Vl9uUpAOk3wRHQ3N38gbZgG462fHNLzrTav+3BS+bU/Gn
         RZIHZrjVge8AGQNGTTXYzHbpCE4DNCPc+NeFI96DjvuMVOxQYleFL96806sn4R/Zsboo
         Wv8VYxfSmtlltN21B4iQhi9Tl3ryIVpl2oQaqmjdGmjq6gEG6B+KHzZoD6cRQkfn5R0i
         JafM002WcrTUR7irNckTYDmRiermNYrGO9sq3zy7W1TsckD1wKZIjniJRWxvFnsHgpf4
         nd0w==
X-Gm-Message-State: AOJu0Yyd606qw/t1B4YnvKK1Fn5HnuuGYvm6U2ZCZ+RhEEGgzzuavVZ9
	shEA+eu5XYMzt1yAriDM60IsCAPQhk2dV9Ee6Wg9Lq0i
X-Google-Smtp-Source: AGHT+IGmBhHoT07F5oCX8JWEXDwcgKJXNakcnF/tAv77Mfg1GaThXS3TZN6p6Aj8WgP55nPFnUFP/w==
X-Received: by 2002:a05:6512:3697:b0:4f9:54f0:b6db with SMTP id d23-20020a056512369700b004f954f0b6dbmr2093607lfs.13.1695492316916;
        Sat, 23 Sep 2023 11:05:16 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i26-20020a056512007a00b00501c6d78f11sm1151937lfo.298.2023.09.23.11.05.15
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:05:15 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50336768615so6700164e87.0
        for <linux-hardening@vger.kernel.org>; Sat, 23 Sep 2023 11:05:15 -0700 (PDT)
X-Received: by 2002:ac2:4bcd:0:b0:504:4165:54c1 with SMTP id
 o13-20020ac24bcd000000b00504416554c1mr2774098lfq.7.1695492315346; Sat, 23 Sep
 2023 11:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202309220957.927ADC0586@keescook> <CAHk-=wg0C+eEm0Tegpvc1zZjcqkdG9L0ed10tg_rQ1-WZciMGA@mail.gmail.com>
 <202309222034.F2B777F55@keescook>
In-Reply-To: <202309222034.F2B777F55@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Sep 2023 11:04:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
Message-ID: <CAHk-=whf6Zu3Cfm1eOTxXniZf5EPaf1iLj_q_6BVHrzTUBfUGw@mail.gmail.com>
Subject: Re: [GIT PULL] hardening fixes for v6.6-rc3
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 22 Sept 2023 at 20:49, Kees Cook <keescook@chromium.org> wrote:
>
> 2) __cplusplus is relatively common in UAPI headers already:
>    $ git grep __cplusplus -- include/uapi | wc -l
>    58

Look a bit closer.

Most of those - by far - is for the usual

  #if defined(__cplusplus)
  extern "C" {
  #endif

pattern. IOW, it's explicitly not different code, but telling the C++
compiler that "this is C code".

So this new #ifdef is an ugly new pattern of "do totally different
things for C++".

Apparently required, but very ugly nonetheless.

               Linus
