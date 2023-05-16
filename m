Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A433C7EE23
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjEPULT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEPULS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 16:11:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4226EB1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:11:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaebed5bd6so636105ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267877; x=1686859877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLgrvnIbTez+ozLofGFvlDwgzYOgc3jwqI2qiIMZDlc=;
        b=fwxxiq7jxyRdl/2cy/Sv+GQ5mQiGF2Lstfp3s18yImRvFgABuVehmXn56JwCzbRdhQ
         KKufXmevtlLM+BTCz8VLc/cV+T/YAzLqsHnyHdPBjeUiw9eAvpKfIulQlnKV0CKwMsFA
         jKjaL6cYIgkSXEiU+Ok8enWf1b1VtTDsVqZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267877; x=1686859877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLgrvnIbTez+ozLofGFvlDwgzYOgc3jwqI2qiIMZDlc=;
        b=OKsd7cJoW470B0bSZVFxmJLPlYxXmrKtJFRrF+Wm028d45RoxquxxOT0ApjgAbQ1GK
         uBuNzS1QTglwIgDr9fl3bmL7wOaeQOH80oNN6Sj0VwxnESIklwlori6jk8956G/iHbIw
         gJknuXK4ajBZdwCeUl/gCb67jIqMZEe5lzGheF9fuiyN3bSp5J9p7fMd2TJNkPLewMuQ
         WUFtBg008Pm3URUDrudhveaLBchNrADPvhujdKgA4AMyhRafikv0C4Nv3+rw5ygINFe1
         wpJQzxX7o/TfKHkNc6XQN7vLzeAE4pGvJbp5W7cIsQ3qxJOhvsqmKqCPTX6cLaKriV/f
         r4Lw==
X-Gm-Message-State: AC+VfDzjkD3z6tqCtcw6ZsmDBhhbNFa1KkHaEN/3T63aEZqfY9Vwa8+O
        XTGNfVD8fNlawIqOIMCorq3ENQ==
X-Google-Smtp-Source: ACHHUZ77IQniMgR4Y8NUBFcCMRu/KSrWXIuCgUNNDXjyikpYHkbmnL7WvFx0Bd2z/BIHgQdZGCLeMQ==
X-Received: by 2002:a17:902:8c98:b0:1ad:be4d:5dfe with SMTP id t24-20020a1709028c9800b001adbe4d5dfemr21153767plo.27.1684267877266;
        Tue, 16 May 2023 13:11:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b001a1a07d04e6sm16019154plb.77.2023.05.16.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:11:15 -0700 (PDT)
Date:   Tue, 16 May 2023 13:11:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161311.0A9B37E131@keescook>
References: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 02:39:56PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement with strlcpy is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
