Return-Path: <SRS0=pEkV=DM=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE1CC4363A
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C5820774
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D1tSC+bu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbgJEWcj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Oct 2020 18:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgJEWcj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Oct 2020 18:32:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F25C0613A7
        for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2020 15:32:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so640052pjb.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2020 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qMW+aSE29mfc0dpFg0kQzfT3L9pQ5NkimhwaHnFfZs=;
        b=D1tSC+bumb62FgIGuo+8IB6KKGvW+KNTkWvAdSYY2bRIgEq9C6S+Z88icDO1jVROY5
         n3yUAhc2SyGGCNaXTN6Wdf0jb9giw3GvZunM3yF7hSg2h8WjkjjigyBynFZKlcbw91VJ
         umb88IgY2RRQJQ89lS+ajaXOsC/+8/NtDUE/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qMW+aSE29mfc0dpFg0kQzfT3L9pQ5NkimhwaHnFfZs=;
        b=FsdWrjxUtkXPmvDKbWsTAs2UU6R2vEAYQN76LqB9DZdni17AudrF6+uH3f3v4gK+2Z
         PawZLUI8oqAppOaKJr+B8w5IqsJXU14RP+M1UjlXMZnZy+pSmovn/luJS3qLsVS+QstY
         Z2t1+jCTgNwlOSaBVEd92+UXCqC8y/Cfm93KQrMQpxdj+AkKHdikHZR89sa/1u4sDNFP
         aF+3MR3uVqkK1nIKdVJwPfqZ/VysOsRtSfhr56kn0Z4JF4dU6B+XjoRf0hR3Z7TlisEu
         WBrkRpIhr1o0Hupljf4pSrGb26VHvdIBHPaFZkvgglSvjxuDhy/fbiCG7xT0114rakKB
         5/JA==
X-Gm-Message-State: AOAM531Gw/xtJbsZJujrFgGCKRQuast9zt9D2eIWn3rCZdIZtofb0yLx
        39srOPXBTu1cfBCpSagLXvbgMrBZWLDswG3v
X-Google-Smtp-Source: ABdhPJwwpxHZjbDiRNiSwr9DTv3L1UTxRsObme+bs9Tfb+P06XarACrEbQKo1i6IJJSR6rcMe+2zFw==
X-Received: by 2002:a17:90a:d905:: with SMTP id c5mr1521662pjv.24.1601937159034;
        Mon, 05 Oct 2020 15:32:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm940040pff.71.2020.10.05.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 15:32:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH resend] seccomp: Make duplicate listener detection non-racy
Date:   Mon,  5 Oct 2020 15:30:54 -0700
Message-Id: <160193704489.2698420.14892403272288554518.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201005014401.490175-1-jannh@google.com>
References: <20201005014401.490175-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 5 Oct 2020 03:44:01 +0200, Jann Horn wrote:
> Currently, init_listener() tries to prevent adding a filter with
> SECCOMP_FILTER_FLAG_NEW_LISTENER if one of the existing filters already
> has a listener. However, this check happens without holding any lock that
> would prevent another thread from concurrently installing a new filter
> (potentially with a listener) on top of the ones we already have.
> 
> Theoretically, this is also a data race: The plain load from
> current->seccomp.filter can race with concurrent writes to the same
> location.
> 
> [...]

Applied, thanks!

I added the stable CC, but I'd agree: it's not so urgent that I need to
get this into Linus's tree ahead of the regular merge window. :)

[1/1] seccomp: Make duplicate listener detection non-racy
      https://git.kernel.org/kees/c/ed2d479d3335

-- 
Kees Cook

