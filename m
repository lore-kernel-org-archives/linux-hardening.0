Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BAC83F2F
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 21:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347489AbjHaVIc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347473AbjHaVIc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 17:08:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7208FF
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3e943762so1105497b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693516109; x=1694120909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdS6aEw25mYoGsnnq+Zex8meOo2Y1HUCQC1ip4dfp1s=;
        b=kwVIlVcTfzt+KWLG+1QxfliQ0vfeuWKZs+EVHZi04zykGTKKvMn0FdK2p+8CO13npp
         zqXju9sqeWMu24HuE1+TisbyGNK4tfwHmW4kcoBDytClrdh8Zk0AZ3WfwCYWmmjmVZ7A
         Qo45c4AxUImEljx0m1GQCU2d10Om+PQmPUBG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516109; x=1694120909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdS6aEw25mYoGsnnq+Zex8meOo2Y1HUCQC1ip4dfp1s=;
        b=MXbG1w6Xdl9lf1yH0em9+apkwGcjcowFopN1bY4FxkpsYKcnyq1cIzpDntXwCt0Vv2
         WGHSg9ipuL5T1RV0y7Sf4l+wx/EVIcX8TlKd5qUGexY0xlLH4+VKtVFnJybSmQ6Lb7Zp
         vEWQkv7kOygD+8MY9DfrBxpdYSU0+3Krycp8JbbjkK95Soi+f/grcrBYrhjxXkhjxmnF
         iMp4MGXT1uQWZfvcNdNZCa9TIDHrRmbSQN8f4d0L9re1aFDwWR4ylH0ziCxt9AyNS5DG
         3L5gjE5YV3Sv/hkQpZ+r4QX31zoa7MZJTRb5q/1CGVLN5Q2NTi0UQbqhgtH11rYIh6qX
         WJTw==
X-Gm-Message-State: AOJu0YzizWlxKcUYu4Q5mVyaki8sYZutR1UuH65TIEgDF9AFaTZXNLSD
        zwZyp6Wir1+a/9wgMzcHQ3VdUQ==
X-Google-Smtp-Source: AGHT+IG3xkW1wQZbnGgPAEUzCt2GSCDdKOHcgxWVXIAe2RZ1/F3iEGAIqwPDUkiNDC9TTJhgLxQd/w==
X-Received: by 2002:a05:6a20:978b:b0:131:c760:2a0b with SMTP id hx11-20020a056a20978b00b00131c7602a0bmr835978pzc.52.1693516109106;
        Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j22-20020aa78016000000b00682868714fdsm1746918pfi.95.2023.08.31.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:08:28 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace/events/task.h: Replace strlcpy with strscpy
Message-ID: <202308311408.A73103C41@keescook>
References: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 31, 2023 at 07:42:12PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
