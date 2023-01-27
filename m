Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D99C54EAA
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 22:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjA0Wkm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjA0Wkl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 17:40:41 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1771213D6C
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 14:40:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso10039613pjj.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mi0d+CK+M9Cvpo6kBCt8Dw5Bmq3VTlMl6FYmGH90jCc=;
        b=SWi4IP4iJzGDXBWt0eLnZKja4pxNbw1GBNz6X3Ff5JYUOz6sM8/8YMzzGuQ7mKbPoP
         PjGze6exSSVRpuuWgjNhtiQB7Rw8FMdJNztT1g1ohE7W8jzXaPzoAP0kO13w+83rVnCb
         vNt+mgwdbGbaLSRT9qjJSvWE2w3cqoWN1+d9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi0d+CK+M9Cvpo6kBCt8Dw5Bmq3VTlMl6FYmGH90jCc=;
        b=Y9Lc92tt+yNnySFl52NShJLWmwMvJtF9EJtXFFj39eHnmEC1PkBqUgyGm/apYng4Dz
         M76+wE8d+8f/30s3txXJzBbZWYqFZOOyb4rzUhSZ7Y9lpaBxHLDUmWkXPWe9U/BPliFs
         MCN/Z27kojYBYBYSWVRCI+LP041k4vPMFtF5kCvFs3WqUuUrgjhzGA6nLzjYqFJsyq0y
         Kyy4d7Lnw6T4Gjoy635wBfyUaCpHYzZeI01qpnM8IFK1LpSsKc+PvtADaXjM9wUH22Pu
         fSFaUKDrrKaFP+00PKxifsJ95hRQDbABlloljHxKKy2T4158UKDs67PNmULWKamNpUCD
         VhCg==
X-Gm-Message-State: AO0yUKUilsNO56mrPLci17DwsiEE27brQWU2ocqKAjzydGQQHrZD3DCp
        ZNTuSpTHweq7gGzJ+kCrCjD6NL8jipNEdX7I
X-Google-Smtp-Source: AK7set+q5CdJ/pPq/o3RZgrDnqZei+2XK5PIfAZ51Qfg/mMdW4DXRyQLmam7r2hfP7mQ+7Zfmua7vA==
X-Received: by 2002:a17:90a:1e:b0:22b:fb91:5719 with SMTP id 30-20020a17090a001e00b0022bfb915719mr14252488pja.3.1674859239533;
        Fri, 27 Jan 2023 14:40:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090ac59800b0022c25153cf0sm3207170pjt.44.2023.01.27.14.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:40:39 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] net: sched: sch: Bounds check priority
Date:   Fri, 27 Jan 2023 14:40:37 -0800
Message-Id: <20230127224036.never.561-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; h=from:subject:message-id; bh=WznqTvrhU7T7Q9mp7lRgEZijP0sAnDxdFOd42SzPeos=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FLlF2NTJvQnZwGxxYtNjelPsiP82tCH++9g1CN1 mGXGd46JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RS5QAKCRCJcvTf3G3AJrMJEA CfNHygMLN8AV7Bx/StJG002yhinvS4PXc7hKsxEqGhQiMVumnsc+9dQc7quTYRD43El3kpsU37r0FF jMdibMOxxlg0IrgaC+OrvCMZj2Lgg31K0pRLjdYbDCVrSyzgdoMlVYOZXd5/IrilnZQ/r8VJHUGgjQ 2Dy0KXxSJlZGqub1Ce2WRglWV5oyBO2igbspm1/uHEF2LQBK+wkklhjL+CnTRh/CkX51qWW5GH0rOb WaBpy46IRnvVHBQO1lGyT/Cft6JNSMdVwgsUbcgsMo/BdKiFbZtjCQ4HCShR1tJRp9BvUY8nLvO/KT NTCU7r4GD9Ovvxxo+GlvXdeOnv2FVwRqB/d4gvBpfnubVY8y8wF70aG8rBA2Ms7EPQuzsp+f74ft25 tvEwGuPc5mXRpYYDodN6ylfnKQYglZZrh3mya//01067lgs5/u3Nfd/iksrEg+RjVhUh+trQEEiDkd JatLvYKbw98tHkyzO2TYqHBERJsx6lPkiJpVk8UnM4Or7FvD0v9FMQFtSBMwRA3yelpqPG1NbWG1G9 MBALYc+yZVrujekUErIpM3B08O3qlyNnejkCbohiUQNdmNixK60P8L6iWj1KB/0SNn8vX6QmhJCee1 RsiGCxaRcss4+ZdtDufmyrSSoaeGT+hhMBHA9A+B9RzUePU+pw8v7MtHB3cg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Nothing was explicitly bounds checking the priority index used to access
clpriop[]. WARN and bail out early if it's pathological. Seen with GCC 13:

../net/sched/sch_htb.c: In function 'htb_activate_prios':
../net/sched/sch_htb.c:437:44: warning: array subscript [0, 31] is outside array bounds of 'struct htb_prio[8]' [-Warray-bounds=]
  437 |                         if (p->inner.clprio[prio].feed.rb_node)
      |                             ~~~~~~~~~~~~~~~^~~~~~
../net/sched/sch_htb.c:131:41: note: while referencing 'clprio'
  131 |                         struct htb_prio clprio[TC_HTB_NUMPRIO];
      |                                         ^~~~~~

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/sched/sch_htb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index f46643850df8..cc28e41fb745 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -431,7 +431,10 @@ static void htb_activate_prios(struct htb_sched *q, struct htb_class *cl)
 	while (cl->cmode == HTB_MAY_BORROW && p && mask) {
 		m = mask;
 		while (m) {
-			int prio = ffz(~m);
+			unsigned int prio = ffz(~m);
+
+			if (WARN_ON_ONCE(prio > ARRAY_SIZE(p->inner.clprio)))
+				break;
 			m &= ~(1 << prio);
 
 			if (p->inner.clprio[prio].feed.rb_node)
-- 
2.34.1

