Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AC7C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiAYWAk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 17:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiAYWAk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 17:00:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F54C061744
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 14:00:40 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id p37so20983808pfh.4
        for <linux-hardening@vger.kernel.org>; Tue, 25 Jan 2022 14:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+gteY1m43RHWpAycmbb69VeDmwEbqJifo/y9P69NPY=;
        b=ARuYewZ5nw2ffzLdYlSu2aMvxPDlJPeFoeXQevHpAhWx0mahldaPAuZCLMPBWq2m1W
         VXOncIt0HDqQbaC7oSXbooZ+Yv2BRa7af2HpboJ7/rLYHtXUsQeMnKSZoBr3U0adBzJF
         ulCr0dgQp9UF0A3gkAK7uqKN1tMapR4NYI2ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+gteY1m43RHWpAycmbb69VeDmwEbqJifo/y9P69NPY=;
        b=hqZcdKrvpiXBLPGs0w9JieHxu5E2ViPqgJC+81g1C728FanCzv/atCdQebtXaftJI+
         jfffTbAHdA0zongKCYXTD1iUwkDKotseMNQoqZdRI93NZb9OBTLWp3XVVDQNp0toQwP+
         CIXMe3zk5cxqxiP+ULNIrq96z+6j93AWW7p4VELEcEvEJqgXQUtwsWl0q1CO0Kh/NiP0
         frXp4tpjQzr/LVr3+isu5WGtBV/INH7BZfraSrgwH0emNwLpVYDsxr8L4ZEp3Fy/plcA
         gOoKXUY8ohtwvDSW8CD35f+0WAvwzZ0vfeLBuCLzSMdMJyKjm2fbaYeIZJpKmftOesbT
         3OYQ==
X-Gm-Message-State: AOAM5327NcdzAEE86D+8UijOvEs1OWOUHyKRTyLZQSRqRS3rziJLp/QR
        EqMFonndNqhYBTdSLviq9YJ/Tw==
X-Google-Smtp-Source: ABdhPJzes72NzIlsk1hNk11tlJURFS9Irv2XtzmUVNkXQUCwSAYsjCxvGFNijeJsuUm756MAeqTZaw==
X-Received: by 2002:a63:5009:: with SMTP id e9mr13537396pgb.9.1643148039767;
        Tue, 25 Jan 2022 14:00:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm1274268pju.7.2022.01.25.14.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:00:39 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] perf: Avoid -Warray-bounds warning for __rel_loc macro
Date:   Tue, 25 Jan 2022 14:00:37 -0800
Message-Id: <20220125220037.2738923-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; h=from:subject; bh=3xCm2+8JkO8X0PscRpFVHhDSlZ1UoLF0UYBAebUszpA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh8HMFGIbJFCGrr+z4Xoy2f3YnntnkP9QDnMb6g02i TSwvyiSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfBzBQAKCRCJcvTf3G3AJqrsD/ 94nj4D9vdN9BWSEEsomamjGEI3J1gCXW+xZ5u7sv0hL1ocGMptGpRIjUC+iXq+GiEW0inZGRByQTz9 4gJVDAWiYy2ZrJAZJacIym4Wnq6YFnAGSl1XPra9r38LFN9yPBIVycYlcoGp3YmlPPilwey9ZP6jtV 5CtWFtr/jt/UNRUm50e28eeO7lxElLxll1OAbW8Vf7LOWyiGXSWzFYUmDWy8u756vkAq4wKd82Ch5K SQh8YtmZoowti5+PZjRxZLsGsHRfjaQ8fZtonvqUNLomp6y4gOB2Lku9JV5gvFvBvMf1rBADSdmiBa t7sSnBU95/9ch6GZmf07QcBkfp2LqZNVCDj8AoKh11eGXVBIlkzaN/OHEAbkHDv/sD2CWYZdOJL4Ok HjEUn2QSOho3O/mV0MAV56pd6PE9PbcF64H0XzETheiDRWgab5rp7/2NVV+LFYPKl2Y/RyNCWYTzM2 uAU+M3sLoylxS0nu1VHREqX4Ty+3v6Nq7LQ/DkptAzYMRz3XgaxpfMMnwLZ/atoDYbQTn7bIScVKYL V6JwuEofnZYi3E6SAwgEch2S4SvHTMyRrB6/+M5kl+5y5njIe/DX1AftdPxZwo3bb1LQTGdbtedloq Ke99TuMaGMCGExVYFLAFXge2tyYhE2ELMp9+qMOWmtDjuB1wUudBAwsB64YQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As done for trace_events.h, also fix the __rel_loc macro in perf.h,
which silences the -Warray-bounds warning:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/mm_types_task.h:14,
                 from ./include/linux/mm_types.h:5,
                 from ./include/linux/buildid.h:5,
                 from ./include/linux/module.h:14,
                 from samples/trace_events/trace-events-sample.c:2:
In function '__fortify_strcpy',
    inlined from 'perf_trace_foo_rel_loc' at samples/trace_events/./trace-events-sample.h:519:1:
./include/linux/fortify-string.h:47:33: warning: '__builtin_strcpy' offset 12 is out of the bounds [
0, 4] [-Warray-bounds]
   47 | #define __underlying_strcpy     __builtin_strcpy
      |                                 ^
./include/linux/fortify-string.h:445:24: note: in expansion of macro '__underlying_strcpy'
  445 |                 return __underlying_strcpy(p, q);
      |                        ^~~~~~~~~~~~~~~~~~~

Also make __data struct member a proper flexible array to avoid future
problems.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/trace/perf.h         | 5 +++--
 include/trace/trace_events.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index b77d09c70a93..5800d13146c3 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -26,8 +26,9 @@
 
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
+		((void *)__entry +					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
 		 (__entry->__rel_loc_##field & 0xffff))
 
 #undef __get_rel_dynamic_array_len
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index cefefed18e85..7c86cc541c7a 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -134,7 +134,7 @@ TRACE_MAKE_SYSTEM_STR();
 	struct trace_event_raw_##name {					\
 		struct trace_entry	ent;				\
 		tstruct							\
-		char			__data[0];			\
+		char			__data[];			\
 	};								\
 									\
 	static struct trace_event_class event_class_##name;
-- 
2.30.2

