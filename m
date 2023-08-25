Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3DC83F08
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Aug 2023 23:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHYXj5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Aug 2023 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjHYXjk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Aug 2023 19:39:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6288271D
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 16:39:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31771bb4869so1139571f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693006749; x=1693611549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARAkvhj7ZJCGS7HKCILL6B4n+8Rbnyk4X5Sfz208Kk0=;
        b=QVGmFqsF4/K5NVoJoJF+dUyFvy7vxGVJw/2VXZ+2uZidyZ4CawnajEyf4nSeJ43ACl
         zsm3vqdDdSaMDQDB8amtxmHw3u+uXWhKayeIGMmRXZoMlA7C18saeGyS87eVkzoPloL3
         R7KuHQ7vtbPQRhiN+GormH5u385wcE4qcpoNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693006749; x=1693611549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARAkvhj7ZJCGS7HKCILL6B4n+8Rbnyk4X5Sfz208Kk0=;
        b=NKRhNoPbCTFtbR8bjZsjxSCjTUhF6lIz1iWgqBfman2wX9TpbCh9GGgRlOXkBwwTli
         pvrbMkxL+/Mqz7FnQBVGaRIlYpWNzPxiXWqAqfbdOzx/IzTe8V5LuWD2f1w5XDDCIspv
         V9uM5jpSqh5GO0qCCS5l9BeM487qzKxA249F00SYVenFoX7HznHhfjqiLIazB4554YhI
         LtBypIAGKyVFUdvVfyjDa1k8kgzkon4ZKuwYx2lCmu1Ou3sfAAGJgYkQKMjcTMkehyTA
         zCVLBm+9+XlVf14oXoOpbHaqUqI78plVhDModMOkkLX3xO8Pu2CrhL1mfZsqVq0kpLfK
         snwg==
X-Gm-Message-State: AOJu0YxzMFTIOHbhjJTggEg8DM1YpiBzlj3W+OZDqhaXkQTeCy1VrMV9
        wbkTwk0iUwxyXqGQJUrbrrBvFi/LNSKNFs2PsLI=
X-Google-Smtp-Source: AGHT+IEsR5kPSot7EBTsKvWX61nUvqSEEWvhLz5WV7RxtPd2oQJSaJpp6kMZakl5ST1PWT//n82OWA==
X-Received: by 2002:a5d:5242:0:b0:319:8261:2087 with SMTP id k2-20020a5d5242000000b0031982612087mr15464022wrc.43.1693006749230;
        Fri, 25 Aug 2023 16:39:09 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id k8-20020a05640212c800b0052a3b212157sm1483947edx.63.2023.08.25.16.39.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 16:39:08 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so2013656a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 25 Aug 2023 16:39:08 -0700 (PDT)
X-Received: by 2002:a17:906:59:b0:9a4:88af:b82 with SMTP id
 25-20020a170906005900b009a488af0b82mr2214834ejg.77.1693006747785; Fri, 25 Aug
 2023 16:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692931954.git.gustavoars@kernel.org> <d4f8780527d551552ee96f17a0229e02e1c200d1.1692931954.git.gustavoars@kernel.org>
 <202308251410.8DAA6AC5E@keescook>
In-Reply-To: <202308251410.8DAA6AC5E@keescook>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 25 Aug 2023 16:38:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
Message-ID: <CA+ASDXNxYZsxFcF2iiKidBr4znsS5ejjmQKU_pdNpsrAqyeXEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 25, 2023 at 2:10=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Thu, Aug 24, 2023 at 09:10:45PM -0600, Gustavo A. R. Silva wrote:
> > +                     mwifiex_dbg(priv->adapter, WARN,
> > +                                 "TLV size (%zu) overflows event_buf b=
uf_left=3D%d\n",
> > +                                 size_add(sizeof(tlv_rxba->header), tl=
v_len),
> > +                                 tlv_buf_left);
>
> With the suggested change to make this a warning and not dbg:

mwifiex_dbg(..., WARN, ...) *is* a warning, not a debug message. Or at
least, that's how it's used throughout this driver, even though it
actually yields a dev_info()-level message, regardless of the 'mask'
arg:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/wireless/marvell/mwifiex/main.c?id=3Dv6.4#n1811
