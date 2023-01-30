Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B94C6379F
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Jan 2023 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbjA3SUB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjA3STu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:50 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104B3C280
        for <linux-hardening@vger.kernel.org>; Mon, 30 Jan 2023 10:19:46 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id w13so1400113ilv.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Jan 2023 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFIqgVTcMIkkVJ93WrMRe7xk5hOeBy6iHYq/c2dnAus=;
        b=BOXkMcmV7Kg852E/lMV7VPR9bxQHwZJ1VHOqpllPBP1SPusf47QZzPxzqalItFJl+E
         h6nY4dhdr/HYhYO0zqlz9dGhFYDJIhs8qJoibnsTiBOqLYIthHpGfkJc3OH6cH/UfAL+
         CYsejaXnNlcgjAXUTVlZ9/Ibodd9dneGfTxTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFIqgVTcMIkkVJ93WrMRe7xk5hOeBy6iHYq/c2dnAus=;
        b=kjU010PDTAvYHdI1i4RDDZnPwHeNjFBekOZ8kM1o7CO6N0drvxYU2M430/h1lLDtMB
         rfuG29v/p9ZW5hk8aT1YHGuCQ7oRkb4HEbC4oTuzpYj0SxWoSBGVetwx2w6k/xYdiF3K
         t0hGbeA/DX2kK4Zr5vQdxZANnT/Pf9NRWnYjtxCYYmLke9QcjxYe88HzDT+PjpYs/g2g
         AtgV00EUpewv91mCZyM+SiYMUUiZvrRGTmf5pwn4svx536D/dktohK8HSHQt+kCwBHLB
         mqmnwGq1USWL7bbA/wWFXdTYPsUyZ2YdFuQrgzw2Mwrco9x4bHddqTCMHSbD8bI4ycPU
         3mPQ==
X-Gm-Message-State: AO0yUKUo1+o23aPb1u4tBKqmzYe+MoTI3phEYNiXt3G8tcZ+ec2zO1OT
        egNxa5LsJY0kgNTBrrZJ2W12xA==
X-Google-Smtp-Source: AK7set8M9u01+a5gnWBWumGHfQfWw+OV0WvXprCsJSsUeNjRozqjV2EnxgHWdTQxe8fVrDNFccalzA==
X-Received: by 2002:a92:b301:0:b0:310:be1e:78e6 with SMTP id p1-20020a92b301000000b00310be1e78e6mr7959753ilh.26.1675102786604;
        Mon, 30 Jan 2023 10:19:46 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:46 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 8/9] leaking_addresses: also skip canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:14 -0700
Message-Id: <20230130181915.1113313-9-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

scripts/leaking_addresses.pl only skipped this older debugfs path, so
let's add the canonical path as well.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 scripts/leaking_addresses.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 8f636a23bc3f..e695634d153d 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -61,6 +61,7 @@ my @skip_abs = (
 	'/proc/device-tree',
 	'/proc/1/syscall',
 	'/sys/firmware/devicetree',
+	'/sys/kernel/tracing/trace_pipe',
 	'/sys/kernel/debug/tracing/trace_pipe',
 	'/sys/kernel/security/apparmor/revision');
 
-- 
2.39.1.456.gfc5497dd1b-goog

