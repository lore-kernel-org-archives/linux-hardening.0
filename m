Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B2CA0FE1
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 23:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHaXUa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347852AbjHaXUa (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 19:20:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F210CC
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 16:20:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401f503b529so13763705e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693524013; x=1694128813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWZZJ4W2c1JEb6sxHZjM2rWbFiQYVpX5RM6za8+8n6s=;
        b=2p7Rsowql8DWRf0YXiAUawrq76ymvQmb3JdU1QoYvxHQFP/NEKi1nRFPElq+99MZf0
         Z8F+Nvvl4/ZXFtPytxZcqBTgit5m0QUTp5pSqj4A0hOOFfrbi3pL8cFSPzZ1OMTHrZ+3
         y8FLwM2oHf+tWtfp1862AlMTngyYmqWfHenZtIbSrQmponF/BPrIwwipDPhz/W//1wsM
         Qxqp7vXkgPeTVJuXUCxjGJhL1IZcV1NJDtZWD+AzkkMZ9uuIjT6EQf216eU5x8FwrjnF
         fkH4NqpLyOv0oIO0VsmSqWvnpATcGmx3eLaMW1Rl2TRstS04wP3Ig9RgAH3QtLqW8/SK
         neXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693524013; x=1694128813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWZZJ4W2c1JEb6sxHZjM2rWbFiQYVpX5RM6za8+8n6s=;
        b=KeV2gfk4Vujhi9AXRZIwySkqdnyidL7Cyz7py77S5ikOkC/H8IBnAeUfZYaf5lg/uO
         6JY56tsVGoLSPNn2IkO26RRMs0ODEIb2o5vi8P3XptpDjgvv8GrCr5Rj8i6Z2ZDZatQv
         ZsfbFTm/aAxXJnr7BxU8K/eMqsv5SDgjhV9HL6eX+SNLa2+xZb8d05Gmgb4LtvMROGZp
         XDhA7OlzRtN4Gvgf5RgQAf2BJc/slrxyhDw3V3Qt2QzgJaxyjDR0APblyCvxDxO7uPaH
         YX44vsPyZqsmihiOyTpasG00EoFnD45Ui7jT8asuF0wUKWKrYHDPkRqqtDAZUE21nCqi
         Fi3g==
X-Gm-Message-State: AOJu0YwhmYb7BSP4oZJNvN9jedDE15AmWZB2ijGO9/UXR1W6Tor0JEvI
        meKNW4m1LrjZUfOtcF41yDYd8Jg+PPFoDe39V/2a+w==
X-Google-Smtp-Source: AGHT+IFY/qULbZslTUFY83I+dyYF857ayC4OzKQ7adtPZGuXyLPjh4tXVAQxgl2KHb//SBEIgqvNsv53UX8QmJLJrCY=
X-Received: by 2002:a5d:4b51:0:b0:317:5b1b:1a40 with SMTP id
 w17-20020a5d4b51000000b003175b1b1a40mr619080wrs.49.1693524012629; Thu, 31 Aug
 2023 16:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 31 Aug 2023 16:20:02 -0700
Message-ID: <CAFhGd8ruFyv=eL6XXY3FQWVAa3SAy=uBebLReGog0oSwE6XUiw@mail.gmail.com>
Subject: Re: [PATCH] trace/events/task.h: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 31, 2023 at 12:42=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.=
com> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/trace/events/task.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 64d160930b0d..47b527464d1a 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -47,7 +47,7 @@ TRACE_EVENT(task_rename,
>         TP_fast_assign(
>                 __entry->pid =3D task->pid;
>                 memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
> -               strlcpy(entry->newcomm, comm, TASK_COMM_LEN);
> +               strscpy(entry->newcomm, comm, TASK_COMM_LEN);
>                 __entry->oom_score_adj =3D task->signal->oom_score_adj;
>         ),
>
> --
> 2.42.0.283.g2d96d420d3-goog
>
>
