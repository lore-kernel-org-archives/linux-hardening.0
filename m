Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE92DC433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FD661027
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 18:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJFSEB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJFSD7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Oct 2021 14:03:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77957C061753
        for <linux-hardening@vger.kernel.org>; Wed,  6 Oct 2021 11:02:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c4so2208443pls.6
        for <linux-hardening@vger.kernel.org>; Wed, 06 Oct 2021 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EG8j31Vcr06OO0AkEnbVwb8A1TK2ZuJTLW5vJccv8+U=;
        b=kyQfZHTuGRS3x7+q3DhtYRabFYQAZrB1mJCuvDtH0mtIVLxEp9hNPNBVAAN+IX2wqk
         NT3vGYdNyZVngtG5ikkNHpFN609iBkyuh+oeZfjl7lW5OiiZzRUzXS0+Zrbn5Cj8aAzA
         hoewaqxmzmvm1GgQcd5QguIU3FyNTea9K8U2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EG8j31Vcr06OO0AkEnbVwb8A1TK2ZuJTLW5vJccv8+U=;
        b=mxkLnD+T3rjK80oqTA7MNfAMgwo85YYFCUYma6RFBM8imch2aqZGI016hFN6BJorIx
         kWot8qWcmmsE+1fiSQRosILUDKvmh/JeEBoQ6yb8YdVmID0Y9QO5IXBDeJ7BkJTL/LQF
         6UxFd2IlxsC33GFG3KhVztEwnr3vS8NAhq0hhOQtqp8jPc8MfJrNZvUcR/kPqbjFhPBA
         Tz2FIBzn6/KEUiOScUyqjUpMSChtibVos3R0S2I3DZpsNop6NCq6cEuprWekkgjYw1KM
         YWqq0cLQc6K1Pq1r2fjH40quVa6TcOeTuDMqDfguJOJrtvJPUh6kZJbfd4KZNoqDmr0E
         u00Q==
X-Gm-Message-State: AOAM530FKVNpVyuHbpIEKxkqCItiJBD6VcfBOPZWitsp6zJqaxDpyhXY
        1VLo5nwUJWBVSpTMKFygFAXCqQ==
X-Google-Smtp-Source: ABdhPJwqIGhj94Z4ChDqPf3S3GPhPLzwMf56i1qKB0Ek4TOHgDRWvJKzVHuMHSC0/GVQpPuDvZVk/A==
X-Received: by 2002:a17:902:aa88:b0:13a:95d:d059 with SMTP id d8-20020a170902aa8800b0013a095dd059mr12467927plr.65.1633543326814;
        Wed, 06 Oct 2021 11:02:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12sm20908080pgi.21.2021.10.06.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 11:02:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add "exec & binfmt" section with myself and Eric
Date:   Wed,  6 Oct 2021 11:02:00 -0700
Message-Id: <20211006180200.1178142-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; h=from:subject; bh=jlsQHm8XF6DHzxt252D/9lsthhPYy3DOfgA1oJ7BBOw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhXeSXH/CxB/y5SqE2evX8LGc7ACYrGw3tQMmBRWjg AVLxizCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYV3klwAKCRCJcvTf3G3AJp2bD/ wNmn1qQtT+QZu4DMDVwK2/i1mB14z/WYMDA28LxFDVQOYP8gs5jv+jjVfPP0foOfM4ftnrIDsdaozc sq22UDQfs68bVgMl5lv6R9u28m0YR34PiaBosKsBfwN8c4pQ7Vcl+4n52RO0xG62hgHdz/M2q8oi/L xHjB+IBXiaCPyG7ViEPF12AEOIGsbGJxpEtych+5bpp6aiQ0PHxQhCO6XA5N1nRs8GuAOWM8OfRsmo Ha7MfK/2cgUtN3rxtZPitucPLKP2+TwBIbTMnfJ8RIUrcKNy/xUU6XH21Ib9LXIr9eXMRcQQexrV92 cfR3+tUvz90Vs7Za7KKLS1TYT5hFGsOVDyTdOIPZjHGJGwkPWFJEvHh+IN+q43tRb7jTQ3DeQKQki+ QzYWfWQKch2vZx8Ym6LcTryFJsiSt+OHNq5UhLedweZ+zy/cJ6K2KOHrQRZCufqw4VJKqHhDlNtpXA QOVzsQJlZQuicB0FxzRDf7CcbpN+Cgdib0k0VQ99jId9vjvjZocVhcSwUoyHfltJ3MMYInKI4XuD/U QkajEB6ZV5TtfS3oUQBeyS5gCadoBq+Twfz0FvUHTHO5dQXED4J7RIjHDqrt+TukT2/3tU/yfFJvmN ltwqWWAyPL6e6uM927ZV/rDxVdM1dlsdAfD3aoT8csskbbMcwPqsnMNqF8hQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I'd like more continuity of review for the exec and binfmt (and ELF)
stuff. Eric and I have been the most active lately, so list us as
reviewers.

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..385b12e37c43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7020,6 +7020,20 @@ F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h
 
+EXEC & BINFMT API
+R:	Eric Biederman <ebiederm@xmission.com>
+R:	Kees Cook <keescook@chromium.org>
+F:	arch/alpha/kernel/binfmt_loader.c
+F:	arch/x86/ia32/ia32_aout.c
+F:	fs/*binfmt_*.c
+F:	fs/exec.c
+F:	include/linux/binfmts.h
+F:	include/linux/elf.h
+F:	include/uapi/linux/binfmts.h
+F:	tools/testing/selftests/exec/
+N:	asm/elf.h
+N:	binfmt
+
 EXFAT FILE SYSTEM
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Sungjong Seo <sj1557.seo@samsung.com>
-- 
2.30.2

