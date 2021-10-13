Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED44C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEEF61056
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJMPZH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhJMPZH (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:25:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84D3160F21;
        Wed, 13 Oct 2021 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634138584;
        bh=NWrNx/WCxNaDBTdOupJGno8eolqNRTIYbYc9Hvg5z4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dTEivvIzvfqp65l6/l1C413vgQi3ZAN2b7rqtfkpQw+0EypOQ2zcTN2KgsDZUhEmT
         fgZinPD7+CjyIUS7kLHF+VTdok/Z6cGhYSlA4dPeuxcGvV9egrWM2Wav6i9we7XMIB
         /a3cuuR2s3ZhLdtrrvBw43FWqKY2DE/OT9bo2Ys6Rlu+WTbtOnT4KNuD8Gu3xtxGlI
         438zLMu8ILpD12JCdEN/YYrjCCC3004biQcyb5FuIj29bCrizwZTpwmyhG/6YRd79S
         GnYnBAN9QNhkzrKkc25mhbbsdmX12nThyf3pD4ycPX9W7HLcXCpEgmKQWOPcynJsV+
         vV6y+Zg1or8BA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 5/9] arm64: chacha-neon: move frame pop forward
Date:   Wed, 13 Oct 2021 17:22:39 +0200
Message-Id: <20211013152243.2216899-6-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013152243.2216899-1-ardb@kernel.org>
References: <20211013152243.2216899-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; h=from:subject; bh=NWrNx/WCxNaDBTdOupJGno8eolqNRTIYbYc9Hvg5z4k=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhZvm6pQrN0LW+3wXswe61yUWzNRCeiMYdNIgdzlIW pwNH4v2JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYWb5ugAKCRDDTyI5ktmPJPaRC/ 0TFaQf1l4oXIYMSl/XixFQjAKPWbE6IaHKS55gaL0B+QSyq8MJEB6ILOWtN1p4IPAg/lVW7LlaTkVz UQu4r+MgOD5tYjB6ObFxmUTKK+N3QuCvFgNmt6G0BQ29ktzJFZBkDtQWoTLKT/lbyVE8WwAULZkbUo DDVbK34xluwBfdvw9pBgdHFqSS72nc5eoyXgN38JgjINryA4HBp7i4vB2Qj/MD274xVfet3sMC82gF f2W31wCccJH/4zypqT191D6WjpjNuG+vdGphKaQRPSPlKEX0Fu/k62r6w8sCqVpQnwrPzswqRitV2D QO5TS6aqz86vHwmIFVLp/Pm3O0O1Qz3/1GmEEtAxREIes15EaScv9Y5JEmDo+i5R0QKtECo2jHaqXo qx043LQnKdjTl0pvJJ7BrP/k7pvPsvcmVrqymvrkMpG6K1W3Uj/KnxkJGJYBOXF1aKrRjkXsWQeHlD m/vwvs4kAVEB19u9g5VbwG7TwnM7oKS8X/hVjXbwQVqoM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Instead of branching back to the common exit point of the routine to pop
the stack frame and return to the caller, move the frame pop to right
after the point where we last use the callee save registers. This
simplifies the generation of CFI unwind metadata, and reduces the number
of needed branches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/crypto/chacha-neon-core.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/crypto/chacha-neon-core.S b/arch/arm64/crypto/chacha-neon-core.S
index b70ac76f2610..918c0beae019 100644
--- a/arch/arm64/crypto/chacha-neon-core.S
+++ b/arch/arm64/crypto/chacha-neon-core.S
@@ -691,6 +691,8 @@ CPU_BE(	  rev		a15, a15	)
 	zip2		v15.2d, v29.2d, v31.2d
 	  stp		a14, a15, [x1, #-8]
 
+	frame_pop
+
 	tbnz		x5, #63, .Lt128
 	ld1		{v28.16b-v31.16b}, [x2]
 
@@ -726,7 +728,6 @@ CPU_BE(	  rev		a15, a15	)
 	st1		{v24.16b-v27.16b}, [x1], #64
 	st1		{v28.16b-v31.16b}, [x1]
 
-.Lout:	frame_pop
 	ret
 
 	// fewer than 192 bytes of in/output
@@ -744,7 +745,7 @@ CPU_BE(	  rev		a15, a15	)
 	eor		v23.16b, v23.16b, v31.16b
 	st1		{v20.16b-v23.16b}, [x5]		// overlapping stores
 1:	st1		{v16.16b-v19.16b}, [x1]
-	b		.Lout
+	ret
 
 	// fewer than 128 bytes of in/output
 .Lt128:	ld1		{v28.16b-v31.16b}, [x10]
@@ -772,7 +773,7 @@ CPU_BE(	  rev		a15, a15	)
 	eor		v31.16b, v31.16b, v3.16b
 	st1		{v28.16b-v31.16b}, [x6]		// overlapping stores
 2:	st1		{v20.16b-v23.16b}, [x1]
-	b		.Lout
+	ret
 
 	// fewer than 320 bytes of in/output
 .Lt320:	cbz		x7, 3f				// exactly 256 bytes?
@@ -789,7 +790,7 @@ CPU_BE(	  rev		a15, a15	)
 	eor		v31.16b, v31.16b, v3.16b
 	st1		{v28.16b-v31.16b}, [x7]		// overlapping stores
 3:	st1		{v24.16b-v27.16b}, [x1]
-	b		.Lout
+	ret
 SYM_FUNC_END(chacha_4block_xor_neon)
 
 	.section	".rodata", "a", %progbits
-- 
2.30.2

