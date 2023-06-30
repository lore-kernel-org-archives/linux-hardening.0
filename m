Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4CFEB64D9
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Jun 2023 00:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjF3AIJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Jun 2023 20:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF3AIH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Jun 2023 20:08:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3022D50
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 17:08:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9928abc11deso151731966b.1
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688083684; x=1690675684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qObUezpKEChN6EJPRpioTlFXu5Gh0veDoFYzvMKfmR4=;
        b=Bc84eEQ2+y4NQ5C40Js2f4YqMQL7aivir7yrXZSExgRu4FGBrgpMemNxm/gU5nOqeQ
         XfncxH+dXvNcjQIJJ2TrV2P0kEhIPiqWRYQ5UjKMFxI9KpYqfw0jfZAYiVqpY/52pa6H
         QFfI1sPfvAKbuniqZ6EeWjrk4Jrj3YE6gRGrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688083684; x=1690675684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qObUezpKEChN6EJPRpioTlFXu5Gh0veDoFYzvMKfmR4=;
        b=UmZtScVCyovzKR0M3i1ZHiV0sBoX3AIMdhF1r0mhhTcTzpwDWmoigjK8WBFPJkUliq
         7I7yelGuLLd634Dl5EqiNjUJGMq3COzzGtKxusjU07Up6kWiaLksnE1KGHsDyqKmQMHc
         QiaphdbqgX2TXvp1iaDVVw5BwTUVXyCiHc6Ufwiqe/9EpXiPIHDP6h3iGEuC+EIz0Ggb
         T2LpZWHAXyfrpMxsse5PJkQg81uJnajuNoYsZc4hQQkgdjhSJmK8/nnVQs6GOatrkzTQ
         zDDlJKkA/erKuayvehP4gFTBsGsOazTMbLW3SCHn2s7PwxWexJwvxjrg8T8accQk60Gz
         0Iig==
X-Gm-Message-State: ABy/qLZPL5aOi5CqFgIhLO1sLIC26h+aCUK2QzitexRLuN5t6wdBc/hk
        ldE5x4kiQ/iY6NZoP/K+qQjMYkQ2kOzRfrqhSrPTWAKT
X-Google-Smtp-Source: APBJJlETHWQT0jnszrWGa6e9pBQCvHsye1Z3NIpR1WPI5uSjVOPoAesDTGC3+2pN2qmI2tpYCrM/yQ==
X-Received: by 2002:a17:906:e118:b0:991:b6f5:5f96 with SMTP id gj24-20020a170906e11800b00991b6f55f96mr516304ejb.60.1688083684542;
        Thu, 29 Jun 2023 17:08:04 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id bu5-20020a170906a14500b0096f6a131b9fsm7411481ejb.23.2023.06.29.17.08.03
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:08:03 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51cb40f13f6so1440593a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Jun 2023 17:08:03 -0700 (PDT)
X-Received: by 2002:aa7:d585:0:b0:51a:3159:53c7 with SMTP id
 r5-20020aa7d585000000b0051a315953c7mr441085edq.30.1688083683177; Thu, 29 Jun
 2023 17:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <ZJxZJDUDs1ry84Rc@work>
In-Reply-To: <ZJxZJDUDs1ry84Rc@work>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 17:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6oH=LanEa6Dz5LTjHqO+UUOor=rpKCfS90aiAWAUJ1A@mail.gmail.com>
Message-ID: <CAHk-=wg6oH=LanEa6Dz5LTjHqO+UUOor=rpKCfS90aiAWAUJ1A@mail.gmail.com>
Subject: Re: [GIT PULL] flexible-array transformations for 6.5-rc1
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 28 Jun 2023 at 08:59, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
>
> Please, pull the following patches that transform zero-length and
> one-element arrays into C99 flexible-array members. These patches
> have been baking in linux-next for a while.

This must stop.

Honestly, this is just making things *WORSE*.

That drivers/media/platform/qcom/venus/hfi_cmds.h needs to be
converted all-or-nothing, not this crazy piece-meal conversion effort.

You literally seem to be converting structure definitions that ARE NOT
USED, and then leaving the ones that actually *are* used alone,
because they have uses like

    struct hfi_sys_set_resource_pkt {
    ..
        u32 resource_data[1];
    };

                pkt->hdr.size += sizeof(*res) - sizeof(u32);

where 'res' is a pointer to that packet type.

I'm not at all interested in patches that convert structures that have
zero use. You might as well just *remove* them in that case, rather
than make some syntactic change that doesn't matter.

And yes, that header file already has a mix of '[]' arrays and '[1]'
arrays. I'm not interested in continuing that kind of pointless
conversion.

Either this gets converted properly, or it gets left alone. No more of
this kind of crazy "let's convert the types that are never used".

            Linus
