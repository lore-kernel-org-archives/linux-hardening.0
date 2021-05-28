Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ACEC4708C
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64D7613D1
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhE1SPR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhE1SPR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 14:15:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA02C0613CE
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 11:13:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e22so3105543pgv.10
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRXKn2a2TJxYpNg614xQbH+vgHW7yySJqcrC710VWeE=;
        b=JrEGdHhP7EFQ1SgkGbszsPMb+bl/KdtbyLCtWuYiqIWndBXagmFrCFffFHn12mBaFe
         v4mY9qlnt+JfEotilQMrF+en1bU+WoiUtTZUMtsQC2SsVufVCdjHQvfcnHwYSFMwkVQ4
         xaMcJ1hhe1R8fFbRNUStlFVu9RvgRLrPYVxSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRXKn2a2TJxYpNg614xQbH+vgHW7yySJqcrC710VWeE=;
        b=ZWen3nzdS4/yYZBdSLrx70WQHk/udjIAxeOl2KvbAgiQwGIhcMDBGR/BewgMe2BT4L
         KcDWqaexjdUfWG+TLu4tiI1Dq2X4UXU+kbBlKLSk9ndJKgz5nWgX/GvFeze48XHbF7SZ
         hOD1nafPIXH+PEOjD/KzEhpC1++fEh/sPlQdY6rm6Ofxb3QXLJ8iSwZP7To7a54v4UE5
         hjgCvG7Y+JUejRhw/RIFnTo8BbVJyg4rbiRw4I7VNrBuwwxhXaS0LkirZwS4PlWIppGa
         aZJovAX5e5UN5YYqZEE7kzJ3hXG8HDH+IieXtOH4lxsguO9L7QVakIzuiM+ZNtb+ESPO
         tFZg==
X-Gm-Message-State: AOAM530EHW0SmAXitwo/5ZOmeSaH+l5op+nMJIhOLI37NoUW0cIuLEPr
        zJIxErrjkAt13CWd0svMnhaxew==
X-Google-Smtp-Source: ABdhPJxONg4ZMLOBq2VKLCPpR2hd5Drqrxa8BYCsNQHzbr0Z55Qng5iRcr3wufgddr3PDf9/LyuVTQ==
X-Received: by 2002:a65:60da:: with SMTP id r26mr10169451pgv.133.1622225621525;
        Fri, 28 May 2021 11:13:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm4637163pfo.85.2021.05.28.11.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 11:13:40 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/3] scsi: isci: Use correctly sized target buffer for memcpy()
Date:   Fri, 28 May 2021 11:13:37 -0700
Message-Id: <20210528181337.792268-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528181337.792268-1-keescook@chromium.org>
References: <20210528181337.792268-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=62b6a772dcc28a3c942828f5b8f7820ee6d3a41f; i=YaeUnfBq3TJQDjDDQLTzHyZVVP6D3nm5nxLM0EpXtRA=; m=ctjrtOVcMtkveReIPPzBsDxfD/jI9YKdALG3fA7QedE=; p=3kYPPaGRNOcMgxn+oYl2l/LriCur9INYsJLjiNU5VNI=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCxMtAACgkQiXL039xtwCZbHxAAhEo sXvA3Z4idNWsm6GyioGcjMQaWDbmW26hmGnFs3/evp3/s2LzULDQ9oYbjBZV5nFM69+nk7pvUMH4Z PbUr5phF7psaj/IF2tsE/J2DyuPnGATxV/9EeBHZdebDS1LAkpmMJQvb810y2bfiqq7zQRXml0erN j8LmuWaES5kiIO0jKBQskL1qBd1eJ+iSDj3EsW6xI7FPpHF6Jb8+hSgjcs6fM+WbI90Y2mxr+zlHb PAuhV+6i3HjVBEwIIVl0Wqm2m8xJEQJbD01mu0DB8y25QQlpBnPwvViurDDKdDnKfpnKR5zxXGGFw Ji9G4OiYP2RDaAVRbKBFOkHKr2BHWGssqcUoC52B+9krw3iAk/OYqQC1aX5dZivSVhoxbYeYUWDBU 7ro14x8WoYuEYUEoM3iGisb027eDktUbz34YA2aOdEO/KpIoMpIwMREmjQgVMbzA6mqzIhqgWaHTf r24DWjL5keQsYfJTu47AGMcrl40Q7U6kvXxYYPPqv87wrZBptj4MF9QlJiIfzB2VquFIiYKlf0d1V yzT94zTBjQECveM1CnVy/Yxj7zbjy6QGAduMN5qLnkP0GQtHpvQh8beMXVX9ZXe6hrMRaz8WZvH5J XrqaQ/KQrNIrwQj5lWHjFg6nVAeY2LqLd8FMhzIk9px3tH6W6Q7AcDJGWbJEDods=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), avoid intentionally writing across
neighboring array fields.

Switch from rsp_ui to resp_buf, since resp_ui isn't SSP_RESP_IU_MAX_SIZE
bytes in length. This avoids future compile-time warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/isci/task.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 62062ed6cd9a..eeaec26ac324 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -709,8 +709,8 @@ isci_task_request_complete(struct isci_host *ihost,
 		tmf->status = completion_status;
 
 		if (tmf->proto == SAS_PROTOCOL_SSP) {
-			memcpy(&tmf->resp.resp_iu,
-			       &ireq->ssp.rsp,
+			memcpy(tmf->resp.rsp_buf,
+			       ireq->ssp.rsp_buf,
 			       SSP_RESP_IU_MAX_SIZE);
 		} else if (tmf->proto == SAS_PROTOCOL_SATA) {
 			memcpy(&tmf->resp.d2h_fis,
-- 
2.25.1

