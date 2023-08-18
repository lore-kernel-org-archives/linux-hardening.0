Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141B7EE498F
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Aug 2023 20:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348310AbjHRU2f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Aug 2023 16:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379972AbjHRU2Q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Aug 2023 16:28:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2656359D
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:28:13 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26b41112708so984320a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Aug 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692390493; x=1692995293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v60FDO20ZAxtFMTdAZj/3F1vLPNsJPXHCNB4+f8djcs=;
        b=PR1eUDciDw3CPju+jDsnRqMHc8co33Sg0jsxctyLZ41+/b0eAYCcWRvb9xAAoVVY0G
         fJb67ntMpe8hhLygWL0N4PTB+n+2TnH8jURilUG6yItQLotw8XlaIn7YLyxZqxhrOCpB
         /K14w5joSKe4RLtLXhmfK6QUNYpvbVkl9+qpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692390493; x=1692995293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v60FDO20ZAxtFMTdAZj/3F1vLPNsJPXHCNB4+f8djcs=;
        b=epf1VTEDJCbltT6YHZU/NszE6xLx7dHPlS5xAiyO9R8MYz5tLPUpeSYJ/v8BklfYip
         OtbuhrK5hlVdfufuTczjOSStEeklAP/qPGx1Nf8uPrOWiYLpsWV6/4wxPhEaf/eH9I8v
         nPW6+atJMmxEAx9FwhpjvE9A6ZhuCmYZKbpI+55tdiCpRb9oFLMCK9cgTyJisoqyvtTS
         pW5TFWVrwgoYtWDKADw4qnX8VU0TCwevGJtfUxka2oCL8qGf7ZBrKgDcYdAKpLrfHX2l
         fLHnX9ltOMwn3UV/+EQVMnQuuQMq97rcQ7ETabQk/9dXieq/u9ogo1fl+qjCrJKbpSB5
         8rBA==
X-Gm-Message-State: AOJu0Yw4yI9YXUp++/yJHHOXr3sK582bLqV6oQjR9PoRODLmyeoc9Q3B
        2Etlsch/Je3mfFR4qWbKcFm+DfOo1uYZ6XQVYtA=
X-Google-Smtp-Source: AGHT+IGW27VG0ehBsoRuaeA6ZSy8egeqxLnm1CvFIa/7yUbn/YoeD0meZfjWa3C1CGsJy9/1D2g/wA==
X-Received: by 2002:a17:90b:1486:b0:268:1dd3:695e with SMTP id js6-20020a17090b148600b002681dd3695emr212937pjb.49.1692390493278;
        Fri, 18 Aug 2023 13:28:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090aba8800b002681131c36csm3675060pjr.45.2023.08.18.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 13:28:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-docs@vger.kernel.org
Subject: Re: [PATCH] pstore: Fix kernel-doc warning
Date:   Fri, 18 Aug 2023 13:28:09 -0700
Message-Id: <169239048671.1533264.10988269625035078525.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818201253.2729485-1-willy@infradead.org>
References: <20230818201253.2729485-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 18 Aug 2023 21:12:53 +0100, Matthew Wilcox (Oracle) wrote:
> Fix the warning for the description of struct persistent_ram_buffer and
> improve the descriptions of the other struct members while I'm here.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore: Fix kernel-doc warning
      https://git.kernel.org/kees/c/af58740d8b06

Take care,

-- 
Kees Cook

