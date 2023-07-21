Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C911C001DF
	for <linux-hardening@archiver.kernel.org>; Fri, 21 Jul 2023 14:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGUOYn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Jul 2023 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGUOYm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Jul 2023 10:24:42 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F1F2D79
        for <linux-hardening@vger.kernel.org>; Fri, 21 Jul 2023 07:24:38 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57688a146ecso22576517b3.2
        for <linux-hardening@vger.kernel.org>; Fri, 21 Jul 2023 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689949478; x=1690554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8ztgMvA+efivb3zvfwoxg39ThpiIM2mYSu5oGv5kHQ=;
        b=cP8k+YLz02K0HGvAlXEo84L+RFE1hAHgDU85TQL6prNb2Z1x9Kj092DtJQ+5Z2Gnt4
         hX/jQxXF1ZzmY02zOJRUhRX0m8vv8y11XVCAloo/etTo/xIhUNLekzvEpswheDzTvKDq
         fLiAYPbzMigSmG5ENKuoiA3fFM/cctYg3titn8JI/6g9lYQVhSsqkb8ZijuwxRuAL0dy
         r4CqMG1BsTjbP0KyvGOtg12OZIIw8MwesZku+d6/GGIb/qTug06+GGpkGPqCFHvAmiRE
         niRsOFymcfOzvCEF2rT0OcQuzfdz5GiRy6xFtStUT9kUVw9nDcsTZk8fmcnYi/bNS0Jk
         UdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949478; x=1690554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8ztgMvA+efivb3zvfwoxg39ThpiIM2mYSu5oGv5kHQ=;
        b=OXvFyEt9wkYlvwvbZzCF8jLkqCULozZiN2eeWduFhaH0+sy4MPdKqW1Pz/W6hDa9Tc
         POuvjFcLTSMqK44JqF5aGser+PGTW0bvnWEQEG+uS6RphafNvVhIteAFjxkEKuMhNPvp
         CSXBA7QL6R2JNag6YrAHnByMByyYF18j0V8O77CJAB5wqbDkGiAktTgyNX1FMbqMw9HE
         0vehg73IBY2PS5NGv6LrZL3lMDEPNalW1EoT/RC/mqe4gG5dnYQGabR28FYUHuIrW0C5
         1LwbA03RVhOgUkzx4H9IlL5G/WCUayedOGcbgQ5rtJcaFroXe59P3LL/DRK5MR1UFVEB
         5sPA==
X-Gm-Message-State: ABy/qLbDpA7aiRFIQGX1437m32Sv4YXq6HpHzVLiCejJEHl2i4beLenx
        AUqr5nnmCoYTMI5yttmQKGCOANMyrt8MxwjnCczY
X-Google-Smtp-Source: APBJJlGkctnRWeYQSNR/Xwb+OMnSG51UHGgmnhj0crFYLZf3uLEvqoDrwlYGU+rZRaE9jZgtAqzvJN1Wd16AeboXQtE=
X-Received: by 2002:a0d:de84:0:b0:576:777f:28bc with SMTP id
 h126-20020a0dde84000000b00576777f28bcmr209789ywe.21.1689949477988; Fri, 21
 Jul 2023 07:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 10:24:27 -0400
Message-ID: <CAHC9VhT3pA12ndrPE_VzgA7_tr2cWVz1jn3QLch+CW9P+B37uw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use NULL for pointers
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, bpf@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 20, 2023 at 11:32=E2=80=AFPM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Replace integer constants with NULL.
>
> security/selinux/hooks.c:251:41: warning: Using plain integer as NULL poi=
nter.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5958
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for your patch, but a patch to address this problem has
already been posted to the list.

https://lore.kernel.org/selinux/20230720203116.316250-2-paul@paul-moore.com=
/

--=20
paul-moore.com
