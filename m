Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C1EC4743C
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10526601FE
	for <linux-hardening@archiver.kernel.org>; Mon, 21 Jun 2021 21:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhFUVrE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhFUVrD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 21 Jun 2021 17:47:03 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C53C061756
        for <linux-hardening@vger.kernel.org>; Mon, 21 Jun 2021 14:44:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id p9so896998pgb.1
        for <linux-hardening@vger.kernel.org>; Mon, 21 Jun 2021 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SQkML+us/TzTvjNIUpTTZK1LcWvPmhVJh6s0rRl9Qk=;
        b=UzZcLSqTmHn9LZBav80swfVHG2/jblmUTnekXNiK7ceuCkj0abzDMDndwp+Ld4OqUV
         41Hql9ComICSBqnWmm5gEi0WTe/BHG12NCvqhsHLOCgCJzBQbLV1rhDjSE6EkdO/HISo
         UnQjzjH1bkfy23XkK8BDDE+IcOVPF14ToJBeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SQkML+us/TzTvjNIUpTTZK1LcWvPmhVJh6s0rRl9Qk=;
        b=LFtVsgjch6PMQqQIfPWsTD43hN7XXu0eaXrFIaAsXr9pQLwJzHBmIdlfu2VojqQmys
         DFaUneBIvke/jLkKn+rC3KUTeY24vHWto9I/oKWlLpwgYPonddAaAt9jU2/BktfRrX3b
         8bG49c7wvXp4+QzWzm0IpHeRkrHifkBFDBU3ERkj3VUyA3oPzIZq3yqGJETs52K0SzIY
         3y7rEJ+o0nOzsXQFCuhtwAixenA4cW1pQmuFOlHASAvTop5Sbi32iLZLx1qty/g+5iCX
         J462MG23MF1XEe0yUHcULaR7S7YGOLIPz+IZi1hNdw5VftansmhdJgsY7XfdoV+ljPGO
         8UXw==
X-Gm-Message-State: AOAM5319ploSM8EefkE18VqdGp75ZZ2pAlr+fH6SuEhM1nOzRpfjFZ7H
        5qlrvqiA5xtjUGptmRTOZLDm9w==
X-Google-Smtp-Source: ABdhPJzz1K6S0azoxavM8zBd3FzUas7iHfXieyJ/64wJfnuk5oRfGU2oMlhigbghP7JxgPgA66efDw==
X-Received: by 2002:aa7:808b:0:b029:2ef:cdd4:8297 with SMTP id v11-20020aa7808b0000b02902efcdd48297mr269068pff.27.1624311888484;
        Mon, 21 Jun 2021 14:44:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y34sm15722960pfa.181.2021.06.21.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:44:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Steve French <stfrench@microsoft.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] cifs: Avoid field over-reading memcpy()
Date:   Mon, 21 Jun 2021 14:44:46 -0700
Message-Id: <20210621214446.1406159-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=e5cadb56c3e7514cb994ed54287fb706e50000e7; i=lOfZOHXQfQA4AvwHsS+g6pzIoRRUmxml/Q0Cvo8KZSY=; m=zkKCsU1v75EihiOwQ8Ntag9WswPCcnp82PKmei5UNOM=; p=zOANoTiXhOGaMHs/B1FA5Z7/pOmXr16srI44FQ2R2hs=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDRCE0ACgkQiXL039xtwCZeThAAkm8 Ibpq7BRnzvOr7DbcYSl91e4mhil+ltMX7OPs/Nz+5ueKoW27hIDKK6d1GLs68V+4qYzzu6V0GKwC/ KanQm7Y2y9MzjSMXNAbHnSTUOVvNhzrgNbmk/jfieZM3RTtexTl8Pfp2BSrLhOm7scyA/AMy+PHW5 83M8hrv4iCKSG6884R6txHIh8Krm9i2U5rU2u2zK1TQbUnIaNO2LLBw/eqb+qdvNiwzPiXI4+Heqv PcDK9edtrbLeIr7xvrsQRWJmDprxUAzJYGSknqhxKnPDFMDJM91jrhapIhaIWB6A8bQ8KvbkhFoOv PO9I0u2ncu/Qr+q6SmwQGHiWlmrMwYIDQAipYDiurdO8mQin36W/z3s9o5cDCJeFqXwZgQDC83/Sr 06mEueHkHrQx6QL2SMZLfNngeQ/XjghIcOq5ERZazU/uWlqAyl+fV0YA7oGnQ2OPZC7C0tkfA2PA+ cRZoWIPA9psiurFiDBhxZIhQugBR6dzEgcy0Yt9AhzxX0SyMdSvab481VUrxjAab2jeOZtFw8lEPI 1EoI8pDr5+0Bcjkgntbh3u0oDKZoJpx0aDS+AzKgS2OrZgK9M0LPjTREc7ub2Zqwb0a8XrkPMpeL4 fOrj4XnPY864J7vUN9b01QffAJ1XCOTkpMu+ngnzxjsylwQ5sZcgcKC0GP5LGSBk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring fields.

Instead of using memcpy to read across multiple struct members, just
perform per-member assignments as already done for other members.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/cifs/smb2pdu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 31784e3fa96f..962826dc3316 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2892,7 +2892,10 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 #endif /* CIFS_DEBUG2 */
 
 	if (buf) {
-		memcpy(buf, &rsp->CreationTime, 32);
+		buf->CreationTime = rsp->CreationTime;
+		buf->LastAccessTime = rsp->LastAccessTime;
+		buf->LastWriteTime = rsp->LastWriteTime;
+		buf->ChangeTime = rsp->ChangeTime;
 		buf->AllocationSize = rsp->AllocationSize;
 		buf->EndOfFile = rsp->EndofFile;
 		buf->Attributes = rsp->FileAttributes;
-- 
2.30.2

