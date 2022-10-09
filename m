Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E37C433F5
	for <linux-hardening@archiver.kernel.org>; Sun,  9 Oct 2022 18:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiJISR1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 9 Oct 2022 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJISRD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 9 Oct 2022 14:17:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8512CE2B
        for <linux-hardening@vger.kernel.org>; Sun,  9 Oct 2022 11:16:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so8589677pld.13
        for <linux-hardening@vger.kernel.org>; Sun, 09 Oct 2022 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i76AD8zPTgyh+QGg4MNmmdW26/iTXDC2CpF5T5kjf4E=;
        b=X9zr3R54WwqprYUPQMyY46a+6a7mk6kMWuhzlwCkxSzZOtQ/6gy3RGnGLUDJ+vTUhX
         U2t1nYFJcyZoZAWhufOFLI1pC785N3JG3Acc9J6BWlOSZTNF3sTsy0yx1kMgY8mxWDNk
         ea5m1m/+SinK6UJxu2uMV4/brAK5MH4635r04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i76AD8zPTgyh+QGg4MNmmdW26/iTXDC2CpF5T5kjf4E=;
        b=jdzkM0fWKCXu7YdKN6ZFTkoUDko3pFrMmklMcp/PaZADXK8Q80FCI760BJm35YEboa
         zA2uiUssKLSTAwmD/PNAidHg8kJhQdD0xhjPegmvpsLXJfN7gmCpPYs2SchZ2AAty/Ow
         pVRYFyniXhkoNmNk354/YCuFh7ttOGWAdHhwM7VFsXqPMCoB50wbj3IAl6RJb1erzshf
         hHdlCe0CCTph9oaBhJFjEn73ZwkN+v/1MqR9LfrhS8FPoIIFOvUrygUbUc8cVExdYo8p
         xfx5S4XtHXLn424FpNFRxwH66uFdsMFOBcyGHpwbKSq6WF4Z8DhDJzwZyf1vCJXsM1RU
         rULg==
X-Gm-Message-State: ACrzQf0LvhyV2vbUGSR2w8p+DPCnGuB3aJ3r3I8c6fQDnIZG/wmA6KEx
        uAD56Eynl7Zamw4zst7k7X9NJw==
X-Google-Smtp-Source: AMsMyM4We+gyViSAmmeikvUD45XAs3kPSQRQ7R4bA6/hWI2PTNmLYsXczTXbO24k4ni/unNOiGtcFQ==
X-Received: by 2002:a17:90b:1d8c:b0:20d:3180:3e8a with SMTP id pf12-20020a17090b1d8c00b0020d31803e8amr4160915pjb.68.1665339366811;
        Sun, 09 Oct 2022 11:16:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b00562641bc0b5sm5258639pfe.132.2022.10.09.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:16:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Kees Cook <keescook@chromium.org>, cocci@inria.fr,
        linux-hardening@vger.kernel.org
Subject: [PATCH] python: Add make_expr and include_match documentation
Date:   Sun,  9 Oct 2022 11:16:03 -0700
Message-Id: <20221009181603.3242176-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; h=from:subject; bh=IfKl0d3b4Wva9kr26WhNzlJvAFNsEln7eoEO6SO+E6Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjQw/ixRXa9E0H0DKu0pWbrRZ+/56bjjFqZPIZ0kI7 hSPRY/qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0MP4gAKCRCJcvTf3G3AJq+AEA CbIe/qtPWgOH5s/FJi2Rz3ZrcLHI6UHuwkcE4TfVT/qVJFE/k3huTtZGueDXFa6zRhTUc8HIJ1DEBw DkA7rL8KJqHNFOTadelPROVwy//NY7j81sLOUQGeBTE3RQeAtrZo9KMfusSx5RGZFTmgFI4qoySgpu f13vmf8ADZLvjdxJ8ch/BUX2YAvPnsukSufUErfjrwKL4+l+6SC6p7/OPAe4HJNw0Kau4FrCxcHFE5 0smMu3BKEkmsI0KdOriw0Z4obFn9/hpp0T5q7/pkJDJlaDRFiBLLxEyp+Y6AraIgQAoEEJOPUaXslg /hbRNRBD7xZMQemT22wd6+CnNK05jjNete6YLB19jSRkPS61Ujf7ZrrR6qnxeOuAoOzOrBHXeBzjgf fFjzk3A5ZD8VewRMr+Cflcj9sBs3Wn7FfjEd1WXNmnO4lcmOIsekKgUERDexmQGpZuxCfaRlxjAVTf PoCUd0szrFurxMjHhT716Jf/D++pH+gOhbRgeKB1mI7TtXcBP2HUTwxUM1dOlZCpMo1U6DG7e1Rc2o Cfo3OrJApbuWa2X0qWznHFVKf+Pf9BZlU6pxh6DwcREStvVGNgn1yn7y8x/RcylbmRX2f0G3V7mC7s IWIQAUeqbLDhf4pAMfwzF+2mZK58qhxJEBw7+TFX0sGO7J6vpEY/I3AyrmXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add the 'make_expr' and 'include_match' helpers in the Python
documentation. Additionally cleans up a markdown-breaking line split.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 python/python_documentation.md | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/python/python_documentation.md b/python/python_documentation.md
index d0194d6c1391..1d933b9a3934 100644
--- a/python/python_documentation.md
+++ b/python/python_documentation.md
@@ -11,13 +11,20 @@ file at the end of the execution of the Python script.
 
 Example: tests/exitp.cocci
 
+## cocci.include_match(state)
+
+If a python rule is running, it has matched. If the match should be
+removed from consideration, this can be called with `state` set to
+`False`.
+
+Example: tests/incpos.cocci
+
 ## cocci.has_env_binding(rule, name)
 
 Returns `true` if the meta-variable `name` is bound in the rule
 `rule`.
 
-## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers,
-       extend_virtual_ids)
+## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers, extend_virtual_ids)
 
 Internal function for the method iteration.register().
 
@@ -28,9 +35,17 @@ Converts the string `id` to a C identifier.
 
 Example: tests/python_mdecl.cocci
 
+## cocci.make_expr(expr)
+
+Converts the thing `expr` to a C expression.
+(Equivalent to Coccilib.make_expr in OCaml.)
+
+Example: tests/python_mdecl.cocci
+
 ## cocci.make_stmt(phrase)
 
 Parses the string `phrase` as a C statement and returns the statement.
+(Equivalent to Coccilib.make_stmt in OCaml.)
 
 Example: tests/python_mdecl.cocci
 
-- 
2.34.1

