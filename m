Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82711C48BE6
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 20:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625CB61245
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 20:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhFPUjz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhFPUjy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Jun 2021 16:39:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F84AC06175F
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 13:37:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h1so1749032plt.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrtKJwOXcfXSraYG3l/8W3KAWUbCghKJ8Syne5pByVc=;
        b=iF+1pCLx6umkhmrOAcWineq6AgsZj+LTiUtKMdk9TLN9SbKTPUe6+gtiOsm5561erp
         cOe5L+aytGUt1/xGAYxg7IOudEnG3cC4eBl1WhXytVcUKktZjC5I8E50EEYozzjLhb+I
         LT+5dsi2BimMrns0/2UiAvjj7L32JD9QenGvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrtKJwOXcfXSraYG3l/8W3KAWUbCghKJ8Syne5pByVc=;
        b=gByGi4Qx/6ZshNNq9GgViG4tfKRX8n54F7N6y0TBzJfkbVSvRcH8PHvRI30ksVhaRy
         UjTYrytOtyWIj/y+MErVCJ4OgF7PMa9y1ibciTLR0xgi4C3/xjKE1Hh/Yqs/Zww1jFct
         6XivhYue/syhforX63nF/4bFnIYFgqZFlzbTySMOU6zzZwVaVeyUnLEbBavDJP4JZqmN
         VEFM1dv+MYj/w0bpH6TCmfPIfn8yi2RKp6WXYFTP1wN71fk/jfwQ1s6WthWDw0rbi61S
         WNqkXbfHXlqTnUxShzMNfdWu1qv4TO+i7EV+oClLodad8V7XkMfl5x2oEOKfmhucrpj/
         +RRg==
X-Gm-Message-State: AOAM530QCoptODCfb84ySGSSOUlI8BIMaEn/fq4XcV/i2/jxbUAVLPCk
        XOZ2rYt2MyfGgXKTGMgApqvewA==
X-Google-Smtp-Source: ABdhPJzllVr+3TM7LwFPMfdLpS02YpwPWbxeaC3ybvt6EQXrCac8flhKtnj3aq9ZkTt2eqWPbMRMfQ==
X-Received: by 2002:a17:90b:358b:: with SMTP id mm11mr1635406pjb.223.1623875866780;
        Wed, 16 Jun 2021 13:37:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm6641206pjb.45.2021.06.16.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:37:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] IB/mlx4: Avoid field-overflowing memcpy()
Date:   Wed, 16 Jun 2021 13:37:44 -0700
Message-Id: <20210616203744.1248551-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=cd8ffb35e914232a0c080415b069a036911d3651; i=IU2NWQYKtuynzfrSLXaQGqkOftycINwXSwyl1Wa7yRs=; m=k4bOsoSdgGMwjhphTNjc12U6ACDoo0QRe0PbNbsxyVs=; p=SbdI3Bt6Us1lKDeHmv3nIAwGJSGvxehinrxYbH9Ls4U=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKYRcACgkQiXL039xtwCZSTg/+JGP byL2pf/2hEZdu+eUNionarfCtwpkJF6dD+x7eBbkFdCPcOZSyow7NtwN+157sD9N9gIoyhEFPxMag FaZ3i5Oqa0B4Nyvi/GC2gRK8RtJaQlKxuCSKtc9KsRKeePDUI90CnXiJBy/AmXvUEpVSnl7YCO05r ShMvNuQeW1yC3hWpjlqNNhynPfLImHL/OgmH+vNm8UMoL+6kR+5Z8irreC4y3kp1YtVCpyqWlyp9q UoymG5UMTzG9zUkKcbYcv5akzYFe9upHqU55xC7e/AFuK1dyZsaVGUJVhQLI8HHgJQ9VOs45cgTTl sIPP2rrWjPT3CfjihGNmttjcxM525hi39sWkQvfqOU8satDX+tX1ejxHd7UzXWEzILFkwAX6dzs55 UKwvsiq39Mf3srNxVB4nrlEOltkOtLZTtvMIU3pIgQfFt3O6lvZnZ2lgQ2fTA5nHJlI/EbfF1Dror DWUlkCn5C6oVXIStBIKC6Fx0hOfwLmz7aeri1C9RDP1bO3N3q/iWqhMjjWdRjMzZeK/4zNFdtEJOy HV+u0oPgM+fynHg/LqMWl5G750ogLAZ+AflR4+BI1/v4O+S0BSz3rmXpfA0K+5V0KNYLdh+ANpxV/ bxgJbAf1DNa67TzcNkVPWHsnmf6iLb6eFJHwf9+MhH4+v8zVtJa/z0NwX4VNbbIk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring array fields.

Use the ether_addr_copy() helper instead, as already done for smac.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 2ae22bf50016..4a2ef7daaded 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3144,7 +3144,7 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
 		mlx->sched_prio = cpu_to_be16(pcp);
 
 		ether_addr_copy(sqp->ud_header.eth.smac_h, ah->av.eth.s_mac);
-		memcpy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac, 6);
+		ether_addr_copy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac);
 		memcpy(&ctrl->srcrb_flags16[0], ah->av.eth.mac, 2);
 		memcpy(&ctrl->imm, ah->av.eth.mac + 2, 4);
 
-- 
2.25.1

