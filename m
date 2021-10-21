Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906CC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6961052
	for <linux-hardening@archiver.kernel.org>; Thu, 21 Oct 2021 15:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhJUPRG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJUPQx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 21 Oct 2021 11:16:53 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F7C0432DC
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:13:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 75so612835pga.3
        for <linux-hardening@vger.kernel.org>; Thu, 21 Oct 2021 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjXozcQMnfIM3dicc9zvKHeODcG75SZtpg7ouGfbVfc=;
        b=jW5xpB2J0jyBp0RMEG/3YYkcELH1lqtEi8p3PzBVZaCRXUwWGFl5S8lc0OQ1W+yXkY
         Kw9ibn+h0mQAgGlNZRFVKMkk16XhLc4gaP59pxuphw+6EXB5oWBmrAVn7sDsfEmlHGL+
         9gvFRczrVhn40swm9MdzYwnX7/xnLUEL2xq8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjXozcQMnfIM3dicc9zvKHeODcG75SZtpg7ouGfbVfc=;
        b=xfvqaWlYJa+s5pQLkDIUmx5kjBHcljO3gyaPKJ8gwg64VPxhuyeMZcP4HNGjrdsi3B
         6lZc10QqEtjD+Gp5o9Rq/vXMqOvL8V0I6DGyfwYNnaIpGhLpTklE4vSHKqy4hflbRTY7
         /v15m0qB6CxsBJxd6T+5SCnUD5ivqqqa5suJfeTXtIkHp/id/TSiPRD1fCv8E4rywT8A
         SK6I0p2z4wsEeamztXxXCcvJU1Wex1Sy+6UBPkvXO9GhQeZMjWxKPMXtFGuUrccfdvuz
         CMXRPta5IBrErR6L+O329G9QAaF0KuNMYiqYXK00u+uznI+AG0i3F8GcmhRzw1F2Ho9A
         5KgQ==
X-Gm-Message-State: AOAM53021paZICKpFr3mKSIzTEOPCneGC4mdTktjit/JjxuWLXa0XP7b
        fcKPMDxxogCPZ/Z/vaUA6kRJ7A==
X-Google-Smtp-Source: ABdhPJx6LGNRT2TP1IaZ8cHA4ospDpLYy/j0F8k1ITp2zTOjd5jCu7IB3rsKv1TLJrGf/O1HRIfG5g==
X-Received: by 2002:a05:6a00:c8c:b0:44d:c583:9b45 with SMTP id a12-20020a056a000c8c00b0044dc5839b45mr6024548pfv.28.1634829234930;
        Thu, 21 Oct 2021 08:13:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s30sm5574234pgn.38.2021.10.21.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:13:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     cgel.zte@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>
Subject: Re: [PATCH V1] gcc-plugins: remove duplicate include in gcc-common.h
Date:   Thu, 21 Oct 2021 08:13:42 -0700
Message-Id: <163482921914.879721.5643296134310047857.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019082910.998257-1-ye.guojin@zte.com.cn>
References: <20211019082910.998257-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 19 Oct 2021 08:29:10 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> 'tree-ssa-operands.h' included in 'gcc-common.h' is duplicated.
> it's also included at line 56.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: remove duplicate include in gcc-common.h
      https://git.kernel.org/kees/c/872268237551

-- 
Kees Cook

