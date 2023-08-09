Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FD4C001B0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Aug 2023 00:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjHIAlR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Aug 2023 20:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHIAlR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Aug 2023 20:41:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA519BC
        for <linux-hardening@vger.kernel.org>; Tue,  8 Aug 2023 17:41:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5230df1ce4fso8305195a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 08 Aug 2023 17:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691541674; x=1692146474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53bleXI1rwMamZX0JWcAtU23Wr0BIzKJAx0qsLh8yXA=;
        b=P+2/9o3rsXDweHtlRPZzhxI1iPCzdYp9atAuwlSGbuCtNsTg5F1zH06KhH1cW5Xlyy
         /Km0R6yfUAhnTFrbOCO6sdKHEZ4Y7ljRokGXJXX5dDPTduAIQ8kNl2t+P4Ah84gbtO/1
         cQc0By1FBfOsuEQhzbEWjf6w5eXtd+aEcKNLed5lFmRBL3JXeXJOyvbfNoJx0YPfxghY
         k5AI//fgNi2wlHUiN/f2psVTQBNoVGHFqbdmYKRLu9cf3e6qVMd0KVS5KH74h8v/J9uu
         rv9niSeuRyxYyNwhuLqZZNqWMQ+pPiddBL/eualB55TM9RpcrqiCml9iYLd8BA6LSUmX
         K8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541674; x=1692146474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53bleXI1rwMamZX0JWcAtU23Wr0BIzKJAx0qsLh8yXA=;
        b=d2Bj6XFW2qcykNEUPsdH+Sc93BH+Rp9XH/Xyd0jlNzbQL5mBoNtcmLyhiaqZb4890s
         vXl7s9sPd5P/48+jC8+JoSk8ZDp2/3Yn7zdkadyDawVbvesQBYG+K1JUzLSKLK4P9ws6
         NUSTgDbx5uL4OLJHtLnlBim5W5ynRz81zCsDpTUkzZf37sx5VBz6rAqPHIoQLJmiF85q
         ue9QKJrvr2EhveQ20LpEKe5DcigRjWWDeJjtbwq3Pmt3tYMd0c9KWv57UzhJmYiLSAtM
         +AvFufne6SBj/R/G54T7fd6FQLFkU66YbA64Z24Vz9lD4y30kUFOvz9zWtlu9JPffCgy
         AVjA==
X-Gm-Message-State: AOJu0YyX9DfiI2Re6dBl0BxSrHLooaxga4Z22SQmyn9tO8bi25V95Ee6
        hWRoo1WWkKfrOCP7PnoHAZaqsjVLVKNkzLjC6+QRqg==
X-Google-Smtp-Source: AGHT+IH+o2gQmZ+g2rXKzG+WrwjtCAkrRGG17r1COP/wNQau3mqxf/ssgwfBWD/6BXEh19oUwJIUMTL6DpaCyUXau/o=
X-Received: by 2002:a17:906:218a:b0:988:6491:98e1 with SMTP id
 10-20020a170906218a00b00988649198e1mr892372eju.42.1691541674457; Tue, 08 Aug
 2023 17:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-2-efbbe4ec60af@google.com> <20230808234001.GJ9741@breakpoint.cc>
In-Reply-To: <20230808234001.GJ9741@breakpoint.cc>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 8 Aug 2023 17:41:01 -0700
Message-ID: <CAFhGd8r5LfczABYD3YNmbwH9tJtsr5MQNi6pUMLiZY3Qywo0kw@mail.gmail.com>
Subject: Re: [PATCH 2/7] netfilter: nf_tables: refactor deprecated strncpy
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 8, 2023 at 4:40=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Justin Stitt <justinstitt@google.com> wrote:
> > Prefer `strscpy` over `strncpy`.
>
> Just like all other nft_*.c changes, this relies on zeroing
> the remaining buffer, so please use strscpy_pad if this is
> really needed for some reason.
I'm soon sending a v2 series that prefers `strscpy_pad` to `strscpy`
as per Florian and Kees' feedback.

It should be noted that there was a similar refactor that took place
in this tree as well [1]. Wolfram Sang opted for `strscpy` as a
replacement to `strlcpy`. I assume the zero-padding is not needed in
such instances, right?

[1]: https://lore.kernel.org/all/20220818210224.8563-1-wsa+renesas@sang-eng=
ineering.com/

Thanks.
