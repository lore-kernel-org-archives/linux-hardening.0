Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32307C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Mar 2022 23:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiCWXbw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiCWXbw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Mar 2022 19:31:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9A469CCF
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 16:30:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id o10so5922195ejd.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Mar 2022 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfS7RNhMsAvhm3dkViHCIr0vMqh85tM7E/+ao0kRKJs=;
        b=tW2EeH/eBKHhPEoNUW7aeZDdjSo2N3sR5g8/rjFyrWWIfWC9lzpK7okoF/VHQoK3/R
         nRnXQzDF/+QOzMU5yhwb972fhRH79C3FASiflIzZF8aFHuGLrEbg9V2ojYFvJoHWrXTg
         Rm9xIyV8e3TrJCUCw+B+7bIVxPbQfaXlyC9ysfKC0uwry4x2DrEiYC++/51pb+RW2DU9
         WKnqE3tlVdqzQHCILZG7Fp5+Hy0OD3VN+P4mdQ35EngOytiOZ/9St5He9SjbDhSUlCYV
         rK+T4hZ4nfTY9AnZMav6bqNLsIOBTA+GiUrJF5I4n8B4BsfziS9oabg3fqvrik1d1MWi
         zURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfS7RNhMsAvhm3dkViHCIr0vMqh85tM7E/+ao0kRKJs=;
        b=4Hah0UiGM6CoFaf7r8cRlEGKYgtsNMgpzZ6t+1CnAdatQHYTwLxsCqoryaK+fBpLnT
         vEAQdWcBQ7LYUmTTw5s9c3oUj/DTLRobdhgk4eOBHizCQIOvpFG3ntm8PP0WV7Um7iE8
         zWwVBM4Mgu5liAdgfiXpa3mxGl/fxQlGwxEwdFz1SGrd3ksY2Q7VC+ipw+Xzr89AaROa
         /543soaZrx4GLtS7D3amj7DYhbAdgiZ+WvoxZ7XGLlipQDJb7AyYeKbAuaVvCc2pcHxa
         YMupEdkn5ZtcgN0EFL7bPpHqjOk/mLInnPF+ffgLQme8bQJW4fx6y28Jruvm3RvxMjfn
         gQRg==
X-Gm-Message-State: AOAM531wjY5+L8C/s0E5oMvVTUyCd/5AX6bjHdNWXvgVzmHZUlVbArFN
        rLUK7ci2kISRb5wTGWVxEBBBk9rBjJxYgDqBL0Yhxg==
X-Google-Smtp-Source: ABdhPJy9tB8cZmFLq7/08WeSSCigTCYfwMBIqUubd0WCU7po5l9Q1JOyl8dsivDi3xN38be3+/LEihyciTgUmeVucoU=
X-Received: by 2002:a17:906:d54d:b0:6e0:1f9b:5064 with SMTP id
 cr13-20020a170906d54d00b006e01f9b5064mr2733192ejc.59.1648078219829; Wed, 23
 Mar 2022 16:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220224055350.1854078-1-keescook@chromium.org>
In-Reply-To: <20220224055350.1854078-1-keescook@chromium.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:30:08 -0400
Message-ID: <CAFd5g47HMRbKOFbANe_kZ8Td4OHxxwDqpszV515uaMzsz9DoXw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Do not colorize output when redirected
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 24, 2022 at 12:53 AM Kees Cook <keescook@chromium.org> wrote:
>
> Filling log files with color codes makes diffs and other comparisons
> difficult. Only emit vt100 codes when the stdout is a TTY.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
