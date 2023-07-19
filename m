Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36F9EB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jul 2023 15:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGSPhA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jul 2023 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGSPg7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jul 2023 11:36:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25110F3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 08:36:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668711086f4so673111b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jul 2023 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689781014; x=1690385814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K38BxEYH26DFGpPyiTmHTMf3gy9MqzicLBbnOKCteTM=;
        b=M31KYUXdWst2TaY1F5jpsUdD4iaP74nNegJ7paY/HMXCBJrbgEohOPoyPhg0NjvTTF
         ZL1bbUaG1BYU4RWYHW3ZzhJaBZRzzB3zcSFsrJUy4zMYMZLN4ilfrMUMcXmvSRnx/t9f
         7LfMVIkncXDARpJfnBf5+vmvQgYgDJrih18Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781014; x=1690385814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K38BxEYH26DFGpPyiTmHTMf3gy9MqzicLBbnOKCteTM=;
        b=VVst6EWCZCiAQPrLfZYLrMYEN+/2/DS5Kxbz/qpjH57kxmMK8mIOTs6lRZnuWJ8n8S
         gKO+DyvJ4ele2kbFj4SMrpV3hajBVnlNXPyM1dDDGsh2WxLQd35Uuul2N1vrlKYvLWfO
         ekFdbME7EzdfOSHMJimtAWvi4s+PNHWDxhD6+/w1l9qgIfyws4ToD6r0qwkh3OXnU1v+
         5Gx4od3hg3Rw6EecwYC9rzyo2cGLd6ESl8xLaMR2xhSnIJNQOR0byb4tK5dF5lTP4Wrx
         cv4SnRLwjTpKPj/2EZwblGSYs+ZPkEpdR28fuuTIzaHVumi7DX9wpclMyDc79k5ggogP
         4Yqg==
X-Gm-Message-State: ABy/qLaPdqPWjDBdfsIZ1AKMORbtLIgzkH66Y5P86pVHBMIkoCc6NySY
        pf30fVL6oriPm1T+Gi0BvB8sDw==
X-Google-Smtp-Source: APBJJlH8qqAz5d6W7EDAD66e1X4MvOuGTuqq1LdVO/pyvNFME1BCH5jDHUK+QmS1hD0xqeuMV5+gjQ==
X-Received: by 2002:a05:6a00:cc2:b0:678:11d6:2ad6 with SMTP id b2-20020a056a000cc200b0067811d62ad6mr4173575pfv.9.1689781014193;
        Wed, 19 Jul 2023 08:36:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x3-20020a056a00270300b0065a1b05193asm3415022pfv.185.2023.07.19.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:36:53 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:36:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Message-ID: <202307190835.752D710D@keescook>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
 <202307190823.086EFD42D9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307190823.086EFD42D9@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Okay, please try:

diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
index aca829062c12..902fe3224453 100644
--- a/fs/vboxsf/shfl_hostintf.h
+++ b/fs/vboxsf/shfl_hostintf.h
@@ -68,12 +68,11 @@ struct shfl_string {
 
 	/** UTF-8 or UTF-16 string. Nul terminated. */
 	union {
-		u8 utf8[2];
-		u16 utf16[1];
-		u16 ucs2[1]; /* misnomer, use utf16. */
+		DECLARE_FLEX_ARRAY(u8, utf8);
+		DECLARE_FLEX_ARRAY(u16, utf16);
 	} string;
 };
-VMMDEV_ASSERT_SIZE(shfl_string, 6);
+VMMDEV_ASSERT_SIZE(shfl_string, 4);
 
 /* The size of shfl_string w/o the string part. */
 #define SHFLSTRING_HEADER_SIZE  4


The size assert doesn't seem to be used anywhere else, but I can do a
more careful binary analysis later today...

-- 
Kees Cook
