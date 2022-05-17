Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC23C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 00:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350561AbiEQAGg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 20:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiEQAGf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 20:06:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242B63E5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 17:06:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x23so15456507pff.9
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGJWRWdfa3KTmoG3aNOqzyx/Wf+ePAVmXNhTqPQrAPg=;
        b=Nv3BmeZdD47Bph3PPRA4UtRyGrtqacMmT6PG5xKg2zURJWDKdKI2+mo4CkgNhDOEA0
         9DXAExWnXsVRpf16SqI9Wt18SkzTyCgH8zFd2PM/Ext0kt8H+GX2NcoA22mkiLld/oYw
         EcBmTubH7zblItcl/cUAoPbOetUul0BJ/t3Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGJWRWdfa3KTmoG3aNOqzyx/Wf+ePAVmXNhTqPQrAPg=;
        b=VANYsEU6KSFF+CqXDfYLPD8qXl4gqGltFK8rgzI6U6ePMAPV/bTOtt/bnV5foNotpa
         VqZuwdZe+MFOcERtF9CNjVE2Zi+hoO6VDCiXfjPVkPExA4D7np4fyHKQ8ZeZYbEpNvzK
         kOurMvXO75n9+wpcXcx5Goym1rGbfZgk0Z8Qq8C8lgYtrGlQNJhjOSbG2X0of4gKeO3X
         2R9YN0HUQB+EfPplMtyoowfp7Y57BL4s64ghlt1Bu/K634Hy6sRibCOLgLWIP+jwRoRC
         0Lmdn46FLkCo8um7LeoOheEqpJ7iclwY38+JcliJEDXO2EHk88YFfFu2NIiNkf/ibb+M
         KrRw==
X-Gm-Message-State: AOAM533gemSOZn4TuO9WlFYRetxM7+lif0v+t+j7moyqmkMjca4ZmbBF
        zarcW9J/59nn0Fzeie6jb/lsZQ==
X-Google-Smtp-Source: ABdhPJyRp9tBevYtLBECx7L46IiKhY3AdADlZVwDMGiuWYjSrScnn89SsdI6GOW2VVOeX3OS3nRFQg==
X-Received: by 2002:a63:8f45:0:b0:398:d78:142f with SMTP id r5-20020a638f45000000b003980d78142fmr17205784pgn.162.1652745993281;
        Mon, 16 May 2022 17:06:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1-20020a170903244100b0015ea4173bd6sm7753792pls.195.2022.05.16.17.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:06:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] sched/core: Address classes via __begin_sched_classes
Date:   Mon, 16 May 2022 17:06:30 -0700
Message-Id: <20220517000630.3383144-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3380; h=from:subject; bh=yE7Y4iEzw2uQDBPWERz4EnWIp9JgtTYW0MBOSnRfrJA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBigucFz5LmgNLKW4UOYvuzv15xB3QwC3f7ncw6ekcE 9t1cbfOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoLnBQAKCRCJcvTf3G3AJseGD/ wJZVyWQ3/vhY/sBnEOOY6L8gDxoT+vB96re6BoLQe1GjYnCtJVei64tiNdhCh8S5t5G99jTpDEHB4B gVlLyvXlMOmPN7T3doJaQ6sk+FT+a6kwdVn+vSG2V7uRdo3cjaitrGGis0QWqSp8K2uSxhV+sDTDJx FYs7QmyVZ5D8tq9EonMBt2JgrwSttB3BHM0vNmIXj7qBsPDR7Cc1XX20FSqfjAV2hbDSPM0AdgV67Y 4oEENbuiRpyE5XHVIXghekDrF7oXhA10m8o7P3XSgrqQN+Rb1v5NlAjlo5vnOYhAg9zGACxCaFVAPq ul8d/bxtIO32UZU5yADn5YPbLUZVW1emzJsA6/4R9Dsi4RLdSgYypMSZSRTphEcK4knFdprHiNdfkm bwztYOIIBbPbc73Z4+WwvM0JUUbqHMsFEiN2qtFYghRcrAIpP3G6ZNGS38Ejnif57IQJNRgCvWAUWK Z0PUu4GJRse8bzg7CjaupaLrVJLFSpWLN3igGvWyPAEObQ6/ziapumonrXNN4PxdLFtDRdczaDrKg3 QsD8T5ZwVI0crz5eHBt5IwAvyH4iEWw7nGKSRcAtnc3L1pUK8AUw/LFlwwsAHT4DJD3M7ENlEjUwdO nG81pmpUKqcgUYAzLDDwIxfNE8EmgY9xMWJ4qOG0yZ02XFr7WBQt6OVVk0iw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

GCC 12 is very sensitive about array checking, and views all negative
array accesses as unsafe (a not unreasonable position). Redefine
sched_class_highest in terms of its location from __begin_sched_classes,
and redefine sched_class_lowest to the actual lowest sched class instead
of one lower (and adjust the for loop so it still works). Silences
this warning:

In file included from kernel/sched/core.c:81:
kernel/sched/core.c: In function ‘set_rq_online.part.0’:
kernel/sched/sched.h:2197:52: error: array subscript -1 is outside array bounds of ‘struct sched_class[44343134792571037]’
 [-Werror=array-bounds]
 2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
      |                                                    ^
kernel/sched/sched.h:2200:41: note: in definition of macro ‘for_class_range’
 2200 |         for (class = (_from); class != (_to); class--)
      |                                         ^~~
kernel/sched/sched.h:2203:53: note: in expansion of macro ‘sched_class_lowest’
 2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
      |                                            ^~~~~~~~~~~~~~~~~~
kernel/sched/core.c:9115:17: note: in expansion of macro ‘for_each_class’
 9115 |                 for_each_class(class) {
      |                 ^~~~~~~~~~~~~~
kernel/sched/sched.h:2193:27: note: at offset -208 into object ‘__begin_sched_classes’ of size [0, 9223372036854775807]
 2193 | extern struct sched_class __begin_sched_classes[];
      |                           ^~~~~~~~~~~~~~~~~~~~~

These can't just be object pointers because GCC still sees it as an
address of a single struct.

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Link: https://lore.kernel.org/lkml/20220414150855.2407137-2-dinechin@redhat.com/
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220516194241.3064242-1-keescook@chromium.org
v2: use the arrays with proper indexes and adjusted loop logic
---
 kernel/sched/sched.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..09304c01e5ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2193,11 +2193,13 @@ const struct sched_class name##_sched_class \
 extern struct sched_class __begin_sched_classes[];
 extern struct sched_class __end_sched_classes[];
 
-#define sched_class_highest (__end_sched_classes - 1)
-#define sched_class_lowest  (__begin_sched_classes - 1)
+#define sched_class_highest (&__begin_sched_classes[__end_sched_classes     \
+						    - __begin_sched_classes \
+						    - 1])
+#define sched_class_lowest  (&__begin_sched_classes[0])
 
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class--)
+	for (class = (_from); class >= (_to); class--)
 
 #define for_each_class(class) \
 	for_class_range(class, sched_class_highest, sched_class_lowest)
-- 
2.32.0

