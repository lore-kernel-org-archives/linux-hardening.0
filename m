Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6ADC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Jan 2022 01:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347402AbiALBNo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Jan 2022 20:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiALBNn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Jan 2022 20:13:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B65C06173F
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jan 2022 17:13:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u21so3442008edd.5
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jan 2022 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaT2R5kaQaju0x+UlFgmD6QCY5CgbQuRRz1zHWPJHC4=;
        b=KwRQEipDQ1RRC11ovJQe096JtPP98rYiCW+xIiGzmIAL1tCH+EtzUwqttlOcM+XYAw
         ZvWANexjQd1shQQzpJlh0l8FfwFdImhKdrrAJCWGSedclApedKOPE7R970cLKZa5eMFE
         9gc2gkd7RCatTI5HoQ+jO+Dlxa0Z7IabAfEoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaT2R5kaQaju0x+UlFgmD6QCY5CgbQuRRz1zHWPJHC4=;
        b=1/CDLVxIIS9+QbGNOkIg9lk6AgD4BxK9Glm4b77FVjCswnHJh+JCguCjTypwFjOnDT
         Aqcocbpomc+4+X+b6XLHMnnR7UljXVRFjRjkB1nSXGnbxLmlpgPtOxt9IQICJuSLJNLt
         tHylbs6VCt8Yw2+FO3jqIcMWjVImBRax/eh8t9gs3yTQ5LqwA1vfAgy63cyBC2LD48Ls
         23YuwIOtpkJobgZJ+gazlQDv9K+fXE09kjxq0+AM9xpAbO73v4KCD+XjjKbcIIjQzDie
         Ibz1fYwOACFLNpJwj04erfQa7MbhPio5ZEItYJZRaOu8b86pNIDwbxx/C5ChIyzdsB6f
         WBPQ==
X-Gm-Message-State: AOAM531GIFr66UtqRkABJAyRwmJdJMVt4vgr6HJzQfvcFP7Vv4WBn3P1
        /nUjvMIpOQkWv7X4Uu44dJslEM5uTPieIuSyMxA=
X-Google-Smtp-Source: ABdhPJxWO2euj7fLDgzmOzCVbl2dNBv0aRCwGPqJ90KE/ag9yweifoCrh1M1sJhWfM2rIH3jotgwEw==
X-Received: by 2002:a17:906:2890:: with SMTP id o16mr5718270ejd.99.1641950021791;
        Tue, 11 Jan 2022 17:13:41 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id cn9sm5502999edb.88.2022.01.11.17.13.40
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 17:13:40 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so608276wmf.3
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jan 2022 17:13:40 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id g20mr4584839wmp.26.1641950020220;
 Tue, 11 Jan 2022 17:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20220111193855.GA13612@embeddedor>
In-Reply-To: <20220111193855.GA13612@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 17:13:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTEj354w942PW88eP6BLu8=XREzUaeo1zx816OUFLe2A@mail.gmail.com>
Message-ID: <CAHk-=wgTEj354w942PW88eP6BLu8=XREzUaeo1zx816OUFLe2A@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wcast-function-type for 5.17-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 11, 2022 at 11:32 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Please, pull the following patch that globally enables
> -Wcast-function-type.

This seems to have been in linux-next, so hopefully that means that
all cases that used to warn are actually fixed and there are no ugly
surprises waiting..

              Linus
