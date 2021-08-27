Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B17C4320A
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 03:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403A460F39
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Aug 2021 03:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbhH0Dsh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 26 Aug 2021 23:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244191AbhH0Dsh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 26 Aug 2021 23:48:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B534C0613CF
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 20:47:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e15so3098004plh.8
        for <linux-hardening@vger.kernel.org>; Thu, 26 Aug 2021 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3iDBnZHVbEreWWuomxF6GQM4vK4iHAWwR63HQF/eKNk=;
        b=Ztu+t6Jzw25jWNOhI/V3DOe8lvDY109i896qfsl54W3uGIWvCVdH53Euxq2HM6Tuk/
         Y+jdZbhhGlJm37zPL7iY+cEg2VI0KDz+0/a2D3gmDi7ywcCTU5bn7vdlWxHMo6YtQY1t
         rA5/Fmx3IUYQhpMhgYOQnrb070ajKlIE3vnRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3iDBnZHVbEreWWuomxF6GQM4vK4iHAWwR63HQF/eKNk=;
        b=rMbvLmEIG4fJcX4Z1WWE6/WYsfX30ghveM4pf1yfEpVVo7rM3rEXh5zpyc2Zp4BN4N
         bvFF8IF4COjsaBN2BhDRWh3am7ADRQrGJtlbHHRt+vl5nZz9rHXWbNsXNVzVahP90WKS
         6h9xAaYY7+PfZWyyLy3fIbojijci+uVah2Fh4SIsZ/DnzQV8UKzrvlIWqnK3vVoES+RU
         Yq6Th0SEA59SNy3IgN6LJNPMioz2w5/oVEoIy2RmWqbMxP2xEhpPgEGciBvdUj3DHD35
         YWGGDW7ozFquQN13OjHFg2wTEJOBoKE3VdxxfP3y5sSkAA4cXJ7RF6rk+UsITy9hg9nL
         r1WQ==
X-Gm-Message-State: AOAM5322jZ0tEc0gu+bAdFPV2LPNEEdbwTmHFO4hnw8pxsXH3RUCXKx/
        vp3YPW9H3JxSS4yhg7aEE8WNDA==
X-Google-Smtp-Source: ABdhPJykH/tLG4lI0FS4eGLtIMm9iMYAanogiPcMmvjyOaUZyMJ4OMAQ8QXUlc6fL8kMiQwyB3W27A==
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr8117562pjb.23.1630036068938;
        Thu, 26 Aug 2021 20:47:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c17sm10338947pjq.16.2021.08.26.20.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 20:47:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] cgroup: Avoid compiler warnings with no subsystems
Date:   Thu, 26 Aug 2021 20:47:41 -0700
Message-Id: <20210827034741.2214318-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3707; h=from:subject; bh=W8mrDHl6epGwfALLfDZy6bZIPBPKmiqLtY/kJ0d40/A=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKGBc5sJcW17N6yaoeIVynlA7aGik+aP71/c/fDv0 xr4JJdGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYShgXAAKCRCJcvTf3G3AJrc+D/ 9GISUvm+dHrhuWYcVAsCuC9AzNUkDwO8OJTJXICqteYG3BwwSvrG3Mh4Z9uc6qsgDjjyJk41wjZHAM 7yf4zprKt89GB47h9ijavum+/hDi5gXsuRJgWrJpRhsOm2HvDG3vMztKCWf8gVyLaVpWb8T4sb4YAI 3hdHs9DA8SHKzfmIGXlJ+YXSXFuMccQrZBRtP0yDG3wF8u7jsgy/nsq8CwI4h1RSARnn2EcH5gQEgB hgeseVGuNtSLugNVQAZlGiunuknJoR9lv1fptLJI3czdxeXU4ossMUZeuEere6n2Q+l2cp0bAfAjDV yKJavzHz6UGE4t7EplPrTou/M9hLuYzZD4ng9HaAX3TiyOmHNgDarS1swdUBS8YLw/vZlj7tq45nXZ RQBwcaqf2Cl3HBY0V9LMB8uEbGUtbMsZf7kjGEMENK8CiFkFxMEl8QRp6k301INBscWxuyR9Kyp40F NXRLzFsRtWOdBipI/Yqhi1yTvFekX6w3DVtGPa7vP7RXhN4Efr9252LkeSPEJZMiBvXsMmYagotiqq lef/jTeqjkmpYx/AHoVlVbxJl8Y06orD0C1FrGQ11qwudw0P/SaK9PY4FBkzxGD98mncCP9clL/R0Q ia9506zycqIh505uQfuYU2VWXdIasbNiJ6aHy4dqOUdaPPu4HT0JoXIFXp7w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

As done before in commit cb4a31675270 ("cgroup: use bitmask to filter
for_each_subsys"), avoid compiler warnings for the pathological case of
having no subsystems (i.e. CGROUP_SUBSYS_COUNT == 0). This condition is
hit for the arm multi_v7_defconfig config under -Wzero-length-bounds:

In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:264,
                 from include/uapi/linux/swab.h:6,
                 from include/linux/swab.h:5,
                 from arch/arm/include/asm/opcodes.h:86,
                 from arch/arm/include/asm/bug.h:7,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from include/linux/cgroup.h:12,
                 from kernel/cgroup/cgroup-internal.h:5,
                 from kernel/cgroup/cgroup.c:31:
kernel/cgroup/cgroup.c: In function 'of_css':
kernel/cgroup/cgroup.c:651:42: warning: array subscript '<unknown>' is outside the bounds of an
interior zero-length array 'struct cgroup_subsys_state *[0]' [-Wzero-length-bounds]
  651 |   return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/cgroup/cgroup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d0725c1a8db5..d23100878002 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -472,7 +472,7 @@ static u16 cgroup_ss_mask(struct cgroup *cgrp)
 static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss)
 {
-	if (ss)
+	if (CGROUP_SUBSYS_COUNT && ss)
 		return rcu_dereference_check(cgrp->subsys[ss->id],
 					lockdep_is_held(&cgroup_mutex));
 	else
@@ -550,6 +550,9 @@ struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
+	if (!CGROUP_SUBSYS_COUNT)
+		return NULL;
+
 	do {
 		css = cgroup_css(cgrp, ss);
 
@@ -577,6 +580,9 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
+	if (!CGROUP_SUBSYS_COUNT)
+		return NULL;
+
 	rcu_read_lock();
 
 	do {
@@ -647,7 +653,7 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 	 * the matching css from the cgroup's subsys table is guaranteed to
 	 * be and stay valid until the enclosing operation is complete.
 	 */
-	if (cft->ss)
+	if (CGROUP_SUBSYS_COUNT && cft->ss)
 		return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);
 	else
 		return &cgrp->self;
@@ -2372,7 +2378,7 @@ struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 	struct css_set *cset = tset->cur_cset;
 	struct task_struct *task = tset->cur_task;
 
-	while (&cset->mg_node != tset->csets) {
+	while (CGROUP_SUBSYS_COUNT && &cset->mg_node != tset->csets) {
 		if (!task)
 			task = list_first_entry(&cset->mg_tasks,
 						struct task_struct, cg_list);
@@ -4643,7 +4649,7 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 	it->ss = css->ss;
 	it->flags = flags;
 
-	if (it->ss)
+	if (CGROUP_SUBSYS_COUNT && it->ss)
 		it->cset_pos = &css->cgroup->e_csets[css->ss->id];
 	else
 		it->cset_pos = &css->cgroup->cset_links;
-- 
2.30.2

