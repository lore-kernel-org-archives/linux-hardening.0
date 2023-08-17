Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2B0C64EBC
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 21:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjHQVLX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355192AbjHQVKw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 17:10:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4193F3A80
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 14:10:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so273530a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692306649; x=1692911449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KARGt4PpfElbzZwIBwRvtX7xaDZsIxyiYVnKOlHTyhg=;
        b=EMas5cliax2QlhrsgcLYZMuSfwfe/lrHBDdnXv8OeJuSjZqTxUD+OZXcX/Ht1U22l6
         ZempxHUD1+qbME5BTq3+Rb/fVDrYt0Xsf9Jq6la0Ep0XIK5zSzbwnATK5cVKHG7TIpdY
         Ixug0lIMRN5lg8SiQM04v7hq+ADFVdrXfBDIK4qHLZ4VQMXEioqxQL8544TEM9okZDed
         joGeDPnlHJoBAq8bV6ydNOvVL0TXKIjbx4QG3gSgbefXPb5vZA7qk8SnqGmcasHODjCT
         qNiliLD7bbAZgFmL5rDBo2WZFE5zFods2jhHiQ6muHP1Sx+2N6MTG/IXFS8KTtBE4Mmh
         M6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306649; x=1692911449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KARGt4PpfElbzZwIBwRvtX7xaDZsIxyiYVnKOlHTyhg=;
        b=UXSQ2a9LHS6FhKUxrxiBG764vnkZsSmkMQ0OaCJyo8NbV3DR/cN7go8L3V8ZMInSav
         MJx/xNppZrHK2AQMNt6RMWXBunZyl26Uv+vGENnPtu662eWO0k9UYHxfTZYEouzWSAi8
         CJYOJC5eFq8XTedTXG3yBf1XwT73KDgHWPhgp+5p5UcNBwpGgJEJjS6LP0hppxhoFq6D
         ODhPqNNu3qveLSF23IPTXp26XKj99zVuR/jdCzYgsHIKAQunzqpU1mdZcBe/AwSVn30O
         kPZ3UxjB7M6FwBjoOz701vvVd9dR0KL7zgqUg2bBSUYV2wI8aBsQhlDhx2ed81dXfOqz
         GEmQ==
X-Gm-Message-State: AOJu0Yyym9Wr4hLVHTjH3UOZjHFKeGcv3pAs1bvVT67B+q8w0NnpK3tY
        h6V9j2SLnoQoEPSICVUO/GyDrABBGFnzhLqlGy8ZOQ==
X-Google-Smtp-Source: AGHT+IGQ252tbGd55IHLjvFB05JtySU6DsEPcHY63A2z15VmmlPP1Kf8NpHuhsLCPory5NR5VYiCYmQ6GRmX3/JgH5g=
X-Received: by 2002:aa7:d791:0:b0:525:6d6e:ed4a with SMTP id
 s17-20020aa7d791000000b005256d6eed4amr655363edq.23.1692306648647; Thu, 17 Aug
 2023 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230817210257.never.920-kees@kernel.org>
In-Reply-To: <20230817210257.never.920-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 17 Aug 2023 14:10:37 -0700
Message-ID: <CAFhGd8qiOQkYB=rW5F6=jp4piwoXvJfnM=ncCzpwK6jauL-huA@mail.gmail.com>
Subject: Re: [PATCH] landlock: Annotate struct landlock_rule with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 17, 2023 at 2:03=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct landlock_rule.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: "Micka=C3=ABl Sala=C3=BCn" <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  security/landlock/ruleset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index d43231b783e4..55b1df8f66a8 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -67,7 +67,7 @@ struct landlock_rule {
>          * @layers: Stack of layers, from the latest to the newest, imple=
mented
>          * as a flexible array member (FAM).
>          */
> -       struct landlock_layer layers[];
> +       struct landlock_layer layers[] __counted_by(num_layers);
>  };
>
>  /**
> --
> 2.34.1
>
