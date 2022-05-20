Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49346C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 20 May 2022 16:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344870AbiETQ70 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 May 2022 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbiETQ70 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 May 2022 12:59:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72815185CA8
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 09:59:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso8393745pjg.0
        for <linux-hardening@vger.kernel.org>; Fri, 20 May 2022 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYQDC1M1CZuV48ZKXFN2Cts3NE6JaCCl55IecsECCIQ=;
        b=M2zhhYWqVviqmDNnxEiQDv/RJlQXUZm/wKUzFX2XXcauWrMuLZcv/0U470u5TYKyoe
         tt/lDtFS4I/NNDdX/kbT1xYfUIDVLRX4kCTtrC7wvzXhmoSbmsfIsW/dzAg8Jq+9PyzZ
         CmeH0rP9fPtVaTpXNZj6bBnLN6DWF9xBvWWbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYQDC1M1CZuV48ZKXFN2Cts3NE6JaCCl55IecsECCIQ=;
        b=ojDJZ7ZTceNtPgEdLLbuHZRtUl8u2DA1RkeJKsDXkLU/9dQrLFzvP+5Tpx3S1iRtey
         VIbneXdB3+UfU/+pFgQokbJHyuTV2ar50z2/azCmHamnbxW5IQPK6bRvXYdBVEbGitYq
         c/qVBz1GHKRZ+KHma3LrA3cbwwcanG0JM+Z+AKneW+IEHxCmPDPRGwcynINnsret9XnJ
         Ms8Pw13ytvwF/P5CIxgF0jW5UrNMLrBUiWzJUQm5lU9r6fotJx5l84FZq5/VZFjIThWZ
         A8Fs5w1nbdSWi0div73Y1aRknzOEEGirvcZmZ2OaLQZBDiG08yV6T8fSuBoJoIqU0A1y
         ei4w==
X-Gm-Message-State: AOAM530kLE834357Pr9m3TbJESRf4bKXvzgBBo9qhLrUm1kDHMcI+ZZt
        5U9l7dQjZIC/U+RuCvxcmI3JZxkrgqtD0A==
X-Google-Smtp-Source: ABdhPJxjRfg0cpH+6s9pfLq6EVrFAcB33wko4OyN8aWvmZyc7qC4HjGFRusHIjWqBLjPgzFWHhq/pQ==
X-Received: by 2002:a17:902:6a85:b0:161:96bc:ef5d with SMTP id n5-20020a1709026a8500b0016196bcef5dmr10886093plk.46.1653065964024;
        Fri, 20 May 2022 09:59:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c27-20020aa7953b000000b0050dc762814fsm2118848pfp.41.2022.05.20.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:59:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Kees Cook <keescook@chromium.org>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] fs/coda: Do not use partially allocated struct
Date:   Fri, 20 May 2022 09:59:22 -0700
Message-Id: <20220520165922.2140450-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; h=from:subject; bh=EWsLugKK7JxpFFTFhQ1Z0fK45IDltRDRvfWym7LQs3Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBih8jpTzLdzGg2nhFSnqG3MKgGXprAQ22QYIvmLkld ioSekFuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYofI6QAKCRCJcvTf3G3AJijWEA CDYjMcRBUsPF1YvvwLlPdbR7tj2Cxwbaz3jZwo8+bmpf/QPPIQ0LZ/zs8oiCqxn+gRqAoYyADk9AjI Ewg5kwPFd1gb+hlb5VlEmW26dR9ZJ7t1WOMLRmkf80g7LtwEasxIhhVrsxNgxB2RaM2KwHE7fzVhF0 0AVOj5tdhU8bdb4LsGUSEKHHM6W1E6oHRRUiQ5l3/J7JoqGBHonv/ZDf3aNCunYAzUD+Aylc/FI1vT grQ5UFERil8mOHjF7+pCXaTf6ghvCmZdbvabAFbJJo+glzzddZ+GTxT1CZJk+/+gtttZvNFrffEdn/ KqC2Byn+inuM6iUzSPDsOTRBriPLwEXmui9ALV5i81A/o1x2q6uHsCuWka5Sbm001GfbVqbPM15oV+ ejjzI13Qpy3ut8hbZrjWqj87aDgY2/Pev46nG1b06kWuKrphuN6OPQqXpb3hGmiLxmLeGhtZWDFJEG d1TG8suzvAIUWUpT8+/j8zWBiqCmPvS3apGg6QmKH3P3Kkelx3XDsNuEjlkFXhX03UOz0ugce5g3t4 uJ6ZqU57a2b4wuPaETGkK+CsxQAMX/IsKcMZUAXRxC1wPqBB2ZyOWr0YIX3Iqc+fyVeniLracfiG7o 9fYFFVCMR32Vg5XRpil38WXEsAxcVITGhJ1+g0q8ifv/3Zu9G2EOTjlSl4kw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

GCC 12 does not like seeing a partially allocated structure being used,
especially when a pointer is being passed out of function scope. Since
only the struct coda_in_hdr member of union inputArgs is being allocated
and used, just replace union inputArgs with struct coda_in_hdr.

../fs/coda/upcall.c: In function 'coda_upcall':
../fs/coda/upcall.c:801:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]
  801 |         sig_inputArgs->ih.opcode = CODA_SIGNAL;
      |                      ^~
In file included from ../include/linux/fs.h:45,
                 from ../include/linux/huge_mm.h:8,
                 from ../include/linux/mm.h:700,
                 from ../fs/coda/upcall.c:22:
In function 'kvmalloc',
    inlined from 'kvzalloc' at ../include/linux/slab.h:758:9,
    inlined from 'coda_upcall' at ../fs/coda/upcall.c:794:18:
../include/linux/slab.h:750:16: note: object of size 20 allocated by 'kvmalloc_node'
  750 |         return kvmalloc_node(size, flags, NUMA_NO_NODE);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/coda/upcall.c: In function 'coda_upcall':
../fs/coda/upcall.c:802:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]
  802 |         sig_inputArgs->ih.unique = req->uc_unique;
      |                      ^~
In function 'kvmalloc',
    inlined from 'kvzalloc' at ../include/linux/slab.h:758:9,
    inlined from 'coda_upcall' at ../fs/coda/upcall.c:794:18:
../include/linux/slab.h:750:16: note: object of size 20 allocated by 'kvmalloc_node'
  750 |         return kvmalloc_node(size, flags, NUMA_NO_NODE);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/coda/upcall.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 59f6cfd06f96..21e4f5f446b2 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -711,7 +711,7 @@ static int coda_upcall(struct venus_comm *vcp,
 		       union inputArgs *buffer)
 {
 	union outputArgs *out;
-	union inputArgs *sig_inputArgs;
+	struct coda_in_hdr *ih;
 	struct upc_req *req = NULL, *sig_req;
 	int error;
 
@@ -791,22 +791,22 @@ static int coda_upcall(struct venus_comm *vcp,
 	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
 	if (!sig_req) goto exit;
 
-	sig_inputArgs = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
-	if (!sig_inputArgs) {
+	ih = kvzalloc(sizeof(*ih), GFP_KERNEL);
+	if (!ih) {
 		kfree(sig_req);
 		goto exit;
 	}
 
 	error = -EINTR;
-	sig_inputArgs->ih.opcode = CODA_SIGNAL;
-	sig_inputArgs->ih.unique = req->uc_unique;
+	ih->opcode = CODA_SIGNAL;
+	ih->unique = req->uc_unique;
 
 	sig_req->uc_flags = CODA_REQ_ASYNC;
-	sig_req->uc_opcode = sig_inputArgs->ih.opcode;
-	sig_req->uc_unique = sig_inputArgs->ih.unique;
-	sig_req->uc_data = (void *)sig_inputArgs;
-	sig_req->uc_inSize = sizeof(struct coda_in_hdr);
-	sig_req->uc_outSize = sizeof(struct coda_in_hdr);
+	sig_req->uc_opcode = ih->opcode;
+	sig_req->uc_unique = ih->unique;
+	sig_req->uc_data = (void *)ih;
+	sig_req->uc_inSize = sizeof(*ih);
+	sig_req->uc_outSize = sizeof(*ih);
 
 	/* insert at head of queue! */
 	list_add(&(sig_req->uc_chain), &vcp->vc_pending);
-- 
2.32.0

