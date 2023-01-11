Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68ECC46467
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Jan 2023 16:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjAKQ1U (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbjAKQ0b (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 Jan 2023 11:26:31 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E75FAC
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jan 2023 08:23:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p24so17275860plw.11
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jan 2023 08:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hf+d7wkWFUyItAMFkXKbXLc5dSp9uQ0/QqLUUKb17sM=;
        b=ZIQ3VG2uBVfFV4Kbi0rz2FtOF6tbJEjuK5zyIrlJOS6BIsU+Rdo6SzE8cB+grgEHJO
         ZMmOfr/i29bP0Q9KiBfC+cQpvLIfTPQTSmjFfvWD6+lCxIlnRLi56abXwq5VnwJMGlXn
         XcNg1Dh3hSMKrqohc2wCk/iVzyIHO5IFhahW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf+d7wkWFUyItAMFkXKbXLc5dSp9uQ0/QqLUUKb17sM=;
        b=ep5haVNTNGsJiT+FzTNfrXbV0xr8uUJPXF8en/MatKWZpb8+isg+mubVhL+Ol/3lR+
         xnNVpMB/QM4PRO2CLhHSch+OBJqCyX4DEpVuvPAK0iAi+lOeBVEuqGN6VAHRuOXk1YYV
         XQrjBlBmLK5MortjWz2rfhDKjYwDXKvPNsSlkETVCRNH10NK9Toap/qQuGp5dBJNllgU
         IghxgLiS8ZxEdExRMufiMbQO/1LOP80rxhd9pNxfhtwf5zkJ9J+Tva44kgMemoPjhvXE
         PWry9XkOWD8Wbc2FgtctsZrkiIghpJLcunG3SWdYqiQJIh5r8RqZs90viHWUlofMxCVp
         OsNA==
X-Gm-Message-State: AFqh2kqmVSSo3e9dr0A2mYKjCJiWxGmuSJp1NxmIw5p4N1O4zTGc7Bnr
        s4GMZVDfJh8aTzsmyMSQYFAYXvYkSSTY92Fn
X-Google-Smtp-Source: AMrXdXsG0cC6qSbESyfDU2q3M51WpAApqA6GVPRpecyM0RlRuAjsHI2KkAzTKOB7yTRsLkHctiloZg==
X-Received: by 2002:a17:902:e8c5:b0:192:b6ae:ecc7 with SMTP id v5-20020a170902e8c500b00192b6aeecc7mr39218802plg.34.1673454220960;
        Wed, 11 Jan 2023 08:23:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b00194584647fasm80920plg.158.2023.01.11.08.23.40
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:23:40 -0800 (PST)
Date:   Wed, 11 Jan 2023 08:23:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: Kernel Self-Protection Project meeting
Message-ID: <202301110820.C6020B71EA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

This is rather short notice; I'll send out a reminder further in advance
next time, but if anyone would like to join our every-2-weeks project
video conference, please drop in:

	https://meet.google.com/cuu-hqcm-ggg

We'll be going over status updates and a little bit of planning for
2023. If you're working on any security things, come tell us about it.
:)

See you there!

-Kees

-- 
Kees Cook
