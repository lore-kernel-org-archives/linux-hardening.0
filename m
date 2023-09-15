Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61F6EDE989
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 03:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjIODEa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjIODEa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 14 Sep 2023 23:04:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325B4270A
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:04:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69042d398b1so372075b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694747065; x=1695351865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oGCU+XO9lmHPleHOolcpXGUsBUX+De3p5Ob7hsvn5gU=;
        b=bOdxjYVmZFExLQqE6s04p5bhi6dKZXSETT/LUwxFif98o31Wn69f9ST0qoGPyI2U9O
         jRB+Jg3PGWFMIt1LKCK/8opG6eI9qaO6BOb0dikQ3e2q0C6o9CcZKo8YvdVSn8v0AbgN
         Toco2CmdGK7zbAmuk0HCdars+SEYJ1Kf6RvJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694747065; x=1695351865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGCU+XO9lmHPleHOolcpXGUsBUX+De3p5Ob7hsvn5gU=;
        b=Nfj+AnQQkXhxMBu1kSb8jjjWyz9uWYfk6YljsNUdo5o6A5DjXZY5Ma7EfRZi0/MLhW
         r33TqphSL06/VXA2e0uWTHPUCoAVy04C9vdNIUSoLDDPaZwKiyQxanjs6fcV5fXcGm/I
         67PVP1EqowpNAFoeFHO2nLhUevsRJUKdL1m3KvYLt3qdGLYTBRQTPRPpQnsp91F0aQWK
         7XpjmqoHLrYUrc4XdOEkfDTP3iQKyyJEPYjPRfk3bf4SUHsKny1tj1nZ80zSkCWG5laD
         9ujkZhzG/Y3WjAkjrlMg8dJO4OmkPlPlFF6TFjj4+kkR5puTDCXgcQFRglV3JjFoWdQH
         9BYQ==
X-Gm-Message-State: AOJu0YwpAtYnqkz2Um6O24YQnN73dD46jfMAFrFE6Nr9tuCKE9tEyg/P
        TM+deFAtmuqMvPfB2FECMmoigQ==
X-Google-Smtp-Source: AGHT+IHpVAX3ysYHUhi4mt+g7HzKFEpt+mObL2VXXl0TVoEcBzg8qVGdqPoLpuTo5z335w514/jdUg==
X-Received: by 2002:a05:6a21:3e0c:b0:14c:3218:c1bd with SMTP id bk12-20020a056a213e0c00b0014c3218c1bdmr621008pzc.11.1694747065687;
        Thu, 14 Sep 2023 20:04:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a190900b0026b45fb4443sm4209388pjg.4.2023.09.14.20.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:04:24 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:04:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] um,ethertap: refactor deprecated strncpy
Message-ID: <202309142001.9C351F8D2B@keescook>
References: <20230911-strncpy-arch-um-os-linux-drivers-ethertap_user-c-v1-1-d9e53f52ab32@google.com>
 <CAMuHMdXJMZ6FebNn01C9EPsZAiJs-n5tp4j2hufAAr=zXOsSOQ@mail.gmail.com>
 <CAFhGd8r9Ow2xmJ++apef0rn2DHBhKm9BvfLooMTqzyaOhqbEgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8r9Ow2xmJ++apef0rn2DHBhKm9BvfLooMTqzyaOhqbEgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 12, 2023 at 01:12:35PM -0700, Justin Stitt wrote:
> On Tue, Sep 12, 2023 at 12:36 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Justin,
> >
> > Thanks for your patch!
> >
> > On Mon, Sep 11, 2023 at 7:53 PM Justin Stitt <justinstitt@google.com> wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > >
> > > `gate_buf` should always be NUL-terminated and does not require
> > > NUL-padding. It is used as a string arg inside an argv array given to
> >
> > Can you please explain why it does not require NUL-padding?
> > It looks like this buffer is passed eventually to a user space
> > application, thus possibly leaking uninitialized stack data.
> 
> It looks like it's being passed as a list of command-line arguments in
> `run_helper()`. Should this be NUL-padded due to its eventual use in
> user space? If we think yes I can send a v2. Thanks for pointing this
> out.

No, it's passed as a pointer to a string, and the clone call will
ultimately make a copy-until-%NUL when building the new process. This
doesn't need padding.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
