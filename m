Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077CDC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5566112D
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhJMPZF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhJMPZF (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DD656113D;
        Wed, 13 Oct 2021 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138582;
        bh=ev012ZKZHpmXzWbmKkQFRhIEIq9GzO5yF2hyvMrLTl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8UemsnlXse4ampLH7gAriyekzoorTOM1PO9HbMjyEswigGSMiUJI5+z3ikjjV64i
         DO2yEC5mv0hgA++oRdtJTXQCEmaogDHt5fevUM8Hqo+oP/jLTjo5YQPtORAKShhkmW
         jyy/LiCfM2U7H+2gs+qzn4KYaHUr+7PQGQ1LnzwW9gXRAiCC1IPHjLH45asZQ5DAkl
         FdfYEU2c9tKw/Qxw7MAsNrxJPlz2llQZmPrCG+6//rCWUSaRtVPKIP3aZPEMc59jpG
         DVZv+tcBFbN8X5rrORMXRsoVSMjZSSgMzpmuX0k4ibg1qYQmaCpBCi4l5o2Y/Qc8c8
         pPSXeJfWjOG0A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 4/9] arm64: aes-neonbs: move frame pop to end of function
Date:   Wed, 13 Oct 2021 17:22:38 +0200
Message-Id: <20211013152243.2216899-5-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; h=from:subject; bh=ev012ZKZHpmXzWbmKkQFRhIEIq9GzO5yF2hyvMrLTl0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvm4C4JNezyScCorZ+vZKcwVprM4gy0BSJ+YUPs4 BCPLDBaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5uAAKCRDDTyI5ktmPJN4NC/ 96ZFbOTa56knGclCnX2tIghJgIz4TvVHbq07xyX4Tf7nuuUylkzWmUn6imw5NTYEZ9GFp8e8GbS7dV k+ajlZtN6j4GxQOVyZ9ZFsvt5IZChpsw3e1K4u6XKJ+3B46Tx//rld5oKZTfTnBFbq8Wfpam69gRaA jtikcQ1wpE1ZCwC2jHtZL00x7f7bSBt2OnObxlOGXa3VqWj4pzuVipdXYegMwksYGMufG8ykkAvccB dbpKR2hH7IYvbKpBk39/Aui0biEF2c7Q81kqEmDx+y/IZdIDUaI4V7OrfQM36MxgehmVda3EwwOUq7 yTcda7zpp75sOsKGZsRYZYT/esccDJZBYJewmlDr1tIu3/9Z8/GR9aIgqb++o+kQTQEjfH1FXKykhq aca7jN7oPLDKGs9xhrLlgvVbQdq7C9KInXLi4dM+ui9TYPPVBNnFTBF10z9r6SsGuoDJ024Hvt0yPl gcOYk8M+nr23X4lM229yjUh8rM3l+ZdM7CA1tSmg+Yn9c=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to decomplicate the generation of CFI unwind metadata for the
AES-CTR routine, which would involve preserving/restoring the virtual
register set to convey that the state during the handling of inputs less
than 8 blocks [which is emitted out of line] equals the state before the
frame pop, let's just move it to the end of the function.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/aes-neonbs-core.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/aes-neonbs-core.S b/arch/arm64/crypto/aes-neonbs-core.S
index a3405b8c344b..7104b54448dc 100644
--- a/arch/arm64/crypto/aes-neonbs-core.S
+++ b/arch/arm64/crypto/aes-neonbs-core.S
@@ -966,10 +966,6 @@ CPU_LE(	rev		x8, x8		)
 
 	b		99b
 
-.Lctr_done:
-	frame_pop
-	ret
-
 	/*
 	 * If we are handling the tail of the input (x6 != NULL), return the
 	 * final keystream block back to the caller.
@@ -998,4 +994,8 @@ CPU_LE(	rev		x8, x8		)
 7:	cbz		x25, 8b
 	st1		{v5.16b}, [x25]
 	b		8b
+
+.Lctr_done:
+	frame_pop
+	ret
 SYM_FUNC_END(aesbs_ctr_encrypt)
-- 
2.30.2

