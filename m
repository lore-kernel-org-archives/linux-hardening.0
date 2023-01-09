Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA9C54EBD
	for <linux-hardening@archiver.kernel.org>; Mon,  9 Jan 2023 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAIPCv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 9 Jan 2023 10:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjAIPCk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 9 Jan 2023 10:02:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965061E3C0
        for <linux-hardening@vger.kernel.org>; Mon,  9 Jan 2023 07:02:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j7so3452102wrn.9
        for <linux-hardening@vger.kernel.org>; Mon, 09 Jan 2023 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=scl7HLexrpFzAYNM3X4Ky/syw+DSRPKvSDyrAeIj/Xg=;
        b=CHAw0gyVrDNWcveZsiRpEav4fi5ABoJLK1XGYiKBa66qrmavgFuFlULji9Ksy5Rhes
         7u8MbCeerP408xQzp74L4b+SCx0M7vz3LW3KHOX+3/J6lxiF+hVo74e/V8EnBYUaLYBE
         6OJmIx0bOpVa6/cUALHUWhx2XJuqIXHZIUDvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scl7HLexrpFzAYNM3X4Ky/syw+DSRPKvSDyrAeIj/Xg=;
        b=goishdtJaWN+BaOQU2M2Y8ZpaP04WqDK5SE+FN5WUlXsRXwEnPAWNbxzTz/+oR9Tp+
         6b5TnLYqDt0NQmEcB6UBbCadHeX0OlE8Sx7ffuj7ZSbf8Zw1qIi/UeKEIDO4pdxhec2N
         pE/LlpUA4Xk+P70paupPEWSXXAU6I/VU25s/c5k+x04VbkoeMY42XE4HeQkxUgMQCzIC
         jmOywub740LbLoaCZ4ogEU75P37Y3tvyqBjzSco/sxNlyzhfas6WxYP4fgMVljBcbe8V
         zdOQCYBD1XKmdws6gLSBxNjG2JtSURtJQlaPLBWJsTBGbtJerIkOh7Zn7mdeIzP2DpoF
         0HCg==
X-Gm-Message-State: AFqh2krb4gS41D9kkCw1dPgUwVRHFgevYaLHGQgzGZkvCOfOW1cw/5DZ
        Tt6KabAZCR7hUJfJFx2F2D0+R+8U5nscnu7iZPZDqg==
X-Google-Smtp-Source: AMrXdXtLHNDyjnAL6zJ2auak1fOjOH8s3wFDYd+GVe/s63gydlggFzt/GvG8ozXZivPLVgmRLHLdDbUmdMJBWoGbY10=
X-Received: by 2002:a05:6000:1001:b0:2bb:3290:2540 with SMTP id
 a1-20020a056000100100b002bb32902540mr467948wrx.18.1673276558005; Mon, 09 Jan
 2023 07:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20230107031406.gonna.761-kees@kernel.org>
In-Reply-To: <20230107031406.gonna.761-kees@kernel.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Mon, 9 Jan 2023 16:02:26 +0100
Message-ID: <CAODwPW9SaomZjWQvR1mmV7OzvQkq-_XoDgSmK04fO5rVMGHmpw@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: coreboot: Check size of table entry and
 split memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>

> -               memcpy(&device->entry, ptr_entry, entry->size);
> +               memcpy(device->raw, entry, entry->size);

nit: It's a bit odd to change the source pointer from ptr_entry to
entry here. Technically the static analyzer would be within its rights
to give you a warning for that as well, because you're now
"overrunning" the source struct instead of the destination one.
