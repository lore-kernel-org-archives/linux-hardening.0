Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E6C4320A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 19:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2D560C3E
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHSTUj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhHSTUi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 15:20:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881E3C061575
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 12:20:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s3so13201957ljp.11
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/UMoQYNiM0OhlEK7+Wk6CZ5b5LK1w4Xd45bb87WFug=;
        b=HUADSkb/5Kmj4z9hojcnMEtS2q7Pi4EfxrfMv4Y/PY1hCqOj8CEdD5A1IN35liPA1O
         /2LcpsfCAakMpVLHTcuqOx9ju2jR15GagGNXMtyO4UZXQLqjOqh3xDYYix/GTxIGzqk/
         GTZRGCM2KWS+l8wuA3ln+flK6POwqX/vKbAwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/UMoQYNiM0OhlEK7+Wk6CZ5b5LK1w4Xd45bb87WFug=;
        b=sE/zEppIuuUf/OoDHOVNZk5S1YNqEj5ddO2lnjX6GAEilDzXR7ekOgieo52G8B6JGO
         R97JYrWOPMjz0zFTHyAHNOUzIRjgKXwYphvWmMVDX4EHNtvOVuvVKggYa+nrq7HICFmF
         oEcwApdqxu4kb24q1WDKaSrmIkgr2zEyC1wQ459HGIlDW6RQkmq3XUsyfEN4M8Nw2epS
         v8zoOUH3BGbg/7vICimIc7LSOaC2hHfpDIVbklN0xOuTVo1pkoPVPTJd1eFiXs1WmmPH
         QckwshKZOrda7kQfiXt8r7nGc08Is/Wm80myMvp3+Ul1lrR8bIJwScPaUZKT7IeAlSwz
         O5+w==
X-Gm-Message-State: AOAM532LE8o8jhWgDHeTk4yNfVFRMM4h/BeVbfgbQeakRw8WB3z9Rs6A
        t9Ts1butk6cpp/SgQd8+3ydXTbAhAF3GUdjYTqg=
X-Google-Smtp-Source: ABdhPJzacSgcgfJsdqRZcqkpAYskCsa3UR65NjRzsKNOHykEJX2KXHb9auTf/CSDQ2bh/Jg5+xC+iQ==
X-Received: by 2002:a2e:1556:: with SMTP id 22mr12853378ljv.253.1629400798363;
        Thu, 19 Aug 2021 12:19:58 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w4sm367098ljg.99.2021.08.19.12.19.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 12:19:57 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i28so15217539lfl.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 12:19:57 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr11471879lfn.41.1629400797296;
 Thu, 19 Aug 2021 12:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210819040517.GA329693@embeddedor>
In-Reply-To: <20210819040517.GA329693@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 12:19:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
Message-ID: <CAHk-=whXUJbqhjkRSjOQ2Tm5OmyKv3_JUTh8pxxvykGaC+fM0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wimplicit-fallthrough for Clang for 5.14-rc7
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 9:02 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Enable -Wimplicit-fallthrough for Clang for 5.14-rc7

No. Much too late in the release, particularly knowing that we have
Clang pre-releases that claim to be 14.0.0 and get this wrong.

So no way does this happen like this.

That's doubly true since the clang support for this all adds exactly
_zero_ upside, only downside: we made the gcc checks be stricter, and
gcc ends up having (a) more wide coverage and (b) doesn't have the
bugs clang has.

Honestly, I think the clang "version 14 or more" check is simply
buggy. We *know* that check fails. Don't do it.

Make it "strictly more than 14.0.0" which hopefully doesn't fail, is
cheap and easy, and which will make clang work correctly in the not
too distant future.

In the meantime, we have the gcc checks,  and we'll have a release
without pointless warnings from garbage clang versions.

                Linus
