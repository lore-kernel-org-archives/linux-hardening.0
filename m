Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B3BC43381
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Mar 2021 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7964EFE
	for <linux-hardening@archiver.kernel.org>; Wed,  3 Mar 2021 07:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbhCCHXD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 02:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448279AbhCBW5j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Mar 2021 17:57:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B5C061793
        for <linux-hardening@vger.kernel.org>; Tue,  2 Mar 2021 14:55:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id i14so2917178pjz.4
        for <linux-hardening@vger.kernel.org>; Tue, 02 Mar 2021 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pM6mjp7Djg5f4SfTpdFFbjFAr1aFF/cRYCS7fpxDU34=;
        b=FC2EN+w/cXbE1L5iUZKDDMVf/ajqnUFTPcgwXMyPPNXEisxojZOeWN7kI0PcCrDfl6
         DnmHKfwqg1mNdwfVn/hxeNTQzLD/KtbPCyYfuU3gsMwMd+bJEEnrDT3cwWIVHDzz1S2M
         VLtUVgDXio9VHYft98UzqJuc3DyDrhGVuYI7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pM6mjp7Djg5f4SfTpdFFbjFAr1aFF/cRYCS7fpxDU34=;
        b=fWmKyzHBD2TxK8Z4BtcmsL+4id+VLr1AcVAg+hqsK+13PkSlRFyew4oORUvHsYUkrM
         oq8JSZRN0LqcmR3IUSbE+HYYCAUbxg3fk3moQBI9ozS7NMjD+cYT6H3NE7tEeMbNIS5o
         2ivYjv2apoJs8w6J1AoMP6dxOp501qxIC8WTYNgSL1XF10vGCGDljKwmAlREyr4j93un
         iyTHDesKEd0e4PoXwo4LraI6q7PiEI3FhU4iOQ8UWb9on238qxhM2b/i5+4ggdNdm/67
         30ij7mvuDlAXprGl+NKKhT/PgWbTpKNKv0cX91l/kZG1fvyPFVxglyD54WB6995vBoGi
         PKJQ==
X-Gm-Message-State: AOAM531CAl42JZaNnbfWKNG09sd6b4EEerzGmAm6Kj76YxzEJ4JLXjsc
        Oe4mESg2vzYy7nKqzVpfOr1xeA==
X-Google-Smtp-Source: ABdhPJzx1XXVtj2bqsB5LrqzwDcX+R2r7mCiMlPMpiva5NGwceFqxpHsSETbyRK9dWNkX3ZA3qqFnQ==
X-Received: by 2002:a17:90a:8d84:: with SMTP id d4mr6628292pjo.56.1614725735845;
        Tue, 02 Mar 2021 14:55:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p23sm21587294pfn.204.2021.03.02.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:55:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] gcc-plugins: structleak: remove unneeded variable 'ret'
Date:   Tue,  2 Mar 2021 14:54:20 -0800
Message-Id: <161472564886.3871405.3468382493884029994.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418070505.10715-1-yanaijie@huawei.com>
References: <20200418070505.10715-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, 18 Apr 2020 15:05:05 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> scripts/gcc-plugins/structleak_plugin.c:177:14-17: Unneeded variable:
> "ret". Return "0" on line 207

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: structleak: remove unneeded variable 'ret'
      https://git.kernel.org/kees/c/b924a8197ac7

-- 
Kees Cook

