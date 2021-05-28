Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B5C2B9F7
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643E4613C9
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 18:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE1SPU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE1SPR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 14:15:17 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735BEC061574
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 11:13:41 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h12so1989902plf.11
        for <linux-hardening@vger.kernel.org>; Fri, 28 May 2021 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDvnpqBXqv8XLON1AxPWRjfcHJXzeJBqZ9NYKHrBM5o=;
        b=KyHPf8zdegewQA7dP0UIsSm3gZOTOHeu6NEg2WQWCjAVqhINgAz1dXE2thdsB1f/8W
         OD2MNTa+SQK6s3vI3syyCaNqsVHiQT34AGX/O8FOwDCvFFQabaFlvk1XS5FRSH16W1jZ
         0w0OESRA5zzkEUTW24p1/3pbJHMFkXXhzfjGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDvnpqBXqv8XLON1AxPWRjfcHJXzeJBqZ9NYKHrBM5o=;
        b=Whck/iUzN6umUJyDXeT//BCIezm71NJ/03rnB8ajstvZ+sq9QDimmbi9p0Y1MX5hsD
         H01WiGNnf/JkQW4E5bZ0Oh5BMp+5JKO8qqkDXDGgK1joX9q5BMzxTNV1Vrw+LLVMH01/
         qcuZmuMCaaMDfMhRGOFhHi0gleIK5+ooVhudyx8/LH0zAz04NQMYGoBQpZHDi7i8k3cf
         9fs+bR7gqBv9ijeK/noQF1idS5mrRnCNeSB/PRqjAdcznl8R0PX6euR+xlRVx6gFAAXT
         dSV9XFz4A9tJ/mAvkGoFJe4AYfz/+qvImCScsd9UgSejKSxQpd6+jLhxDOkwrVAMaqbg
         GmOw==
X-Gm-Message-State: AOAM531WOaOVmdhTMOI5vMRoF030hZ/z0cEKX0VwczrQjUGx5GV81pN9
        eYUI2ogw8A208i41gsYzwTMEpA==
X-Google-Smtp-Source: ABdhPJy0pEj5kXexZ3kbLMRUqpx5WAYMi/90yCyx0lldYTW/IAk5CHNJdRyH2RLdK+kAJq1S5xwhPg==
X-Received: by 2002:a17:90b:4386:: with SMTP id in6mr5775448pjb.160.1622225620900;
        Fri, 28 May 2021 11:13:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 21sm4764913pfh.103.2021.05.28.11.13.40
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
Subject: [PATCH 2/3] scsi: esas2r: Switch to flexible array member
Date:   Fri, 28 May 2021 11:13:36 -0700
Message-Id: <20210528181337.792268-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528181337.792268-1-keescook@chromium.org>
References: <20210528181337.792268-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=ed33a7a5f3363106fee565de7dbeee0ed0e40367; i=BYSzddwUIutLMyBe4gwWgWRPW0Hyydpyw0TO1883Jzg=; m=YbO8CRPgssEoXh7CdGXaGg4HSn/4MdRiTXs7ilaylIE=; p=lWDkVNs9OQuwMDzmOamHffGHEwqku1AwhzpCn4AKrps=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCxMtAACgkQiXL039xtwCYbjxAApoR gVcRcTyxYGtZIQKqX/2G6HqNiiSzqxvfk7xFPlCDVWGGJ2pACdpFHWfIDslPj5dmTaVr+fJ+SemQb Sw+bs48JHiL2nlUIez21DyHDlhO/V7AtPQzFmDgOEBPvgHQcIhhIa3uLiVzjo+3THPMcudJjtrBuM t8Ml1IcYym3eY4cwTCleCwwCujdIe+e+cutoTJZCp6neD0BeAPdfLvyddMC6cr4CtQmzMa6PcWPKL 1V2N7Td3Qi1m6AD2TLlDIffwLiQMjIV6s4zZxp9b1ZyGNIrrwOpBg0vppST0YSCH56/KeEAFZN6bb /JG6hZm8iR56E+X65xV4rOG0+Vjyr+kn9KS5iE7RJo276zzt9PcmnXetpV9XdP4UwS6Xp6fQJuqm3 VYHOSmoPADBUUhoYBHRSU3L3lZNzFFAV1TNYraoafgEaWziHEqnUnpnhie6eW+4fYSMI7nqoGqc5y keC5ukPpw3skUYfe1X7oSUe3Y4og+v0qAInEbcqlcw1QDmtXBcOeOp3z7ZgF/4R8MPmS8RHfNRM5Q daQ8HXLrV6zguj3cCmERbio5z3R7sW4pz9rmvitzVk3ej2aYwDNmioUhExtBwFAVOcR2q7ZahfINn MmzR5Ginfa9TjTS/YTWSkxWsG01LU8dN5oox8qjrzcksZpaVGcyYuaqFlZSOfwRo=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), avoid intentionally writing across
neighboring array fields.

Remove old-style 1-byte array in favor of a flexible array[1] to avoid
future false-positive cross-field memcpy() warning in:

esas2r_vda.c:
	memcpy(vi->cmd.gsv.version_info, esas2r_vdaioctl_versions, ...)

The change in struct size doesn't change other structure sizes (it is
already maxed out to 256 bytes, for example here:

        union {
                struct atto_ioctl_vda_scsi_cmd scsi;
                struct atto_ioctl_vda_flash_cmd flash;
                struct atto_ioctl_vda_diag_cmd diag;
                struct atto_ioctl_vda_cli_cmd cli;
                struct atto_ioctl_vda_smp_cmd smp;
                struct atto_ioctl_vda_cfg_cmd cfg;
                struct atto_ioctl_vda_mgt_cmd mgt;
                struct atto_ioctl_vda_gsv_cmd gsv;
                u8 cmd_info[256];
        } cmd;

No sizes are calculated using the enclosing structure, so no other
updates are needed.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/esas2r/atioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/atioctl.h b/drivers/scsi/esas2r/atioctl.h
index 4aca3d52c851..ff2ad9b38575 100644
--- a/drivers/scsi/esas2r/atioctl.h
+++ b/drivers/scsi/esas2r/atioctl.h
@@ -1141,7 +1141,7 @@ struct __packed atto_ioctl_vda_gsv_cmd {
 
 	u8 rsp_len;
 	u8 reserved[7];
-	u8 version_info[1];
+	u8 version_info[];
 	#define ATTO_VDA_VER_UNSUPPORTED 0xFF
 
 };
-- 
2.25.1

