Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC3C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 17 May 2022 21:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiEQVWl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 May 2022 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiEQVWj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 May 2022 17:22:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A46F3EBBE
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ds11so102611pjb.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pyuUYM2nhfs1gICpi/ez0EJClISm0Vub2nnFcMFlfJE=;
        b=A9UDQ/9LPNxHRuAqHkEFWdqVmK+zKul9hMQlG3pY6UDl5Vv5FyIL3crIFn/KCFNuR+
         zrd5xZNVvHNso+FSjYZn573hSuGL2f0Pex6TwP2xkfJUChFUDBw5tJ5Jyie9EK0EmLCJ
         ZiKykHLBKWbbT7uvUEe4EB9pO0QI192mU9NyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pyuUYM2nhfs1gICpi/ez0EJClISm0Vub2nnFcMFlfJE=;
        b=nPUs708Daiui9fY8wNbMoGo85evaSSgwQWjbMYWBy2t+3a+QEockv+bkLv5hB0xwLR
         bDN4khKzAwIDMKNPRFGofmZPR9m5YIyv7skCoTLgzkvIUTK4/nfhRHaSo7p+9iHaccE6
         rOUNBoLRs6R157xNUHb50+WsMAitkPYW28JKcFf/ACISrqCy8hq85wjABOFKmi8Ok0NZ
         TMcGl9sqTRSuCRnGUuPE8EEgdhGihkyUVr3zM+ht//amfH43hUoCb1bdx1joaJy5DRwp
         6atr4eg1XddrYVeG2Qm+bFwjpI4h0mABmWr//dhCnYOjMiyEOweKUTFnCebPp0t53p4v
         xD6g==
X-Gm-Message-State: AOAM533dE5w+VNCHB1BJiL9owHh1qWqd1fTHzFBUWA1eRZu3SDIgOja4
        0bb9A5kj0Q6raC9rH6ZNWCmUNw==
X-Google-Smtp-Source: ABdhPJwdf06LARTfcGEJ4oQdkjhe+AFA07h1wXiXiTaEg9WDBgitDF0Gsrlujdp1pPcx/Re8RN3qnA==
X-Received: by 2002:a17:902:9345:b0:15f:186b:e478 with SMTP id g5-20020a170902934500b0015f186be478mr24168187plp.117.1652822557024;
        Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o137-20020a62cd8f000000b005106b52a823sm188918pfg.145.2022.05.17.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:22:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] bitmap: Fix return values to be unsigned
Date:   Tue, 17 May 2022 14:22:32 -0700
Message-Id: <20220517212234.868181-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; h=from:subject; bh=wvKVL3ZvHJApmM6H5ZjVHfC77q4Z7C8eeNJCjVYEji4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBIZFUAj5RR+FhK+1sNHu7PZ2NCF+xbZ1D77mdwO 1SIWNbeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQSGQAKCRCJcvTf3G3AJjTDD/ 44XrBbkZDtGl9HsnBqQ1WY0Jx4vUrZlNOSzn+9PHpz6IwOqzd/hF3arbAQAUjPBATQnuMJIdv4CD5K jG2EBFa7MAHpP2Nl1lje4gyCiqnjgI/zJ6pYo4hTQtoHl8FB9Sn63eES/RzS8ND5kD40xFDxpwqgjx 5Od2WzSASVP3UcV6SsFP6mZ4Ec9FNlJIApSCpLGhXuokM243jirRvdWTPoDN8f6TXx79FyC8VQOkC0 y6ngueFZvLmS3W/SIUipiYSvuv/1WKspeU698IsV1kRSpX347MirUs7ZUoJbFq7YNE8n1OAYjC5ZIa IDzFzotBG1I3NedN7wnPeZXjfNA+hbYTfBNXo+8wWro/2+mE/QVU8aq4ORRk1SaQuDQKj9lNKNdDow zordWpC1DRlueK+L+dgBImDdWZW0wEG0hkYWBAHrJkcTvrB7s1XaYCWGCAlVZHrFsGswJmMpWbJef2 aCb19DUaDODAl6ibayTZ2TVgFu0a94NeVS8tNXboL8EeJLNF0EYS37h7ssSVT14CiFkQdGSOSxgey2 iy0hhiDqC+LLpaeMbSpQKbOaXkiJTfmFcEzutgVKgHFm4v3Q0RzgM2daVWd3ERDuhYqRaFOdth7NJG +yUu6/PKLPhR+H8J7GcWDi4qkWKZ9g07hYz4TvmjHm4Sk67Nw6Cmjs5pXlug==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

As mentioned in the last patch:

Both nodemask and bitmap routines had mixed return values that provided
potentially signed results that could never happen. This was leading to
the compiler getting confusing about the range of possible return values
(it was thinking things could be negative where they could not be). Fix
all the nodemask and bitmap routines that should be returning unsigned
(or bool) values. Silences GCC 12 warnings:

 mm/swapfile.c: In function ‘setup_swap_info’:
 mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds of ‘struct plist_node[]’ [-Werror=array-bounds]
  2291 |                                 p->avail_lists[i].prio = 1;
       |                                 ~~~~~~~~~~~~~~^~~
 In file included from mm/swapfile.c:16:
 ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
   292 |         struct plist_node avail_lists[]; /*
       |                           ^~~~~~~~~~~

This splits up the patch into the bitmap and nodemask halves, and drops
a needless change to the random node helper.

I note that Alexey and Rasmus touched on this area in the past, fixing
up node ids to be unsigned:

ce0725f78a56 ("numa: make "nr_online_nodes" unsigned int")
b9726c26dc21 ("numa: make "nr_node_ids" unsigned int")
33c4fa8c6763 ("linux/nodemask.h: update bitmap wrappers to take unsigned int")

If anyone else would like to carry this, please let me know. I'm happy
to carry it in my tree.

-Kees

Kees Cook (2):
  bitmap: Fix return values to be unsigned
  nodemask: Fix return values to be unsigned

 include/linux/bitmap.h   | 14 +++++++-------
 include/linux/nodemask.h | 38 +++++++++++++++++++-------------------
 lib/bitmap.c             | 28 ++++++++++++++--------------
 lib/nodemask.c           |  2 +-
 4 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.32.0

