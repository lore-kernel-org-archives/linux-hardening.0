Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D1CC6FA83
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 15:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiI0PkJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiI0Pjf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 27 Sep 2022 11:39:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59470E7A
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 08:37:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so738552pjs.4
        for <linux-hardening@vger.kernel.org>; Tue, 27 Sep 2022 08:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ykCQj/F1ypqbvqexiYMjYhFxNcu6uF4BGSAsLrFhFos=;
        b=AoTNrZ6i/DA3ZJMwyJ1E0YeMp99pdWHG1nuqWQZsW7ASfoRYoBHZhy4+sypx3iJ914
         aD6tisqFBf3zyz/vv99eurUL8/9mD4qSULoVzrrnjSA/ae4Vz7KBUZCVx8ROOTsi8K8E
         foooo0cNNM4fUY5TRC6JrjK2osBxddtlVAkt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ykCQj/F1ypqbvqexiYMjYhFxNcu6uF4BGSAsLrFhFos=;
        b=K/82eff1Dgp+IS80hn/5S+r/MftpEnLabKcN0cA+9Q3EEBBCj4TfBCQjJmnQb2zYwR
         oaCdyqThn9OizoC/ZCbnB7C6dq+8ce9/TGSVvjqg1LXBbHnPKsnn+wsDF2goudaYSYQ8
         quKGVtecDCPoRoA/4qX0myrEdp9S7TH60eNklBX+bvXYeDFUBGbaE3ZvBCkGTZWOi8dK
         DQILo8RLMEM5EOVOKLmx+puBd5a/H933KPQf1+/ZHS6CJFcyfzU466sUph5prWtmIlrp
         QOe4o66ltwKHdBLHVovBK2nXguB3/qZojRCBqXKiFs9psxvLURONlcuBVJaKuw08Z7pf
         LdHA==
X-Gm-Message-State: ACrzQf2C0SVKx6P1oSnesntStZ/C65yFqyWgbDzmrtpUUIdrwcCw38JU
        whfwSsdHy5X9oD/dNMFyYcHqkA==
X-Google-Smtp-Source: AMsMyM4naSQ2tfT6ukvZrllCFAbhDgh/m5kkTJyLRd93cbWNuZl123In5MUJoO5CqKmQlmhLuDEW9Q==
X-Received: by 2002:a17:90b:2785:b0:203:6279:f03a with SMTP id pw5-20020a17090b278500b002036279f03amr5267591pjb.36.1664293031076;
        Tue, 27 Sep 2022 08:37:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001754064ac31sm1720685pla.280.2022.09.27.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:37:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] net: sched: cls_u32: Avoid memcpy() false-positive warning
Date:   Tue, 27 Sep 2022 08:37:01 -0700
Message-Id: <20220927153700.3071688-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; h=from:subject; bh=a5kfZGJ20b02uPWXgL+F0pZhrLA3yDR5ugsapwWzdVQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjMxibiOsVeOwkPIgAZeyeGKuoXXag6IdhCVwdK/mY wPyLQjGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzMYmwAKCRCJcvTf3G3AJriyEA CPC7YSelum/IEpcDi7K97nEgWYsr8mtNQH1474+2H4xJLyhNW3HAMl1vTyCeMjvYmOD1aYN0xQ5teM LmKF6oPT44UK0btmPpAVOqyGNOV3/R8NvRRcCt3I/qv3AsQP6Ly3Ah4jaCYlNE5DYQsG+coJVVmJB7 535LwZTqcC9rI4xRNGfLr8af/UnLd9FGt2KbBnZ4NK5hiTgDET1qGYwK+EmgBpRtJZgN+SeagpND1b EdSXKgo7Zouz8Sh7xgWTYmHvOPDAbC3nb+oUmd+tg3rw9i2Cztj3UVHhxf8jQFJ1PNSi8Szmw5Edh/ DWl13x831rcqnPaIuaT8Abt4L+ypjwZZ6flOQxYCXGR5uIwLZBlpH65AMJJgRsZSsUJDrZd62N5V2w S39qNbLuiohGb+gBSPI/UpLSN5z1HeVvMkK+CfXq9Y7/R5xGKstH/COHXZDSoWjHNwYWV3xNeDWLCx 2JeNqT5Nfh7dI7MK6/RowSVlm4wFzOV+8sGJHeYY55Hebx8Ss4SGDx0VPWHJEVg9dEvIFJ/yARARp4 WEPBLJ2t2ncEXWLliNDmYK1gx6DaajGEZjW/c65rTBOUXqMA/r/6XPr38JGNyvHOiMyMfMQg+b2rE6 KknkWeeGmjYq1ZOABLLYpRno65rTj6e23knzZGqxvCR7zLXEsNl3ci2t24ZA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), use unsafe_memcpy(), as the sizing,
bounds-checking, and allocation are all very tightly coupled here.
This silences the false-positive reported by syzbot:

  memcpy: detected field-spanning write (size 80) of single field "&n->sel" at net/sched/cls_u32.c:1043 (size 16)

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reported-by: syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/000000000000a96c0b05e97f0444@google.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/sched/cls_u32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 4d27300c287c..5f33472aad36 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1040,7 +1040,11 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	memcpy(&n->sel, s, sel_size);
+	unsafe_memcpy(&n->sel, s, sel_size,
+		      /* A composite flex-array structure destination,
+		       * which was correctly sized with struct_size(),
+		       * bounds-checked against nla_len(), and allocated
+		       * above. */);
 	RCU_INIT_POINTER(n->ht_up, ht);
 	n->handle = handle;
 	n->fshift = s->hmask ? ffs(ntohl(s->hmask)) - 1 : 0;
-- 
2.34.1

