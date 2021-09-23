Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7217C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9947161090
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhIWVaJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243306AbhIWVaJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 17:30:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B66C061574
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 14:28:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id n18so7615028pgm.12
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl6ksqPQqIKN75JFfTH6/Pk9+YdmSlLlZkO55PLhGvg=;
        b=BV/wAeAcKrUfFqRtuNdJIeTuspgGV6AZ+VbKCN1M1VWT70s0U/7xhjjjN92VtgjVwT
         3hjnEgvV+h3U0mMRSnLcBzLKsiYaMpPwARmgldSeHOitU3V3120QSgcrSIf7QqGHJC9W
         Pj01OweZ6+JrIm797hNb+9i/3zKzNwIMn/O9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl6ksqPQqIKN75JFfTH6/Pk9+YdmSlLlZkO55PLhGvg=;
        b=GAyS+51CRK9FJL3J0v70ft4kIZloPcM4xHQp5Pk1yFwA8h8UEF/S0yIe0MXj3eW54Y
         CX4KK8rdhD4uVF5zJQ3wvGJKWxWTQ0hqtGDiS+ZroQLk7lsw86W4ldPQg68RLPFH/BvK
         tH2x1YJB+m5DyF5bnJ/xFC1JsiYBxeA3R2nMBGXMgdFptXdakFxLyrDRYcKy4zc/vl1P
         bsFJLVMzCUTyzCaP2FUe+HES/sEaTKgtWt12V6cQLJlkmkvtEkmc/NwO82dzbAwB+iak
         T443/BUJHp7pw+hFpdEAMoAEgw5hpJ8o0AvPkCjyyHe8paFTCmx7bi0/VLKM9PLQNH20
         it5g==
X-Gm-Message-State: AOAM533ykmtTIyD4BLUjMfcEGk2G7ZCQOh88EnVMo+ANWE0FzY1Vw2Rn
        p0F9l/chNuNgjil1afWpV25Glg==
X-Google-Smtp-Source: ABdhPJyQ0UA0Ckii31NthkiiXEqic9HxqS/w05InILK1pO513pensGWmz+dwfR30d5QsvXbXtNFjkw==
X-Received: by 2002:a62:6d86:0:b0:448:152d:83a4 with SMTP id i128-20020a626d86000000b00448152d83a4mr6310631pfc.38.1632432517135;
        Thu, 23 Sep 2021 14:28:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm6215502pjj.42.2021.09.23.14.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 14:28:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] gcc-plugins: remove support for GCC 4.9 and older
Date:   Thu, 23 Sep 2021 14:28:20 -0700
Message-Id: <163243249065.3933714.17684575354417357483.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922182632.633394-1-ardb@kernel.org>
References: <20210922182632.633394-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 22 Sep 2021 20:26:32 +0200, Ard Biesheuvel wrote:
> The minimum GCC version has been bumped to 5.1, so we can get rid of all
> the compatibility code for anything older than that.

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: remove support for GCC 4.9 and older
      https://git.kernel.org/kees/c/864552765859

-- 
Kees Cook

